import { useEffect } from 'react';
import MainProfilesPage from '../components/pageComponents/SearchProfilesPage/MainSearchProfilesPage';

export default function ProfilesPage() {
  // Move window position on top of page
  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });

  return <MainProfilesPage />;
}
