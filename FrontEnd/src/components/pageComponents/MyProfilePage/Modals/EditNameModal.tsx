import ReactModal from 'react-modal';
import { IUsers } from '../../../../@types/IUsers';
import DefaultBtn from '../../../standaloneComponents/Button/DefaultBtn';

interface EditNameProps {
  user: IUsers;
  isNameModalOpen: boolean;
  setIsNameModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  setEditedProfile: React.Dispatch<React.SetStateAction<Partial<IUsers>>>;
  isNewName: string;
  setNewName: React.Dispatch<React.SetStateAction<string>>;
}

export default function EditNameModal({
  user,
  setEditedProfile,
  isNameModalOpen,
  setIsNameModalOpen,
  isNewName,
  setNewName,
}: EditNameProps) {
  const validateName = async () => {
    setEditedProfile((prev) => ({ ...prev, name: isNewName }));
    setIsNameModalOpen(false);
  };
  return (
    <ReactModal
      isOpen={isNameModalOpen}
      onRequestClose={() => setIsNameModalOpen(false)}
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
      <h3 className="text-xl font-semibold text-secondaryPink mb-4">
        Modifiez votre prénom
      </h3>
      <div className="flex flex-col gap-3">
        <input
          type="text"
          name="new-text"
          id="new-text"
          onChange={(e) => setNewName(e.target.value)}
          placeholder={user.name}
          className="border border-gray-300 rounded-lg px-3 py-2 text-gray-700"
        />
      </div>
      <div className="flex flex-col gap-4 mt-4">
        <DefaultBtn btnText="Valider" onClick={validateName} />
      </div>
    </ReactModal>
  );
}
