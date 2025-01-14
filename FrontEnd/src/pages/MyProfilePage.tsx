import MyProfileViewRefactor from '../components/pageComponents/MyProfilePage/MyProfileViewRefactor';

interface MyProfilePageProps {
  setIsAuthenticated: React.Dispatch<React.SetStateAction<boolean>>;
}
export default function MyProfilePage({
  setIsAuthenticated,
}: MyProfilePageProps) {
  return <MyProfileViewRefactor setIsAuthenticated={setIsAuthenticated} />;
}
