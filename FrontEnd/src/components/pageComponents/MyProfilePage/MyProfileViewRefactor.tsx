// TODO: add | hobbies, email, password, picture | update
import { useNavigate, useParams } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { AxiosError } from 'axios';
import { IUsers } from '../../../@types/IUsers';
import {
  removeTokenFromLocalStorage,
  updateDataInLocalStorage,
} from '../../../localStorage/localStorage';

import axios from '../../../axios';
import EventSticker from '../../standaloneComponents/EventSticker/EventSticker';
import DefaultBtn from '../../standaloneComponents/Button/DefaultBtn';
import Error500Page from '../../../pages/Error500Page';
import editLogo from '/icon/edit.svg';
import Loader from '../../standaloneComponents/Loader/Loader';
import EditImageModal from './Modals/EditImageModal';
import EditHobbyModal from './Modals/EditHobbyModal';
import ConfirmDeleteModal from './Modals/ConfirmDeleteModal';
import EditNameModal from './Modals/EditNameModal';
import EditAboutModal from './Modals/EditAboutModal';
import EditMailModal from './Modals/EditMailModal';
import EditPasswordlModal from './Modals/EditPasswordModal';

interface MyProfileViewRefactorProps {
  setIsAuthenticated: React.Dispatch<React.SetStateAction<boolean>>;
}

