import { useEffect, useState } from 'react';
import { IContacts } from '../../@types/IContacts';
// import axios from '../../axios';
import { SocketMessage } from '../../@types/ISocketMessage';

interface ConversationPreviewProps {
  confirmation: () => void;
  selectedContact: (newMessages: IContacts) => void;
  contact: IContacts;
  setBadSend: React.Dispatch<React.SetStateAction<boolean>>;
  onSelect: () => void;
  isSelected: boolean;
  switchView: () => void;
  socketMessage: SocketMessage[];
}

export default function ConversationPreview({
  confirmation,
  socketMessage,
  contact,
  selectedContact,
  setBadSend,
  onSelect,
  isSelected,
  switchView,
}: ConversationPreviewProps) {
  // nouveau message
  const lastMessage = contact.messages[contact.messages.length - 1];
  const { message }: { message: string } = lastMessage;
  const [newNotification, setNewNotification] = useState<boolean>(false);
  const [newMessage, setNewMessage] = useState<string>(message);

  /* async function handleReadMessage(contactId: number) {
    await axios.put('private/messages/read', {
      contactId,
    });
  setnewNotification(false);
  } */

  function handleSetNew() {
    if (isSelected) {
      setNewNotification(false);
    }
  }

  // vérifie si dans le message socket que l'id émetteur correspond a celui du
  // contact passé en paramètre
  /* function foundUser() {
    const messageContact = socketMessage.find(
      (messageFrom) => messageFrom.from === contact.id)
    return messageContact;
  } */

  useEffect(() => {
    const even = (noRead: object) => noRead.from === contact.id;
    const last = socketMessage[socketMessage.length - 1];
    if (last?.from === contact.id) {
      setNewMessage(last.message);
      setNewNotification(socketMessage.some(even));
    }
  }, [contact.id, socketMessage]);

  useEffect(() => {
    const even = (noRead) => noRead.sender_id === contact.id && !noRead.read;
    setNewNotification(contact.messages.some(even));
  }, [contact]);

  return (
    <button
      type="button"
      className={`p-2 hover:shadow-around max-md:shadow-md ${isSelected ? 'md:shadow-pink' : ''} w-full rounded-3xl relative`}
      onClick={() => {
        selectedContact(contact);
        setBadSend(false);
        handleSetNew();
        // confirm socket message is read
        if (newNotification) {
          confirmation();
        }
        onSelect();
        // confirm database message is read
        // handleReadMessage(contact.id);
        if (window.innerWidth <= 768) {
          switchView();
        }
      }}
    >
      {newNotification && (
        <span
          className="absolute text-xs italic text-corailNotification top-0 right-0 animate-pulse"
          aria-label="Nouveau message"
        >
          Nouveau
        </span>
      )}
      <div className="flex justify-start">
        <img
          src={contact.picture}
          alt="Expediteur"
          className="aspect-square rounded-full size-20 object-cover shadow-lg"
        />
        <div>
          <h2 className="mb-1.5 text-sm p-2 text-left font-medium text-secondaryPink">
            {contact.name}
          </h2>

          <p
            className={`p-2 ${newNotification ? 'font-semibold text-primaryText' : ''} text-xs text-gray-400 block`}
          >
            {`${newMessage.substring(0, 50)}...`}
          </p>
        </div>
      </div>
    </button>
  );
}
