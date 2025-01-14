import { Link, useParams, Navigate, useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { AxiosError } from 'axios';
import axios from '../../../../axios';

import { IEvent } from '../../../../@types/IEvent';
import { IUsersFull } from '../../../../@types/IUsersFull';
import DefaultBtn from '../../../standaloneComponents/Button/DefaultBtn';

import { removeTokenFromLocalStorage } from '../../../../localStorage/localStorage';

import {
  displayFullDate,
  formatTime,
} from '../../../../utils/dateAndTimeUtils';
import Loader from '../../../standaloneComponents/Loader/Loader';
import Error500Page from '../../../../pages/Error500Page';

interface EventViewProps {
  isAuthenticated: boolean;
}
export default function EventView({ isAuthenticated }: EventViewProps) {
  // STATE 1 : event infos
  const [event, setEvent] = useState<IEvent | null>(null);

  // STATE 2 : user events infos
  const [userEvents, setUserEvents] = useState<IUsersFull[]>([]);

  // STATE 3 : subscription to event state
  const [isSubscribe, setIsSubscribe] = useState<boolean>();

  // STATE 4 : subscribe button text
  const [buttonText, setButtonText] = useState<string>('');

  // STATE 4 : loading
  const [isLoading, setIsLoading] = useState<boolean>(true);

  // STATE 5 : error
  const [isError, setIsError] = useState<number | null>(null);

  const navigate = useNavigate();

  // toast de confirmation
  const subNotify = () =>
    toast.success('Vous êtes bien inscrit(e) à cet événement', {
      autoClose: 3000,
    });

  const UnsubNotify = () =>
    toast.info("Vous n'êtes plus inscrit(e) à cet événement", {
      autoClose: 3000,
    });

  const { id } = useParams();

  // Fetch event infos and set state
  useEffect(() => {
    const getEvent = async () => {
      try {
        const result = await axios.get(`public/events/${id}`);
        setEvent(result.data);
      } catch (e) {
        if (e instanceof AxiosError && e.response?.status === 404) {
          console.error(e);
          setIsError(404);
        } else {
          setIsError(500);
          console.error(e);
        }
      } finally {
        setIsLoading(false);
      }
    };
    getEvent();
  }, [id]);

  // vérification des évenements possédés par l'user
  const checkSubscribe = userEvents.some(
    (element) => element.id === Number(id)
  );
  // If authenticated fetch me to check subscriptions to events and set state
  useEffect(() => {
    const getUser = async () => {
      try {
        const result = await axios.get('private/users/me');
        setUserEvents(result.data.events);
      } catch (e) {
        console.error(e);
        if (
          e instanceof AxiosError &&
          (e.response?.data.blocked || e.response?.status === 401)
        ) {
          removeTokenFromLocalStorage();
          navigate('/loggedout');
        } else {
          setIsError(500);
        }
      } finally {
        setIsLoading(false);
      }
    };
    if (isAuthenticated) {
      getUser();
    }

    if (event) {
      if (checkSubscribe) {
        setIsSubscribe(true);
      } else {
        setIsSubscribe(false);
      }
      setButtonText(isSubscribe ? 'Me désinscrire' : 'Je participe');
    }
  }, [checkSubscribe, event, isAuthenticated, isSubscribe, navigate]);

  // s'inscrire à un évenement
  async function subscribeEvent(eventId: number) {
    try {
      const result = await axios.put(`/private/events/${eventId}/register`);
      console.log(result.status);
      setIsSubscribe(true);
      console.log('ATTEMPT');
      subNotify();
    } catch (e) {
      console.error(e);
      if (
        e instanceof AxiosError &&
        (e.response?.data.blocked || e.response?.status === 401)
      ) {
        removeTokenFromLocalStorage();
        navigate('/loggedout');
      } else {
        setIsError(500);
      }
    }
  }

  // se désinscrire d'un évenement
  async function unsubscribeEvent(eventId: number) {
    try {
      const result = await axios.delete(
        `/private/events/${eventId}/unregister`
      );
      console.log(result.status);
      setIsSubscribe(false);
      UnsubNotify();
    } catch (e) {
      console.error(e);
      if (
        e instanceof AxiosError &&
        (e.response?.data.blocked || e.response?.status === 401)
      ) {
        removeTokenFromLocalStorage();
        navigate('/loggedout');
      } else {
        setIsError(500);
      }
    }
  }
  if (isError === 404) {
    return <Navigate to="/error" />;
  }

  if (isError === 500) {
    return <Error500Page />;
  }

  if (isLoading) {
    return <Loader />;
  }

  if (event) {
    return (
      <div className="w-full min-h-full flex-grow flex bg-backgroundPink">
        <div className="pt-8 px-8 max-w-7xl w-full justify-center mx-auto ">
          <div className="h-72 rounded-xl relative mb-4">
            <img
              src={event.picture}
              alt={event.name}
              className="h-full object-cover rounded-md shadow-xl w-full"
            />
          </div>

          <div className="flex flex-col justify-between">
            <div className="p-2 w-full text-primaryText text-xl text-center mb-4">
              <p>{event.name}</p>
            </div>{' '}
            {/* Aside */}
            <div className="flex flex-col md:flex-row-reverse md:justify-between">
              <div className="flex md:flex-col md:pl-20 gap-4 flex-wrap justify-center">
                <p className="text-primaryText italic">
                  <span className="font-semibold">Date : </span>
                  {displayFullDate(event.date as string)}
                </p>
                <p className="text-primaryText italic">
                  <span className="font-semibold">Heure : </span>
                  {formatTime(event.time as string)}
                </p>
                <p className="text-primaryText italic">
                  <span className="font-semibold">Lieu : </span>{' '}
                  {event.location}, France
                </p>
                <div>
                  <p className="text-primaryText italic mb-1">
                    <span className="font-semibold">
                      Centres d&apos;intérêt
                    </span>{' '}
                    :
                  </p>
                  <div className="text-primaryText">
                    {event.hobbies.map((hobby) => (
                      <p key={hobby.name}>{hobby.name}</p>
                    ))}
                  </div>
                </div>
              </div>
              {/* Description */}
              <div className="md:w-4/5 pb-8">
                <p className="text-primaryText py-6 md:py-0 italic">
                  {event.description}
                </p>
              </div>
            </div>
          </div>
          {isSubscribe && (
            <p className="text-center text-x0 text-primaryText">
              Vous êtes déja inscrit(e) à cet évenement
            </p>
          )}

          {isAuthenticated ? (
            <button
              type="button"
              className="min-w-44 bg-secondaryPink hover:bg-secondaryPinkHover rounded-lg text-white font-bold text-lg shadow-md py-1 px-4 block mx-auto my-4"
              onClick={() =>
                isSubscribe
                  ? unsubscribeEvent(event.id as number)
                  : subscribeEvent(event.id as number)
              }
            >
              {buttonText}
            </button>
          ) : (
            <>
              <Link to="/">
                <DefaultBtn btnText="Inscrivez-vous" btnType="button" />
              </Link>
              <div className="connexion_paragraph text-primaryText text-center text-base mb-4">
                <p>
                  Deja membre? Connectez-vous{' '}
                  <Link to="/login" className="text-secondaryPink">
                    ici
                  </Link>
                  .
                </p>
              </div>
            </>
          )}

          <ToastContainer />
        </div>
      </div>
    );
  }
}
