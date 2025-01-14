import { Link } from 'react-router-dom';

export default function ErrorAuthPage() {
  return (
    <div className="flex flex-col items-center justify-center min-h-full flex-grow text-center text-primaryText my-20">
      <h1 className="text-3xl font-semibold mb-20">
        🐔 Oups ! Votre session a expiré. 🐔
      </h1>

      <p className="text-lg mb-6">
        Veuillez vous{' '}
        <Link to="/login" className="text-secondaryPink">
          re-connecter
        </Link>{' '}
      </p>
    </div>
  );
}
