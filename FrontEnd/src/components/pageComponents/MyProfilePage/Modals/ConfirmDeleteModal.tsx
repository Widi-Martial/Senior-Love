import ReactModal from 'react-modal';
import DefaultBtn from '../../../standaloneComponents/Button/DefaultBtn';

interface ConfirmDeleteModalProps {
  isConfirmDeleteModalOpen: boolean;
  setIsConfirmDeleteModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  handleConfirmDelete: () => void;
  handleCancelDelete: () => void;
}

export default function ConfirmDeleteModal({
  isConfirmDeleteModalOpen,
  setIsConfirmDeleteModalOpen,
  handleConfirmDelete,
  handleCancelDelete,
}: ConfirmDeleteModalProps) {
  return (
    <ReactModal
      isOpen={isConfirmDeleteModalOpen}
      onRequestClose={() => setIsConfirmDeleteModalOpen(false)}
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
      <div className="flex flex-col text-center gap-3">
        <p className="flex flex-col">
          Êtes-vous sûr de vouloir supprimer votre compte ?
          <span className="text-red-500 font-medium">
            Cette action est irréversible.
          </span>
        </p>
        <div className="mt-4 flex gap-2">
          <DefaultBtn
            btnText="Oui, supprimer"
            onClick={handleConfirmDelete}
            btnDelete
            btnModalDelete
          />
          {/* <button
            className="bg-buttonGreen hover:bg-red-500 text-black font-bold py-2 px-4 rounded mr-2"
            onClick={handleConfirmDelete}
            type="button"
          >
            Oui, supprimer
          </button> */}
          <DefaultBtn
            btnText="Annuler"
            onClick={handleCancelDelete}
            btnModalDelete
          />
          {/* <button
            className="bg-secondaryPink hover:bg-gray-500 text-white font-bold py-2 px-4 rounded"
            onClick={handleCancelDelete}
            type="button"
          >
            Annuler
          </button> */}
        </div>
      </div>
      <div className="flex flex-col gap-4 mt-4" />
    </ReactModal>
  );
}
