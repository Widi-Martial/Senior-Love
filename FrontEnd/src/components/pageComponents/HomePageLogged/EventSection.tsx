import { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { AxiosError } from 'axios';
import axios from '../../../axios';
import { IEvent } from '../../../@types/IEvent';
import EventSticker from '../../standaloneComponents/EventSticker/EventSticker';
import DefaultBtn from '../../standaloneComponents/Button/DefaultBtn';
import Loader from '../../standaloneComponents/Loader/Loader';
import Error500Page from '../../../pages/Error500Page';

import { removeTokenFromLocalStorage } from '../../../localStorage/localStorage';

export default function EventSection() {
  // STATE 1 : events
  const [events, setEvents] = useState<IEvent[]>([]);

  // STATE 2 : events number
  const [numEvents, setnumEvents] = useState(3);

  // STATE 3 : loading
  const [isLoading, setIsLoading] = useState<boolean>(true);

  // STATE 4 : error server
  const [serverError, setServerError] = useState(false);

  const navigate = useNavigate();

  // Check window size to adapt number of events on screen
  useEffect(() => {
    const updatenumEvents = () => {
      if (window.innerWidth >= 1280) {
        setnumEvents(8);
      } else if (window.innerWidth >= 1024) {
        setnumEvents(6);
      } else if (window.innerWidth >= 640) {
        setnumEvents(4);
      } else {
        setnumEvents(3);
      }
    };

    updatenumEvents(); // Set initial value
    window.addEventListener('resize', updatenumEvents); // Update on resize

    return () => window.removeEventListener('resize', updatenumEvents);
  }, []);

  // Fetch events from API

  useEffect(() => {
    const fetchAndSaveEvents = async () => {
      try {
        const result = await axios.get('/public/events');
        setEvents(result.data);
      } catch (e) {
        console.log(e);
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

  if (isLoading) {
    return <Loader />;
  }

  return (
    <div className="w-full py-10">
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8 justify-center mx-auto w-11/12 pb-8">
        {events.slice(0, numEvents).map((event) => (
          <EventSticker event={event} key={event.name} />
        ))}
      </div>
      <Link to="/events">
        <DefaultBtn btnText="Voir plus d'évènements" />
      </Link>
    </div>
  );
}
