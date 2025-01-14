import ReactModal from 'react-modal';
import { IUsers } from '../../../../@types/IUsers';
import DefaultBtn from '../../../standaloneComponents/Button/DefaultBtn';

interface EditAboutProps {
  user: IUsers;
  isAboutModalOpen: boolean;
  setIsAboutModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  setEditedProfile: React.Dispatch<React.SetStateAction<Partial<IUsers>>>;
  isNewAbout: string;
  setNewAbout: React.Dispatch<React.SetStateAction<string>>;
}

export default function EditAboutModal({
  user,
  setEditedProfile,
  isAboutModalOpen,
  setIsAboutModalOpen,
  isNewAbout,
  setNewAbout,
}: EditAboutProps) {
  const validateAbout = async () => {
    setEditedProfile((prev) => ({ ...prev, about: isNewAbout }));
    setIsAboutModalOpen(false);
  };
  return (
    <ReactModal
      isOpen={isAboutModalOpen}
      onRequestClose={() => setIsAboutModalOpen(false)}
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
        Modifiez votre description
      </h3>
      <div className="flex flex-col gap-3">
        <textarea
          name="new-description"
          id="new-description"
          onChange={(e) => setNewAbout(e.target.value)}
          rows={10}
          placeholder={user.description}
          className="border border-gray-300 rounded-lg px-3 py-2 text-gray-700"
        />
      </div>
      <div className="flex flex-col gap-4 mt-4">
        <DefaultBtn btnText="Valider" onClick={validateAbout} />
      </div>
    </ReactModal>
  );
}
