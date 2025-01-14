import ReactModal from 'react-modal';
import { useState } from 'react';
import { IUsers } from '../../../../@types/IUsers';
import DefaultBtn from '../../../standaloneComponents/Button/DefaultBtn';

interface EditImageModalProps {
  isImageModalOpen: boolean;
  setIsImageModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  user: IUsers;
  setEditedProfile: React.Dispatch<React.SetStateAction<Partial<IUsers>>>;
  setModifiedPhotoUrl: React.Dispatch<React.SetStateAction<string | null>>;
  setIsPhotoLoading: React.Dispatch<React.SetStateAction<boolean>>;
}

export default function EditImageModal({
  isImageModalOpen,
  setIsImageModalOpen,
  user,
  setEditedProfile,
  setModifiedPhotoUrl,
  setIsPhotoLoading,
}: EditImageModalProps) {
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [previewUrl, setPreviewUrl] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files ? e.target.files[0] : null;
    if (file) {
      setSelectedFile(file);
    }
    // Create a preview of the selected image
    const reader = new FileReader();
    reader.onloadend = () => {
      setPreviewUrl(reader.result as string);
    };

    if (file) {
      reader.readAsDataURL(file as Blob);
    }
  };

  const handleImageUpload = async () => {
    if (!selectedFile) {
      console.error('No file selected');
      return;
    }

    setIsPhotoLoading(true);
    setError(null);

    const formData = new FormData();
    formData.append('new-image', selectedFile);

    try {
      const response = await fetch(
        `http://localhost:4000/api/private/users/${user.id}/uploadPhoto`,
        {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`,
          },
          body: formData,
        }
      );

      const result = await response.json();
      if (response.ok) {
        setEditedProfile((prev) => ({ ...prev, picture: result.pictureUrl }));
        setEditedProfile((prev) => ({ ...prev, picture_id: result.pictureId }));
        setModifiedPhotoUrl(result.pictureUrl);
        setIsImageModalOpen(false); // Close modal after success
      } else {
        setError(result.error || 'Image upload failed');
      }
    } catch (err) {
      setError('Error uploading image');
      console.error('Error uploading image:', error);
    } finally {
      setIsPhotoLoading(false);
    }
  };

  const validateImage = async () => {
    handleImageUpload();
    setIsImageModalOpen(false);
  };

  return (
    <ReactModal
      isOpen={isImageModalOpen}
      onRequestClose={() => setIsImageModalOpen(false)}
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
        Changez votre image
      </h3>
      <div className="flex flex-col gap-4 mt-4">
        <div className="flex flex-col gap-6">
          <div className="flex flex-col items-center">
            <img
              src={user.picture} // Replace with actual image path
              alt={user.name}
              className="w-1/2 object-cover rounded-md border border-gray-300"
            />
            <p className="mt-2 text-gray-600">Ancienne image</p>
          </div>

          <div className="flex flex-col items-center">
            <input
              type="file"
              name="new-image"
              id="new-image"
              className="border border-gray-300 rounded-lg px-3 py-2 text-gray-700 mb-2"
              onChange={handleFileChange}
            />
            {previewUrl && (
              <>
                <p className="mt-2 text-gray-600">Nouvelle image</p>
                <img
                  src={previewUrl}
                  alt={user.name}
                  className="w-1/2 object-cover rounded-md shadow border border-gray-300"
                />
              </>
            )}
          </div>
        </div>
        <DefaultBtn btnText="Valider" onClick={() => validateImage()} />
      </div>
    </ReactModal>
  );
}
