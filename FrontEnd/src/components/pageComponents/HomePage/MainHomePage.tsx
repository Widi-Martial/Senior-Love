import { useState } from 'react';
import HeadbandV1 from '../../standaloneComponents/Headband/HeadbandV1';
import DescriptionSection from './DescriptionSection/DescriptionSection';
import FormSection from './FormSection/FormSection';
import HeadbandV2 from '../../standaloneComponents/Headband/HeadbandV2';

export default function Main() {
  // STATE 1 : isFirstFormValidated
  const [isForm1Validated, setIsForm1Validated] = useState(false);

  // STATE 2 : isSecondFormValidated
  const [isForm2Validated, setIsForm2Validated] = useState(false);

  // STATE 3 : isThirdFormValidated
  const [isForm3Validated, setIsForm3Validated] = useState(false);

  // STATE 4 : isFourthFormValidated
  const [isForm4Validated, setisForm4Validated] = useState(false);

  return (
    <main className="w-full">
      <FormSection
        isForm1Validated={isForm1Validated}
        setIsForm1Validated={setIsForm1Validated}
        isForm2Validated={isForm2Validated}
        setIsForm2Validated={setIsForm2Validated}
        isForm3Validated={isForm3Validated}
        setIsForm3Validated={setIsForm3Validated}
        isForm4Validated={isForm4Validated}
        setIsForm4Validated={setisForm4Validated}
      />

      {!isForm1Validated ? <HeadbandV1 /> : <HeadbandV2 />}
      <DescriptionSection
        isForm1Validated={isForm1Validated}
        isForm2Validated={isForm2Validated}
      />
    </main>
  );
}
