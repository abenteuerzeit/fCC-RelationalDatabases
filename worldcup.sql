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

DROP DATABASE worldcup;
--
-- Name: worldcup; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE worldcup WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE worldcup OWNER TO freecodecamp;

\connect worldcup

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
    year integer NOT NULL,
    round character varying(50) NOT NULL,
    winner_id integer NOT NULL,
    opponent_id integer NOT NULL,
    winner_goals integer NOT NULL,
    opponent_goals integer NOT NULL
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
-- Name: teams; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.teams OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1133, 2018, 'Final', 1119, 1120, 4, 2);
INSERT INTO public.games VALUES (1134, 2018, 'Third Place', 1121, 1122, 2, 0);
INSERT INTO public.games VALUES (1135, 2018, 'Semi-Final', 1120, 1122, 2, 1);
INSERT INTO public.games VALUES (1136, 2018, 'Semi-Final', 1119, 1121, 1, 0);
INSERT INTO public.games VALUES (1137, 2018, 'Quarter-Final', 1120, 1123, 3, 2);
INSERT INTO public.games VALUES (1138, 2018, 'Quarter-Final', 1122, 1124, 2, 0);
INSERT INTO public.games VALUES (1139, 2018, 'Quarter-Final', 1121, 1125, 2, 1);
INSERT INTO public.games VALUES (1140, 2018, 'Quarter-Final', 1119, 1126, 2, 0);
INSERT INTO public.games VALUES (1141, 2018, 'Eighth-Final', 1122, 1127, 2, 1);
INSERT INTO public.games VALUES (1142, 2018, 'Eighth-Final', 1124, 1128, 1, 0);
INSERT INTO public.games VALUES (1143, 2018, 'Eighth-Final', 1121, 1129, 3, 2);
INSERT INTO public.games VALUES (1144, 2018, 'Eighth-Final', 1125, 1130, 2, 0);
INSERT INTO public.games VALUES (1145, 2018, 'Eighth-Final', 1120, 1131, 2, 1);
INSERT INTO public.games VALUES (1146, 2018, 'Eighth-Final', 1123, 1132, 2, 1);
INSERT INTO public.games VALUES (1147, 2018, 'Eighth-Final', 1126, 1133, 2, 1);
INSERT INTO public.games VALUES (1148, 2018, 'Eighth-Final', 1119, 1134, 4, 3);
INSERT INTO public.games VALUES (1149, 2014, 'Final', 1135, 1134, 1, 0);
INSERT INTO public.games VALUES (1150, 2014, 'Third Place', 1136, 1125, 3, 0);
INSERT INTO public.games VALUES (1151, 2014, 'Semi-Final', 1134, 1136, 1, 0);
INSERT INTO public.games VALUES (1152, 2014, 'Semi-Final', 1135, 1125, 7, 1);
INSERT INTO public.games VALUES (1153, 2014, 'Quarter-Final', 1136, 1137, 1, 0);
INSERT INTO public.games VALUES (1154, 2014, 'Quarter-Final', 1134, 1121, 1, 0);
INSERT INTO public.games VALUES (1155, 2014, 'Quarter-Final', 1125, 1127, 2, 1);
INSERT INTO public.games VALUES (1156, 2014, 'Quarter-Final', 1135, 1119, 1, 0);
INSERT INTO public.games VALUES (1157, 2014, 'Eighth-Final', 1125, 1138, 2, 1);
INSERT INTO public.games VALUES (1158, 2014, 'Eighth-Final', 1127, 1126, 2, 0);
INSERT INTO public.games VALUES (1159, 2014, 'Eighth-Final', 1119, 1139, 2, 0);
INSERT INTO public.games VALUES (1160, 2014, 'Eighth-Final', 1135, 1140, 2, 1);
INSERT INTO public.games VALUES (1161, 2014, 'Eighth-Final', 1136, 1130, 2, 1);
INSERT INTO public.games VALUES (1162, 2014, 'Eighth-Final', 1137, 1141, 2, 1);
INSERT INTO public.games VALUES (1163, 2014, 'Eighth-Final', 1134, 1128, 1, 0);
INSERT INTO public.games VALUES (1164, 2014, 'Eighth-Final', 1121, 1142, 2, 1);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.teams VALUES (1119, 'France');
INSERT INTO public.teams VALUES (1120, 'Croatia');
INSERT INTO public.teams VALUES (1121, 'Belgium');
INSERT INTO public.teams VALUES (1122, 'England');
INSERT INTO public.teams VALUES (1123, 'Russia');
INSERT INTO public.teams VALUES (1124, 'Sweden');
INSERT INTO public.teams VALUES (1125, 'Brazil');
INSERT INTO public.teams VALUES (1126, 'Uruguay');
INSERT INTO public.teams VALUES (1127, 'Colombia');
INSERT INTO public.teams VALUES (1128, 'Switzerland');
INSERT INTO public.teams VALUES (1129, 'Japan');
INSERT INTO public.teams VALUES (1130, 'Mexico');
INSERT INTO public.teams VALUES (1131, 'Denmark');
INSERT INTO public.teams VALUES (1132, 'Spain');
INSERT INTO public.teams VALUES (1133, 'Portugal');
INSERT INTO public.teams VALUES (1134, 'Argentina');
INSERT INTO public.teams VALUES (1135, 'Germany');
INSERT INTO public.teams VALUES (1136, 'Netherlands');
INSERT INTO public.teams VALUES (1137, 'Costa Rica');
INSERT INTO public.teams VALUES (1138, 'Chile');
INSERT INTO public.teams VALUES (1139, 'Nigeria');
INSERT INTO public.teams VALUES (1140, 'Algeria');
INSERT INTO public.teams VALUES (1141, 'Greece');
INSERT INTO public.teams VALUES (1142, 'United States');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 1164, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 1142, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: games games_opponent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_opponent_id_fkey FOREIGN KEY (opponent_id) REFERENCES public.teams(team_id);


--
-- Name: games games_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--

