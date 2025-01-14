import { useEffect, useState, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { AxiosError } from 'axios';
import axios from '../../axios';
import ContactsListField from './ContacstListField';
import EditMessagesForm from './EditMessagesForm';
import SentMessage from './SentMessage';
import { IContacts } from '../../@types/IContacts';
import Loader from '../standaloneComponents/Loader/Loader';
import Error500Page from '../../pages/Error500Page';
import {
  getTokenAndDataFromLocalStorage,
  removeTokenFromLocalStorage,
} from '../../localStorage/localStorage';
import DefaultBtn from '../standaloneComponents/Button/DefaultBtn';
import SOCKET from '../../socketIO';
import ReceivedMessage from './ReceivedMessage';
import { SocketMessage } from '../../@types/ISocketMessage';

export default function MessagesField() {
  const messagesContainerRef = useRef<HTMLDivElement>(null);
  // STATE 1 : données de tous les messages
  const [messagesData, setMessagesData] = useState<IContacts[]>([]);
  // STATE 2 : données du message a afficher
  const [displayMessages, setDisplayMessages] = useState<IContacts>();
  // STATE 3 : status de l'envoi du message et id destinataire
  const [sendMessage, setSendMessage] = useState({
    sendStatus: false,
    lastReceiverId: displayMessages?.id,
  });
  // STATE 4 : state pour changer les classe css en fonction de la taille d'écran
  const [toggleDisplay, setToggleDisplay] = useState<boolean>(false);
  // STATE 5 : state pour indiquer que l'api renvoi une 403 (user not found  ou blocked)
  const [badSend, setBadSend] = useState<boolean>(false);

  // STATE 6 : loading
  const [isLoading, setIsLoading] = useState<boolean>(true);

  // STATE 7 : error server
  const [serverError, setServerError] = useState(false);
  const [socketMessage, setSocketMessage] = useState<SocketMessage[]>([]);
  // const [usernameAlreadySelected, setUsernameAlreadySelected] = useState<boolean>();

  const [isView, setIsView] = useState<boolean[]>([]);
  // Import of navigate to force redirection when forced logged out
  const navigate = useNavigate();

  // connexion du socket
  useEffect(() => {
    const sessionID = getTokenAndDataFromLocalStorage()?.token;
    if (sessionID) {
      // setUsernameAlreadySelected(true);
      SOCKET.auth = { sessionID };
      SOCKET.connect();
    }
    return () => {
      SOCKET.disconnect();
    };
  }, []);

  // TODO: A refaire
  useEffect(() => {
    const fetchMessages = async () => {
      try {
        const result = await axios.get('/private/contacts');
        setMessagesData(result.data);

        if (sendMessage.lastReceiverId) {
          setDisplayMessages(
            result.data.find(
              (data: IContacts) => data.id === sendMessage.lastReceiverId
            )
          );
        } else {
          setDisplayMessages(result.data[0]);
        }
      } catch (err) {
        console.error(err);
        if (
          err instanceof AxiosError &&
          (err.response?.data.blocked || err.response?.status === 401)
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
    fetchMessages();
    // passe le display a true pour l'affichage par default des classes css
    if (window.innerWidth >= 768) {
      setToggleDisplay(true);
    }
  }, [navigate, sendMessage]);

  const handleUpdateMessages = (newMessages: IContacts) => {
    setDisplayMessages(newMessages);
    // console.log(displayMessages);
  };

  // mettre a jour le statut des messages lu
  useEffect(() => {
    const setView = () => {
      setIsView([...Array(socketMessage.length).fill(false)]);
    };
    setView();
  }, [socketMessage]);

  // envoi du message au serveur via socketIO
  const handleSendMessages = (message: string, to: number) => {
    SOCKET.emit('Chat Message', {
      message,
      to,
    });
    setSocketMessage([
      ...socketMessage,
      { message, fromSelf: true, from: SOCKET.userID, to, date: new Date() },
    ]);
    setSendMessage({ lastReceiverId: to, sendStatus: false });
  };

  // envoi de confirmation de lecture
  const handleConfirmReceipt = (to: number) => {
    SOCKET.emit('Read Receipt', {
      to,
      read: true,
    });
  };

  // ecoute sur la confirmation de lecture
  SOCKET.on('Read Receipt', (confirmation) => {
    const newViewList = [...isView];
    newViewList[newViewList.length - 1] = confirmation.read;
    setIsView(newViewList);
  });

  // Ecoutes des messages reçu de l'utilisateur
  useEffect(() => {
    SOCKET.on('Chat Message', (receiveMessage) => {
      const { message, from, to } = receiveMessage;
      // console.log(receiveMessage);
      setSocketMessage((prevMessage) => [
        ...prevMessage,
        { message, date: new Date(), fromSelf: false, from, to },
      ]);
    });
    return () => {
      SOCKET.off('Chat Message');
    };
  });

  // changer l'état de toggle pour indiquer aux classes css de changer l'affichage
  const handleToggleMessageView = () => {
    setToggleDisplay(false);
  };

  const idSent = Number(displayMessages?.id);

  useEffect(() => {
    if (messagesContainerRef.current) {
      messagesContainerRef.current.scrollTop =
        messagesContainerRef.current.scrollHeight;
    }
  }, [displayMessages]);

  if (serverError) {
    return <Error500Page />;
  }

  if (isLoading) {
    return <Loader />;
  }

  // messages from database
  const messageData = displayMessages?.messages.map((message) => {
    if (displayMessages.id === message.sender_id) {
      return (
        <ReceivedMessage
          receiveMessage={message.message}
          userId={displayMessages.id}
          key={message.id}
          picture={displayMessages.picture}
          time={message.created_at}
        />
      );
    }
    return (
      <SentMessage
        sentMessage={message.message}
        key={message.id}
        isView={message.read}
      />
    );
  });

  // messages from socketIO
  const chatMessages = socketMessage.map(
    (chatMessage: SocketMessage, i: number) => {
      if (chatMessage.from === displayMessages?.id) {
        return (
          <ReceivedMessage
            receiveMessage={chatMessage.message}
            picture={displayMessages?.picture}
            userId={displayMessages?.id}
            time={chatMessage.date}
            key={
              // todo : mettre l'index
              displayMessages?.id * Math.floor(Math.random() * 1000)
            }
          />
        );
      }
      if (chatMessage.to === displayMessages?.id) {
        return (
          <SentMessage
            sentMessage={chatMessage.message}
            key={displayMessages?.id * Math.floor(Math.random() * 1000)}
            isView={isView[i]}
            to={chatMessage.to}
            contactID={displayMessages.id}
          />
        );
      }
      return null;
    }
  );

  return (
    <main
      className="flex flex-col w-full items-center justify-center
     bg-backgroundPink pb-8 flex-1"
    >
      <div className="w-full lg:w-5/6 xl:w-4/6 px-3">
        {!toggleDisplay && (
          <div className="mt-4">
            <DefaultBtn
              btnText="Revenir aux contacts"
              btnMessageMobile
              onClick={() => setToggleDisplay(true)}
            />
          </div>
        )}
        {messagesData.length === 0 ? (
          <p className="text-center font-semibold pt-6">
            Vous n&apos;avez pas de messages !
          </p>
        ) : (
          <div className="md:flex mt-6 md:w-full">
            <ContactsListField
              listContacts={messagesData}
              selectedContact={handleUpdateMessages}
              setBadSend={setBadSend}
              toggleDisplay={toggleDisplay}
              switchView={handleToggleMessageView}
              socketMessage={socketMessage}
              confirmation={handleConfirmReceipt}
            />
            <div
              className={`${toggleDisplay ? 'hidden' : ''} md:block w-full `}
            >
              <div
                className="md:rounded-r-3xl max-md:rounded-3xl bg-white 
              border flex flex-col justify-between w-full h-[calc(100vh-300px)] md:h-[calc(100vh-400px)]"
              >
                <div
                  ref={messagesContainerRef}
                  className="w-full flex flex-col overflow-y-scroll md:overflow-y-auto"
                >
                  {/* data messages */}
                  {messageData}
                  {/* socket messages */}
                  {chatMessages}
                </div>
                <EditMessagesForm
                  badSend={badSend}
                  send={handleSendMessages}
                  receiverId={idSent}
                  confirmation={handleConfirmReceipt}
                />
              </div>
            </div>
          </div>
        )}
      </div>
    </main>
  );
}
