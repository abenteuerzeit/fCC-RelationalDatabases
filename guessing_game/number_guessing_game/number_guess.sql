--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    username character varying(22),
    number_of_guesses integer,
    secret_number integer
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    username character varying(22) NOT NULL,
    games_played integer DEFAULT 0,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 'user_1698517622794', 792, 791);
INSERT INTO public.games VALUES (2, 'user_1698517622794', 619, 618);
INSERT INTO public.games VALUES (3, 'user_1698517622793', 242, 241);
INSERT INTO public.games VALUES (4, 'user_1698517622793', 544, 543);
INSERT INTO public.games VALUES (5, 'user_1698517622794', 366, 363);
INSERT INTO public.games VALUES (6, 'user_1698517622794', 586, 584);
INSERT INTO public.games VALUES (7, 'user_1698517622794', 426, 425);
INSERT INTO public.games VALUES (8, 'user_1698517675346', 61, 60);
INSERT INTO public.games VALUES (9, 'user_1698517675346', 972, 971);
INSERT INTO public.games VALUES (10, 'user_1698517675345', 598, 597);
INSERT INTO public.games VALUES (11, 'user_1698517675345', 419, 418);
INSERT INTO public.games VALUES (12, 'user_1698517675346', 842, 839);
INSERT INTO public.games VALUES (13, 'user_1698517675346', 455, 453);
INSERT INTO public.games VALUES (14, 'user_1698517675346', 768, 767);
INSERT INTO public.games VALUES (15, 'user_1698517689587', 648, 647);
INSERT INTO public.games VALUES (16, 'user_1698517689587', 652, 651);
INSERT INTO public.games VALUES (17, 'user_1698517689586', 258, 257);
INSERT INTO public.games VALUES (18, 'user_1698517689586', 479, 478);
INSERT INTO public.games VALUES (19, 'user_1698517689587', 588, 585);
INSERT INTO public.games VALUES (20, 'user_1698517689587', 464, 462);
INSERT INTO public.games VALUES (21, 'user_1698517689587', 495, 494);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES ('user_1698517622793', 2, NULL);
INSERT INTO public.users VALUES ('user_1698517622794', 5, NULL);
INSERT INTO public.users VALUES ('user_1698517675345', 2, NULL);
INSERT INTO public.users VALUES ('user_1698517675346', 5, NULL);
INSERT INTO public.users VALUES ('user_1698517689586', 2, NULL);
INSERT INTO public.users VALUES ('user_1698517689587', 5, NULL);


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 21, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- Name: games games_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_username_fkey FOREIGN KEY (username) REFERENCES public.users(username);


--
-- PostgreSQL database dump complete
--

