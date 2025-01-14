import ReactModal from 'react-modal';
import { useState } from 'react';
import DefaultBtn from '../../../standaloneComponents/Button/DefaultBtn';
import { IUsers } from '../../../../@types/IUsers';

interface EditPasswordModalProps {
  isPasswordModalOpen: boolean;
  setIsPasswordModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  setEditedProfile: React.Dispatch<React.SetStateAction<Partial<IUsers>>>;
}

export default function EditPasswordlModal({
  isPasswordModalOpen,
  setIsPasswordModalOpen,
  setEditedProfile,
}: EditPasswordModalProps) {
  const [oldPassword, setOldPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');

  const validatePassword = async () => {
    // need to find a way to compare oldPassword with password
    if (!oldPassword || !newPassword || !confirmPassword) {
      setErrorMessage('Tous les champs doivent être remplis.');
    } else if (newPassword.length < 12) {
      setErrorMessage(
        'Le nouveau mot de passe doit contenir au moins 12 caractères.'
      );
    } else if (newPassword !== confirmPassword) {
      setErrorMessage(
        'Le nouveau mot de passe et la confirmation ne correspondent pas.'
      );
    } else if (newPassword === oldPassword) {
      setErrorMessage(
        "Le nouveau mot de passe doit être différent de l'ancien."
      );
    } else {
      setEditedProfile((prev) => ({ ...prev, old_password: oldPassword }));
      setEditedProfile((prev) => ({ ...prev, new_password: newPassword }));
      setEditedProfile((prev) => ({
        ...prev,
        repeat_new_password: confirmPassword,
      }));
      setIsPasswordModalOpen(false);
    }
  };
  return (
    <ReactModal
      isOpen={isPasswordModalOpen}
      onRequestClose={() => setIsPasswordModalOpen(false)}
      style={{
        content: {
          width: '80vw',
          height: 'fit-content',
          maxWidth: '500px',
          margin: 'auto',
          padding: '20px',
          borderRadius: '8px',
          backgroundColor: 'white',
          boxShadow: '0 4px 6px rgba(0, 0, 0, 0.1)',
        },
        overlay: {
          backgroundColor: 'rgba(0, 0, 0, 0.5)' /* Customize overlay color */,
        },
      }}
    >
      <h3 className="text-xl font-semibold text-secondaryPink">
        Changer votre mot de passe
      </h3>
      <div className="flex flex-col gap-4 mt-4">
        <div className="flex flex-col gap-3">
          <label
            htmlFor="old-password"
            className="font-medium text-secondaryPink"
          >
            Mot de passe actuel
          </label>
          <input
            type="password"
            name="old-password"
            id="old-password"
            onChange={(e) => setOldPassword(e.target.value)}
            placeholder="Entrez votre mot de passe actuel"
            className="border border-gray-300 rounded-lg px-3 py-2 text-gray-700"
          />
        </div>
        <div className="flex flex-col gap-3">
          <label
            htmlFor="new-password"
            className="font-medium text-secondaryPink"
          >
            Nouveau mot de passe
          </label>
          <input
            type="password"
            name="new-password"
            id="new-password"
            onChange={(e) => setNewPassword(e.target.value)}
            placeholder="Entrez le nouveau mot de passe"
            className="border border-gray-300 rounded-lg px-3 py-2 text-gray-700"
          />
        </div>
        <div className="flex flex-col gap-3">
          <label
            htmlFor="confirm-password"
            className="font-medium text-secondaryPink"
          >
            Confirmez le nouveau mot de passe
          </label>
          <input
            type="password"
            name="confirm-password"
            id="confirm-password"
            onChange={(e) => setConfirmPassword(e.target.value)}
            placeholder="Confirmez le nouveau mot de passe"
            className="border border-gray-300 rounded-lg px-3 py-2 text-gray-700"
          />
          {errorMessage && (
            <p className="text-red-600 text-sm text-center">{errorMessage}</p>
          )}
        </div>
        <DefaultBtn btnText="Valider" onClick={() => validatePassword()} />
      </div>
    </ReactModal>
  );
}
