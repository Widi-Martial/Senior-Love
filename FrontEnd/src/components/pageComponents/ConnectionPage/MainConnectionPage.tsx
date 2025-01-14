import HeadbandV1 from '../../standaloneComponents/Headband/HeadbandV1';
import ConnectionDescriptionSection from './ConnectionDescriptionSection/ConnectionDescriptionSection';
import ConnectionFormSection from './ConnectionFormSection/ConnectionFormSection';

interface MainConnectionPageProps {
  setUserToken: React.Dispatch<React.SetStateAction<string | null>>;
}

export default function MainConnectionPage({
  setUserToken,
}: MainConnectionPageProps) {
  return (
    <main className="w-full">
      <ConnectionFormSection setUserToken={setUserToken} />
      <HeadbandV1 />
      <ConnectionDescriptionSection />
    </main>
  );
}
