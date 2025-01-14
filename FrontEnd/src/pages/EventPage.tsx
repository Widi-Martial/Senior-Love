import { useEffect } from 'react';
import MainEventPage from '../components/pageComponents/EventPage/MainEventPage';

interface EventPageProps {
  isAuthenticated: boolean;
}
export default function EventPage({ isAuthenticated }: EventPageProps) {
  // Move window position on top of page
  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
  return <MainEventPage isAuthenticated={isAuthenticated} />;
}
