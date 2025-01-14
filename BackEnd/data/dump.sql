--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Sessions; Type: TABLE; Schema: public; Owner: senior
--

CREATE TABLE public."Sessions" (
    sid character varying(36) NOT NULL,
    expires timestamp with time zone,
    data text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public."Sessions" OWNER TO senior;

--
-- Name: administrators; Type: TABLE; Schema: public; Owner: senior
--

CREATE TABLE public.administrators (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.administrators OWNER TO senior;

--
-- Name: administrators_id_seq; Type: SEQUENCE; Schema: public; Owner: senior
--

ALTER TABLE public.administrators ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.administrators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: events; Type: TABLE; Schema: public; Owner: senior
--

CREATE TABLE public.events (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    location character varying(255) NOT NULL,
    description text NOT NULL,
    picture character varying(255),
    picture_id character varying(255),
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    admin_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.events OWNER TO senior;

--
-- Name: events_hobbies; Type: TABLE; Schema: public; Owner: senior
--

CREATE TABLE public.events_hobbies (
    id integer NOT NULL,
    event_id integer NOT NULL,
    hobby_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.events_hobbies OWNER TO senior;

--
-- Name: events_hobbies_id_seq; Type: SEQUENCE; Schema: public; Owner: senior
--

ALTER TABLE public.events_hobbies ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_hobbies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: senior
--

ALTER TABLE public.events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: hobbies; Type: TABLE; Schema: public; Owner: senior
--

CREATE TABLE public.hobbies (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.hobbies OWNER TO senior;

--
-- Name: hobbies_id_seq; Type: SEQUENCE; Schema: public; Owner: senior
--

ALTER TABLE public.hobbies ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.hobbies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: senior
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    birth_date date NOT NULL,
    description text,
    gender character varying(10) NOT NULL,
    picture text,
    picture_id character varying(255),
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    old_password character varying(255),
    new_password character varying(255),
    repeat_new_password character varying(255),
    status character varying(10) DEFAULT 'pending'::character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.users OWNER TO senior;

--
-- Name: users_events; Type: TABLE; Schema: public; Owner: senior
--

CREATE TABLE public.users_events (
    id integer NOT NULL,
    user_id integer NOT NULL,
    event_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.users_events OWNER TO senior;

--
-- Name: users_events_id_seq; Type: SEQUENCE; Schema: public; Owner: senior
--

ALTER TABLE public.users_events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_hobbies; Type: TABLE; Schema: public; Owner: senior
--

CREATE TABLE public.users_hobbies (
    id integer NOT NULL,
    user_id integer NOT NULL,
    hobby_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.users_hobbies OWNER TO senior;

--
-- Name: users_hobbies_id_seq; Type: SEQUENCE; Schema: public; Owner: senior
--

ALTER TABLE public.users_hobbies ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_hobbies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: senior
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_messages; Type: TABLE; Schema: public; Owner: senior
--

CREATE TABLE public.users_messages (
    id integer NOT NULL,
    message text NOT NULL,
    sender_id integer,
    receiver_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    read boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users_messages OWNER TO senior;

--
-- Name: users_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: senior
--

ALTER TABLE public.users_messages ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: Sessions; Type: TABLE DATA; Schema: public; Owner: senior
--

COPY public."Sessions" (sid, expires, data, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: administrators; Type: TABLE DATA; Schema: public; Owner: senior
--

COPY public.administrators (id, name, email, password, created_at, updated_at) FROM stdin;
1	admin	admin1@seniorlove.com	f7830c2711df2a75cfa995c0cc48844ced089a68083122ebdbd1b3f03cce103c809a9b5fea23f97fc7fa2aa60bd039cfb957aece3cf43d07a453eecc16564ed2.f9d7ca21ceed12cb867af3b5fadd5f5e	2024-09-18 15:44:27.253182+02	\N
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: senior
--

COPY public.events (id, name, location, description, picture, picture_id, date, "time", admin_id, created_at, updated_at) FROM stdin;
1	Cours de cuisine	Paris	Rejoignez-nous pour une expérience culinaire inoubliable au cœur de Paris ! Notre événement de cours de cuisine vous invite à découvrir les secrets de la gastronomie française dans un cadre élégant et convivial. Sous la direction de chefs talentueux et passionnés, vous apprendrez à préparer des plats emblématiques tels que le coq au vin, les macarons ou encore les éclairs au chocolat. Que vous soyez débutant ou amateur averti, ce cours vous permettra d'affiner vos compétences tout en partageant un moment chaleureux avec d'autres passionnés de cuisine. Profitez également de notre sélection de vins pour accompagner vos créations et d'une ambiance parisienne authentique. Réservez dès maintenant et plongez dans l'art culinaire à Paris !	https://images.pexels.com/photos/2284166/pexels-photo-2284166.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-01	10:00:00	1	2024-09-18 15:44:31.739646+02	\N
2	Apéro céramique	Lyon	Venez explorer votre créativité au cœur de Lyon lors de notre atelier de céramique ! Pour une journée, plongez dans l'univers fascinant de la poterie et du modelage sous l'œil expert de céramistes passionnés. Le matin, découvrez les techniques de base pour façonner et sculpter l'argile, en créant des pièces uniques telles que des bols et des vases. Après une pause déjeuner gourmande, poursuivez avec un atelier sur la décoration et l'émaillage, où vous apprendrez à appliquer des motifs et des couleurs vibrantes à vos créations. À la fin de la journée, repartez avec vos œuvres, prêtes à être cuites et exposées. Que vous soyez novice ou amateur confirmé, cet atelier vous offre une occasion idéale pour exprimer votre créativité tout en profitant de l'atmosphère chaleureuse et inspirante de Lyon. Réservez votre place pour une journée artistique et enrichissante !	https://images.pexels.com/photos/22823/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-03	17:30:00	1	2024-09-18 15:44:31.739646+02	\N
3	Atelier mixologie	Marseille	Venez vivre une soirée pétillante et raffinée à Marseille lors de notre atelier de mixologie ! Plongez dans l'art de la création de cocktails sous la houlette de barmen experts, qui vous guideront à travers les techniques essentielles et les secrets des mélanges audacieux. L'atelier commence par une introduction aux bases de la mixologie, suivie de la préparation de cocktails emblématiques et innovants, tels que le Mojito revisité ou le Negroni parfait. Après une pause pour déguster vos créations accompagnées de tapas gourmet, vous explorerez des astuces de présentation et des combinaisons de saveurs originales. Que vous soyez un amateur de cocktails ou un passionné en quête de nouvelles compétences, cet événement promet une expérience ludique et instructive dans un cadre chic et convivial. Réservez votre place dès maintenant pour une soirée savoureuse et animée au cœur de Marseille !	https://images.pexels.com/photos/2789328/pexels-photo-2789328.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-20	18:00:00	1	2024-09-18 15:44:31.739646+02	\N
4	Dégustation de vins	Bordeaux	Venez découvrir l'élégance des grands crus lors de notre événement de dégustation de vin à Bordeaux ! Ce rendez-vous incontournable vous plonge dans l'univers fascinant des vignobles bordelais. La journée commence par un accueil chaleureux avec un verre de vin pétillant, suivi d'une présentation captivante des cépages emblématiques de la région. Sous la conduite d’experts œnologues, vous apprendrez à déguster et à apprécier les subtilités des grands Bordeaux, des rouges puissants aux blancs raffinés. Chaque session est accompagnée de bouchées gastronomiques préparées pour sublimer les accords mets-vins. En fin de journée, vous aurez l'opportunité de discuter avec les producteurs locaux et de découvrir leurs secrets de vinification. Que vous soyez novice ou connaisseur, cet événement promet une immersion sensorielle enrichissante au cœur de la capitale du vin. Réservez dès maintenant pour vivre une expérience inoubliable dans l'une des plus célèbres régions viticoles du monde !	https://images.pexels.com/photos/1123260/pexels-photo-1123260.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-15	11:30:00	1	2024-09-18 15:44:31.739646+02	\N
5	Speed dating	Nice	Venez vivre une soirée conviviale et pleine de rencontres à Nice lors de notre événement de speed dating spécialement conçu pour les seniors ! Dans un cadre élégant et chaleureux, cet événement vous offre une opportunité unique de faire de nouvelles connaissances et de partager des moments précieux avec des personnes ayant des intérêts et des expériences de vie similaires. Chaque participant aura la chance de discuter brièvement avec plusieurs personnes au cours de sessions de 5 à 7 minutes, permettant ainsi de découvrir de nouvelles affinités et de nouer des liens significatifs. Après les rencontres, profitez d'un moment de détente autour d’un verre et de douceurs, pour échanger librement et prolonger les conversations. Que vous cherchiez une nouvelle amitié ou une connexion plus personnelle, cette soirée est l'occasion parfaite de redécouvrir les plaisirs de la rencontre dans une ambiance détendue et respectueuse. Réservez votre place pour une expérience enrichissante au cœur de Nice !	https://images.pexels.com/photos/330247/pexels-photo-330247.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-03	19:00:00	1	2024-09-18 15:44:31.739646+02	\N
6	Atelier jardinage	Toulouse	Rejoignez-nous pour une journée verdoyante et enrichissante lors de notre atelier de jardinage à Toulouse ! Cet événement vous plonge dans l'art de cultiver un jardin florissant, que vous soyez novice ou passionné. La matinée débute par une introduction aux techniques de base du jardinage, incluant la préparation du sol, la sélection des plantes adaptées et les secrets pour une croissance optimale. Après une pause gourmande, passez à la pratique en créant vos propres pots de fleurs ou jardinières, tout en apprenant les astuces pour entretenir vos plantations. Nos experts vous guideront également sur la gestion des ressources naturelles et des outils de jardinage. En fin de journée, repartez avec vos créations et des conseils personnalisés pour continuer à développer votre jardin chez vous. Profitez de cette occasion pour partager votre passion avec d'autres amoureux de la nature dans un cadre convivial et inspirant. Réservez dès maintenant pour une immersion totale dans le monde du jardinage à Toulouse !	https://images.pexels.com/photos/27176060/pexels-photo-27176060/free-photo-of-legumes-nature-terre-agriculture.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-12	08:30:00	1	2024-09-18 15:44:31.739646+02	\N
7	Cours de photographie	Strasbourg	Participez à notre événement captivant de cours de photographie à Strasbourg et découvrez les secrets pour capturer des images éblouissantes ! Cette journée immersive commence par une introduction aux techniques fondamentales de la photographie, de la composition à l'éclairage, animée par des professionnels expérimentés. Ensuite, mettez en pratique vos nouvelles compétences lors d'une session de prise de vue dans les charmantes rues et paysages strasbourgeois. Après une pause déjeuner, plongez dans les astuces de retouche photo avec des logiciels spécialisés pour sublimer vos clichés. Vous aurez également l'opportunité de partager vos photos avec les autres participants et de recevoir des critiques constructives. Que vous soyez débutant ou photographe amateur, cet atelier vous offre une chance unique d'améliorer votre art tout en explorant la beauté de Strasbourg. Réservez dès maintenant pour capturer des souvenirs inoubliables et perfectionner votre technique !	https://images.pexels.com/photos/243757/pexels-photo-243757.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-06	09:30:00	1	2024-09-18 15:44:31.739646+02	\N
8	Soirée jazz	Nantes	Plongez dans une soirée envoûtante de jazz à Nantes et laissez-vous emporter par des mélodies enivrantes ! Cet événement exceptionnel vous invite à découvrir le meilleur du jazz dans une ambiance élégante et intimiste. La soirée commence avec un accueil chaleureux, suivi d'une performance en direct d'artistes de jazz de renom qui vous séduiront avec des improvisations captivantes et des standards intemporels. Profitez d’une sélection raffinée de cocktails et de tapas gourmet tout en vous imprégnant des rythmes entraînants et des harmonies sophistiquées. Laissez-vous bercer par les sonorités du saxophone, du piano et de la batterie dans un cadre convivial où la musique crée des moments magiques. Que vous soyez un amateur de jazz ou simplement en quête d'une soirée mémorable, cet événement promet une expérience sensorielle inoubliable au cœur de Nantes. Réservez dès maintenant pour une nuit de jazz élégante et inspirante !	https://images.pexels.com/photos/1358817/pexels-photo-1358817.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-10	20:00:00	1	2024-09-18 15:44:31.739646+02	\N
9	Club de lecture	En ligne	Rejoignez notre club de lecture en ligne pour une expérience littéraire enrichissante et interactive ! Chaque mois, nous plongeons ensemble dans un livre captivant, choisi pour sa richesse et sa pertinence. Lors de nos rencontres virtuelles, animées par un modérateur passionné, nous échangeons nos impressions, analyses et découvertes autour du roman, essai ou nouvelle sélectionné. Ce club offre un espace convivial et stimulant pour partager vos réflexions et écouter celles des autres participants, tout en approfondissant votre compréhension des œuvres lues. Profitez également de recommandations personnalisées et de discussions animées sur des thèmes variés, allant de la fiction contemporaine aux classiques littéraires. Que vous soyez un lecteur assidu ou occasionnel, cet événement est l'occasion parfaite pour explorer de nouveaux horizons littéraires et tisser des liens avec d'autres passionnés. Réservez votre place pour une aventure littéraire inoubliable !	https://images.pexels.com/photos/415071/pexels-photo-415071.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-02	18:00:00	1	2024-09-18 15:44:31.739646+02	\N
10	Cours de chorale	Avignon	Rejoignez-nous pour une journée musicale inoubliable lors de notre cours de chorale à Avignon ! Que vous soyez un chanteur débutant ou expérimenté, cet événement est l’occasion idéale de découvrir les plaisirs du chant choral dans un cadre inspirant. Sous la direction d’un chef de chœur passionné, vous apprendrez à interpréter des morceaux variés, allant des classiques intemporels aux chansons modernes. Le matin, vous participerez à des échauffements vocaux et des techniques de respiration, avant de plonger dans la pratique en groupe. Après une pause déjeuner conviviale, continuez à perfectionner votre voix et votre harmonie avec des exercices dynamiques. En fin de journée, partagez le fruit de votre travail avec une performance en petit groupe, mettant en valeur les progrès réalisés. Venez vivre une expérience enrichissante et harmonieuse au cœur d’Avignon, où musique et convivialité se rencontrent !	https://images.pexels.com/photos/7520744/pexels-photo-7520744.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-23	16:00:00	1	2024-09-18 15:44:31.739646+02	\N
11	Soirée méditation	Rennes	Offrez-vous une soirée de sérénité et de bien-être lors de notre soirée méditation à Rennes ! Dans un cadre apaisant et élégant, plongez dans l’univers de la pleine conscience et du calme intérieur. La soirée commence par une introduction douce aux principes de la méditation, suivie de séances guidées adaptées à tous les niveaux. Nos instructeurs expérimentés vous guideront à travers des pratiques de méditation variées, allant de la relaxation profonde à la pleine conscience, pour vous aider à libérer le stress et retrouver votre équilibre. Après une pause revitalisante avec des infusions et des en-cas sains, poursuivez avec une méditation en groupe, favorisant un sentiment de connexion et de paix intérieure. Que vous soyez novice ou méditant régulier, cette soirée vous offrira une pause bien méritée dans la routine quotidienne. Réservez dès maintenant pour une expérience de méditation apaisante et revitalisante au cœur de Rennes !	https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-19	21:00:00	1	2024-09-18 15:44:31.739646+02	\N
12	Balade en montgolfière	Saumur	Vivez une aventure inoubliable avec notre balade en montgolfière au-dessus de Saumur ! Offrez-vous une vue panoramique spectaculaire sur les paysages enchâssés de la vallée de la Loire et les châteaux majestueux qui ornent la région. À l''aube, vous serez accueilli avec un petit-déjeuner léger avant de participer à la préparation de la montgolfière, où vous découvrirez le processus fascinant de gonflage. Une fois dans les airs, laissez-vous emporter par la douce montée et admirez les panoramas époustouflants qui se dévoilent sous vos yeux. Votre pilote expérimenté partagera des anecdotes locales et vous guidera tout au long de cette expérience magique. À la fin du vol, célébrez votre aventure avec un toast traditionnel et un certificat souvenir. Réservez dès maintenant pour un voyage aérien mémorable qui allie sérénité et émerveillement au cœur de Saumur !	https://images.pexels.com/photos/24877165/pexels-photo-24877165/free-photo-of-vol-paysage-ciel-nuages.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-07	10:30:00	1	2024-09-18 15:44:31.739646+02	\N
13	Prise en main du smartphone	Paris	Découvrez la magie de la technologie avec notre événement spécial pour les personnes âgées : Tech & Convivialité : Atelier Découverte des Nouveaux Outils Numériques ! Ce rendez-vous convivial est conçu pour familiariser les seniors avec les dernières innovations technologiques dans un cadre détendu et encourageant.L''événement commence par une introduction chaleureuse sur les bases des appareils numériques modernes, comme les smartphones et les tablettes. Ensuite, nos experts vous guideront à travers des ateliers pratiques où vous apprendrez à utiliser des applications courantes telles que les réseaux sociaux, les messageries instantanées, et les services de vidéo-conférence pour rester connecté avec vos proches.Après une pause-café, explorez les outils de sécurité en ligne pour protéger vos données et découvrez les applications de santé qui peuvent améliorer votre quotidien. Les sessions sont interactives et adaptées à votre rythme, permettant un apprentissage personnalisé et une assistance individuelle. En fin de journée, partagez vos nouvelles compétences autour d’un goûter et posez toutes vos questions à nos experts. Réservez dès maintenant pour un après-midi enrichissant où la technologie devient accessible et amusante, tout en favorisant l’échange et la convivialité !	https://images.pexels.com/photos/1092644/pexels-photo-1092644.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	2024-12-08	10:30:00	1	2024-09-18 15:44:31.739646+02	\N
14	Voyance solaire	Paris	Venez voir comment lire dans l'avenir, dans notre goulotte.\r\nVous apprendrez les rudiment de la voyances et de la numérologie, comme jamais ! Aller voir notre brochure sur http://www.afinity-seniors.com et inscrivez vous pour participer à cet atelier.\r\nAttention, le nombre de place est limité.	https://res.cloudinary.com/dsb2ihfdx/image/upload/v1726761288/event_photos/eu6ybva6gjf3lqu5qzb7.png	event_photos/eu6ybva6gjf3lqu5qzb7	2024-11-06	23:55:00	\N	2024-09-19 17:54:47.56+02	2024-09-19 17:54:47.561+02
\.


--
-- Data for Name: events_hobbies; Type: TABLE DATA; Schema: public; Owner: senior
--

COPY public.events_hobbies (id, event_id, hobby_id, created_at, updated_at) FROM stdin;
1	1	4	2024-09-18 15:44:35.597809+02	\N
2	1	12	2024-09-18 15:44:35.597809+02	\N
3	2	2	2024-09-18 15:44:35.597809+02	\N
4	2	10	2024-09-18 15:44:35.597809+02	\N
5	3	4	2024-09-18 15:44:35.597809+02	\N
6	4	2	2024-09-18 15:44:35.597809+02	\N
7	4	4	2024-09-18 15:44:35.597809+02	\N
8	5	7	2024-09-18 15:44:35.597809+02	\N
9	6	10	2024-09-18 15:44:35.597809+02	\N
10	6	11	2024-09-18 15:44:35.597809+02	\N
11	7	1	2024-09-18 15:44:35.597809+02	\N
12	7	2	2024-09-18 15:44:35.597809+02	\N
13	8	2	2024-09-18 15:44:35.597809+02	\N
14	8	5	2024-09-18 15:44:35.597809+02	\N
15	9	7	2024-09-18 15:44:35.597809+02	\N
16	9	9	2024-09-18 15:44:35.597809+02	\N
17	10	5	2024-09-18 15:44:35.597809+02	\N
18	10	9	2024-09-18 15:44:35.597809+02	\N
19	11	3	2024-09-18 15:44:35.597809+02	\N
20	11	9	2024-09-18 15:44:35.597809+02	\N
21	12	1	2024-09-18 15:44:35.597809+02	\N
22	12	12	2024-09-18 15:44:35.597809+02	\N
23	13	8	2024-09-18 15:44:35.597809+02	\N
70	14	9	2024-09-19 17:54:47.592+02	2024-09-19 17:54:47.592+02
\.


--
-- Data for Name: hobbies; Type: TABLE DATA; Schema: public; Owner: senior
--

COPY public.hobbies (id, name, created_at, updated_at) FROM stdin;
1	Voyages et découvertes	2024-09-18 15:44:31.739646+02	\N
2	Art et culture	2024-09-18 15:44:31.739646+02	\N
3	Sport et bien-être	2024-09-18 15:44:31.739646+02	\N
4	Gastronomie et cuisine	2024-09-18 15:44:31.739646+02	\N
5	Musique et danse	2024-09-18 15:44:31.739646+02	\N
6	Bénévolat et engagement social	2024-09-18 15:44:31.739646+02	\N
7	Jeux et divertissement	2024-09-18 15:44:31.739646+02	\N
8	Technologies et innovations	2024-09-18 15:44:31.739646+02	\N
9	Spiritualité et bien-être intérieur	2024-09-18 15:44:31.739646+02	\N
10	Bricolage et loisirs créatifs	2024-09-18 15:44:31.739646+02	\N
11	Animaux et nature	2024-09-18 15:44:31.739646+02	\N
12	Histoire et patrimoine	2024-09-18 15:44:31.739646+02	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: senior
--

COPY public.users (id, name, birth_date, description, gender, picture, picture_id, email, password, old_password, new_password, repeat_new_password, status, created_at, updated_at) FROM stdin;
1	Jacqueline	1950-05-15	Je suis Jacqueline, une passionnée de lecture et de voyages. Depuis ma retraite, j'ai enfin le temps de dévorer tous les livres que je n'avais pas le temps de lire. J'adore également découvrir de nouveaux horizons, rencontrer des gens et explorer différentes cultures. Je suis particulièrement attirée par l'Asie, où j'ai passé plusieurs mois à voyager. En dehors de cela, je suis très impliquée dans le bénévolat, aidant les jeunes à réussir leur parcours scolaire. J'aime aussi jardiner, transformer ma cour en un petit paradis fleuri. La cuisine est une autre de mes passions, surtout la pâtisserie, que je partage avec mes amis lors de goûters que j'organise régulièrement.	female	https://st4.depositphotos.com/22611548/38059/i/1600/depositphotos_380591824-stock-photo-portrait-happy-mature-woman-eyeglasses.jpg	\N	jacqueline@example.com	5cc15b9826f41ec4001dfea40b0f7b03c3635b07bef3a73bce437b2321a4cb94923e20fdaa45faf9660aa868561d8a1c9552f7e7a95d20f90aea94e57e7eb526.c27841ccea2beadbabba558858385da5	\N	\N	\N	active	2024-09-18 15:44:01.246147+02	\N
2	Michel	1948-11-02	Je m'appelle Michel et je suis un passionné de photographie. Depuis mon plus jeune âge, j'ai toujours eu un appareil photo à la main, capturant des moments uniques de la vie. Après une carrière dans l'ingénierie, je me consacre maintenant entièrement à ma passion. J'aime particulièrement photographier la nature et les paysages, cherchant toujours à capturer la beauté du monde qui m'entoure. En dehors de la photographie, je suis un amateur de cyclisme. Je passe beaucoup de temps à parcourir les routes de campagne, profitant de l'air frais et du calme. Je suis également un grand fan de jazz, une musique qui m'accompagne souvent lors de mes escapades photographiques.	male	https://images.pexels.com/photos/236214/pexels-photo-236214.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	michel@example.com	8c2a2513ea80c226e567fff9b77e5249b124c4cf98504d63eb91aaddadc2db62bb86c8b17669e8f95b2eb75ef76ebae23e8598cfd480189bbb7653fd6cb5a738.ca840d263e44b58bd560ecfc982c2002	\N	\N	\N	active	2024-09-18 15:44:01.556097+02	\N
3	Renée	1949-03-08	Je suis Renée, une passionnée d'art et d'histoire. Après avoir travaillé comme enseignante pendant de nombreuses années, j'ai désormais plus de temps pour me consacrer à mes passions. J'adore visiter des musées et des expositions, m'imprégnant de la culture et des histoires qui s'y trouvent. Je suis également une amatrice de musique classique, que j'écoute régulièrement lors de mes moments de détente. J'aime aussi la peinture, une activité que je pratique moi-même à mes heures perdues. En plus de cela, je participe à des cours de yoga, une discipline que j'ai découverte récemment et qui m'aide à rester en forme et à me détendre.	other	https://images.pexels.com/photos/1729931/pexels-photo-1729931.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	renee@example.com	aef9554754ab120faad074a0ff4a51dcff40256eecbb793d4e7d44d7ce14174826644d40625afbac9c712051cb611a00cf65a646d5eaf14cd7523a3574642276.09ed793393f738a929d0de7386328647	\N	\N	\N	active	2024-09-18 15:44:01.865627+02	\N
4	Henri	1952-02-14	Je suis Henri, un mélomane et amateur d'échecs. La musique classique me passionne depuis mon enfance. Je joue du violon dans un orchestre amateur et assiste régulièrement à des concerts. En dehors de la musique, j'aime jouer aux échecs, que ce soit contre des adversaires locaux ou en ligne. Je suis également un grand lecteur, avec une préférence pour les essais philosophiques et les romans historiques. J'aime aussi cuisiner, surtout des plats traditionnels français que je prépare avec soin pour mes amis et ma famille. Lorsqu'il me reste du temps libre, je pars en excursion pour découvrir de nouveaux lieux culturels, toujours à la recherche de nouvelles expériences artistiques.	other	https://images.pexels.com/photos/3018993/pexels-photo-3018993.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	henri@example.com	c61c3e96dbfb01b698d6ce8ed7a5b588ece0559a684f898a9ad3f8196682d8a215431cd330d73330775ea12866b3efcfeb3845ce60326cd8d2cba99452ba8bb3.f98fcddbacda68b578c7621c37a01a07	\N	\N	\N	active	2024-09-18 15:44:02.173217+02	\N
6	André	1946-10-05	Je m'appelle André, ancien professeur de mathématiques avec une passion pour l'apprentissage et la technologie. Depuis ma retraite, je me consacre à la lecture, explorant des sujets aussi variés que la philosophie, l'histoire et les sciences. J'aime également rester à jour avec les dernières innovations technologiques et j'utilise souvent mon ordinateur pour découvrir de nouvelles idées. Je suis aussi un grand amateur de jardinage, passant beaucoup de temps à entretenir mon jardin. En plus de cela, j'aime voyager et écrire, partageant mes réflexions sur un blog que je tiens régulièrement. Je suis très proche de ma famille et je passe souvent du temps avec mes enfants et petits-enfants.	male	https://images.pexels.com/photos/3831645/pexels-photo-3831645.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	andre@example.com	4cab00048363b9fe2fddb3a6bcafe85725d616ec534c2c8508af4eba2003a44812c8d30f02c6938d0309b61a8609ba5001f6b5da5fd222596dcf94feeeda54b3.49338ff6817631bf247b9ac9d8289960	\N	\N	\N	active	2024-09-18 15:44:02.784911+02	\N
7	Lucienne	1960-04-02	Je suis Lucienne, une cuisinière passionnée, connue pour mes recettes savoureuses. J'adore expérimenter de nouvelles recettes et perfectionner mes techniques culinaires. En dehors de la cuisine, je suis une grande amatrice d'artisanat, créant des objets de décoration à partir de matériaux recyclés. J'aime recevoir des invités, organisant souvent des dîners pour mes amis et ma famille. Je passe aussi du temps dans mon jardin potager, cultivant des herbes et des légumes frais que j'utilise dans mes plats. Je suis très sociable, participant à des clubs de lecture et à des groupes de marche avec mes amis.	female	https://images.pexels.com/photos/34540/old-lady-smile-beautiful-woman.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	lucienne@example.com	45a085990e2931efd24d268c5729bf94f53aff722a3d05913152f8ea6c90bbe2e41725bdb95ee19d5b8705995b2e246402fe7525427c03aa089ba88567fda426.610e8cd58a6b31e449c9303dc4489399	\N	\N	\N	active	2024-09-18 15:44:03.092736+02	\N
28	Claire	1959-12-05	Je suis Claire, une passionnée de voyages. J'aime découvrir de nouveaux pays, cultures et paysages. Chaque voyage est une occasion pour moi d'apprendre et de m'enrichir personnellement.	female	https://images.pexels.com/photos/638196/pexels-photo-638196.jpeg?auto=compress&cs=tinysrgb&w=600	\N	claire.durand@example.com	c526b25a46098053ac30e7ad864c567912ceb9e8aafda0a7a5b9c424cc1536b1cda7aa29d6778394b9d15fe651a33439a7da7d0a8028281f530139bbdc124e33.6d3a35eed018ed0f06af7e2643edbf0a	\N	\N	\N	active	2024-09-18 15:44:09.516776+02	\N
8	Gérard	1947-09-18	Je m'appelle Gérard, un passionné de sport et de nature. J'ai passé ma vie à enseigner l'éducation physique, et même à la retraite, je reste actif en pratiquant la randonnée et le vélo. J'aime explorer les sentiers de montagne et profiter de la beauté de la nature. En dehors du sport, je suis un amateur de photographie, capturant les paysages que je découvre lors de mes randonnées. J'aime aussi cuisiner des plats simples et sains, souvent avec des ingrédients que je cultive moi-même. Ma famille et mes amis sont très importants pour moi, et je passe beaucoup de temps avec eux, partageant des repas et des moments de convivialité.	male	https://images.pexels.com/photos/2421934/pexels-photo-2421934.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	gerard@example.com	91f11d31ef2cd939d79f153fe88982f3192c96a6a166334cfeb92dbfccf000b7e7e41d509b62571e37fbd0142c419e1418e2f165007f5dd476d667911bddc3d6.65c3b9597187a7ca19a36983932b5214	\N	\N	\N	active	2024-09-18 15:44:03.399674+02	\N
9	Marie	1949-06-10	Je suis Marie, une passionnée de jardinage et de lecture. Mon jardin est mon sanctuaire, un endroit où je peux passer des heures à planter, tailler et entretenir mes fleurs. J'aime particulièrement les roses, que je cultive avec soin. Quand je ne suis pas dans mon jardin, je suis probablement en train de lire un roman ou un livre d'histoire. Je fais partie d'un club de lecture où nous partageons nos découvertes littéraires. En plus de cela, j'aime voyager, surtout pour découvrir de nouveaux jardins botaniques et rencontrer d'autres passionnés de plantes. La nature est une source d'inspiration pour moi, et je cherche toujours à apprendre et à partager mes connaissances.	female	https://images.pexels.com/photos/788567/pexels-photo-788567.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	marie@example.com	ebeb5d5f206382a5bb4fadbb75cd2d397353b4113677d8e5356fe56b391a91561b639e0e45fa33c30cd38d2298b277a71dcfc12e7d6713f9225a1658a7923b3d.5e9d791a078cfa2c63f6ed44029895dc	\N	\N	\N	active	2024-09-18 15:44:03.707624+02	\N
10	Bernard	1951-12-20	Je suis Bernard, un passionné d'histoire et de modélisme. Depuis toujours, je suis fasciné par les récits historiques, en particulier ceux qui concernent les guerres mondiales. J'ai passé des années à construire des maquettes de navires et d'avions de cette époque, une activité qui me détend et me passionne. En plus de cela, j'aime lire des biographies et des documentaires historiques. Je suis également un amateur de vin, et j'aime découvrir de nouvelles régions viticoles lors de mes voyages. En dehors de mes passions, je suis très impliqué dans ma communauté, organisant des conférences et des expositions sur l'histoire locale.	male	https://images.pexels.com/photos/25758/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	bernard@example.com	f1693131f3b0383699ef70261e8c41f5dc80262948a593aaa50ce5cfe3bf3766d60e948d879bc329bcdecf49c62dd0fd0fb28fff8f5aee74555512e666bd8aed.0ed0e07d5e2dbf6403ecc800a8ab6c3e	\N	\N	\N	active	2024-09-18 15:44:04.014479+02	\N
11	Jacques	1945-05-14	Je suis Jacques, un amateur de machines à écrire anciennes. Depuis ma retraite, je passe mes journées à restaurer ces machines et à les utiliser pour écrire des lettres et des histoires. J’apprécie le calme de mon atelier, où je peux me plonger dans des tâches manuelles et créatives. En dehors de cela, j’aime lire des romans classiques et m’intéresse à l’histoire des technologies de communication. Je passe aussi beaucoup de temps à partager mes connaissances avec d’autres passionnés lors de salons et d’expositions.	male	https://img.freepik.com/free-photo/senior-caucasian-man-using-vintage-typewriter-grayscale_53876-31560.jpg?t=st=1725032211~exp=1725035811~hmac=fd133fedfcf1cd11cfb5074c62b8d1bdeed30fa7c902b9c4c248c3e3f6500148&w=2000	\N	jacques.dubois@example.com	69a1f5df2066ccd513652b735b0bc8d031953a427593d0c9091cf027bf38165a3dc6a8baeb530bb94a14051b9186f96a020e079e923bf47be3b4e046c02f3012.545293478d86353c1c71f3cf8080f5f4	\N	\N	\N	banned	2024-09-18 15:44:04.321096+02	\N
12	Henri	1942-07-22	Je suis Henri, un passionné de téléphones anciens. J’aime collectionner et restaurer ces objets fascinants qui rappellent une époque révolue. Ma journée typique consiste à travailler sur mes téléphones, en réparant et en nettoyant les pièces pour les faire revivre. J’organise également des rencontres avec d’autres collectionneurs et amateurs de vintage, où nous échangeons des histoires et des techniques de restauration.	male	https://img.freepik.com/free-photo/old-man-holding-telephone_23-2148432087.jpg?t=st=1725032288~exp=1725035888~hmac=619f47b4e7d7b1d421a987f46bc01df2c5e1edda177b3a53c0eae830dd8e66ce&w=1060	\N	henri.moreau@example.com	91d120beade731912846865c70af9168bfaf6fbb5ca5708bfbab68d4e8a7a13d58bc3447849355c3c7159ec61414c2eb34539e2087578d6bdfffdd385dbfd89a.b51ddd55c24ac727932d6057e26de4e6	\N	\N	\N	active	2024-09-18 15:44:04.627549+02	\N
13	Paul	1938-11-01	Je suis Paul, un amateur de photographie qui aime capturer des moments précieux avec mon appareil photo. J’ai passé ma vie à explorer le monde à travers l’objectif et à partager mes photos avec d’autres passionnés. Je consacre une grande partie de mon temps à prendre des photos lors de différents événements et paysages, tout en discutant des techniques et des équipements avec mes amis photographes.	male	https://img.freepik.com/free-photo/portrait-senior-man-with-camera-device-world-photography-day-celebration_23-2151657270.jpg?t=st=1725032354~exp=1725035954~hmac=5a956684a0deeafc69574ac1dd25227ad998b3c9fe64b0af8a95d7d234e066e0&w=2000	\N	paul.lefebvre@example.com	d207193c67fa02470269b62d5dc19f69a505ea6cf2aa8367aa1fff153431e197e21ca4d4c8d2ae06cc625ebf94d30642cfe376637a59935305ecfc19e97991ed.eef8d64bf4c5c09ca89caaa038ba8d00	\N	\N	\N	active	2024-09-18 15:44:04.934679+02	\N
14	Lucien	1947-02-10	Je suis Lucien, un homme sage qui aime passer du temps dans des lieux calmes et paisibles. J’aime me promener et profiter de la tranquillité des espaces intérieurs, où je peux réfléchir et apprécier la simplicité de la vie. Je trouve du plaisir à observer les détails de mon environnement et à partager ces moments de calme avec les autres.	male	https://img.freepik.com/free-photo/old-man-posing-indoors-side-view_23-2149883573.jpg?t=st=1725032412~exp=1725036012~hmac=cd9635a4d9330751174c813c7cfa8e51c5ccac00cd5a1d87d5eaa33eff9642eb&w=1060	\N	lucien.bernard@example.com	d1152e2fd444aa8a1e54d6d7bd74ac8bf29360ed92d5a4d7e82e044f928102fcf3fe4fa4c6f62d2a50d3dddab25d5d11df363515b05046a0e075494ad768f408.14d50c616b148f0428c9bd0c8f667aef	\N	\N	\N	active	2024-09-18 15:44:05.241687+02	\N
15	Éric	1962-03-05	Je suis Éric, un homme élégant qui aime s’habiller avec soin et profiter des belles journées ensoleillées. J’apprécie les moments passés en plein air, surtout lorsqu’ils me permettent de montrer mes tenues préférées. Je suis également passionné par la mode et l’élégance, ce qui se reflète dans chaque aspect de ma vie.	male	https://img.freepik.com/free-photo/senior-man-posing-white-shirt-hat_23-2149487991.jpg?t=st=1725032446~exp=1725036046~hmac=371f49f8f4c97c753d37f1a7c3f0942bb440b3aa4f99767716c81009ac87bb65&w=2000	\N	eric.martin@example.com	adec590eb55bcc293409f79457a73bdd2009d9df2a9b117a02d6a096b87bc5f6b336949f7462d9c98f25669c0d6dc1205071ba0efd8b31b15258913241db75e1.f2c15065f7bb1062435b03462b3761e6	\N	\N	\N	pending	2024-09-18 15:44:05.548057+02	\N
16	Alain	1935-09-20	Je suis Alain, un homme âgé qui aime se détendre dans les parcs et profiter de la nature. J’apprécie particulièrement les moments de repos sur un banc, où je peux observer les gens et profiter du paysage. C’est dans ces moments de calme que je me sens le plus connecté avec le monde qui m’entoure.	male	https://img.freepik.com/free-photo/front-view-old-man-sitting-bench_23-2150493075.jpg?t=st=1725032486~exp=1725036086~hmac=e828fbb7cdefd7fcf040257ab6678c3631da7433837adeff4f1111d641bd93aa&w=2000	\N	alain.durand@example.com	4d45e18b6be3ffc2622fd6afa3fcc58b3585febcdda9a3937847250e7d6f4a81b5ff2457dc28a2059bdd07b5bb60c79bd86dd54615030ccd64a0be5dec6a713f.d75f2d755178e35896200adf537dd9c0	\N	\N	\N	active	2024-09-18 15:44:05.853129+02	\N
18	Louis	1939-10-10	Je suis Louis, un homme sage qui aime poser pour des photos et capturer des moments précieux de la vie. J’apprécie particulièrement les séances photo en studio, où je peux exprimer ma personnalité et partager des instants de ma vie avec les autres.	male	https://img.freepik.com/free-photo/wise-senior-man-posing-indoors-front-view_23-2149883531.jpg?t=st=1725032688~exp=1725036288~hmac=00da6a70e10d070217905040c9ae39e5ee3cbe536bda730782877c5ca025b0c9&w=2000	\N	louis.chevalier@example.com	1e32ba1423a5ce3bdb01789c80a1f4c3186c6a4be7e3a3fe003bf9978a3046bd2984f5568c431d76c249e32c3cfc29271b1dcc899a90e76f79b47f37cd270b5f.90b7c7b9b37ee989a401037af37b0487	\N	\N	\N	active	2024-09-18 15:44:06.463632+02	\N
19	Claude	1948-08-14	Je suis Claude, un homme âgé qui aime porter des chapeaux élégants. J’apprécie les jours ensoleillés où je peux me promener en extérieur tout en mettant en avant mes accessoires de mode préférés. La mode et le style sont importants pour moi et me permettent de m’exprimer au quotidien.	male	https://img.freepik.com/free-photo/front-view-elderly-man-wearing-hat_23-2150168218.jpg?t=st=1725032702~exp=1725036302~hmac=b328d1a98bc49af424cf01c4874705155c90ccca198c78dd0ffbc78b49595e48&w=1060	\N	claude.duval@example.com	deece60198e2630cc9ee542566d59adf5cac6179b55d9b914b5127da1ee9034568f57418748a013e7a80c5f0d57596db9083b3dc901e2abda8a0f1e8db01f03f.1651836b7790fd8d3accf76947235a57	\N	\N	\N	active	2024-09-18 15:44:06.769168+02	\N
20	Jean	1936-02-28	Je suis Jean, un homme qui aime profiter des belles journées et de la nature. Rien ne me fait plus plaisir que de prendre une tasse de café en extérieur, entouré par la beauté naturelle. C’est dans ces moments simples que je trouve le plus grand bonheur.	male	https://images.pexels.com/photos/34534/people-peoples-homeless-male.jpg?auto=compress&cs=tinysrgb&w=600	\N	jean.moret@example.com	254d05493d49c9a9886bdb6b7cb782ccd01deb4c9ba4190a67b3eca6694856260f34777a378edc7a04846ef80ab1b6816ec0b1b74bb2a096c38395ba33520e6c.3786fb3effaf4da29119711916ebe8e0	\N	\N	\N	active	2024-09-18 15:44:07.074424+02	\N
21	Marcel	1946-03-21	Je suis Marcel, un passionné de jardinage qui passe la plupart de mon temps dans mon jardin. J'adore planter des fleurs et des légumes et voir comment ils poussent jour après jour. Le jardinage est ma manière de rester actif et connecté avec la nature.	male	https://images.pexels.com/photos/1139743/pexels-photo-1139743.jpeg?auto=compress&cs=tinysrgb&w=600	\N	marcel.dupont@example.com	dd7c23ed2ba300db925edec2a4b048da0a21f14e395bc0a8314ab04999a3d02b45a6a589e6333a752dbecad9aed01deafd22bde9bacd2a2f3a009dea24fd8e96.2212bdd23ab93e43ff69b8a1821b4915	\N	\N	\N	active	2024-09-18 15:44:07.379099+02	\N
22	Suzanne	1941-06-30	Je suis Suzanne, une passionnée de cuisine qui adore préparer de délicieux repas pour ma famille et mes amis. J'ai passé ma vie à perfectionner mes recettes et à apprendre de nouvelles techniques culinaires.	female	https://images.pexels.com/photos/236214/pexels-photo-236214.jpeg?auto=compress&cs=tinysrgb&w=600	\N	suzanne.martin@example.com	808723be5ce6e940b9b9ca4e38a0e864069b6b380d145dedaa04717dcd9951d195439561a38e1d14b1b2ee903c5b7d4eceb5bef8edd9f18943a4e80f2a769337.7164f6f2c724c8730ed0c0ba3f25e8eb	\N	\N	\N	active	2024-09-18 15:44:07.684639+02	\N
23	Pierre	1957-09-15	Je suis Pierre, un passionné de pêche. Depuis ma retraite, je passe mes journées au bord de l'eau, profitant de la tranquillité et de la patience que nécessite ce passe-temps. Pour moi, la pêche est une manière de me détendre et de me reconnecter avec la nature.	male	https://images.pexels.com/photos/3018993/pexels-photo-3018993.jpeg?auto=compress&cs=tinysrgb&w=600	\N	pierre.renard@example.com	9343182fb330724c1cdc154191224c05af209e77795a4451c193e8798fda4bf68bc99fa87e7b069a1ac51ff7b921aba8dc9063521257d5996bc237d2760bc208.1fe12bf3fb91622577c54a9493187d67	\N	\N	\N	active	2024-09-18 15:44:07.991247+02	\N
24	Yvonne	1947-01-12	Je suis Yvonne, une femme active qui aime faire des randonnées. J'apprécie particulièrement les paysages montagneux où je peux respirer l'air frais et profiter de la beauté de la nature. Chaque randonnée est une nouvelle aventure pour moi.	female	https://images.pexels.com/photos/4057756/pexels-photo-4057756.jpeg?auto=compress&cs=tinysrgb&w=600	\N	yvonne.legrand@example.com	f0baa79f11caa26b2dcb48f36d577aa089a86e9b6c82d4d31ae7facf3237e850757decdd4ad59ace5d8a335494825745d70a527ac8e6726c25facb67ccab586f.bb2e5a1dcdfedffb5c461aa44005a2f0	\N	\N	\N	active	2024-09-18 15:44:08.296183+02	\N
25	René	1944-11-23	Je suis René, un passionné de musique classique. Je joue du piano depuis mon enfance et j'aime passer des heures à interpréter mes morceaux préférés. La musique est une partie essentielle de ma vie.	male	https://images.pexels.com/photos/35065/homeless-man-color-poverty.jpg?auto=compress&cs=tinysrgb&w=600	\N	rene.beaumont@example.com	f0bc92318e02d3a00ac713f79def428fc9dea78fac29fb202787c17b86d00920bbeaa8f96c40e90e7b7526f39e60efdbac3d7f2a3c875d9540da08a31df82d78.f82714cfe002393f9f0149fa71ef1a1e	\N	\N	\N	active	2024-09-18 15:44:08.60116+02	\N
26	Jeanne	1938-04-07	Je suis Jeanne, une passionnée de tricot et de couture. J'aime créer des vêtements et des accessoires pour ma famille et mes amis. Travailler avec mes mains me procure une grande satisfaction.	female	https://images.pexels.com/photos/3778171/pexels-photo-3778171.jpeg?auto=compress&cs=tinysrgb&w=600	\N	jeanne.laurent@example.com	85f3ad1eb209249867cb2e79655ee6ed106dd1c314434a7c2029f6dbd6f214ad8e253954d78e492034470f8029c7ba3488e73f4c095767afd966dcb2955def3d.21c2d694dc6019e25540c097ca20f141	\N	\N	\N	active	2024-09-18 15:44:08.906243+02	\N
27	Michel	1945-08-19	Je suis Michel, un amateur de peinture. Depuis ma retraite, je passe beaucoup de temps à peindre des paysages et des portraits. La peinture me permet d'exprimer ma créativité et de me détendre.	male	https://images.pexels.com/photos/41008/cowboy-ronald-reagan-cowboy-hat-hat-41008.jpeg?auto=compress&cs=tinysrgb&w=600	\N	michel.roux@example.com	09f8c784cc2c7c40441fc207511352a535f7fd6b9f6b926c0dcfeb2c3fbf4a14b9ff5c6ba314c7c4a832e0af3f2ae3c5e8a4c6e44684c19377e337543b5c019c.3b91380f3311640dadcbccb343507d2a	\N	\N	\N	active	2024-09-18 15:44:09.211639+02	\N
29	Georges	1937-02-15	Je suis Georges, un passionné d'échecs. J'aime passer du temps à jouer aux échecs, que ce soit en ligne ou avec des amis. Ce jeu me permet de rester mentalement actif et de relever des défis stratégiques.	male	https://images.pexels.com/photos/818261/pexels-photo-818261.jpeg?auto=compress&cs=tinysrgb&w=600	\N	georges.marchand@example.com	0a039007061816db68af38f86cbd2cf5b56cf593aeaf6543198d1682a4465938f7d1397a923938209c7adc51a577e8784feca095657e57e4a231b8fed5021f9d.4e36acce6cb02fa5e2e871b5a4548281	\N	\N	\N	active	2024-09-18 15:44:09.823976+02	\N
30	Elisabeth	1943-09-25	Je suis Elisabeth, une amoureuse de la lecture. J'ai toujours un livre à la main et j'aime me plonger dans des mondes différents grâce à la littérature. Les livres sont ma fenêtre sur le monde.	female	https://images.pexels.com/photos/1676021/pexels-photo-1676021.jpeg?auto=compress&cs=tinysrgb&w=600	\N	elisabeth.dubois@example.com	9fd89fcb79476965ec905f35f2109cf867ca9080febb3b4872f05b0f4740be962b06d7a9d5d18d8a19239e9eb3fa9bafcc18ec4756a79f854134a6ecb9a2dcf9.3dfd3f19c62234ad5347508057746726	\N	\N	\N	active	2024-09-18 15:44:10.12948+02	\N
31	Antoine	1948-10-18	Je suis Antoine, un passionné d'histoire. Je passe mon temps à lire des livres d'histoire et à visiter des musées pour en apprendre davantage sur les événements passés. L'histoire me fascine et j'aime partager mes connaissances avec les autres.	male	https://images.pexels.com/photos/2774292/pexels-photo-2774292.jpeg?auto=compress&cs=tinysrgb&w=600	\N	antoine.dupuis@example.com	b202c3eba03fc7b622d3ab35ec73f17b3393810a7c06a7fc0df1bea25ab153aa25bbf0c385bfdb8c774bcdd46612be59f65ee2b3b4a632342f9d6db67ba178b3.7fc57507798ef5f3355ef002c5ab6de7	\N	\N	\N	active	2024-09-18 15:44:10.434574+02	\N
32	Monique	1946-06-22	Je suis Monique, une passionnée de danse. Depuis mon plus jeune âge, j'ai toujours aimé danser et je continue à le faire pour rester en forme et m'amuser. La danse me permet de me sentir vivante.	female	https://images.pexels.com/photos/3768117/pexels-photo-3768117.jpeg?auto=compress&cs=tinysrgb&w=600	\N	monique.lambert@example.com	d689d5284a1b8b7db6e11814ec30260b3a24e6e39d7aa8f09bc46ccecd9e2eaccf1671fb825bd9396301446ac669a03df7355efab572038fbe3dc069aedc85e8.19a365ddfa24b41a3764f1157bf04ad6	\N	\N	\N	active	2024-09-18 15:44:10.741188+02	\N
33	André	1961-03-28	Je suis André, un passionné de bricolage. J'aime travailler de mes mains et réparer des objets. Que ce soit en bois, en métal ou en électricité, je suis toujours à la recherche de nouveaux projets à réaliser.	male	https://images.pexels.com/photos/2880285/pexels-photo-2880285.jpeg?auto=compress&cs=tinysrgb&w=600	\N	andre.bonnet@example.com	f4a27a720686179f5d7320748e74491d4a9395c575d96620b473c89c4e8e7921fa2e7e50a7e6ee145af1a8f15b4c83a82b3503f2440f382050cda4700e9729ad.06c19ea569c6840bdf1de16c92246549	\N	\N	\N	active	2024-09-18 15:44:11.047327+02	\N
34	Isabelle	1949-11-04	Je suis Isabelle, une passionnée de jardinage. J'adore cultiver des plantes et voir mon jardin fleurir tout au long de l'année. Le jardinage est pour moi une source de détente et de satisfaction.	female	https://images.pexels.com/photos/731506/pexels-photo-731506.jpeg?auto=compress&cs=tinysrgb&w=600	\N	isabelle.gautier@example.com	fbc4812599d5de2ba59af822791f59b1a2d38cedebf72f57e76bfca7ea02d466daf8b81d461fd9b6e73a380f1f36909999aa2fbc46dbdc36bc7c7eccb62d8b42.2189f236e010c84863d2a07a6e672969	\N	\N	\N	active	2024-09-18 15:44:11.353579+02	\N
35	Bernard	1953-08-11	Je suis Bernard, un passionné de photographie. J'aime capturer les moments de la vie quotidienne ainsi que les paysages lors de mes voyages. La photographie est pour moi un moyen de documenter ma vie et de partager ma vision du monde.	male	https://images.pexels.com/photos/162547/man-old-white-beard-face-162547.jpeg?auto=compress&cs=tinysrgb&w=600	\N	bernard.giraud@example.com	c80112b0b087a46c58fcaa3d37ce54916b8747457601f488b8dd8a4a0bd4021ce620a03fe7aab684f96aab5eefb275a799fe30218e3a7c8d343e785b6cabf7c9.b0c903129a8e8f56d54453fba5a3599f	\N	\N	\N	active	2024-09-18 15:44:11.658425+02	\N
36	Lucie	1951-05-29	Je suis Lucie, une passionnée de couture. J'adore créer des vêtements sur mesure pour moi et ma famille. Coudre est une façon pour moi de m'exprimer et de créer quelque chose de beau et d'unique.	female	https://images.pexels.com/photos/34540/old-lady-smile-beautiful-woman.jpg?auto=compress&cs=tinysrgb&w=600	\N	lucie.leclerc@example.com	74c501722356b557480b635191a82b4b1812e8dc5fd41a21724f5b1591ad74c20898e958124a7f9a5052e45278937fc351c044b373a1c774c463ab46f1177b2a.298aa27acfa488fda9f06e33376d5379	\N	\N	\N	active	2024-09-18 15:44:11.963392+02	\N
37	Henri	1940-07-16	Je suis Henri, un passionné de cuisine. J'aime expérimenter de nouvelles recettes et partager mes créations avec ma famille et mes amis. Pour moi, la cuisine est un art et une passion.	male	https://images.pexels.com/photos/1933873/pexels-photo-1933873.jpeg?auto=compress&cs=tinysrgb&w=600	\N	henri.petit@example.com	b81c8fd7e1243cf924983eb13d46ff22720fb36c18e525ddc70a90eb82c129f6de6456aefdfdbe480a9bca183683e495ee6533b5ef09bdaeb2354b8c0e38b93f.2107fcbdf96922bf580c4062d06f91d1	\N	\N	\N	active	2024-09-18 15:44:12.271734+02	\N
38	Agnès	1962-09-09	Je suis Agnès, une passionnée de lecture. Je passe des heures à lire des romans, des biographies, et des poèmes. La lecture est pour moi une échappatoire et un moyen de découvrir de nouveaux mondes.	female	https://images.pexels.com/photos/1786258/pexels-photo-1786258.jpeg?auto=compress&cs=tinysrgb&w=600	\N	agnes.lemoine@example.com	707c913b8e1147d355df3f441bbdc662d659da8cf48ae1b0b57a2aba3750621725554f8e412f99505da275ffff65d8141b31e892e0610188cac7cd9ddec2729e.156c53c5f20ecfe9945e73930aee0e7d	\N	\N	\N	active	2024-09-18 15:44:12.578157+02	\N
40	Marie	1947-03-06	Je suis Marie, une passionnée de peinture. J'aime capturer la beauté des paysages et des gens à travers mes pinceaux. Peindre est pour moi un moyen d'expression et une source de bonheur.	female	https://images.pexels.com/photos/3768140/pexels-photo-3768140.jpeg?auto=compress&cs=tinysrgb&w=600	\N	marie.perrin@example.com	9a9553d15b033e5473d95ec317af759b93aef8f0d3ab76718639506428c58c6db93b67ac3dda29b636917c86f8419c4d86e2c81e04345d0fb2762efd6d3032f8.d0c8b28de0b408466a170d911115747d	\N	\N	\N	active	2024-09-18 15:44:13.188806+02	\N
41	Robert	1950-10-30	Je suis Robert, un amateur de photographie. J'aime immortaliser des moments uniques à travers mon objectif. La photographie me permet de capturer la beauté du monde et de la partager avec les autres.	male	https://images.pexels.com/photos/1474705/pexels-photo-1474705.jpeg?auto=compress&cs=tinysrgb&w=600	\N	robert.roussel@example.com	2a2ac6eb56bcb4023ddb9e7b215e5bd7ca2ecc33f7671572722bb86b8d40bee7e11d24b373f862c58747385ea9e651117a26e17776bcff7df850af697187da71.97bcd8df700ca180b668b14c141faaeb	\N	\N	\N	active	2024-09-18 15:44:13.494338+02	\N
42	Françoise	1953-12-13	Je suis Françoise, une passionnée de tricot. J'aime passer mes soirées à tricoter des pulls, des écharpes et des bonnets pour mes proches. Le tricot est pour moi une activité relaxante et créative.	female	https://images.pexels.com/photos/2382890/pexels-photo-2382890.jpeg?auto=compress&cs=tinysrgb&w=600	\N	francoise.lefevre@example.com	d4c08d0405cd411bec2076b4103deb3ee159aa04a450725b99e832a496c744751aacb5addbc913180d6b1d588901eddbc8380a5795f12c1383f399569d6b99e8.67e1ff14dfed70a2010a9bb85e35adaf	\N	\N	\N	active	2024-09-18 15:44:13.801121+02	\N
43	Gérard	1954-05-12	Je suis Gérard, un passionné de jardinage. J'aime passer du temps dans mon jardin, à planter des fleurs et des légumes. Le jardinage est pour moi une source de paix et de satisfaction.	male	https://images.pexels.com/photos/2586537/pexels-photo-2586537.jpeg?auto=compress&cs=tinysrgb&w=600	\N	gerard.fontaine@example.com	9fd63a160a90e7c3fa710989d189e1209bf80cafc33a4443ef8913ab9d83fcc295743a3b6d36387822c7098b9b5b33492a6138a432759934869c776f89a4d2de.3b73197a3aada57edb0dc07b3846cdc9	\N	\N	\N	active	2024-09-18 15:44:14.108799+02	\N
44	Simone	1949-11-18	Je suis Simone, une passionnée de lecture. J'aime passer mes après-midi à lire des romans et des biographies. La lecture est pour moi une façon de voyager sans quitter ma maison.	female	https://images.pexels.com/photos/407422/pexels-photo-407422.jpeg?auto=compress&cs=tinysrgb&w=600	\N	simone.renard@example.com	8abd248f29014bb44109698971075ca90a9d9dd97feb76aa024ac68ba226629fbfaac632eaa2f080f4aa8b22690ac84d66e34edd1f9ab1f2f9ef1cdb9eca3674.7644b7e1e1398edcbbe432ffdaacae04	\N	\N	\N	active	2024-09-18 15:44:14.414593+02	\N
46	Renée	1948-04-02	Je suis Renée, une passionnée de danse. J'aime danser depuis mon enfance et je continue à pratiquer pour le plaisir et pour rester en forme. La danse est pour moi une expression de joie de vivre.	female	https://images.pexels.com/photos/4057758/pexels-photo-4057758.jpeg?auto=compress&cs=tinysrgb&w=600	\N	renee.blanc@example.com	2354936e492a81402e2268470e891b90193fbab7f076381c188afc169bef763622261a367e05221af72157b0a69d6f91a5a0575cb21cdc780afdfff91b45ae12.a20f64f42dd956dbccf200e634159be3	\N	\N	\N	active	2024-09-18 15:44:15.026798+02	\N
47	Jacques	1945-07-20	Je suis Jacques, un passionné de modélisme. J'aime construire des maquettes d'avions, de trains et de bateaux. Le modélisme est pour moi une activité qui me demande de la patience et de la précision, ce qui me procure beaucoup de satisfaction.	male	https://images.pexels.com/photos/3831614/pexels-photo-3831614.jpeg?auto=compress&cs=tinysrgb&w=600	\N	jacques.moreau@example.com	c806b88e70654fd3be4d8945710b42509a50761dda465ead39b8e6aee83de3b71940829982db44946be6e57e41047c8d5b64bf27336b8fbac229517de0a368bd.82d9c23b02a7cb851ee7ddf4848a29eb	\N	\N	\N	active	2024-09-18 15:44:15.331206+02	\N
50	Catherine	1947-10-02	Je suis Catherine, une passionnée de cuisine. J'aime expérimenter avec de nouvelles recettes et partager mes créations culinaires avec ma famille et mes amis. Pour moi, la cuisine est un moyen d'expression et une façon de montrer mon amour.	female	https://images.pexels.com/photos/1539702/pexels-photo-1539702.jpeg?auto=compress&cs=tinysrgb&w=600	\N	catherine.lemarie@example.com	a39b5cc4294972eae21bf41373255a48f197138f128996f287da29a5644b430797ae383e25d0dc357a59edd14fa6525a5f7b68dd1c722e37c560835c96818010.2a0eaf781d0eb1d763a3772eb75c57c4	\N	\N	\N	active	2024-09-18 15:44:16.244833+02	\N
51	Philippe	1946-05-03	Je suis Philippe, un passionné de photographie. J'aime immortaliser les moments spéciaux de la vie à travers mon objectif. La photographie est pour moi une manière de capturer et de préserver les souvenirs.	male	https://images.pexels.com/photos/228842/pexels-photo-228842.jpeg?auto=compress&cs=tinysrgb&w=600	\N	philippe.guerin@example.com	244d3f272c0511b31efce2b567d4d17f65aac4966f32c0ec3c927b17d9a9d7e1b2a62b9ee63ee20d7eade65c24e85e7d07d9181a124d93f8d13116274c023d20.0c71853f171615b625c8300dea2fcd22	\N	\N	\N	active	2024-09-18 15:44:16.550261+02	\N
52	Madeleine	1958-04-12	Je suis Madeleine, une passionnée de jardinage. J'adore passer du temps dans mon jardin à planter des fleurs et des légumes. Le jardinage est pour moi une source de paix et de satisfaction.	female	https://images.pexels.com/photos/1786781/pexels-photo-1786781.jpeg?auto=compress&cs=tinysrgb&w=600	\N	madeleine.feraud@example.com	91c6b053d68bad3194dafb8a30dd1ac823f69c20d9999cd9b9cdcc9059666f0407c3407403a289f911c02951dda6b5b6c02ea2028a550f31bf7bc13896249420.fe3e89498286cbec31e885dff262af2e	\N	\N	\N	active	2024-09-18 15:44:16.856341+02	\N
53	François	1948-06-11	Je suis François, un passionné de pêche. Depuis ma retraite, je passe mes journées au bord de l'eau, profitant de la tranquillité et de la patience que nécessite ce passe-temps. Pour moi, la pêche est une manière de me détendre et de me reconnecter avec la nature.	male	https://images.pexels.com/photos/160422/man-hat-portrait-old-man-160422.jpeg?auto=compress&cs=tinysrgb&w=600	\N	francois.bernard@example.com	30b4ea92f42f7e0110a85da8e4dd90f710054e66f5c929bba75b681a91d7a09a88bdaa4ed40c0a4f47d0bd2e5bd6949989e1452871c0bacbe40b18631e4ae4fd.dc826c119d575f5971e2647b86ac3324	\N	\N	\N	active	2024-09-18 15:44:17.161088+02	\N
54	Chantal	1949-12-21	Je suis Chantal, une passionnée de peinture. J'aime capturer la beauté des paysages et des gens à travers mes pinceaux. Peindre est pour moi un moyen d'expression et une source de bonheur.	female	https://images.pexels.com/photos/3867213/pexels-photo-3867213.jpeg?auto=compress&cs=tinysrgb&w=600	\N	chantal.delorme@example.com	d781c1a3ea329bb1e71651ce45d180d5e06c5d32d644271ef980ae84ceb99f4790f3f17fae5a2145d2b9f2b6fa551f90321403dd5dddef46079403934f072dc3.94de78e64eb05961bc41c7bf22a5cfab	\N	\N	\N	active	2024-09-18 15:44:17.466562+02	\N
55	Christian	1951-03-14	Je suis Christian, un passionné de bricolage. J'aime travailler de mes mains et réparer des objets. Que ce soit en bois, en métal ou en électricité, je suis toujours à la recherche de nouveaux projets à réaliser.	male	https://images.pexels.com/photos/631043/pexels-photo-631043.jpeg?auto=compress&cs=tinysrgb&w=600	\N	christian.renault@example.com	3644bf1edc1de136f2dd22a9e21f5d7205b89f727ee072612b4551595ea058749b6600dc3fb3b042ed04126e6cf90e6f01469eea2c7064f5d868115ea8f76203.daddcc74202757c83a0a1a5ba81f05e2	\N	\N	\N	active	2024-09-18 15:44:17.774265+02	\N
56	Paule	1954-07-22	Je suis Paule, une passionnée de danse. Depuis mon plus jeune âge, j'ai toujours aimé danser et je continue à le faire pour rester en forme et m'amuser. La danse me permet de me sentir vivante.	female	https://images.pexels.com/photos/3455462/pexels-photo-3455462.jpeg?auto=compress&cs=tinysrgb&w=600	\N	paule.leblanc@example.com	d9b4c1b04d75fb416916657a3c308bf140a35933e8e724f6065ee062b5f313e4f29cf562e900c56179f9770235f72a2ca2d057838fb46c85e0d7ec2519fc8daa.24a1d64b37e367b63a18e79ba50259df	\N	\N	\N	active	2024-09-18 15:44:18.079119+02	\N
57	Michel	1947-09-07	Je suis Michel, un passionné de musique. Je joue de la guitare et j'aime composer mes propres chansons. La musique est pour moi une manière de m'exprimer et de me connecter aux autres.	male	https://images.pexels.com/photos/53159/man-old-fisherman-portrait-53159.jpeg?auto=compress&cs=tinysrgb&w=600	\N	michel.riviere@example.com	b70b6039133dbc86c60e86320f4a6db839055be82d0c1224847d724920b06bb29af1c17038aea1ba6e4819f3cd40c04c318e7014b12b3d81f91844c5d16220e9.1d89b34a3bb5ab48fada28e5b2dc6bdc	\N	\N	\N	active	2024-09-18 15:44:18.387228+02	\N
58	Marguerite	1950-06-05	Je suis Marguerite, une passionnée de lecture. J'aime passer mes après-midi à lire des romans et des biographies. La lecture est pour moi une façon de voyager sans quitter ma maison.	female	https://images.pexels.com/photos/1592091/pexels-photo-1592091.jpeg?auto=compress&cs=tinysrgb&w=600	\N	marguerite.carre@example.com	4a7474c03402e0f78a2594fc7a5282676ca6241380f5e784b63c945a60821003c85cf7139c5dcdeec813a36a86be067d52d0e07e714d08b9a12e59362c0c3571.380836e127393eaa527625a8800e7267	\N	\N	\N	active	2024-09-18 15:44:18.694026+02	\N
59	Jean	1951-11-17	Je suis Jean, un passionné d'histoire. Je passe mon temps à lire des livres d'histoire et à visiter des musées pour en apprendre davantage sur les événements passés. L'histoire me fascine et j'aime partager mes connaissances avec les autres.	male	https://images.pexels.com/photos/1058064/pexels-photo-1058064.jpeg?auto=compress&cs=tinysrgb&w=600	\N	jean.faure@example.com	27ae85009290380a418add0521fd72465611b58fc1b043224b870a1db8cfc0acb916b5bfa9f2198bfdf277804361806d7c8c34eed31518a299fbe84d27659641.24ebb5c9cbf6d43237231fb19ae294ec	\N	\N	\N	active	2024-09-18 15:44:18.999143+02	\N
61	Gilbert	1953-04-26	Je suis Gilbert, un passionné de pêche. Depuis ma retraite, je passe mes journées au bord de l'eau, profitant de la tranquillité et de la patience que nécessite ce passe-temps. Pour moi, la pêche est une manière de me détendre et de me reconnecter avec la nature.	male	https://images.pexels.com/photos/316680/pexels-photo-316680.jpeg?auto=compress&cs=tinysrgb&w=600	\N	gilbert.charpentier@example.com	64e1026defb94e7275a6dca2e044a96ae20569e360cf0e53735c9f786156c2f414a0618254f76e1917ea1f6f682d95f76447c5ba1f4fac8124a2632824206b1c.d9e29ebe508339bb90a40729bd4e4817	\N	\N	\N	active	2024-09-18 15:44:19.610995+02	\N
62	Bernadette	1954-08-14	Je suis Bernadette, une passionnée de jardinage. J'aime cultiver des plantes et voir mon jardin fleurir tout au long de l'année. Le jardinage est pour moi une source de détente et de satisfaction.	female	https://images.pexels.com/photos/3024605/pexels-photo-3024605.jpeg?auto=compress&cs=tinysrgb&w=600	\N	bernadette.gaudin@example.com	ecfe1fdd9878ccd32f51a3c1d71d113d48b7d36430b548d525f217c85bf8fa9d731654a7ab57e2558fd0a91edb1b988fd9f7e5acd2d40fd8294749cd343b90b9.7d26f6a7be9c7e3be49663ea98e2ca8f	\N	\N	\N	active	2024-09-18 15:44:19.915703+02	\N
63	Monique	1951-01-12	Je suis Monique, une passionnée de couture et de design d'intérieur. J'adore transformer des tissus en vêtements élégants et décorer sa maison avec des créations uniques. Je passe également du temps à organiser des ateliers de couture pour partager son savoir-faire.	female	https://images.pexels.com/photos/3707680/pexels-photo-3707680.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	monique@example.com	fd99b500d93fd4b2ab9ec370faf4febc9913437ef81795782ee7e6a77ddda117a00e6ba7b8e0fc7f35118a661cb537e9c9c6ed33bef92a5f05fa1b4234e786d4.7153fc907eeb1983efb77b41a89b2bf9	\N	\N	\N	active	2024-09-18 15:44:20.224045+02	\N
64	Alain	1949-03-23	Je suis Alain, un passionné d'histoire et d'archéologie. J'aime explorer des sites historiques et partager ses découvertes à travers des conférences et des articles. En dehors de mes recherches, j'apprécie la randonnée et les voyages culturels.	male	https://images.pexels.com/photos/45852/farmer-smile-man-person-45852.jpeg?auto=compress&cs=tinysrgb&w=600	\N	alain@example.com	666d703cce44c8329528924d6b591ed447a0123933270f5587796b27da32d4e5f427eabee51f28ebd075659938f3bac563c4b97ea26babb332ee2d9da6b9fa88.e8fbac8e71d57bc2e4425782e95c20a8	\N	\N	\N	active	2024-09-18 15:44:20.528518+02	\N
65	Claudine	1952-08-16	Je suis une amatrice de jardinage et de permaculture. Je cultive un jardin durable, partage mes connaissances avec des groupes locaux, et organise des ateliers sur la culture biologique. J''aime également préparer des plats faits maison avec les produits de mon jardin.	female	https://images.pexels.com/photos/3171160/pexels-photo-3171160.jpeg?auto=compress&cs=tinysrgb&w=600	\N	claudine@example.com	f7c4ed173bb9d4e0fb5c364a8295690f1626ba5407a26057a2d3c535e5343be0d3f2af555170ce25a05c60cd75928c72eb9b252e1b25dc7839a5e0ebdd64ceca.82c416872a594fb21b84016c1ec46631	\N	\N	\N	active	2024-09-18 15:44:20.83328+02	\N
66	Jean-Pierre	1964-07-06	Je suis un amateur de vin et de gastronomie. J''aime explorer les régions viticoles, découvrir de nouveaux crus, et organiser des dégustations pour mes amis. Je suis aussi un fervent lecteur de romans policiers.	male	https://images.pexels.com/photos/1152705/pexels-photo-1152705.jpeg?auto=compress&cs=tinysrgb&w=600	\N	jeanpierre@example.com	7f635d2533c64064c5e3ec7c7a03de7ea76d91278aa84ade49afb0b99b095e750086ebed0f68159513154fe3430034c6d4589b812c5d7eff6a11c5f7843044ac.bc3b7c81a700b210c60eb0f891189b44	\N	\N	\N	active	2024-09-18 15:44:21.139522+02	\N
67	Catherine	1948-12-11	Je suis passionnée de musique folk et de chants traditionnels. Je joue de la guitare et chante dans des groupes locaux. En plus de ma passion musicale, j''adore le bricolage et la décoration artisanale.	female	https://images.pexels.com/photos/4511649/pexels-photo-4511649.jpeg?auto=compress&cs=tinysrgb&w=600	\N	catherine@example.com	49bf9b7db83d6d4700adc10d6372e3c6b534bafe3d668f01e4b6a73a3fd919e2e30eadb9d014cde817dca073e666ad674f7497038b4e77fadbb660fb091520ed.4726e86ef677b4ea9a20b6e432867bf2	\N	\N	\N	active	2024-09-18 15:44:21.447981+02	\N
68	Henriette	1954-09-30	Je suis une fervente défenseuse des droits des animaux et une bénévole dans plusieurs refuges. J''aime également la photographie animalière et passe beaucoup de temps à capturer la faune dans son environnement naturel.	female	https://images.pexels.com/photos/3677094/pexels-photo-3677094.jpeg?auto=compress&cs=tinysrgb&w=600	\N	henriette@example.com	7a3e422fcf96c1f2a39d4d887b964882e0d3e921a3b6dd6baa4c1bea10a5b2c2be22da72df6ea6c64ecef1759ff1e545975f895861afe65c2757dacdd2cc059b.a0d09f971e469d427c40744b9ce4b0d7	\N	\N	\N	active	2024-09-18 15:44:21.752982+02	\N
69	Maurice	1950-02-19	Je suis un passionné de mécanique et de voitures anciennes. Je passe mes weekends à restaurer des véhicules classiques et à participer à des concours de voitures anciennes. J''apprécie aussi le théâtre et assiste régulièrement à des représentations.	male	https://images.pexels.com/photos/8173604/pexels-photo-8173604.jpeg?auto=compress&cs=tinysrgb&w=600	\N	maurice@example.com	40cdd42301025b6a1a645602c1be4dd9fe2940cd58e84df24c17f3210307c8cc9e842ce13516d6917342a6a7ef5718f353cb07cb56046d20384191c0981f40c2.5e198f3924f16ce43b476f3d8040b454	\N	\N	\N	active	2024-09-18 15:44:22.058833+02	\N
70	Brigitte	1951-05-04	Je suis une passionnée de poésie et de littérature. Je participe à des cercles de lecture et organise des soirées poésie où je partage mes poèmes avec mes amis. Je suis également impliquée dans des projets de soutien aux jeunes écrivains.	female	https://images.pexels.com/photos/5705526/pexels-photo-5705526.jpeg?auto=compress&cs=tinysrgb&w=600	\N	brigitte@example.com	2a7982b8953874b0f326db3772c97d6d53edd639ca39f4c496f1aa6326ce0c6234eb9328f9b290febc6ef446a3df956a3d73255d6fa721c5ebf3e875c1542b1e.69d70fd6ad93818f0ffcd2bc5b750903	\N	\N	\N	active	2024-09-18 15:44:22.363079+02	\N
71	Marie	1955-03-18	Je suis Marie, passionnée de jardinage et de cuisine bio. Ancienne institutrice, je consacre maintenant mon temps à cultiver mon potager et à partager mes connaissances sur l'alimentation saine avec ma communauté. J'anime des ateliers de cuisine pour les enfants du quartier, leur apprenant à apprécier les légumes qu'ils ont eux-mêmes cultivés.	female	https://images.pexels.com/photos/5637499/pexels-photo-5637499.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	marie.jardin55@example.com	aac1c279da86278debf6fd6b30d7ce95a08bac8ccd11bc827a9517e6052ba08e9eb436186c0d7296736a04dd58db33b8a3898b1329b36977b91c040f60fa8f3e.ee477148b98b7151cff3efb0cca39d34	\N	\N	\N	active	2024-09-18 15:44:22.669171+02	\N
72	Robert	1953-09-22	Je m'appelle Robert, un passionné d'histoire locale. Après une carrière dans l'administration, je me consacre à la préservation du patrimoine de ma ville. J'organise des visites guidées bénévoles et je travaille sur un livre retraçant l'histoire de notre région à travers les siècles.	male	https://images.pexels.com/photos/5637526/pexels-photo-5637526.jpeg?auto=compress&cs=tinysrgb&w=600	\N	robert.histoire53@example.com	f6b99e018022bdb4e0a49a1362883213fcf50e82335152fd8a29977e6578ba0dccc8ce9cc150558617b7daab9bdcec2f25c16940c5a2b57264d1eb56dc34bc93.234059f2a4d5e88d44ec36d93ca8a29a	\N	\N	\N	active	2024-09-18 15:44:22.974701+02	\N
73	Aminata	1958-11-30	Je suis Aminata, une ancienne sage-femme originaire du Sénégal. Aujourd'hui à la retraite, je me consacre à l'accompagnement des jeunes mères dans ma communauté. Je suis également passionnée de couture et je crée des vêtements traditionnels africains que je vends au profit d'associations caritatives.	female	https://img.freepik.com/photos-gratuite/vue-laterale-senior-femme-noire-posant_23-2150247818.jpg?t=st=1726664731~exp=1726668331~hmac=f29188de63fd7244ff597308f2aaa4ea77e79ef46e57b4914ac7d6019dbc896f&w=740	\N	aminata.sage58@example.com	3f2304f0ef353b0b57758f0c574f5f6450f7c610855017a3f32989205706bf1ad1549794256b62a2319d60875d610b3845f01871179898156edab1385480fb63.d1c2d1d33fb44d59c198dcc1eeb6671f	\N	\N	\N	active	2024-09-18 15:44:23.279501+02	\N
74	Jean-Pierre	1951-05-07	Je m'appelle Jean-Pierre, un ancien ingénieur en aéronautique. Ma passion pour l'aviation ne m'a jamais quitté et je consacre désormais mon temps à construire des modèles réduits d'avions historiques. J'anime également un club d'aéromodélisme pour les jeunes de ma ville.	male	https://images.pexels.com/photos/5647229/pexels-photo-5647229.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	jeanpierre.aviation51@example.com	2ebd350ac07ef2fcdd7ff16837d5cc7da70b07970361762ae68c8842149c4c75ca75eb653e91da4fe2e7c612c7778fda0d7cf30aa154ed13541cfc0b93374b58.8fdd47a42fcf6a2d6ddc5a62ab3dee9c	\N	\N	\N	active	2024-09-18 15:44:23.584688+02	\N
75	Fatima	1960-02-14	Je suis Fatima, une artiste peintre d'origine marocaine. Après une carrière dans l'enseignement des arts plastiques, je me consacre entièrement à ma passion. Mes œuvres, inspirées de la culture berbère, sont exposées dans plusieurs galeries. J'anime également des ateliers d'art-thérapie pour les personnes âgées.	female	https://img.freepik.com/photos-gratuite/portrait-monochrome-belle-femme-africaine_23-2151436186.jpg?t=st=1726665216~exp=1726668816~hmac=8d6376a45a63076616489dec2744a3e873bcf82a838dfb83b6349a92cc936f77&w=1380	\N	fatima.art60@example.com	ec0758df326a01039a515b423be2ea33de04c8da785f3200a3c4c93a0d55157638178db5de4c07d4d3b73068adc2255a54cc5074c79344656529fd5ce7597253.1dafce25e7b2d1203c9b500564601f25	\N	\N	\N	active	2024-09-18 15:44:23.892472+02	\N
76	Georges	1949-08-23	Je m'appelle Georges, un ancien chef cuisinier. Ma passion pour la gastronomie ne m'a jamais quitté. Aujourd'hui, je partage mon savoir-faire en donnant des cours de cuisine française traditionnelle. Je suis également bénévole dans une banque alimentaire, où je prépare des repas pour les plus démunis.	male	https://images.pexels.com/photos/1703540/pexels-photo-1703540.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1	\N	georges.cuisine49@example.com	3d6639307b44353a5d3939def49095148ab27ec4a7c21a0f18061829dab099e9c79d0ed830537323dfcf3e98551993a816e69c865eded8f6d1b8316345070007.898b5145ec03ecdd694c0fb1c51f487b	\N	\N	\N	active	2024-09-18 15:44:24.198155+02	\N
77	Awa	1957-06-19	Je suis Awa, une ancienne assistante sociale originaire du Mali. Depuis ma retraite, je me consacre à l'aide aux migrants, les accompagnant dans leurs démarches administratives et leur intégration. Je suis aussi passionnée de contes africains, que je raconte régulièrement aux enfants de ma communauté.	female	https://img.freepik.com/photos-gratuite/portrait-exterieur-femme-africaine-agee_23-2149351982.jpg?t=st=1726665322~exp=1726668922~hmac=998b2763f410e1addd803f4d3baf84031b7d458e34d89f7ed0d73911d449fe38&w=740	\N	awa.solidarite57@example.com	20b3162cefa837760ec57965ca5104e153d055bbbe110f00151ffb0df71b996ef55330d8c026ae3a3d42df954a15eaa82fcf768320d35aa02e2e0cff6899b0be.47fdccee931d90cf0bb63cd1127571cf	\N	\N	\N	active	2024-09-18 15:44:24.504275+02	\N
78	Pierre	1952-12-01	Je m'appelle Pierre, un ancien professeur de littérature. Ma passion pour les livres ne m'a jamais quitté. Aujourd'hui, j'anime un club de lecture et j'écris des critiques littéraires pour un journal local. Je travaille également sur mon premier roman, inspiré de mes voyages en Asie.	male	https://img.freepik.com/photos-gratuite/portrait-homme-buvant-du-the_23-2151783055.jpg?t=st=1726665271~exp=1726668871~hmac=8263eb2b6ef1a017056a78dc2640f281af9405dd4d5da627e424e2e8d4bf23b6&w=1380	\N	pierre.litterature52@example.com	bda56dd3f4d07ea819fec730d69a2de6a7a302afd655acbd89969004d363f07f452c45f46251482682f55da0e954115f42e591aff5bec352f8fe01fd4aaf897a.41ac5955e9fda70c8c27a1430d0853d5	\N	\N	\N	active	2024-09-18 15:44:24.809952+02	\N
79	Amina	1959-04-05	Je suis Amina, une ancienne comptable d'origine algérienne. Depuis ma retraite, je me suis découvert une passion pour la photographie. Je capture la diversité culturelle de mon quartier et organise des expositions pour promouvoir le dialogue interculturel. Je donne aussi des cours d'arabe aux enfants de ma communauté.	female	https://img.freepik.com/photos-gratuite/femme-interagissant-argent_23-2151664829.jpg?t=st=1726665376~exp=1726668976~hmac=181e3fe3f09bef8ca1172ceb09e687fbd4149a69ea8a18b5775a68a475b642ce&w=740	\N	amina.photo59@example.com	a5ed7c98a46df2900ca6941775cff26f85e90b5425b032bfce7f276ce73c6f798fdafae0ef8320a64b0334eb448c13115801c2569a441df352aff62d53b9f549.56ce0f631b620dd539949037dc98fc11	\N	\N	\N	active	2024-09-18 15:44:25.113943+02	\N
80	Jacques	1950-10-17	Je m'appelle Jacques, un ancien ingénieur en télécommunications. Aujourd'hui, je consacre mon temps à ma passion pour l'astronomie. J'anime un club d'observation des étoiles et je donne des conférences sur l'histoire de l'exploration spatiale dans les écoles de ma région.	male	https://img.freepik.com/photos-gratuite/portrait-homme-buvant-du-the_23-2151783094.jpg?uid=R163988052&ga=GA1.1.471918670.1726651168&semt=ais_hybrid	\N	jacques.etoiles50@example.com	99c99a11e923787cb667c74e3857c08a666ca018b2fb53654582cf26c8df23991ee37e997ba2f4756dd2627522d782df85478c93764b167a5940b6c2d97e057e.fb57aa0321c1ec5eb56bd85b78e04475	\N	\N	\N	active	2024-09-18 15:44:25.419694+02	\N
81	Martine	1956-01-23	Je suis Martine, une ancienne journaliste. Ma passion pour la photographie, autrefois un outil de travail, est devenue mon passe-temps favori. Je parcours ma région à la recherche de paysages à immortaliser et j'expose mes œuvres dans des galeries locales. Je donne également des cours de photographie aux débutants.	female	https://img.freepik.com/photos-gratuite/vieille-femme-celebre-journee-mondiale-photographie_23-2151644818.jpg?t=st=1726665431~exp=1726669031~hmac=9621a51ecf8777779805c0beb82eb0989bf9d7c24aef79fd504d787c7861e4bd&w=1380	\N	martine.photo56@example.com	4f894be3b1ab80740c4d1dd1851a1cd4644073c29a99313cb3e90b3ca653019e04e9c44119e98b1d4c7e5815fd4e3936d932e1f8a82c8894c74a7df7081172dc.c4186c373050cf385050845d4b1ee458	\N	\N	\N	active	2024-09-18 15:44:25.724729+02	\N
83	Françoise	1961-09-12	Je suis Françoise, une ancienne infirmière. Depuis ma retraite, je me suis investie dans le bénévolat auprès des personnes âgées isolées. J'organise des visites à domicile et des activités pour rompre leur solitude. Je suis également passionnée de tricot et j'anime un atelier hebdomadaire à la maison de retraite locale.	female	https://img.freepik.com/photos-gratuite/portrait-femme-triste-solitaire_23-2151263181.jpg?t=st=1726665568~exp=1726669168~hmac=d760103a7d9760384e411fe7f99f4f317454031565bd9497eb0bc80a48dce847&w=1380	\N	francoise.solidarite61@example.com	b30b9931b2b09d1c9b1f9613740df5e47895f6b546159b153e09f7914b2511d441dc5d5c8981148106338c2a4c05771ab23d216c45f8957c750fcc116504bf01.238ae41e45546efb7e25be2d0266740d	\N	\N	\N	active	2024-09-18 15:44:26.337667+02	\N
84	Alain	1948-03-30	Je m'appelle Alain, un ancien professeur de mathématiques. Ma passion pour l'enseignement ne m'a jamais quitté. Aujourd'hui, je donne des cours de soutien bénévoles aux élèves en difficulté et j'anime un club d'échecs dans ma ville. J'aime transmettre ma passion pour la logique et la stratégie aux jeunes générations.	male	https://img.freepik.com/photos-gratuite/portrait-homme-moderne-effectuant-taches-menageres-dans-atmosphere-douce-reveuse_23-2151469416.jpg?t=st=1726665457~exp=1726669057~hmac=a34f54a1b0d08d861e2b834a4ee28e8f9d26370418b2b77df69c673b951ff993&w=1380	\N	alain.maths48@example.com	61a6a2f3b9ce3f46686f017b97a18c4dc7254e7998515120fd035f94801d191b337461384bcb75604af184479c22177c48467bba9f610a8db1db3df1c16c10f8.a1d168315985fe8d94bfff20b3eb1172	\N	\N	\N	active	2024-09-18 15:44:26.642306+02	\N
85	Monique	1957-11-05	Je suis Monique, une ancienne bibliothécaire. Ma passion pour les livres et l'éducation m'a conduite à créer une petite bibliothèque mobile. Je parcours les zones rurales de ma région pour apporter des livres aux personnes isolées. J'organise également des cercles de lecture et des ateliers d'écriture pour tous les âges.	female	https://img.freepik.com/photos-gratuite/concept-education-pour-femmes-agees-taille-moyenne_23-2151074852.jpg?t=st=1726665588~exp=1726669188~hmac=5572a023543bba408314f2ad52358be436d1bee615595f0d4e8c3aa6d56a7518&amp;w=740	\N	monique.lecture57@example.com	1b43c604837f6aa61b3a04ca2eca191b55463f79a46dff0e39ff3303abc6e161ceb622b2af4dd8ede3bc400dbdf3db185a8f87e70b1d364b2d3bbfc65943a8f9.1359985fb18ee7022174bc227ae8a466	\N	\N	\N	active	2024-09-18 15:44:26.948313+02	2024-09-18 15:45:43.034+02
82	Bernard	1954-07-08	Je m'appelle Bernard, un ancien technicien radio. Ma passion pour la musique et la technologie m'a conduit à créer une web-radio locale dédiée au jazz et au blues. J'anime également des ateliers d'initiation à la production musicale pour les jeunes de mon quartier.	male	https://img.freepik.com/photos-gratuite/portrait-photorealiste-personne-ecoutant-radio-pour-celebrer-journee-mondiale-radio_23-2151447313.jpg?t=st=1726665399~exp=1726668999~hmac=3afc8b846642a0c2baa05eb3c007507d7e91c7d6dffad2cf9dc42f9399ad9a77&amp;w=740	\N	bernard.radio54@example.com	8f9d6d457c5233495ab014229d3e248309a4b622c08afb6b9d7ad4e8663296dad0e29497c3054432727aabfcb927c49e3d09e32164e0b846a8a6998e34c953be.bb7c846c113a38d7d72f0bdd542174f9	\N	\N	\N	active	2024-09-18 15:44:26.031831+02	2024-10-18 10:12:22.96+02
87	widi	1950-05-15	test de d'inscription	male	\N	\N	widi@love.com	910e5b63e25b53d06b7ab1ec7dce3fc8df0c02fda801bbfa1ad8e0cb2ede28a4947e69f43dceddc206a43780c2ccf14e9cf66437e1d305c14ca4f3114aa4600d.c605c0b5afeb4fef93c1cbea98843356	\N	\N	\N	pending	2024-10-19 09:50:31.193+02	2024-10-19 09:50:31.197+02
60	Denise	1952-10-19	Je suis Denise, une passionnée de tricot. J'aime créer des vêtements sur mesure pour moi et ma famille. Travailler avec mes mains me procure une grande satisfaction.	female	https://images.pexels.com/photos/3561566/pexels-photo-3561566.jpeg?auto=compress&cs=tinysrgb&w=600	\N	denise.morin@example.com	feac9874963b99e1b32d563db6ee54f1d29ea558b899bcb49c945f9d319167029c9c8de4d9c19844fc0dc1b4848dfb70fb9879eb430c73b23991390f6ad7e254.9501e9bca0c8e1966d64c990c36e94f4	\N	\N	\N	active	2024-09-18 15:44:19.305022+02	2024-10-19 14:48:41.546+02
5	Simone	1950-05-15	Bonjour je suis la pour tester l'update	female	https://images.pexels.com/photos/1786258/pexels-photo-1786258.jpeg?auto=compress&amp;cs=tinysrgb&amp;w=1260&amp;h=750&amp;dpr=1	\N	simone@example.com	e73d98d556ef781ee9445d1d81e55c6853737e08460430c20c6bbee85db856e1b625bd3426d83108caeaf1d03b020ca9975e0688efd2046a1e655e28f936cabd.6483674cb17e25ffdef968f3014242b6	\N	\N	\N	active	2024-09-18 15:44:02.478854+02	2024-10-19 10:17:54.617+02
86	super expert	1902-09-10	Hello je suis le super expert	male	https://res.cloudinary.com/dsb2ihfdx/image/upload/v1729329690/user_photos/noivfpegqv6f0ccpsf4y.jpg	user_photos/noivfpegqv6f0ccpsf4y	typixaxyq@mailinator.com	aa64493b9c56c515a9dc468417f32b70323f7fb586c777fd16c1888d931bdec52553a20d01711f3f0d169c441ba76aabc44c0a1ccad5b34200458bc0a8dd5067.f40429593ab4cb0fe3cf6057b51257a3	\N	\N	\N	active	2024-09-19 17:50:55.903+02	2024-10-19 11:21:32.476+02
\.


--
-- Data for Name: users_events; Type: TABLE DATA; Schema: public; Owner: senior
--

COPY public.users_events (id, user_id, event_id, created_at, updated_at) FROM stdin;
1	1	1	2024-09-18 15:44:35.597809+02	\N
2	2	1	2024-09-18 15:44:35.597809+02	\N
3	2	3	2024-09-18 15:44:35.597809+02	\N
4	3	5	2024-09-18 15:44:35.597809+02	\N
5	3	6	2024-09-18 15:44:35.597809+02	\N
6	3	4	2024-09-18 15:44:35.597809+02	\N
7	3	10	2024-09-18 15:44:35.597809+02	\N
8	4	4	2024-09-18 15:44:35.597809+02	\N
9	5	10	2024-09-18 15:44:35.597809+02	\N
10	6	13	2024-09-18 15:44:35.597809+02	\N
11	7	1	2024-09-18 15:44:35.597809+02	\N
12	7	4	2024-09-18 15:44:35.597809+02	\N
13	7	9	2024-09-18 15:44:35.597809+02	\N
14	8	2	2024-09-18 15:44:35.597809+02	\N
15	8	11	2024-09-18 15:44:35.597809+02	\N
16	9	1	2024-09-18 15:44:35.597809+02	\N
17	9	4	2024-09-18 15:44:35.597809+02	\N
18	10	5	2024-09-18 15:44:35.597809+02	\N
19	10	11	2024-09-18 15:44:35.597809+02	\N
20	11	11	2024-09-18 15:44:35.597809+02	\N
21	13	1	2024-09-18 15:44:35.597809+02	\N
22	14	2	2024-09-18 15:44:35.597809+02	\N
23	14	5	2024-09-18 15:44:35.597809+02	\N
24	15	4	2024-09-18 15:44:35.597809+02	\N
25	15	6	2024-09-18 15:44:35.597809+02	\N
26	15	9	2024-09-18 15:44:35.597809+02	\N
27	16	8	2024-09-18 15:44:35.597809+02	\N
28	16	10	2024-09-18 15:44:35.597809+02	\N
30	18	2	2024-09-18 15:44:35.597809+02	\N
31	18	5	2024-09-18 15:44:35.597809+02	\N
32	18	12	2024-09-18 15:44:35.597809+02	\N
33	19	3	2024-09-18 15:44:35.597809+02	\N
34	19	7	2024-09-18 15:44:35.597809+02	\N
35	27	3	2024-09-18 15:44:35.597809+02	\N
36	27	10	2024-09-18 15:44:35.597809+02	\N
37	27	12	2024-09-18 15:44:35.597809+02	\N
38	28	4	2024-09-18 15:44:35.597809+02	\N
39	28	7	2024-09-18 15:44:35.597809+02	\N
40	29	1	2024-09-18 15:44:35.597809+02	\N
41	29	6	2024-09-18 15:44:35.597809+02	\N
42	29	11	2024-09-18 15:44:35.597809+02	\N
43	30	2	2024-09-18 15:44:35.597809+02	\N
44	30	8	2024-09-18 15:44:35.597809+02	\N
45	31	3	2024-09-18 15:44:35.597809+02	\N
46	31	12	2024-09-18 15:44:35.597809+02	\N
47	31	13	2024-09-18 15:44:35.597809+02	\N
48	32	4	2024-09-18 15:44:35.597809+02	\N
49	32	9	2024-09-18 15:44:35.597809+02	\N
50	33	1	2024-09-18 15:44:35.597809+02	\N
51	33	5	2024-09-18 15:44:35.597809+02	\N
54	40	4	2024-09-18 15:44:35.597809+02	\N
55	41	1	2024-09-18 15:44:35.597809+02	\N
56	41	11	2024-09-18 15:44:35.597809+02	\N
57	42	2	2024-09-18 15:44:35.597809+02	\N
58	42	5	2024-09-18 15:44:35.597809+02	\N
59	42	9	2024-09-18 15:44:35.597809+02	\N
60	43	3	2024-09-18 15:44:35.597809+02	\N
61	43	8	2024-09-18 15:44:35.597809+02	\N
62	44	4	2024-09-18 15:44:35.597809+02	\N
63	44	10	2024-09-18 15:44:35.597809+02	\N
64	44	13	2024-09-18 15:44:35.597809+02	\N
67	46	2	2024-09-18 15:44:35.597809+02	\N
68	46	11	2024-09-18 15:44:35.597809+02	\N
69	52	4	2024-09-18 15:44:35.597809+02	\N
70	52	6	2024-09-18 15:44:35.597809+02	\N
71	52	12	2024-09-18 15:44:35.597809+02	\N
72	53	1	2024-09-18 15:44:35.597809+02	\N
73	53	7	2024-09-18 15:44:35.597809+02	\N
74	54	2	2024-09-18 15:44:35.597809+02	\N
75	54	9	2024-09-18 15:44:35.597809+02	\N
76	54	13	2024-09-18 15:44:35.597809+02	\N
77	55	3	2024-09-18 15:44:35.597809+02	\N
78	55	8	2024-09-18 15:44:35.597809+02	\N
79	59	3	2024-09-18 15:44:35.597809+02	\N
80	59	6	2024-09-18 15:44:35.597809+02	\N
81	59	9	2024-09-18 15:44:35.597809+02	\N
82	60	4	2024-09-18 15:44:35.597809+02	\N
83	60	11	2024-09-18 15:44:35.597809+02	\N
84	61	1	2024-09-18 15:44:35.597809+02	\N
85	61	8	2024-09-18 15:44:35.597809+02	\N
86	62	2	2024-09-18 15:44:35.597809+02	\N
87	62	5	2024-09-18 15:44:35.597809+02	\N
88	62	12	2024-09-18 15:44:35.597809+02	\N
89	84	2	2024-09-18 18:20:43.305+02	2024-09-18 18:20:43.305+02
92	84	5	2024-09-19 17:24:55.769+02	2024-09-19 17:24:55.769+02
93	86	14	2024-09-19 17:56:32.288+02	2024-09-19 17:56:32.288+02
94	84	12	2024-09-20 15:42:47.102+02	2024-09-20 15:42:47.102+02
97	86	1	2024-10-19 11:07:15.031+02	2024-10-19 11:07:15.031+02
98	86	8	2024-10-19 11:07:23.726+02	2024-10-19 11:07:23.726+02
102	4	1	2024-11-12 23:06:50.548+01	2024-11-12 23:06:50.548+01
104	84	6	2024-11-18 13:38:05.323+01	2024-11-18 13:38:05.323+01
\.


--
-- Data for Name: users_hobbies; Type: TABLE DATA; Schema: public; Owner: senior
--

COPY public.users_hobbies (id, user_id, hobby_id, created_at, updated_at) FROM stdin;
1	1	1	2024-09-18 15:44:35.597809+02	\N
2	1	7	2024-09-18 15:44:35.597809+02	\N
3	1	4	2024-09-18 15:44:35.597809+02	\N
4	2	1	2024-09-18 15:44:35.597809+02	\N
5	2	12	2024-09-18 15:44:35.597809+02	\N
6	2	10	2024-09-18 15:44:35.597809+02	\N
7	2	7	2024-09-18 15:44:35.597809+02	\N
8	3	2	2024-09-18 15:44:35.597809+02	\N
9	3	3	2024-09-18 15:44:35.597809+02	\N
10	3	11	2024-09-18 15:44:35.597809+02	\N
11	3	4	2024-09-18 15:44:35.597809+02	\N
12	3	6	2024-09-18 15:44:35.597809+02	\N
13	4	3	2024-09-18 15:44:35.597809+02	\N
14	4	6	2024-09-18 15:44:35.597809+02	\N
15	4	9	2024-09-18 15:44:35.597809+02	\N
17	6	1	2024-09-18 15:44:35.597809+02	\N
18	6	2	2024-09-18 15:44:35.597809+02	\N
19	6	3	2024-09-18 15:44:35.597809+02	\N
20	6	4	2024-09-18 15:44:35.597809+02	\N
21	6	5	2024-09-18 15:44:35.597809+02	\N
22	7	5	2024-09-18 15:44:35.597809+02	\N
23	7	6	2024-09-18 15:44:35.597809+02	\N
24	8	3	2024-09-18 15:44:35.597809+02	\N
25	8	8	2024-09-18 15:44:35.597809+02	\N
26	8	9	2024-09-18 15:44:35.597809+02	\N
27	9	4	2024-09-18 15:44:35.597809+02	\N
28	9	5	2024-09-18 15:44:35.597809+02	\N
29	9	6	2024-09-18 15:44:35.597809+02	\N
30	9	7	2024-09-18 15:44:35.597809+02	\N
31	9	8	2024-09-18 15:44:35.597809+02	\N
32	9	10	2024-09-18 15:44:35.597809+02	\N
33	10	5	2024-09-18 15:44:35.597809+02	\N
34	10	12	2024-09-18 15:44:35.597809+02	\N
35	11	5	2024-09-18 15:44:35.597809+02	\N
36	11	11	2024-09-18 15:44:35.597809+02	\N
37	12	2	2024-09-18 15:44:35.597809+02	\N
38	13	2	2024-09-18 15:44:35.597809+02	\N
39	13	5	2024-09-18 15:44:35.597809+02	\N
40	13	8	2024-09-18 15:44:35.597809+02	\N
41	14	1	2024-09-18 15:44:35.597809+02	\N
42	14	6	2024-09-18 15:44:35.597809+02	\N
43	15	3	2024-09-18 15:44:35.597809+02	\N
44	15	9	2024-09-18 15:44:35.597809+02	\N
45	15	10	2024-09-18 15:44:35.597809+02	\N
46	16	4	2024-09-18 15:44:35.597809+02	\N
47	16	11	2024-09-18 15:44:35.597809+02	\N
51	18	1	2024-09-18 15:44:35.597809+02	\N
52	18	3	2024-09-18 15:44:35.597809+02	\N
53	19	5	2024-09-18 15:44:35.597809+02	\N
54	19	8	2024-09-18 15:44:35.597809+02	\N
55	19	9	2024-09-18 15:44:35.597809+02	\N
56	20	6	2024-09-18 15:44:35.597809+02	\N
57	20	10	2024-09-18 15:44:35.597809+02	\N
58	21	4	2024-09-18 15:44:35.597809+02	\N
59	21	7	2024-09-18 15:44:35.597809+02	\N
60	21	12	2024-09-18 15:44:35.597809+02	\N
61	22	2	2024-09-18 15:44:35.597809+02	\N
62	22	11	2024-09-18 15:44:35.597809+02	\N
63	23	1	2024-09-18 15:44:35.597809+02	\N
64	23	5	2024-09-18 15:44:35.597809+02	\N
65	23	8	2024-09-18 15:44:35.597809+02	\N
66	24	3	2024-09-18 15:44:35.597809+02	\N
67	24	9	2024-09-18 15:44:35.597809+02	\N
68	24	10	2024-09-18 15:44:35.597809+02	\N
69	25	6	2024-09-18 15:44:35.597809+02	\N
70	25	7	2024-09-18 15:44:35.597809+02	\N
71	26	4	2024-09-18 15:44:35.597809+02	\N
72	26	12	2024-09-18 15:44:35.597809+02	\N
73	27	2	2024-09-18 15:44:35.597809+02	\N
74	27	11	2024-09-18 15:44:35.597809+02	\N
75	28	1	2024-09-18 15:44:35.597809+02	\N
76	28	5	2024-09-18 15:44:35.597809+02	\N
77	28	8	2024-09-18 15:44:35.597809+02	\N
78	28	9	2024-09-18 15:44:35.597809+02	\N
79	29	3	2024-09-18 15:44:35.597809+02	\N
80	29	10	2024-09-18 15:44:35.597809+02	\N
81	30	6	2024-09-18 15:44:35.597809+02	\N
82	30	7	2024-09-18 15:44:35.597809+02	\N
83	30	12	2024-09-18 15:44:35.597809+02	\N
84	31	4	2024-09-18 15:44:35.597809+02	\N
85	31	11	2024-09-18 15:44:35.597809+02	\N
86	32	2	2024-09-18 15:44:35.597809+02	\N
87	32	9	2024-09-18 15:44:35.597809+02	\N
88	33	1	2024-09-18 15:44:35.597809+02	\N
89	33	5	2024-09-18 15:44:35.597809+02	\N
90	33	8	2024-09-18 15:44:35.597809+02	\N
91	34	3	2024-09-18 15:44:35.597809+02	\N
92	34	6	2024-09-18 15:44:35.597809+02	\N
93	34	12	2024-09-18 15:44:35.597809+02	\N
94	35	4	2024-09-18 15:44:35.597809+02	\N
95	35	10	2024-09-18 15:44:35.597809+02	\N
96	36	2	2024-09-18 15:44:35.597809+02	\N
97	36	11	2024-09-18 15:44:35.597809+02	\N
98	37	1	2024-09-18 15:44:35.597809+02	\N
99	37	7	2024-09-18 15:44:35.597809+02	\N
100	37	9	2024-09-18 15:44:35.597809+02	\N
101	38	3	2024-09-18 15:44:35.597809+02	\N
102	38	8	2024-09-18 15:44:35.597809+02	\N
106	40	6	2024-09-18 15:44:35.597809+02	\N
107	40	11	2024-09-18 15:44:35.597809+02	\N
108	41	2	2024-09-18 15:44:35.597809+02	\N
109	41	7	2024-09-18 15:44:35.597809+02	\N
110	42	1	2024-09-18 15:44:35.597809+02	\N
111	42	5	2024-09-18 15:44:35.597809+02	\N
112	42	9	2024-09-18 15:44:35.597809+02	\N
113	43	3	2024-09-18 15:44:35.597809+02	\N
114	43	8	2024-09-18 15:44:35.597809+02	\N
115	43	10	2024-09-18 15:44:35.597809+02	\N
116	44	6	2024-09-18 15:44:35.597809+02	\N
117	44	12	2024-09-18 15:44:35.597809+02	\N
120	46	2	2024-09-18 15:44:35.597809+02	\N
121	46	7	2024-09-18 15:44:35.597809+02	\N
122	47	1	2024-09-18 15:44:35.597809+02	\N
123	47	5	2024-09-18 15:44:35.597809+02	\N
124	47	8	2024-09-18 15:44:35.597809+02	\N
130	50	2	2024-09-18 15:44:35.597809+02	\N
131	50	6	2024-09-18 15:44:35.597809+02	\N
132	50	11	2024-09-18 15:44:35.597809+02	\N
133	51	1	2024-09-18 15:44:35.597809+02	\N
134	51	7	2024-09-18 15:44:35.597809+02	\N
135	52	3	2024-09-18 15:44:35.597809+02	\N
136	52	8	2024-09-18 15:44:35.597809+02	\N
137	52	9	2024-09-18 15:44:35.597809+02	\N
138	53	4	2024-09-18 15:44:35.597809+02	\N
139	53	12	2024-09-18 15:44:35.597809+02	\N
140	54	5	2024-09-18 15:44:35.597809+02	\N
141	54	10	2024-09-18 15:44:35.597809+02	\N
142	54	11	2024-09-18 15:44:35.597809+02	\N
143	55	2	2024-09-18 15:44:35.597809+02	\N
144	55	6	2024-09-18 15:44:35.597809+02	\N
145	56	1	2024-09-18 15:44:35.597809+02	\N
146	56	3	2024-09-18 15:44:35.597809+02	\N
147	56	9	2024-09-18 15:44:35.597809+02	\N
148	57	4	2024-09-18 15:44:35.597809+02	\N
149	57	7	2024-09-18 15:44:35.597809+02	\N
150	57	12	2024-09-18 15:44:35.597809+02	\N
151	58	5	2024-09-18 15:44:35.597809+02	\N
152	58	8	2024-09-18 15:44:35.597809+02	\N
153	59	2	2024-09-18 15:44:35.597809+02	\N
154	59	10	2024-09-18 15:44:35.597809+02	\N
155	59	11	2024-09-18 15:44:35.597809+02	\N
156	60	1	2024-09-18 15:44:35.597809+02	\N
157	60	6	2024-09-18 15:44:35.597809+02	\N
158	61	3	2024-09-18 15:44:35.597809+02	\N
159	61	7	2024-09-18 15:44:35.597809+02	\N
160	61	9	2024-09-18 15:44:35.597809+02	\N
161	62	4	2024-09-18 15:44:35.597809+02	\N
162	62	12	2024-09-18 15:44:35.597809+02	\N
163	62	10	2024-09-18 15:44:35.597809+02	\N
164	85	2	2024-09-18 15:45:43.041+02	2024-09-18 15:45:43.041+02
165	85	3	2024-09-18 15:45:43.041+02	2024-09-18 15:45:43.041+02
166	85	4	2024-09-18 15:45:43.041+02	2024-09-18 15:45:43.041+02
167	85	7	2024-09-18 15:45:43.041+02	2024-09-18 15:45:43.041+02
306	86	6	2024-09-19 17:50:55.912+02	2024-09-19 17:50:55.912+02
307	86	7	2024-09-19 17:50:55.912+02	2024-09-19 17:50:55.912+02
311	82	2	2024-10-18 10:12:22.963+02	2024-10-18 10:12:22.963+02
312	82	7	2024-10-18 10:12:22.963+02	2024-10-18 10:12:22.963+02
313	82	12	2024-10-18 10:12:22.963+02	2024-10-18 10:12:22.963+02
314	87	2	2024-10-19 09:50:31.211+02	2024-10-19 09:50:31.211+02
315	87	3	2024-10-19 09:50:31.211+02	2024-10-19 09:50:31.211+02
316	87	4	2024-10-19 09:50:31.211+02	2024-10-19 09:50:31.211+02
319	5	11	2024-10-19 10:39:09.09+02	2024-10-19 10:39:09.09+02
320	5	7	2024-10-19 10:39:09.09+02	2024-10-19 10:39:09.09+02
321	5	8	2024-10-19 10:39:09.09+02	2024-10-19 10:39:09.09+02
322	5	9	2024-10-19 10:39:09.09+02	2024-10-19 10:39:09.09+02
260	63	1	2024-09-18 15:56:16.569759+02	\N
261	63	5	2024-09-18 15:56:16.569759+02	\N
262	64	2	2024-09-18 15:56:16.569759+02	\N
263	64	8	2024-09-18 15:56:16.569759+02	\N
264	65	3	2024-09-18 15:56:16.569759+02	\N
265	65	9	2024-09-18 15:56:16.569759+02	\N
266	66	4	2024-09-18 15:56:16.569759+02	\N
267	66	10	2024-09-18 15:56:16.569759+02	\N
268	67	5	2024-09-18 15:56:16.569759+02	\N
269	67	11	2024-09-18 15:56:16.569759+02	\N
270	68	6	2024-09-18 15:56:16.569759+02	\N
271	68	12	2024-09-18 15:56:16.569759+02	\N
272	69	7	2024-09-18 15:56:16.569759+02	\N
273	69	1	2024-09-18 15:56:16.569759+02	\N
274	70	8	2024-09-18 15:56:16.569759+02	\N
275	70	1	2024-09-18 15:56:16.569759+02	\N
276	71	9	2024-09-18 15:56:16.569759+02	\N
277	71	2	2024-09-18 15:56:16.569759+02	\N
278	72	10	2024-09-18 15:56:16.569759+02	\N
279	72	3	2024-09-18 15:56:16.569759+02	\N
280	73	11	2024-09-18 15:56:16.569759+02	\N
281	73	4	2024-09-18 15:56:16.569759+02	\N
282	74	12	2024-09-18 15:56:16.569759+02	\N
283	74	5	2024-09-18 15:56:16.569759+02	\N
284	75	12	2024-09-18 15:56:16.569759+02	\N
285	75	6	2024-09-18 15:56:16.569759+02	\N
286	76	1	2024-09-18 15:56:16.569759+02	\N
287	76	7	2024-09-18 15:56:16.569759+02	\N
288	77	2	2024-09-18 15:56:16.569759+02	\N
289	77	8	2024-09-18 15:56:16.569759+02	\N
290	78	3	2024-09-18 15:56:16.569759+02	\N
291	78	9	2024-09-18 15:56:16.569759+02	\N
292	79	4	2024-09-18 15:56:16.569759+02	\N
293	79	10	2024-09-18 15:56:16.569759+02	\N
294	80	5	2024-09-18 15:56:16.569759+02	\N
295	80	11	2024-09-18 15:56:16.569759+02	\N
296	81	6	2024-09-18 15:56:16.569759+02	\N
297	81	12	2024-09-18 15:56:16.569759+02	\N
300	83	8	2024-09-18 15:56:16.569759+02	\N
301	83	1	2024-09-18 15:56:16.569759+02	\N
302	84	9	2024-09-18 15:56:16.569759+02	\N
303	84	2	2024-09-18 15:56:16.569759+02	\N
304	85	10	2024-09-18 15:56:16.569759+02	\N
305	85	3	2024-09-18 15:56:16.569759+02	\N
\.


--
-- Data for Name: users_messages; Type: TABLE DATA; Schema: public; Owner: senior
--

COPY public.users_messages (id, message, sender_id, receiver_id, created_at, updated_at, read) FROM stdin;
102	Ok j'ai compris alors bonne journée	86	75	2024-09-19 18:00:49.822+02	2024-09-19 18:32:26.64+02	t
171	bonjour arrete de me contacter	84	12	2024-11-12 11:07:59.824+01	2024-11-12 11:07:59.824+01	f
108	355	84	64	2024-10-02 16:59:07.206+02	2024-10-02 16:59:07.207+02	f
109	ddd	84	3	2024-10-10 10:20:31.716+02	2024-10-10 10:20:31.717+02	f
141	Salut pote Asiatique	82	84	2024-10-18 10:14:13.312+02	2024-11-28 10:57:27.125+01	t
182	bonjour	84	82	2024-11-12 11:34:00.153+01	2024-11-12 11:34:00.153+01	f
200	hello	84	3	2024-11-18 13:52:35.401+01	2024-11-18 13:52:35.401+01	f
105	hello	75	86	2024-09-19 19:06:20.761+02	2024-10-19 11:05:03.989+02	t
99	Bonjour Renée	84	46	2024-09-19 16:18:33.142+02	2024-10-19 13:43:48.009+02	t
201	bonjour	\N	18	2024-11-19 08:57:19.276+01	2024-11-19 08:57:19.277+01	f
86	On s’y retrouvera alors.	18	\N	2024-08-09 18:45:00+02	2024-11-19 08:57:16.492+01	t
189	on fait la fête	4	84	2024-11-12 21:02:49.371+01	2024-12-06 12:50:18.221+01	t
196	on fait la fête	4	84	2024-11-12 22:07:02.785+01	2024-12-06 12:50:18.221+01	t
121	Salut	84	12	2024-10-15 12:05:00.117+02	2024-10-15 12:05:00.117+02	f
128	bonjour	84	64	2024-10-15 13:13:03.273+02	2024-10-15 13:13:03.273+02	f
187	toto quoi ?	84	71	2024-11-12 11:36:08.55+01	2025-01-14 13:10:12.143+01	t
106	bonjour	84	4	2024-09-24 18:12:57.293+02	2024-12-05 09:34:45.182+01	t
37	Je trouve la méditation très relaxante. Vous aimez cuisiner pour des occasions spéciales ?	1	5	2024-08-19 06:00:00+02	2024-10-18 15:25:48.724+02	t
124	yo henri	84	4	2024-10-15 12:11:46.32+02	2024-12-05 09:34:45.182+01	t
138	ssqsdqdq	84	4	2024-10-15 13:29:44.329+02	2024-12-05 09:34:45.182+01	t
131	Ok j'ai compris alors bonne journée	84	4	2024-10-15 13:14:10.827+02	2024-12-05 09:34:45.182+01	t
167	bonjour arrete de me contacter	84	71	2024-11-12 10:40:55.184+01	2025-01-14 13:10:12.143+01	t
159	dd	84	82	2024-11-08 18:35:13.476+01	2024-11-08 18:35:13.476+01	f
136	Ok j'ai compris alors bonne journée	84	64	2024-10-15 13:29:28.738+02	2024-10-15 13:29:28.738+02	f
137	ddd	84	64	2024-10-15 13:29:33.289+02	2024-10-15 13:29:33.289+02	f
165	Et toi tu mange quoi demain Jacqueline	84	71	2024-11-12 10:25:14.601+01	2025-01-14 13:10:12.143+01	t
203	Bonjour	84	5	2024-11-19 10:35:35.905+01	2024-11-19 10:35:35.905+01	f
208	Bonjour <a href="javascript:alert('hacked!')">Clique ici</a>	84	5	2024-11-19 10:53:57.566+01	2024-11-19 10:53:57.566+01	f
212	Bonjour <div dangerouslySetInnerHTML={ __html: "<script>alert('hacked!')</script> }></div>	84	5	2024-11-19 10:58:56.34+01	2024-11-19 10:58:56.34+01	f
215	<a href="http://www.site-mal-protege.com/change-password.php?newpass=h4ck3rZ">Voir des chatons mignons</a>	84	5	2024-11-19 11:12:49.894+01	2024-11-19 11:12:49.894+01	f
163	salut	84	64	2024-11-08 19:10:21.671+01	2024-11-08 19:10:21.671+01	f
144	Marie on test voir si ca rentre bien en base de données	84	71	2024-10-24 19:54:38.404+02	2025-01-14 13:10:12.143+01	t
115	Et toi tu mange quoi demain Jacqueline	84	71	2024-10-15 09:27:59.68+02	2025-01-14 13:10:12.143+01	t
175	Ok j'ai compris alors bonne journée	84	71	2024-11-12 11:13:58.761+01	2025-01-14 13:10:12.143+01	t
118	bonjour	84	71	2024-10-15 09:49:37.885+02	2025-01-14 13:10:12.143+01	t
142	Bonjour comment aller vous ? je vous contact pour un test	46	4	2024-10-19 13:30:23.432+02	2024-11-12 20:17:22.871+01	t
132	bonjour	84	71	2024-10-15 13:14:37.755+02	2025-01-14 13:10:12.143+01	t
146	tu es déconnecté ?	84	71	2024-10-24 21:41:16.995+02	2025-01-14 13:10:12.143+01	t
199	Bonjour	84	71	2024-11-18 13:39:36.944+01	2025-01-14 13:10:12.143+01	t
193	bonjour arrete de me contacter	71	84	2024-11-12 21:06:00.602+01	2025-01-14 13:10:19.119+01	t
169	bonjour	84	46	2024-11-12 11:05:34.177+01	2024-11-12 11:05:34.177+01	f
170	bonjour	84	64	2024-11-12 11:07:44.624+01	2024-11-12 11:07:44.624+01	f
188	bonjour arrete de me contacter	71	84	2024-11-12 12:43:50.508+01	2025-01-14 13:10:19.119+01	t
172	bonjour	71	84	2024-11-12 11:08:50.491+01	2025-01-14 13:10:19.119+01	t
112	ca va bien	71	84	2024-10-15 09:15:40.477+02	2025-01-14 13:10:19.119+01	t
114	bonjour	71	84	2024-10-15 09:26:19.316+02	2025-01-14 13:10:19.119+01	t
176	bonjour arrete de me contacter	84	64	2024-11-12 11:14:42.88+01	2024-11-12 11:14:42.88+01	f
177	bonjour arrete de me contacter	84	3	2024-11-12 11:14:47+01	2024-11-12 11:14:47+01	f
98	ca va merci	71	84	2024-09-18 18:26:12.335+02	2025-01-14 13:10:19.119+01	t
117	bonjour arrete de me contacter	71	84	2024-10-15 09:44:24.533+02	2025-01-14 13:10:19.119+01	t
111	bonjour	71	84	2024-10-15 09:15:05.848+02	2025-01-14 13:10:19.119+01	t
164	bonjour	71	84	2024-11-12 10:24:17.105+01	2025-01-14 13:10:19.119+01	t
166	ssqsdqdq	71	84	2024-11-12 10:39:57.88+01	2025-01-14 13:10:19.119+01	t
173	bonjour arrete de me contacter	71	84	2024-11-12 11:09:26.84+01	2025-01-14 13:10:19.119+01	t
7	J’ai voyagé en France et en Espagne. Vous aimez explorer de nouveaux endroits ?	2	5	2024-08-04 14:30:00+02	2024-10-18 14:20:34.631+02	t
103	Mais non j'ai vu ton message, j'étais au marché	75	86	2024-09-19 18:17:35.664+02	2024-10-19 11:05:03.989+02	t
143	Bonjour comment aller vous ? je vous contact pour un test	46	5	2024-10-19 13:30:41.504+02	2024-10-19 13:30:41.504+02	f
100	Salut mon pote Henri	84	4	2024-09-19 17:25:12.06+02	2024-12-05 09:34:45.182+01	t
139	bonjour	84	46	2024-10-15 14:02:01.857+02	2024-10-19 13:43:48.009+02	t
27	J’ai assisté à une pièce de théâtre récemment. Vous aimez écouter de la musique ?	3	4	2024-08-15 01:00:00+02	2024-10-14 13:57:36.181+02	t
5	J’aime beaucoup « Les Misérables » de Victor Hugo. Avez-vous déjà visité un endroit spécial ?	1	4	2024-08-03 13:00:00+02	2024-10-14 13:57:36.973+02	t
129	Ok j'ai compris alors bonne journée	84	3	2024-10-15 13:13:42.754+02	2024-10-15 13:13:42.754+02	f
84	Salut Max, oui, j’y serai. Et toi ?	18	\N	2024-08-09 18:15:00+02	2024-11-19 08:57:16.492+01	t
174	bonjour arrete de me contacter	71	84	2024-11-12 11:13:29.442+01	2025-01-14 13:10:19.119+01	t
107	bonjour arrete de me contacter	84	4	2024-09-30 15:29:57.752+02	2024-12-05 09:34:45.182+01	t
17	J’ai deux petits-enfants qui me rendent visite souvent. Vous aimez les jeux de société ?	4	5	2024-08-09 20:00:00+02	2024-10-18 15:25:48.331+02	t
30	Oui, mes vacances en Bretagne étaient mémorables. Avez-vous des projets pour le futur ?	6	5	2024-08-15 02:05:00+02	2024-10-18 15:25:49.169+02	t
18	Oui, j’adore jouer aux échecs. Quel est le dernier film que vous avez vu ?	5	4	2024-08-09 20:05:00+02	2024-10-18 15:30:03.252+02	t
194	bonjour	84	71	2024-11-12 22:06:04.392+01	2025-01-14 13:10:12.143+01	t
151	test	84	71	2024-10-24 22:24:08.085+02	2025-01-14 13:10:12.143+01	t
1	Bonjour Michel, quel est votre passe-temps préféré ?	1	2	2024-08-01 11:00:00+02	\N	f
2	Bonjour Jacqueline, j’adore le jardinage. Et vous ?	2	1	2024-08-01 11:05:00+02	\N	f
3	Je suis passionnée par la lecture. Quel genre de livres aimez-vous ?	1	3	2024-08-02 12:15:00+02	\N	f
4	Je lis surtout des romans historiques. Quel est votre livre préféré ?	3	1	2024-08-02 12:20:00+02	\N	f
6	Oui, j’ai eu la chance de visiter l’Italie. C’est magnifique ! Et vous, avez-vous voyagé ?	4	1	2024-08-03 13:05:00+02	\N	f
8	Oui, j’adore découvrir de nouvelles cultures. Quel est votre plat préféré ?	5	2	2024-08-04 14:35:00+02	\N	f
9	J’aime beaucoup la cuisine italienne. Vous avez une recette que vous aimez préparer ?	6	7	2024-08-05 16:00:00+02	\N	f
10	Je fais un excellent risotto aux champignons. Quels sont vos loisirs ?	7	6	2024-08-05 16:05:00+02	\N	f
11	J’aime la photographie. Avez-vous des hobbies créatifs ?	8	9	2024-08-06 17:00:00+02	\N	f
12	Je peins des aquarelles depuis des années. Quelle est votre saison préférée ?	9	8	2024-08-06 17:05:00+02	\N	f
13	J’aime l’automne pour ses couleurs magnifiques. Vous faites du sport ou de l’exercice ?	10	11	2024-08-07 18:00:00+02	\N	f
14	Je fais du yoga tous les matins. Quel est votre endroit préféré pour vous détendre ?	11	10	2024-08-07 18:10:00+02	\N	f
15	J’aime me détendre dans mon jardin. Avez-vous des animaux de compagnie ?	2	3	2024-08-08 19:00:00+02	\N	f
16	Oui, j’ai un chat qui me tient compagnie. Vous avez des enfants ou des petits-enfants ?	3	2	2024-08-08 19:05:00+02	\N	f
19	J’ai vu un film romantique récemment. Vous avez des hobbies que vous pratiquez régulièrement ?	6	7	2024-08-10 21:00:00+02	\N	f
20	Je fais du jardinage dès que je le peux. Vous aimez cuisiner ?	7	6	2024-08-10 21:05:00+02	\N	f
21	Oui, la cuisine est une grande passion pour moi. Quels sont vos plats préférés à préparer ?	8	9	2024-08-11 22:00:00+02	\N	f
22	J’aime préparer des plats traditionnels. Vous avez déjà essayé de nouvelles recettes récemment ?	9	8	2024-08-11 22:05:00+02	\N	f
23	J’ai essayé une nouvelle recette de soupe. Vous aimez lire des magazines ou des journaux ?	10	11	2024-08-12 23:00:00+02	\N	f
24	Oui, je lis beaucoup de magazines de jardinage. Quel est votre auteur préféré ?	11	10	2024-08-12 23:05:00+02	\N	f
25	J’aime beaucoup les romans de Jane Austen. Vous aimez les films ou les séries télé ?	1	2	2024-08-14 00:00:00+02	\N	f
26	J’apprécie les séries historiques. Vous aimez les spectacles en direct ?	2	1	2024-08-14 00:05:00+02	\N	f
28	Oui, j’écoute beaucoup de jazz. Avez-vous une musique préférée ?	4	3	2024-08-15 01:05:00+02	\N	f
29	J’aime le classique. Vous avez des souvenirs de vacances préférés ?	5	6	2024-08-15 02:00:00+02	\N	f
31	Je prévois de commencer un nouveau hobby. Vous avez des activités que vous aimeriez essayer ?	7	8	2024-08-16 03:00:00+02	\N	f
32	J’aimerais apprendre à jouer d’un instrument de musique. Vous avez une expérience musicale ?	8	7	2024-08-16 03:05:00+02	\N	f
33	Je joue du piano depuis des années. Vous avez des conseils pour rester en forme ?	9	10	2024-08-17 04:00:00+02	\N	f
34	Faire des promenades quotidiennes me garde en forme. Vous avez des astuces de bien-être ?	10	9	2024-08-17 04:05:00+02	\N	f
35	Je fais du yoga régulièrement. Vous aimez partager vos passions ?	11	12	2024-08-18 05:00:00+02	\N	f
205	<script>alert('hacked!')</script>";	84	5	2024-11-19 10:42:57.371+01	2024-11-19 10:42:57.371+01	f
204	bonjour	84	5	2024-11-19 10:42:51.886+01	2024-11-19 10:42:51.887+01	f
140	bonjour	5	84	2024-10-18 09:05:11.389+02	2024-11-21 13:15:09.406+01	t
209	Bonjour <div dangerouslySetInnerHTML={__html: "<script>alert('hacked!')}</div>	84	5	2024-11-19 10:56:26.772+01	2024-11-19 10:56:26.772+01	f
190	bonjour arrete de me contacter	84	4	2024-11-12 21:03:22.794+01	2024-12-05 09:34:45.182+01	t
149	salut	84	71	2024-10-24 22:05:06.596+02	2025-01-14 13:10:12.143+01	t
153	tu es déconnecté ?	71	84	2024-11-08 18:07:19.631+01	2025-01-14 13:10:19.119+01	t
119	Et toi 	71	84	2024-10-15 09:56:45.877+02	2025-01-14 13:10:19.119+01	t
116	bonjour	71	84	2024-10-15 09:31:59.859+02	2025-01-14 13:10:19.119+01	t
213	Bonjour <script>alert('hacked!')</script>	84	5	2024-11-19 10:59:18.476+01	2024-11-19 10:59:18.476+01	f
110	Bonjour Marie comment aller vous	84	71	2024-10-10 10:28:33.063+02	2025-01-14 13:10:12.143+01	t
152	re test	84	71	2024-10-24 22:24:29.892+02	2025-01-14 13:10:12.143+01	t
228	yep	84	71	2025-01-14 13:10:00.178+01	2025-01-14 13:10:12.143+01	t
125	ddd	84	71	2024-10-15 12:12:13.599+02	2025-01-14 13:10:12.143+01	t
162	sss	84	71	2024-11-08 19:09:15.359+01	2025-01-14 13:10:12.143+01	t
36	Oui, j’aime parler de mes voyages. Vous avez une activité préférée pour vous détendre ?	12	11	2024-08-18 05:05:00+02	\N	f
147	encore déconnecté	84	71	2024-10-24 21:59:23.437+02	2025-01-14 13:10:12.143+01	t
38	Oui, j’adore préparer des repas pour les fêtes. Vous avez des plats traditionnels ?	5	1	2024-08-19 06:05:00+02	\N	f
39	Ma famille adore le gâteau au chocolat. Vous aimez faire des projets créatifs ?	6	7	2024-08-20 07:00:00+02	\N	f
40	Je fais souvent du bricolage à la maison. Vous avez un endroit préféré pour passer du temps ?	7	6	2024-08-20 07:05:00+02	\N	f
41	J’aime lire dans mon coin préféré du jardin. Vous faites souvent du bénévolat ?	8	9	2024-08-21 08:00:00+02	\N	f
42	Oui, je fais du bénévolat dans une association locale. Vous aimez vous engager dans des activités communautaires ?	9	8	2024-08-21 08:05:00+02	\N	f
43	Je suis impliqué dans un groupe de lecture. Vous aimez partager vos livres préférés ?	10	11	2024-08-22 09:00:00+02	\N	f
44	Oui, j’aime organiser des échanges de livres. Quel est le dernier livre que vous avez lu ?	11	10	2024-08-22 09:05:00+02	\N	f
45	J’ai lu un très bon roman récemment. Vous avez des activités estivales préférées ?	12	1	2024-08-23 10:00:00+02	\N	f
46	J’aime me promener au bord de la mer. Vous avez des souvenirs de vacances que vous aimez partager ?	1	12	2024-08-23 10:05:00+02	\N	f
47	Oui, mes vacances en Provence sont inoubliables. Vous aimez participer à des clubs ou des groupes ?	2	3	2024-08-24 11:00:00+02	\N	f
48	Je fais partie d’un club de lecture. Vous avez des conseils pour rester actif ?	3	2	2024-08-24 11:05:00+02	\N	f
51	Bonjour Michel, quel est votre passe-temps préféré ?	1	2	2024-08-01 11:00:00+02	\N	f
52	Salut Jean, jaime le football. Et toi ?	2	1	2024-08-01 11:15:00+02	\N	f
53	Moi aussi, je suis un grand fan de football !	1	2	2024-08-01 11:30:00+02	\N	f
54	Génial ! On devrait organiser un match.	2	1	2024-08-01 11:45:00+02	\N	f
56	Oui, c’était incroyable !	4	3	2024-08-02 12:15:00+02	\N	f
58	Pareil, c’était impressionnant.	4	3	2024-08-02 12:45:00+02	\N	f
59	Hey Laura, comment vas-tu ?	5	6	2024-08-03 13:00:00+02	\N	f
61	Je vais bien aussi, merci !	5	6	2024-08-03 13:30:00+02	\N	f
63	Salut Marc, tu as des projets pour le week-end ?	7	8	2024-08-04 14:00:00+02	\N	f
64	Salut Julie, je prévois une randonnée. Tu veux te joindre à nous ?	8	7	2024-08-04 14:15:00+02	\N	f
65	Pourquoi pas, ça pourrait être sympa !	7	8	2024-08-04 14:30:00+02	\N	f
66	Super, je te tiens au courant.	8	7	2024-08-04 14:45:00+02	\N	f
67	Salut Alice, tu as réussi à résoudre ce bug ?	9	10	2024-08-05 15:00:00+02	\N	f
68	Salut Tom, oui, c’était un problème de syntaxe.	10	9	2024-08-05 15:15:00+02	\N	f
69	Ah super, merci pour l’info !	9	10	2024-08-05 15:30:00+02	\N	f
70	Pas de souci, si tu as encore des soucis, fais-moi signe.	10	9	2024-08-05 15:45:00+02	\N	f
71	Hey Lucas, as-tu des nouvelles du projet ?	11	12	2024-08-06 16:00:00+02	\N	f
72	Oui, il avance bien, on devrait avoir une démo bientôt.	12	11	2024-08-06 16:15:00+02	\N	f
73	Bonne nouvelle, hâte de voir ça !	11	12	2024-08-06 16:30:00+02	\N	f
74	Je te tiens au courant dès que c’est prêt.	12	11	2024-08-06 16:45:00+02	\N	f
75	Bonjour Emma, comment s’est passée ta présentation ?	13	14	2024-08-07 17:00:00+02	\N	f
76	Salut Noah, ça s’est bien passé, merci !	14	13	2024-08-07 17:15:00+02	\N	f
77	Content de l’entendre, félicitations !	13	14	2024-08-07 17:30:00+02	\N	f
78	Merci beaucoup, ça me fait plaisir.	14	13	2024-08-07 17:45:00+02	\N	f
79	Salut Olivia, tu veux déjeuner ensemble aujourd’hui ?	15	16	2024-08-08 14:00:00+02	\N	f
80	Salut Leo, bien sûr, où tu veux ?	16	15	2024-08-08 14:15:00+02	\N	f
81	On se retrouve à la cantine à midi ? 	15	16	2024-08-08 14:30:00+02	\N	f
82	Parfait, à tout à l’heure !	16	15	2024-08-08 14:45:00+02	\N	f
87	Hey, Clara, as-tu vu le nouveau projet ?	19	20	2024-08-10 19:00:00+02	\N	f
88	Oui, ça a l’air super intéressant !	20	19	2024-08-10 19:15:00+02	\N	f
89	Je suis d’accord, j’ai hâte de commencer.	19	20	2024-08-10 19:30:00+02	\N	f
90	Pareil, ça va être une belle aventure.	20	19	2024-08-10 19:45:00+02	\N	f
91	Salut Anna, tu es disponible pour une réunion demain ?	21	22	2024-08-11 20:00:00+02	\N	f
92	Salut David, oui, pas de problème.	22	21	2024-08-11 20:15:00+02	\N	f
93	Super, à 14h ça te va ?	21	22	2024-08-11 20:30:00+02	\N	f
94	Parfait, je note ça dans mon agenda.	22	21	2024-08-11 20:45:00+02	\N	f
95	Bonjour je m'appel Alain	84	3	2024-09-18 16:05:29.345+02	2024-09-18 16:05:29.345+02	f
96	bonjour arrete de me contacter	84	3	2024-09-18 16:28:22.819+02	2024-09-18 16:28:22.82+02	f
197	on fait la fête	4	84	2024-11-12 22:07:40.505+01	2024-12-06 12:50:18.221+01	t
104	ah je comprend pas de problème ce n'est pas grave comment vas tu ?	75	86	2024-09-19 18:31:08.426+02	2024-10-19 11:05:03.989+02	t
135	bonjour arrete de me contacter	84	46	2024-10-15 13:27:12.374+02	2024-10-19 13:43:48.009+02	t
50	Oui, j’aime essayer de nouvelles choses. Vous avez des objectifs pour l’année prochaine ?	5	4	2024-08-25 12:05:00+02	2024-10-18 15:30:03.252+02	t
202	";	84	5	2024-11-19 10:34:52.583+01	2024-11-19 10:34:52.583+01	f
49	Je pense que rester actif est essentiel. Vous aimez découvrir de nouvelles activités ?	4	5	2024-08-25 12:00:00+02	2024-10-18 15:25:48.331+02	t
101	Oh bonjour Fatima vous êtes vraiment marocaine ?	86	75	2024-09-19 17:55:52.057+02	2024-09-19 18:32:26.64+02	t
120	bonjour	84	64	2024-10-15 12:04:38.865+02	2024-10-15 12:04:38.866+02	f
206	<script>alert('hacked!')</script>	84	5	2024-11-19 10:43:22.256+01	2024-11-19 10:43:22.256+01	f
83	Salut Zoé, tu participes à l’atelier de demain ?	\N	18	2024-08-09 18:00:00+02	\N	f
55	Salut Sophie, tu as vu le dernier film au cinéma ?	3	4	2024-08-02 12:00:00+02	2024-10-14 13:57:36.181+02	t
57	J’ai adoré les effets spéciaux.	3	4	2024-08-02 12:30:00+02	2024-10-14 13:57:36.181+02	t
123	bonjour	84	3	2024-10-15 12:11:21.344+02	2024-10-15 12:11:21.344+02	f
134	bonjour	84	3	2024-10-15 13:27:05.558+02	2024-10-15 13:27:05.558+02	f
127	bonjour arrete de me contacter	84	12	2024-10-15 13:12:02.594+02	2024-10-15 13:12:02.594+02	f
130	bonjour	84	3	2024-10-15 13:13:56.448+02	2024-10-15 13:13:56.448+02	f
126	bonjour	84	4	2024-10-15 13:11:47.385+02	2024-12-05 09:34:45.182+01	t
85	Oui, j’ai hâte d’y être.	\N	18	2024-08-09 18:30:00+02	\N	f
60	Coucou Paul, ça va bien, et toi ?	6	5	2024-08-03 13:15:00+02	2024-10-18 15:25:49.169+02	t
62	Content de l’entendre.	6	5	2024-08-03 13:45:00+02	2024-10-18 15:25:49.169+02	t
210	Bonjour <div dangerouslySetInnerHTML={ __html: "<script>alert('hacked!')</script> }</div>	84	5	2024-11-19 10:57:15.226+01	2024-11-19 10:57:15.226+01	f
217	bonjour	84	19	2024-11-21 14:03:55.251+01	2024-11-21 14:03:55.251+01	f
207	bonjour<script>alert('hacked!')</script>	84	5	2024-11-19 10:43:41.85+01	2024-11-19 10:43:41.85+01	f
211	Bonjour <div dangerouslySetInnerHTML={ __html: "<script>alert('hacked!')</script> }></div>	84	5	2024-11-19 10:57:59.772+01	2024-11-19 10:57:59.772+01	f
214	http://www.site-mal-protege.com	84	5	2024-11-19 11:12:21.614+01	2024-11-19 11:12:21.614+01	f
195	on fait la fête	4	84	2024-11-12 22:06:45.177+01	2024-12-06 12:50:18.221+01	t
220	Salut ca gaz Marie	4	71	2024-11-25 09:30:09.442+01	2024-12-04 13:19:07.594+01	t
222	bonjour	4	71	2024-11-25 09:56:14.953+01	2024-12-04 13:19:07.594+01	t
218	bonjour	84	71	2024-11-21 14:05:28.315+01	2025-01-14 13:10:12.143+01	t
133	bonjou alelele	84	71	2024-10-15 13:15:32.416+02	2025-01-14 13:10:12.143+01	t
145	on dirait que ca fonctionne	84	71	2024-10-24 19:55:39.777+02	2025-01-14 13:10:12.143+01	t
216	Et toi tu mange quoi demain Jacqueline	84	71	2024-11-21 13:22:21.917+01	2025-01-14 13:10:12.143+01	t
97	Bonjour Marie comment aller vous	84	71	2024-09-18 18:21:16.422+02	2025-01-14 13:10:12.143+01	t
148	c'est free t'a rien compris !!	84	71	2024-10-24 22:02:09.875+02	2025-01-14 13:10:12.143+01	t
150	ca fonctionne enfin	84	71	2024-10-24 22:12:07.714+02	2025-01-14 13:10:12.143+01	t
154	Oui j'en avais assez de tchat	84	71	2024-11-08 18:07:46.081+01	2025-01-14 13:10:12.143+01	t
157	salut	84	71	2024-11-08 18:15:34.264+01	2025-01-14 13:10:12.143+01	t
161	rien dutout	84	71	2024-11-08 19:05:18.47+01	2025-01-14 13:10:12.143+01	t
155	salut	84	71	2024-11-08 18:08:12.669+01	2025-01-14 13:10:12.143+01	t
168	bonjour	84	71	2024-11-12 10:41:10.942+01	2025-01-14 13:10:12.143+01	t
198	Bonjour	84	4	2024-11-18 13:39:05.648+01	2024-12-05 09:34:45.182+01	t
219	Bonjour henri	71	4	2024-11-25 09:29:08.798+01	2024-12-05 09:35:04.311+01	t
221	bonjour	71	4	2024-11-25 09:55:58.188+01	2024-12-05 09:35:04.311+01	t
192	ca va bien	84	71	2024-11-12 21:04:26.435+01	2025-01-14 13:10:12.143+01	t
113	bonjour arrete de me contacter	71	84	2024-10-15 09:17:51.642+02	2025-01-14 13:10:19.119+01	t
156	rien dutout	71	84	2024-11-08 18:08:15.512+01	2025-01-14 13:10:19.119+01	t
158	ahaha	71	84	2024-11-08 18:28:32.662+01	2025-01-14 13:10:19.119+01	t
184	bonjour arrete de me contacter	71	84	2024-11-12 11:35:06.106+01	2025-01-14 13:10:19.119+01	t
160	ddd	71	84	2024-11-08 19:05:08.454+01	2025-01-14 13:10:19.119+01	t
183	ddd	71	84	2024-11-12 11:34:18.788+01	2025-01-14 13:10:19.119+01	t
178	bonjour	71	84	2024-11-12 11:14:51.041+01	2025-01-14 13:10:19.119+01	t
179	bonjour	71	84	2024-11-12 11:15:14.057+01	2025-01-14 13:10:19.119+01	t
180	bonjour	71	84	2024-11-12 11:28:00.946+01	2025-01-14 13:10:19.119+01	t
181	Et toi tu mange quoi demain Jacqueline	71	84	2024-11-12 11:28:15.69+01	2025-01-14 13:10:19.119+01	t
224	Bonjour	84	6	2024-12-05 10:05:19.874+01	2024-12-05 10:05:19.874+01	f
223	bien le bonjour	84	71	2024-11-28 12:52:02.783+01	2025-01-14 13:10:12.143+01	t
225	hello	84	71	2024-12-05 10:05:39.962+01	2025-01-14 13:10:12.143+01	t
226	hello	84	71	2024-12-06 12:48:57.75+01	2025-01-14 13:10:12.143+01	t
185	totoyoutu	71	84	2024-11-12 11:35:17.802+01	2025-01-14 13:10:19.119+01	t
186	allo	71	84	2024-11-12 11:35:39.958+01	2025-01-14 13:10:19.119+01	t
191	bonjour	71	84	2024-11-12 21:04:18.058+01	2025-01-14 13:10:19.119+01	t
227	bonjour arrete de me contacter	71	84	2024-12-06 12:49:34.566+01	2025-01-14 13:10:19.119+01	t
122	bonjour arrete de me contacter	84	71	2024-10-15 12:10:21.143+02	2025-01-14 13:10:12.143+01	t
229	bonjour	71	84	2025-01-14 13:10:15.336+01	2025-01-14 13:10:19.119+01	t
\.


--
-- Name: administrators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: senior
--

SELECT pg_catalog.setval('public.administrators_id_seq', 1, true);


--
-- Name: events_hobbies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: senior
--

SELECT pg_catalog.setval('public.events_hobbies_id_seq', 74, true);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: senior
--

SELECT pg_catalog.setval('public.events_id_seq', 69, true);


--
-- Name: hobbies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: senior
--

SELECT pg_catalog.setval('public.hobbies_id_seq', 12, true);


--
-- Name: users_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: senior
--

SELECT pg_catalog.setval('public.users_events_id_seq', 113, true);


--
-- Name: users_hobbies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: senior
--

SELECT pg_catalog.setval('public.users_hobbies_id_seq', 325, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: senior
--

SELECT pg_catalog.setval('public.users_id_seq', 87, true);


--
-- Name: users_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: senior
--

SELECT pg_catalog.setval('public.users_messages_id_seq', 229, true);


--
-- Name: Sessions Sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public."Sessions"
    ADD CONSTRAINT "Sessions_pkey" PRIMARY KEY (sid);


--
-- Name: administrators administrators_email_key; Type: CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.administrators
    ADD CONSTRAINT administrators_email_key UNIQUE (email);


--
-- Name: administrators administrators_pkey; Type: CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.administrators
    ADD CONSTRAINT administrators_pkey PRIMARY KEY (id);


--
-- Name: events_hobbies events_hobbies_pkey; Type: CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.events_hobbies
    ADD CONSTRAINT events_hobbies_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: hobbies hobbies_pkey; Type: CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.hobbies
    ADD CONSTRAINT hobbies_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_events users_events_pkey; Type: CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.users_events
    ADD CONSTRAINT users_events_pkey PRIMARY KEY (id);


--
-- Name: users_hobbies users_hobbies_pkey; Type: CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.users_hobbies
    ADD CONSTRAINT users_hobbies_pkey PRIMARY KEY (id);


--
-- Name: users_messages users_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.users_messages
    ADD CONSTRAINT users_messages_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: events events_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.administrators(id) ON DELETE SET NULL;


--
-- Name: events_hobbies events_hobbies_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.events_hobbies
    ADD CONSTRAINT events_hobbies_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- Name: events_hobbies events_hobbies_hobby_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.events_hobbies
    ADD CONSTRAINT events_hobbies_hobby_id_fkey FOREIGN KEY (hobby_id) REFERENCES public.hobbies(id) ON DELETE CASCADE;


--
-- Name: users_events users_events_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.users_events
    ADD CONSTRAINT users_events_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- Name: users_events users_events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.users_events
    ADD CONSTRAINT users_events_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users_hobbies users_hobbies_hobby_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.users_hobbies
    ADD CONSTRAINT users_hobbies_hobby_id_fkey FOREIGN KEY (hobby_id) REFERENCES public.hobbies(id) ON DELETE CASCADE;


--
-- Name: users_hobbies users_hobbies_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.users_hobbies
    ADD CONSTRAINT users_hobbies_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users_messages users_messages_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.users_messages
    ADD CONSTRAINT users_messages_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: users_messages users_messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: senior
--

ALTER TABLE ONLY public.users_messages
    ADD CONSTRAINT users_messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

