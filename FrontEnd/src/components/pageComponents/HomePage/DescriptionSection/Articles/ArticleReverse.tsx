interface ArticleReverseProps {
  isForm1Validated: boolean;
  isForm2Validated: boolean;
}

export default function ArticleReverse({
  isForm1Validated,
  isForm2Validated,
}: ArticleReverseProps) {
  return (
    <article className="bg-primaryGrey px-3 md:px-12 xl:px-24 py-12 flex flex-col">
      <div className="flex flex-col gap-3 md:flex-row-reverse md:px-16 md:items-center md:justify-between md:gap-12 lg:gap-24">
        <div className="flex flex-col gap-3 md:w-2/3">
          <p>
            {!isForm1Validated && !isForm2Validated && (
              <>
                Imaginez-vous discuter de vos lectures préférées lors d&apos;un
                café littéraire, explorer une nouvelle exposition avec un
                compagnon d&apos;art, ou partager vos astuces de jardinage lors
                d&apos;un atelier en plein air. Chez SeniorLove, nous facilitons
                non seulement les rencontres en ligne, mais nous vous offrons
                aussi des expériences enrichissantes dans le monde réel. Que
                vous recherchiez l&apos;amour, l&apos;amitié ou simplement de
                nouvelles connexions, notre plateforme est conçue pour répondre
                à vos attentes.
              </>
            )}
            {isForm1Validated && !isForm2Validated && (
              <>
                Que vous soyez à la recherche d&apos;une belle histoire
                d&apos;amour, d&apos;une nouvelle amitié, ou d&apos;activités à
                partager, vous trouverez des personnes avec les mêmes centres
                d&apos;intérêt, prêtes à vivre ces moments avec vous. Votre
                sécurité et votre confort sont nos priorités absolues. Nos
                événements sont conçus pour vous offrir un cadre convivial où
                vous pouvez vous épanouir en toute sérénité.
              </>
            )}
            {isForm1Validated && isForm2Validated && (
              <>
                Chaque jour est une chance de découvrir quelque chose de nouveau
                et de créer des souvenirs mémorables. Avec Senior Love, vous
                êtes entouré de personnes qui comprennent vos aspirations et
                sont prêtes à partager des expériences enrichissantes. Nous vous
                offrons bien plus qu&apos;une simple plateforme de rencontres :
                nous vous ouvrons les portes d&apos;une communauté dynamique où
                chaque interaction peut devenir un moment exceptionnel. Faites
                le choix de vous épanouir et de vous connecter en toute
                sérénité.
              </>
            )}
          </p>
          <h3 className="font-semibold">
            {!isForm1Validated && !isForm2Validated && (
              <>
                Rejoignez Senior Love aujourd&apos;hui et commencez une nouvelle
                aventure riche en découvertes et en rencontres !
              </>
            )}
            {isForm1Validated && !isForm2Validated && (
              <>
                Rejoignez-nous et découvrez un nouveau monde de possibilités.
                Chez Senior Love, chaque rencontre est une chance de créer des
                souvenirs mémorables !
              </>
            )}
            {isForm1Validated && isForm2Validated && (
              <>Un Voyage Vers de Nouvelles Connexions !</>
            )}
          </h3>
        </div>
        {!isForm1Validated && !isForm2Validated && (
          <img
            src="/img/senior-love-guitar.webp"
            alt="Un homme jouant de la guitare avec une femme à ses côtés."
            className="hidden md:block w-60 h-80 xl:w-1/4 xl:h-96 object-cover rounded-2xl shadow-lg"
          />
        )}
        {isForm1Validated && !isForm2Validated && (
          <img
            src="/img/senior-dancer.webp"
            alt="Un couple qui danse"
            className="hidden md:block w-60 h-80 xl:w-1/4 xl:h-96 object-cover rounded-2xl shadow-lg"
          />
        )}
        {isForm1Validated && isForm2Validated && (
          <img
            src="/img/senior-field.webp"
            alt="Un couple qui fait du trekking"
            className="hidden md:block w-60 h-80 xl:w-1/4 xl:h-96 object-cover rounded-2xl shadow-lg"
          />
        )}
      </div>
    </article>
  );
}
