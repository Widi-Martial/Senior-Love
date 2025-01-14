import { useState } from 'react';
import Error500Page from '../../pages/Error500Page';

interface EditMessage {
  // setBadSend: React.Dispatch<React.SetStateAction<boolean>>;
  badSend: boolean;
  send: (message: string, receiverId: number) => void;
  receiverId: number;
  confirmation: (to: number) => void;
}
export default function EditMessagesForm({
  send,
  receiverId,
  badSend,
  confirmation,

  // setBadSend,
}: EditMessage) {
  // STATE 1 : message
  const [message, setMessage] = useState<string>('');
  // STATE 2 : error server
  const [serverError, setServerError] = useState(false);

  /* const submitMessage = async () => {
    // Check if message is not empty before sending to API
    /* if (message.toString().length === 0) {
      return;
    }
    try {
      await axios.post('/private/messages', {
        message,
        receiver_id: receiverId,
      });
      send(receiverId);
      setMessage('');
    } catch (err) {
      console.error(err);
      if (err instanceof AxiosError && err.response?.status === 403) {
        setBadSend(true);
        setMessage('');
      } else {
        setServerError(true);
      }
    }
  }; */

  const handleKeyPress = (event: React.KeyboardEvent) => {
    if (event.key === 'Enter') {
      event.preventDefault(); // Prevents the default action (form submission or new line in a textarea)
      send(message, receiverId);
      setMessage('');
    }
  };

  if (serverError) {
    return <Error500Page />;
  }

  return (
    <form
      action="post"
      className="bg-transparent shadow-message"
      id="formMessage"
    >
      {badSend && (
        <p className="text-red-500 text-xs text-center">
          Ce contact n&aposest plus disponible pour recevoir des messages.
        </p>
      )}
      <input
        type="text"
        name="sendMessage"
        placeholder="Ecrivez un message..."
        className="border-y shadow-inner w-full h-15 px-2"
        value={message}
        onChange={(e) => {
          setMessage(e.target.value);
        }}
        onKeyDown={handleKeyPress}
        // TODO: fix la confirmation sur les nouveaux messages uniquement
        onClick={() => confirmation(receiverId)}
      />
      <button
        type="button"
        className="min-w-44 bg-secondaryPink hover:bg-secondaryPinkHover
         hover:text-white text-white font-bold text-lg rounded-full shadow-md py-1 px-4 block mx-auto my-4"
        aria-label="Envoyer le message"
        onClick={() => {
          send(message, receiverId);
          setMessage('');
        }}
      >
        Envoyer
      </button>
    </form>
  );
}
