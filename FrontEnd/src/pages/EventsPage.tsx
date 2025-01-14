import { useEffect } from 'react';

import MainEventsPage from '../components/pageComponents/EventsPage/MainEventsPage';

export default function EventsPage() {
  // Move window position on top of page
  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
  return <MainEventsPage />;
}
