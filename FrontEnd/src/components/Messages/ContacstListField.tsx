import { useEffect, useState } from 'react';
import ConversationPreview from './ConversationPreview';
import { IContacts } from '../../@types/IContacts';
import { SocketMessage } from '../../@types/ISocketMessage';

interface ContactInterface {
  selectedContact: (message: IContacts) => void;
  listContacts: IContacts[];
  setBadSend: React.Dispatch<React.SetStateAction<boolean>>;
  confirmation: (to: number) => void;
  toggleDisplay: boolean;
  switchView: () => void;
  socketMessage: SocketMessage[];
}

export default function ContactsListField({
  confirmation,
  socketMessage,
  listContacts,
  selectedContact,
  setBadSend,
  toggleDisplay,
  switchView,
}: ContactInterface) {
  const [isSelected, setIsSelected] = useState<boolean[]>([]);

  // mettre en surbrillance le contact séléctionné
  function handleSelected(index: number) {
    const newSelected = new Array(isSelected.length).fill(false);
    newSelected[index] = true;
    setIsSelected(newSelected);
  }

  useEffect(() => {
    const set = () => {
      // fournis un tableau de taille identique a listcontact vide remplis de false
      // selectionne le premier contact par defaut
      setIsSelected([...Array(listContacts.length).fill(false)]);
      const newDefaultList = [...isSelected];
      newDefaultList[0] = true;
      setIsSelected(newDefaultList);
      handleSelected(0);
    };
    set();
  }, [listContacts]);

  return (
    <div
      className={`md:rounded-l-3xl max-md:rounded-3xl overflow-y-scroll 
        md:overflow-y-auto p-4 bg-white border flex-col ${toggleDisplay ? 'flex' : 'hidden'} 
        gap-y-2 items-center md:w-3/5 h-[calc(100vh-300px)] md:h-[calc(100vh-400px)]`}
    >
      <p className="italic text-secondaryPink">Messages</p>
      {listContacts.map((contact, i) => {
        // fourni l'id du contact a la fonction founduser
        // const find = foundUser(contact.id);
        return (
          <ConversationPreview
            key={contact.id}
            contact={contact}
            setBadSend={setBadSend}
            selectedContact={selectedContact}
            onSelect={() => handleSelected(i)}
            isSelected={isSelected[i]}
            switchView={switchView}
            socketMessage={socketMessage}
            confirmation={() => confirmation(contact.id)}
          />
        );
      })}
    </div>
  );
}
