import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AxiosError } from 'axios';
import axios from '../../../axios';
import {
  getTokenAndDataFromLocalStorage,
  removeTokenFromLocalStorage,
} from '../../../localStorage/localStorage';
import { IUsers } from '../../../@types/IUsers';
import { FilterUser } from '../../../@types/IFilterUser';
import Loader from '../../standaloneComponents/Loader/Loader';
import Error500Page from '../../../pages/Error500Page';
import ProfileSticker from '../../standaloneComponents/ProfileSticker/ProfileSticker';

interface DisplayUsersProps {
  filter: FilterUser[];
}

export default function DisplayUsers({ filter }: DisplayUsersProps) {
  const response = getTokenAndDataFromLocalStorage();
  const token = response?.token;
  // STATE 1 : users
  const [users, setUsers] = useState<IUsers[]>([]);

  // STATE 2 : loading
  const [isLoading, setIsLoading] = useState<boolean>(true);

  // STATE 3 : error server
  const [serverError, setServerError] = useState(false);

  const navigate = useNavigate();

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const responseFetch = await axios.get('/private/users/me/suggestions');
        setUsers(responseFetch.data);
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

  const filterUser = users.filter((user) => {
    // Filtrer par genre
    const genderSort =
      user.gender === filter[0].gender || filter[0].gender === 'allGender';

    // Filtrer par âge
    const ageSort =
      filter[0].age === '0' ||
      (filter[0].age === '80'
        ? user.age >= 80
        : user.age >= Number(filter[0].age) &&
          user.age <= Number(filter[0].age) + 9);

    return genderSort && ageSort;
  });

  if (serverError) {
    return <Error500Page />;
  }

  if (isLoading) {
    return <Loader />;
  }

  return (
    <div className="w-full py-10">
      {filterUser.length === 0 ? (
        <p className="text-center text-gray-500">
          Aucun utilisateur ne correspond à votre recherche.
        </p>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8 justify-center mx-auto w-11/12 pb-8">
          {filterUser.map((user) => (
            <ProfileSticker user={user} key={user.picture} />
          ))}
        </div>
      )}
    </div>
  );
}
