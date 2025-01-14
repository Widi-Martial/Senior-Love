// Importing components
import { Route, Routes, Navigate } from 'react-router-dom';
import HomePage from './pages/HomePage';
import EventsPage from './pages/EventsPage';
import HomePageLogged from './pages/HomePageLogged';
import ProfilesPage from './pages/ProfilesPage';
import ProfilePage from './pages/ProfilePage';
import MyProfilePage from './pages/MyProfilePage';
import ConnexionPage from './pages/ConnectionPage';
import EventPage from './pages/EventPage';
import Error404Page from './pages/Error404Page';
import ErrorAuthPage from './pages/ErrorAuthPage';
import MessagePage from './pages/MessagePage';
// import SOCKET from './socket';

interface AppProps {
  isAuthenticated: boolean;
  setUserToken: React.Dispatch<React.SetStateAction<string | null>>;
  setIsAuthenticated: React.Dispatch<React.SetStateAction<boolean>>;
}

export default function App({
  isAuthenticated,
  setUserToken,
  setIsAuthenticated,
}: AppProps) {
  return (
    <Routes>
      {isAuthenticated ? (
        <>
          <Route path="/" element={<Navigate to="/home" />} />
          <Route path="/home" element={<HomePageLogged />} />
          <Route path="/profiles" element={<ProfilesPage />} />
          <Route path="/profiles/:userId" element={<ProfilePage />} />
          <Route path="/messages" element={<MessagePage />} />
          <Route
            path="/myprofile"
            element={<MyProfilePage setIsAuthenticated={setIsAuthenticated} />}
          />
          <Route path="/events" element={<EventsPage />} />
          <Route
            path="/events/:id"
            element={<EventPage isAuthenticated={isAuthenticated} />}
          />
        </>
      ) : (
        <>
          <Route path="/" element={<HomePage />} />
          <Route
            path="/login"
            element={<ConnexionPage setUserToken={setUserToken} />}
          />
          <Route path="/events" element={<EventsPage />} />
          <Route
            path="/events/:id"
            element={<EventPage isAuthenticated={isAuthenticated} />}
          />
        </>
      )}
      <Route path="/loggedout" element={<ErrorAuthPage />} />

      <Route
        path="*"
        element={<Error404Page isAuthenticated={isAuthenticated} />}
      />

      <Route
        path="/error"
        element={<Error404Page isAuthenticated={isAuthenticated} />}
      />
    </Routes>
  );
}
