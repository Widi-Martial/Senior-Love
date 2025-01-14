interface DefaultBtnProps {
  btnText: string;
  onClick?: () => void;
  btnType?: 'button' | 'submit' | 'reset';
  btnPage?: string;
  btnDelete?: boolean;
  btnMessage?: boolean;
  btnMessageMobile?: boolean;
  btnEdit?: boolean;
  btnModalDelete?: boolean;
}

export default function DefaultBtn({
  btnText,
  onClick,
  btnType,
  btnPage,
  btnDelete,
  btnMessage,
  btnMessageMobile,
  btnEdit,
  btnModalDelete,
}: DefaultBtnProps) {
  const getBackgroundColor = () => {
    if (btnDelete) return 'bg-[#F28C8C] hover:bg-[#F49797]';
    if (btnMessage || btnEdit) return 'bg-[#A8C4A2] hover:bg-[#8FAD8B]';
    return 'bg-secondaryPink hover:bg-secondaryPinkHover';
  };

  const getSizeAndPadding = () => {
    if (btnPage === 'profile' || btnMessageMobile) {
      return 'text-sm px-2 min-w-24 my-0';
    }
    if (btnModalDelete) {
      return 'text-sm px-4 md:min-w-44 my-4';
    }
    return 'text-lg px-4 min-w-44 my-4';
  };

  const buttonClasses = `
    rounded-lg text-white font-bold shadow-md py-1 block mx-auto
    ${getBackgroundColor()}
    ${getSizeAndPadding()}
  `;

  return (
    <button type={btnType} className={buttonClasses} onClick={onClick}>
      {btnText}
    </button>
  );
}
