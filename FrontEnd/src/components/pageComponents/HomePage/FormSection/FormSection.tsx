import { useState, useEffect } from 'react';
import { AxiosError } from 'axios';
import axios from '../../../../axios';

import SubscribeFormV1 from './SubscribeForms/SubscribeFormV1';
import SubscribeFormV2 from './SubscribeForms/SubscribeFormV2';
import SubscribeFormV3 from './SubscribeForms/SubscribeFormV3';
import SubscribeFormV4 from './SubscribeForms/SubscribeFormV4';
import EndSection from './EndSection';

import { IHobby } from '../../../../@types/IHobby';
import { IRegisterForm } from '../../../../@types/IRegisterForm';

import Loader from '../../../standaloneComponents/Loader/Loader';
import Error500Page from '../../../../pages/Error500Page';

interface FormSectionProps {
  setIsForm1Validated: React.Dispatch<React.SetStateAction<boolean>>;
  isForm1Validated: boolean;
  isForm2Validated: boolean;
  setIsForm2Validated: React.Dispatch<React.SetStateAction<boolean>>;
  isForm3Validated: boolean;
  setIsForm3Validated: React.Dispatch<React.SetStateAction<boolean>>;
  isForm4Validated: boolean;
  setIsForm4Validated: React.Dispatch<React.SetStateAction<boolean>>;
}

export default function FormSection({
  isForm1Validated,
  setIsForm1Validated,
  isForm2Validated,
  setIsForm2Validated,
  isForm3Validated,
  setIsForm3Validated,
  isForm4Validated,
  setIsForm4Validated,
}: FormSectionProps) {
  // STATE 1 :formInfos
  const [formInfos, setFormInfos] = useState({} as IRegisterForm);

  // STATE 2 : hobbies
  const [hobbies, setHobbies] = useState<IHobby[]>([]);

  // STATE 3 : register error
  const [registerError, setRegisterError] = useState<null | string>(null);

  // STATE 4 : is global form submitted
  const [isGlobalFormSubmitted, setIsGlobalFormSubmitted] =
    useState<boolean>(false);

  // STATE 5 : loading
  const [isLoading, setIsLoading] = useState<boolean>(true);

  // STATE 6 : error server
  const [serverError, setServerError] = useState(false);

  const fillFormInfos = (incomingInfos: object) => {
    setFormInfos((previousInfos) => {
      return { ...previousInfos, ...incomingInfos };
    });
  };

  const goToForm1 = () => {
    setIsForm1Validated(false);
  };

  const goToForm2 = () => {
    setIsForm2Validated(false);
  };

  const goToForm3 = () => {
    setIsForm3Validated(false);
  };

  const goToForm4 = () => {
    setIsForm4Validated(false);
  };

  useEffect(() => {
    const submitGlobalForm = async () => {
      try {
        // Attempt to post the formInfos object to the server
        // The 'Content-Type' header is set to 'multipart/form-data' to indicate that the request is sending form data
        await axios.post('/public/register', formInfos, {
          headers: { 'Content-Type': 'multipart/form-data' },
        });

        // If the request is successful, clear any previous register error
        setRegisterError(null);
      } catch (e) {
        // Handle errors that occur during the request
        if (e instanceof AxiosError) {
          // Check if the error is an AxiosError, indicating an error response from the server
          if (e.response?.status === 400) {
            // If the server responds with a 400 status code, set a specific error message related to email already being registered
            setRegisterError(
              "L'adresse e-mail que vous avez renseigné correspond à un compte déjà créé. Essayez de vous connecter"
            );
          } else {
            // For other Axios errors, set a generic error message for the user
            setServerError(true);
          }
        }
        console.error(e);
      } finally {
        // Set the loading state to false to indicate that the request process has completed
        setIsLoading(false);
      }
    };

    // Check if the global form has been submitted
    if (isGlobalFormSubmitted) {
      // Call the submitGlobalForm function to handle the form submission
      submitGlobalForm();
    }
  }, [formInfos, isGlobalFormSubmitted]);

  useEffect(() => {
    const fetchAndSaveHobbies = async () => {
      try {
        const result = await axios.get('/public/hobbies');
        const hobbiesData = result.data.map((hobby: IHobby) => {
          return { ...hobby, checked: false };
        });
        setHobbies(hobbiesData);
      } catch (e) {
        console.error(e);
        setServerError(true);
      } finally {
        setIsLoading(false);
      }
    };
    fetchAndSaveHobbies();
  }, []);

  if (serverError) {
    return <Error500Page />;
  }

  if (isLoading) {
    return (
      <section className=" justify-center md:items-center flex md:px-16 md:h-screen">
        <Loader />
      </section>
    );
  }

  // if form 1 not yet validated, show form 1
  if (!isForm1Validated) {
    return (
      <section className="bg-firstForm bg-cover bg-no-repeat bg-center text-white content-center justify-center md:items-center gap-12 flex md:px-16 md:h-screen flex-1">
        <div className="hidden md:block font-semibold text-2xl xl:text-4xl md:w-1/2 lg:2/3">
          <p>
            Rejoignez notre communauté dédiée aux seniors en quête de belles
            rencontres.
          </p>
          <p>Inscrivez-vous ici et commencez cette belle aventure !</p>
        </div>
        <SubscribeFormV1
          formInfos={formInfos}
          setIsForm1Validated={setIsForm1Validated}
          fillFormInfos={fillFormInfos}
        />
      </section>
    );
  }

  // if form 2 not yet validated, show form 2
  if (!isForm2Validated) {
    return (
      <section className="bg-secondForm bg-cover bg-no-repeat bg-center text-white content-center justify-center md:items-center gap-12 flex md:px-16 md:h-screen flex-1">
        <SubscribeFormV2
          hobbies={hobbies}
          setHobbies={setHobbies}
          setIsForm2Validated={setIsForm2Validated}
          onPreviousClick={goToForm1}
          fillFormInfos={fillFormInfos}
        />
      </section>
    );
  }

  // if form 3 not yet validated, show form 3
  if (!isForm3Validated) {
    return (
      <section className="bg-thirdForm bg-cover bg-no-repeat bg-center text-white content-center justify-center md:items-center gap-12 flex md:px-16 md:h-screen flex-1">
        <SubscribeFormV3
          formInfos={formInfos}
          setIsForm3Validated={setIsForm3Validated}
          fillFormInfos={fillFormInfos}
          onPreviousClick={goToForm2}
        />
      </section>
    );
  }
  // // if form 4 not yet validated, show form 4
  if (!isForm4Validated) {
    return (
      <section className="bg-fourthForm bg-cover bg-no-repeat bg-center text-white content-center justify-center md:items-center gap-12 flex md:px-16 md:h-screen flex-1">
        <SubscribeFormV4
          onPreviousClick={goToForm3}
          fillFormInfos={fillFormInfos}
          setIsForm4Validated={setIsForm4Validated}
          setIsGlobalFormSubmitted={setIsGlobalFormSubmitted}
        />
      </section>
    );
  }

  return (
    <section className="bg-endForm bg-cover bg-no-repeat bg-center text-white content-center justify-center md:items-center gap-12 flex md:px-16 md:h-screen flex-1">
      <EndSection onPreviousClick={goToForm4} error={registerError} />
    </section>
  );
}
