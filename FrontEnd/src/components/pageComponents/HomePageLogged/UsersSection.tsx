import { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { AxiosError } from 'axios';
import axios from '../../../axios';
import ProfileSticker from '../../standaloneComponents/ProfileSticker/ProfileSticker';
import DefaultBtn from '../../standaloneComponents/Button/DefaultBtn';
import {
  getTokenAndDataFromLocalStorage,
  removeTokenFromLocalStorage,
} from '../../../localStorage/localStorage';
import { IUsers } from '../../../@types/IUsers';
import Loader from '../../standaloneComponents/Loader/Loader';
import Error500Page from '../../../pages/Error500Page';

export default function UsersSection() {
  const response = getTokenAndDataFromLocalStorage();
  const token = response?.token;
  // STATE 1 : users
  const [users, setUsers] = useState<IUsers[]>([]);

  // STATE 2 : loading
  const [isLoading, setIsLoading] = useState<boolean>(true);

  // STATE 3 : error server
  const [serverError, setServerError] = useState(false);
  // Import of navigate to force redirection when forced logged out
  const navigate = useNavigate();

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const responseFetch = await axios.get('/private/users/me/suggestions');

        setUsers(
          responseFetch.data.sort(() => 0.5 - Math.random()).slice(0, 8)
        );
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
    if (token) {
      fetchUsers();
    }
  }, [navigate, token]);
  // const [numProfiles, setNumProfiles] = useState(3);

  /* useEffect(() => {
    const updateNumProfiles = () => {
      if (window.innerWidth >= 1280) {
        setNumProfiles(8);
      } else if (window.innerWidth >= 1024) {
        setNumProfiles(6);
      } else if (window.innerWidth >= 640) {
        setNumProfiles(4);
      } else {
        setNumProfiles(3);
      }
    };

    updateNumProfiles(); // Set initial value
    window.addEventListener('resize', updateNumProfiles); // Update on resize

    return () => window.removeEventListener('resize', updateNumProfiles);
  }, []); */

  if (serverError) {
    return <Error500Page />;
  }

  if (isLoading) {
    return <Loader />;
  }

  return (
    <div className="w-full py-10">
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8 justify-center mx-auto w-11/12 pb-8">
        {users.map((user) => (
          <ProfileSticker user={user} key={user.id} />
        ))}
      </div>
      <Link to="/profiles">
        <DefaultBtn btnText="Voir plus de profils" />
      </Link>
    </div>
  );
}
