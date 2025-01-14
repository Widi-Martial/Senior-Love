import { useState } from 'react';
import DefaultBtn from '../../standaloneComponents/Button/DefaultBtn';
import { FilterUser } from '../../../@types/IFilterUser';

interface FilterPanelProps {
  setFilter: React.Dispatch<React.SetStateAction<FilterUser[]>>;
}
export default function FilterPanel({ setFilter }: FilterPanelProps) {
  const [isFilterVisible, setIsFilterVisible] = useState(false);
  // afficher/cacher le formulaire de recherche
  const toggleFilterVisibility = () => {
    setIsFilterVisible((prevState) => !prevState);
  };

  function changeFilter(name: string, value: string) {
    setFilter((prevFilter) =>
      prevFilter.map((filterValue) => ({
        ...filterValue,
        [name]: value,
      }))
    );
  }

  return (
    <div className="flex flex-col items-center gap-4">
      <DefaultBtn
        btnText={
          isFilterVisible
            ? 'Masquer les filtres de recherche'
            : 'Affiner votre recherche'
        }
        onClick={toggleFilterVisibility}
      />
      <div
        className={`flex flex-col lg:flex-row gap-6 lg:gap-20 items-center ${!isFilterVisible ? 'hidden' : 'block'}`}
      >
        <label htmlFor="gender" className="flex items-center gap-2">
          Genre :
          <select
            name="gender"
            id="gender"
            className="rounded-lg p-2 border border-primaryGrey min-w-[150px]"
            onChange={(e) => changeFilter('gender', e.currentTarget.value)}
          >
            <option value="allGender">Tous</option>
            <option value="female">Femme</option>
            <option value="male">Homme</option>
            <option value="other">Autre</option>
          </select>
        </label>

        <label htmlFor="age" className="flex items-center gap-2">
          Age :
          <select
            name="age"
            id="age"
            className="rounded-lg p-2 border border-primaryGrey min-w-[150px]"
            onChange={(e) => changeFilter('age', e.currentTarget.value)}
          >
            <option value="0">Tous les âges</option>
            <option value="60">De 60 à 69 ans</option>
            <option value="70">De 70 à 79 ans</option>
            <option value="80">80 ans et plus</option>
          </select>
        </label>
      </div>
    </div>
  );
}
