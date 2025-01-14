import { useEffect } from 'react';
import MainConnectionPage from '../components/pageComponents/ConnectionPage/MainConnectionPage';

interface ConnectionPageProps {
  setUserToken: React.Dispatch<React.SetStateAction<string | null>>;
}

export default function ConnectionPage({ setUserToken }: ConnectionPageProps) {
  // Move window position on top of page
  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
  return <MainConnectionPage setUserToken={setUserToken} />;
}
