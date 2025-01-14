import { Link, useNavigate } from 'react-router-dom';
import { useState } from 'react';
import { AxiosError } from 'axios';
import axios from '../../../../axios';
import { setTokenAndDataInLocalStorage } from '../../../../localStorage/localStorage';
import DefaultBtn from '../../../standaloneComponents/Button/DefaultBtn';
import Logo from '/img/logo-text-seniorlove.webp';
import Error500Page from '../../../../pages/Error500Page';

interface ConnectionFormSectionProps {
  setUserToken: React.Dispatch<React.SetStateAction<string | null>>;
}

export default function ConnectionFormSection({
  setUserToken,
}: ConnectionFormSectionProps) {
  // STATE 1:  error login
  const [errorLog, setErrorLog] = useState<boolean>(false);

  // STATE 2 : error server
  const [serverError, setServerError] = useState(false);
  const navigate = useNavigate();

  const checkCredentials = async (email: string, password: string) => {
    try {
      setErrorLog(false);

      const response = await axios.post('/public/login', {
        email,
        password,
      });
      setTokenAndDataInLocalStorage(
        response.data.token,
        response.data.name,
        response.data.picture,
        response.data.id
      );
      setUserToken(response.data.token);
      setErrorLog(false);
      navigate('/home');
    } catch (e) {
      // if error is from axios and respons status is 401, it means credentials error
      if (e instanceof AxiosError && e.response?.status === 401) {
        console.error(e);
        setErrorLog(true);
      } else {
        // other status means server is down
        console.error(e);
        setServerError(true);
      }
    }
  };

  if (serverError) {
    return <Error500Page />;
  }

  return (
    <section className="bg-connectionForm bg-cover bg-no-repeat bg-center text-white content-center justify-center md:items-center gap-12 flex md:px-16 md:h-screen flex-1">
      <div className="md:block md:w-1/2 lg:2/3">
        <div className="bg-white opacity-90 p-10 rounded-xl shadow-md my-10 mx-4 md:mx-auto md:my-0 md:max-w-lg">
          <div className="flex flex-col items-center justify-center mb-4">
            <img src={Logo} alt="" className="max-w-44 mb-4" />
          </div>
          <p className="mb-4 text-lg text-primaryText font-semibold text-center uppercase">
            Connexion
          </p>
          <form
            className="text-primaryText"
            onSubmit={async (event) => {
              event.preventDefault();
              const form = event.currentTarget;
              const formData = new FormData(form);
              const email = formData.get('email') as string;
              const password = formData.get('password') as string;
              await checkCredentials(email, password);
            }}
          >
            <div className="mb-4">
              <label
                htmlFor="email"
                className="block text-lg font-medium leading-6 text-primaryText"
              >
                Adresse e-mail
              </label>
              <div className="mt-2">
                <div className="flex bg-white rounded-md shadow-sm border">
                  <input
                    id="email"
                    name="email"
                    type="email"
                    placeholder="Adresse e-mail"
                    className="block w-full border-0 bg-transparent py-1.5 p-2 text-primaryText placeholder:text-gray-400 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>
            </div>
            <div className="mb-4">
              <label
                htmlFor="password"
                className="block text-lg font-medium leading-6 text-primaryText"
              >
                Mot de passe
              </label>
              <div className="mt-2">
                <div className="flex bg-white rounded-md shadow-sm border">
                  <input
                    id="password"
                    name="password"
                    type="password"
                    placeholder="Mot de passe"
                    className="block w-full border-0 bg-transparent py-1.5 p-2 text-primaryText placeholder:text-gray-400 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>
            </div>
            {errorLog ? (
              <p className="text-center text-red-600 font-semibold">
                Email et/ou Mot de passe invalide
              </p>
            ) : null}
            <div className="flex justify-center mt-6 mb-2">
              <DefaultBtn btnText="Connexion" btnType="submit" />
            </div>
          </form>
          <div className="connexion_paragraph text-primaryText text-base mb-4 text-center">
            <p>
              Pas encore membre?{' '}
              <Link to="/" className="text-secondaryPink">
                Inscrivez-vous ici
              </Link>
            </p>
          </div>
        </div>
      </div>
    </section>
  );
}