export default function MyProfileViewRefactor({
  setIsAuthenticated,
}: MyProfileViewRefactorProps) {
  // Get the user ID from the URL parameters
  const { myId } = useParams<{ myId: string }>();

  // Use the navigate function from react-router-dom
  const navigate = useNavigate();

  // STATE 1 : my profile
  const [me, setMe] = useState<IUsers | null>(null);

  // STATE 2 : loading
  const [isLoading, setIsLoading] = useState<boolean>(true);

  // STATE 3 : error server
  const [serverError, setServerError] = useState(false);

  // STATE 4 : image modal
  const [isImageModalOpen, setIsImageModalOpen] = useState(false);

  // STATE 5 : hobbies modal
  const [isHobbyModalOpen, setIsHobbyModalOpen] = useState(false);

  // STATE 6 : name modal
  const [isNameModalOpen, setIsNameModalOpen] = useState(false);
  const [NewName, setNewName] = useState('');

  // STATE 7 : about modal
  const [isAboutModalOpen, setIsAboutModalOpen] = useState(false);
  const [NewAbout, setNewAbout] = useState('');

  // STATE 8 : modified photo URL
  const [modifiedPhotoUrl, setModifiedPhotoUrl] = useState<string | null>(null);

  // STATE 9 : editing mode
  const [isEditing, setIsEditing] = useState<boolean>(false);

  // STATE 10 : edited profile
  const [editedProfile, setEditedProfile] = useState<Partial<IUsers>>({});

  // STATE 11 : confirm delete modal
  const [isConfirmDeleteModalOpen, setIsConfirmDeleteModalOpen] =
    useState<boolean>(false);

  const [isPhotoLoading, setIsPhotoLoading] = useState<boolean>(false);

  const [isEmailModalOpen, setIsEmailModalOpen] = useState(false);
  const [isPasswordModalOpen, setIsPasswordModalOpen] = useState(false);

  // Fetch the connected user using useEffect
  useEffect(() => {
    // Fetch the connected user
    const fetchConnectedUser = async () => {
      try {
        const response = await axios.get(`/private/users/me`);
        setMe(response.data);
        setEditedProfile(response.data);
        setNewName(me?.name || '');
        setNewAbout(me?.description || '');
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
    fetchConnectedUser();
  }, [myId, navigate, me?.name, me?.description]);

  // Delete account function
  const deleteAccount = async () => {
    try {
      await axios.delete(`/private/users/me/delete`);
      setIsAuthenticated(false);
      removeTokenFromLocalStorage();
      navigate('/');
    } catch (e) {
      console.error(e);
      setServerError(true);
    }
  };

  const handleDeleteClick = () => {
    // Affiche la modale de confirmation
    // setShowModal(true);
    setIsConfirmDeleteModalOpen(true);
  };

  const handleConfirmDelete = () => {
    // Confirmation de la suppression
    deleteAccount();
  };

  const handleCancelDelete = () => {
    // Annulation de la suppression
    setIsConfirmDeleteModalOpen(false);
  };

  // Handle submit function
  const handleSubmit = async () => {
    try {
      // Prepare the data to send to the backend
      const dataToSend = {
        name: editedProfile.name,
        description: editedProfile.description,
        gender: editedProfile.gender,
        picture: editedProfile.picture,
        picture_id: editedProfile.picture_id,
        // TODO déplacer la partie changement de mot de passe et mail
        email: editedProfile.email,
        old_password: editedProfile.old_password,
        new_password: editedProfile.new_password,
        repeat_new_password: editedProfile.repeat_new_password,
        hobbies: editedProfile.hobbies,
      };

      const response = await axios.patch(`/private/users/me`, dataToSend);
      setMe(response.data);
      updateDataInLocalStorage(response.data.picture, response.data.name);
      // localStorage.setItem('name', response.data.name); // TODO: fix this with useState
      setIsEditing(false);
    } catch (e) {
      console.error(e);
      setServerError(true);
    }
  };

  // Handle edit toggle function
  const handleEditToggle = () => {
    if (isEditing) {
      handleSubmit();
    } else {
      setIsEditing(true);
      setEditedProfile(me || {});
    }
  };

  const handleCancelEdit = () => {
    setIsEditing(false);
    setNewName(me?.name || '');
    setNewAbout(me?.description || '');
  };

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

  if (!me) {
    return <Error500Page />;
  }

  return (
    <div className="w-full min-h-full flex-grow flex flex-col items-center justify-between bg-primaryGrey">
      <div className="flex flex-col pt-8 px-8 max-w-7xl w-full gap-10 md:flex-row">
        {/* Aside in desktop view */}
        <div className="flex flex-col items-center gap-5 md:w-1/3">
          {/* Profile picture */}
          <div className="relative">
            {isPhotoLoading ? (
              <Loader />
            ) : (
              <>
                {isEditing && (
                  <button
                    type="button"
                    onClick={() => {
                      setIsImageModalOpen(true);
                    }}
                    className="bg-white border border-gray-300 shadow p-1 rounded-2xl absolute top-2 left-2"
                  >
                    <img src={editLogo} alt="edit" className="w-6 h-6" />
                  </button>
                )}
                <img
                  src={modifiedPhotoUrl || me.picture}
                  alt={me.name}
                  className="max-w-64 md:max-w-full rounded-md border border-secondaryPink"
                />
              </>
            )}
          </div>

          <div className="font-semibold flex flex-col text-center justify-between md:hidden">
            {/* Name & Age */}
            <div>
              {isEditing ? (
                <button
                  type="button"
                  onClick={() => {
                    setIsNameModalOpen(true);
                  }}
                  className="p-1 rounded-2xl"
                >
                  <div className="flex gap-2 items-center">
                    <img src={editLogo} alt="edit" className="w-6 h-6" />
                    <span className="text-3xl text-secondaryPink hover:text-secondaryPinkHover">
                      {NewName}
                    </span>
                  </div>
                </button>
              ) : (
                <div>
                  <span className="text-3xl text-secondaryPink">{me.name}</span>
                  , {me.age} ans
                </div>
              )}
            </div>
            {/* Edit button */}
            <div className="flex pt-4 gap-3">
              <DefaultBtn
                btnText={isEditing ? 'Sauvegarder' : 'Éditer mon profil'}
                btnPage="profile"
                btnEdit={isEditing}
                onClick={handleEditToggle}
              />
              {isEditing && (
                <DefaultBtn
                  btnText="Annuler"
                  btnPage="profile"
                  btnEdit={!isEditing}
                  onClick={handleCancelEdit}
                />
              )}
            </div>
          </div>
          {/* Hobbies */}
          <div>
            {/* Title */}
            <div className="flex flex-row gap-2 items-center justify-center w-full">
              {isEditing ? (
                <button
                  type="button"
                  onClick={() => {
                    setIsHobbyModalOpen(true);
                  }}
                >
                  <h2 className="text-xl w-full flex gap-2 font-semibold text-secondaryPink hover:text-secondaryPinkHover pb-3 text-center">
                    <img src={editLogo} alt="edit" className="w-6 h-6" />{' '}
                    Modifiez vos centres d&apos;intérêt
                  </h2>
                </button>
              ) : (
                <h2 className="text-xl w-full font-semibold text-secondaryPink pb-3 text-center">
                  Mes Centres d&apos;intérêt
                </h2>
              )}
            </div>
            {/* Hobbies list */}
            <div className="flex flex-wrap justify-around gap-2">
              {me.hobbies.map((hobby) => (
                <span
                  key={hobby.id}
                  className="bg-primaryPink text-primaryText font-medium rounded-lg text-sm py-1 px-2"
                >
                  {hobby.name}
                </span>
              ))}
            </div>
          </div>
        </div>

        {/* Main content */}
        <div className="md:w-2/3 flex flex-col gap-3 md:gap-6">
          <div className="hidden font-semibold md:flex text-center justify-between">
            {/* Name & Age */}
            <div>
              {isEditing ? (
                <button
                  type="button"
                  onClick={() => {
                    setIsNameModalOpen(true);
                  }}
                  className="p-1 rounded-2xl"
                >
                  <div className="flex gap-2 items-center">
                    <img src={editLogo} alt="edit" className="w-6 h-6" />
                    <span className="text-3xl text-secondaryPink hover:text-secondaryPinkHover">
                      {NewName}
                    </span>
                  </div>
                </button>
              ) : (
                <div>
                  <span className="text-3xl text-secondaryPink">{me.name}</span>
                  , {me.age} ans
                </div>
              )}
            </div>
            {/* Edit button desktop */}
            <div className="flex gap-3 items-center">
              <DefaultBtn
                btnText={isEditing ? 'Sauvegarder' : 'Editer mon profil'}
                btnPage="profile"
                btnEdit={isEditing}
                onClick={handleEditToggle}
              />
              {isEditing && (
                <DefaultBtn
                  btnText="Annuler"
                  btnPage="profile"
                  btnEdit={!isEditing}
                  onClick={handleCancelEdit}
                />
              )}
            </div>
          </div>
          {/* Description */}
          <div>
            {isEditing ? (
              <>
                <button
                  type="button"
                  onClick={() => {
                    setIsAboutModalOpen(true);
                  }}
                  className="p-1 rounded-2xl"
                >
                  <div className="flex gap-2 justify-center md:text-left">
                    <img src={editLogo} alt="edit" className="w-6 h-6" />
                    <h3 className="text-xl text-secondaryPink hover:text-secondaryPinkHover text-center font-semibold pb-3 md:text-left ">
                      A propos de moi :
                    </h3>
                  </div>
                </button>
                <p className="text-primaryText text-justify">{NewAbout}</p>
              </>
            ) : (
              <>
                <h3 className="text-xl text-secondaryPink text-center font-semibold pb-3 md:text-left ">
                  A propos de moi :
                </h3>
                <p className="text-primaryText text-justify">
                  {me.description}
                </p>
              </>
            )}
          </div>

          {isEditing && (
            <div className="flex flex-row justify-center gap-6">
              <button
                type="button"
                onClick={() => setIsEmailModalOpen(true)}
                className="text-secondaryPink text-center md:text-start px-4 rounded-lg w-fit font-semibold"
              >
                <div className="flex gap-2 self items-center">
                  <img src={editLogo} alt="edit" className="w-6 h-6" />
                  Modifier l&apos;adresse e-mail
                </div>
              </button>
              <button
                type="button"
                onClick={() => setIsPasswordModalOpen(true)}
                className="text-secondaryPink hover:text-secondaryPinkHover text-center md:text-start px-4 py-2 rounded-lg w-fit font-semibold"
              >
                <div className="flex gap-2 self items-center">
                  <img src={editLogo} alt="edit" className="w-6 h-6" />
                  Modifier le mot de passe
                </div>
              </button>
            </div>
          )}

          {/* Events */}
          <div className="pt-8">
            <h3 className="text-xl text-secondaryPink text-center font-semibold md:text-black pb-3">
              Mes prochaines sorties :
            </h3>
            {me.events && me.events.length > 0 ? (
              <div className="flex flex-wrap justify-center gap-5 md:gap-10 pt-5">
                {me.events.map((event) => (
                  <EventSticker event={event} key={event.id} page="profile" />
                ))}
              </div>
            ) : (
              <p className="text-center pt-6">
                Je ne suis actuellement enregistré à aucun futur événement.
              </p>
            )}
          </div>
        </div>
      </div>

      {/* Delete */}
      <div className="pb-8 pt-32 md:pt-16">
        <DefaultBtn
          btnText="Supprimer mon compte"
          btnPage="profile"
          btnDelete
          onClick={handleDeleteClick}
        />
      </div>
      {isEmailModalOpen && (
        <EditMailModal
          isEmailModalOpen={isEmailModalOpen}
          setIsEmailModalOpen={setIsEmailModalOpen}
          user={me}
          setEditedProfile={setEditedProfile}
        />
      )}
      {isPasswordModalOpen && (
        <EditPasswordlModal
          isPasswordModalOpen={isPasswordModalOpen}
          setIsPasswordModalOpen={setIsPasswordModalOpen}
          setEditedProfile={setEditedProfile}
        />
      )}
      {isImageModalOpen && (
        <EditImageModal
          isImageModalOpen={isImageModalOpen}
          setIsImageModalOpen={setIsImageModalOpen}
          setEditedProfile={setEditedProfile}
          setModifiedPhotoUrl={setModifiedPhotoUrl}
          setIsPhotoLoading={setIsPhotoLoading}
          user={me}
        />
      )}
      {isNameModalOpen && (
        <EditNameModal
          isNameModalOpen={isNameModalOpen}
          setIsNameModalOpen={setIsNameModalOpen}
          user={me}
          setEditedProfile={setEditedProfile}
          isNewName={NewName}
          setNewName={setNewName}
        />
      )}
      {isAboutModalOpen && (
        <EditAboutModal
          isAboutModalOpen={isAboutModalOpen}
          setIsAboutModalOpen={setIsAboutModalOpen}
          user={me}
          setEditedProfile={setEditedProfile}
          isNewAbout={NewAbout}
          setNewAbout={setNewAbout}
        />
      )}
      {isHobbyModalOpen && (
        <EditHobbyModal
          isHobbyModalOpen={isHobbyModalOpen}
          setIsHobbyModalOpen={setIsHobbyModalOpen}
          setEditedProfile={setEditedProfile}
          user={me}
        />
      )}
      {isConfirmDeleteModalOpen && (
        <ConfirmDeleteModal
          isConfirmDeleteModalOpen={isConfirmDeleteModalOpen}
          setIsConfirmDeleteModalOpen={setIsConfirmDeleteModalOpen}
          handleConfirmDelete={handleConfirmDelete}
          handleCancelDelete={handleCancelDelete}
        />
      )}
      {serverError && (
        <p className="text-red-600 mt-4">
          Une erreur est survenue lors de la suppression du compte.
        </p>
      )}
    </div>
  );
}
