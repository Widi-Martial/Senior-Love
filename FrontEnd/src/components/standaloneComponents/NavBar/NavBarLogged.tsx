import Logo from '/img/logo-text-seniorlove.webp';
import MobileNavBarLogged from '../MobileNavBar/MobileNavBarLogged';
import { Link, NavLink } from 'react-router-dom';
import { useEffect, useState } from 'react';
import {
  getTokenAndDataFromLocalStorage,
  removeTokenFromLocalStorage,
} from '../../../localStorage/localStorage';


interface UserHeadbandProps {
  setIsAuthenticated: React.Dispatch<React.SetStateAction<boolean>>;
}

export default function NavBarLogged({
  setIsAuthenticated,
}: UserHeadbandProps) {
  const response = getTokenAndDataFromLocalStorage();
  const { name, picture } = response || { name: null, picture: null };
  const [newPicture, setNewPicture] = useState<string | null>(picture);
  const [newName, setNewName] = useState<string | null>(name);

  useEffect(() => {
    const fetchPicture = () => {
      setNewPicture(picture);
      setNewName(name);
    };

    // Fetch immediately on mount
    fetchPicture();

    // Set up an interval to fetch data periodically
    const intervalId = setInterval(fetchPicture, 1000); // Fetch data every 5 seconds

    // Cleanup interval on component unmount
    return () => clearInterval(intervalId);
  }, []);

  const onClickDisconnect = () => {
    setIsAuthenticated(false);
    removeTokenFromLocalStorage();
  };

  const NavBarButtons = [
    { text: 'Accueil', to: '/home' },
    { text: 'Découvrir', to: '/profiles' },
    { text: 'Evènements', to: '/events' },
    { text: 'Messages', to: '/messages' },
  ];

  return (
    <header className="bg-[#EBEBEA] bg-opacity-90 md:sticky top-0 w-full py-4 z-10">
      <nav className="flex justify-center md:justify-between items-center w-full px-4">
        <Link to="/home">
          <img
            src={Logo}
            alt="Retour à l'accueil"
            className="max-w-36 lg:max-w-52"
          />
        </Link>
        <div className="flex gap-2 flex-wrap justify-end">
          {NavBarButtons.map((button) => (
            <NavLink
              to={button.to}
              key={button.text}
              className="text-[#607D8B] hover:text-[#59616B] font-semibold py-2 px-3 nav-link hidden md:block"
            >
              {button.text}
            </NavLink>
          ))}
          <Link
            to="/"
            onClick={() => onClickDisconnect()}
            className="text-[#607D8B] hover:text-corailNotification font-semibold py-2 px-3 nav-link hidden md:block"
          >
            Déconnexion
          </Link>
          <Link to="/myprofile">
            <img
              src={newPicture ?? ''}
              alt={newName ?? ''}
              className="hidden md:block md:w-10 md:h-10 rounded-full object-cover shadow-around"
            />
          </Link>
        </div>
      </nav>
      <MobileNavBarLogged />
    </header>
  );
}
