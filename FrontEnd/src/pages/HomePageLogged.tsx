import { useEffect } from 'react';
import MainHomePageLogged from '../components/pageComponents/HomePageLogged/MainHomePageLogged';

export default function HomePageLogged() {
  // Move window position on top of page
  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
  return <MainHomePageLogged />;
}
