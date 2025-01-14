import EventView from './EventView/EventView';

interface MainEventPageProps {
  isAuthenticated: boolean;
}
export default function MainEventPage({ isAuthenticated }: MainEventPageProps) {
  return <EventView isAuthenticated={isAuthenticated} />;
}
