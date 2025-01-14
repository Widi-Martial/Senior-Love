import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AxiosError } from 'axios';
import axios from '../../../axios';
import EventSticker from '../../standaloneComponents/EventSticker/EventSticker';
import { IEvent } from '../../../@types/IEvent';
import Loader from '../../standaloneComponents/Loader/Loader';
import Error500Page from '../../../pages/Error500Page';

import { removeTokenFromLocalStorage } from '../../../localStorage/localStorage';

export default function MainEventsPage() {
  // STATE 1 : events
  const [events, setEvents] = useState<IEvent[]>([]);

  // STATE 2 : loading
  const [isLoading, setIsLoading] = useState<boolean>(true);

  // STATE 3 : error server
  const [serverError, setServerError] = useState(false);

  const navigate = useNavigate();

  useEffect(() => {
    const fetchAndSaveEvents = async () => {
      try {
        const result = await axios.get('/public/events');
        setEvents(result.data);
      } catch (e) {
        console.error(e);
        if (
          e instanceof AxiosError &&
          (e.response?.data.blocked || e.response?.status === 401)
        ) {
          removeTokenFromLocalStorage();
          navigate('/loggedout');
        } else {
          setServerError(true);
        }
      } finally {
        setIsLoading(false);
      }
    };
    fetchAndSaveEvents();
  }, [navigate]);

  if (serverError) {
    return <Error500Page />;
  }

  return (
    <main className="w-full min-h-screen flex-grow flex flex-col justify-start items-center bg-backgroundPink pb-8 gap-8">
      <p className="text-sm text-center font-medium md:text-xl my-4 text-primaryText w-9/12 pt-8">
        Bienvenue sur la page dédiée aux{' '}
        <span className="text-secondaryPink">évènements</span> que nous
        organisons ! Découvrez une sélection d&apos;activités et
        d&apos;événements qui se dérouleront prochainement dans notre
        communauté. Que vous soyez amateur de culture, passionné de sport, ou
        simplement à la recherche d&apos;une sortie en plein air, il y en a pour
        tous les goûts!
      </p>
      {isLoading ? (
        <Loader />
      ) : (
        <div className="flex flex-wrap gap-10 justify-center content-around w-10/12">
          {events.map((event) => (
            <EventSticker event={event} key={event.name} />
          ))}
        </div>
      )}
    </main>
  );
}
