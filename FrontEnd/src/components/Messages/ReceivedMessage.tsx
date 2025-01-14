import { Link } from 'react-router-dom';

interface ReceivedMessageProps {
  receiveMessage: string;
  picture: string | undefined;
  userId: number | undefined;
  time: Date;
}

export default function ReceivedMessage({
  receiveMessage,
  picture,
  userId,
  time,
}: ReceivedMessageProps) {
  const date = new Date(time).toLocaleString('fr-FR', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
  });

  return (
    <>
      <time
        className="text-center mt-4 text-xs text-gray-400 italic block"
        dateTime={time.toString()}
      >
        {date}
      </time>
      <Link to={`/profiles/${userId}`}>
        <div className="flex gap-2 justify-start md:w-2/3 mx-4 self-start">
          <img
            src={picture}
            alt="Moi"
            className="aspect-square rounded-full w-10 h-10 self-center md:w-16 md:h-16 object-cover shadow-md"
          />

          <div className="p-2 md:p-4 bg-white border shadow-around rounded-3xl self-center">
            <p className="text-sm text-primaryText">{receiveMessage}</p>
          </div>
        </div>
      </Link>
    </>
  );
}
