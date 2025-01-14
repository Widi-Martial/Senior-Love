import { useState } from 'react';
import DefaultBtn from '../../../../standaloneComponents/Button/DefaultBtn';
import stepFourSchema from '../../../../../utils/joiValidateFormV4';

interface SubscribeFormV4Props {
  onPreviousClick: () => void;
  fillFormInfos: (incomingInfos: object) => void;
  setIsForm4Validated: React.Dispatch<React.SetStateAction<boolean>>;
  setIsGlobalFormSubmitted: React.Dispatch<React.SetStateAction<boolean>>;
}

function SubscribeFormV4({
  onPreviousClick,
  fillFormInfos,
  setIsForm4Validated,
  setIsGlobalFormSubmitted,
}: SubscribeFormV4Props) {
  // STATE 1 : error
  const [err, setError] = useState<null | string>(null);

  const handleValidateFormV4 = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const rawFormData = Object.fromEntries(new FormData(e.currentTarget));
    const { email, password, repeatPassword } = rawFormData;
    console.log(typeof rawFormData);

    const { error } = stepFourSchema.validate(rawFormData);
    if (error) {
      setError(error.details[0].message);
    } else {
      const formV3Infos = {
        email,
        password,
        repeat_password: repeatPassword,
      };
      fillFormInfos(formV3Infos);
      setIsForm4Validated(true);
      setIsGlobalFormSubmitted(true);
    }
  };

  return (
    <div className="bg-white opacity-90 p-10 rounded-xl shadow-md max-w-xl my-10 mx-4 md:mx-auto md:my-0">
      <form onSubmit={(e) => handleValidateFormV4(e)}>
        <fieldset className="mb-4">
          <legend className="text-xl text-center font-semibold leading-6 text-primaryText mb-8">
            Il ne vous reste plus qu&apos;une étape pour finaliser votre
            inscription !
          </legend>
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
                  placeholder="exemple@domaine.com"
                  className="block w-full border-0 bg-transparent py-1.5 p-2 text-primaryText placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6"
                  required
                />
              </div>
            </div>
          </div>
          <div className="mb-4">
            <label
              htmlFor="email"
              className="block text-lg font-medium leading-6 text-primaryText"
            >
              Mot de passe{' '}
              <span className="text-sm text-secondaryPink">
                (12 caractères minimum)
              </span>
            </label>
            <div className="mt-2">
              <div className="flex bg-white rounded-md shadow-sm border">
                <input
                  id="password"
                  name="password"
                  type="password"
                  placeholder="Votre mot de passe"
                  className="block w-full border-0 bg-transparent py-1.5 p-2 text-primaryText placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6"
                  required
                />
              </div>
            </div>
          </div>
          <div className="mb-4">
            <label
              htmlFor="email"
              className="block text-lg font-medium leading-6 text-primaryText"
            >
              Confirmer mot de passe
            </label>
            <div className="mt-2">
              <div className="flex bg-white rounded-md shadow-sm border">
                <input
                  id="repeatPassword"
                  name="repeatPassword"
                  type="password"
                  placeholder="Confirmer votre mot de passe"
                  className="block w-full border-0 bg-transparent py-1.5 p-2 text-primaryText placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6"
                  required
                />
              </div>
            </div>
          </div>
        </fieldset>

        {err && (
          <div className="text-secondaryPink text-center flex justify-center mt-6">
            <p>{err}</p>
          </div>
        )}

        <div className="flex justify-center mt-6 mb-2">
          <DefaultBtn btnType="submit" btnText="Valider" />
        </div>
        <div className="step_paragraph text-primaryText flex justify-center">
          <p>Étape 4/4: Validation d&#39;inscription</p>
        </div>
        <div className="flex justify-center text-secondaryPink mt-1">
          <button type="button" onClick={onPreviousClick}>
            Revenir à l&#39;étape précédente
          </button>
        </div>
      </form>
    </div>
  );
}

export default SubscribeFormV4;
