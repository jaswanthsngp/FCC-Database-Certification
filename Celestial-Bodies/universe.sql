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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(20) NOT NULL,
    galaxy_type text,
    starcntinbillions integer NOT NULL,
    diainly integer,
    galgroup_id integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galgroup; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galgroup (
    galgroup_id integer NOT NULL,
    name character varying(20) NOT NULL,
    galcnt integer NOT NULL
);


ALTER TABLE public.galgroup OWNER TO freecodecamp;

--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(20) NOT NULL,
    orbittimeinearthdays double precision,
    radiusinkm integer NOT NULL,
    habitable boolean,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(20) NOT NULL,
    mooncnt integer,
    orbittimeinearthdays double precision,
    radiusinkm integer NOT NULL,
    habitable boolean,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(20) NOT NULL,
    planetcnt integer NOT NULL,
    diainmilkms numeric NOT NULL,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Andromeda', 'Barred Spiral', 1000, 152000, 1);
INSERT INTO public.galaxy VALUES (2, 'Caldwell 30', 'Unbarred Spiral', 750, 120000, 2);
INSERT INTO public.galaxy VALUES (3, 'Milky Way', 'Barred Spiral', 400, 87000, 1);
INSERT INTO public.galaxy VALUES (4, 'Messier 32', 'Elliptical', 40, 1000, 1);
INSERT INTO public.galaxy VALUES (5, 'Pheonix Dwarf', 'Dwarf Irregular', 60, 1200, 1);
INSERT INTO public.galaxy VALUES (6, 'NGC 185', 'Dwarf Spherical', 10, 3000, 1);


--
-- Data for Name: galgroup; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galgroup VALUES (1, 'local group', 50);
INSERT INTO public.galgroup VALUES (2, 'deer lick group', 20);
INSERT INTO public.galgroup VALUES (3, 'Leo Triplet', 3);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna', 30, 500, false, 1);
INSERT INTO public.moon VALUES (2, 'Phobos', 25, 100, false, 2);
INSERT INTO public.moon VALUES (3, 'Deimos', 65, 150, false, 2);
INSERT INTO public.moon VALUES (4, 'Europa', 105, 2000, false, 5);
INSERT INTO public.moon VALUES (5, 'Lo', 95, 1800, false, 5);
INSERT INTO public.moon VALUES (6, 'Gynemede', 45, 3000, false, 5);
INSERT INTO public.moon VALUES (7, 'Calisto', 64, 2200, false, 5);
INSERT INTO public.moon VALUES (8, 'Cyllene', 234, 2400, false, 5);
INSERT INTO public.moon VALUES (9, 'Amalthea', 94, 200, false, 5);
INSERT INTO public.moon VALUES (10, 'Himalia', 64, 150, false, 5);
INSERT INTO public.moon VALUES (11, 'Adrastea', 74, 120, false, 5);
INSERT INTO public.moon VALUES (12, 'Titan', 74, 2000, false, 6);
INSERT INTO public.moon VALUES (13, 'Encladeus', 64, 1800, false, 6);
INSERT INTO public.moon VALUES (14, 'Mimas', 92, 1400, true, 6);
INSERT INTO public.moon VALUES (15, 'Dione', 84, 1600, false, 6);
INSERT INTO public.moon VALUES (16, 'Tethys', 76, 1200, false, 6);
INSERT INTO public.moon VALUES (17, 'Lepetus', 89, 2600, false, 6);
INSERT INTO public.moon VALUES (18, 'Rhea', 42, 1740, false, 6);
INSERT INTO public.moon VALUES (20, 'Oberon', 23, 1600, false, 8);
INSERT INTO public.moon VALUES (19, 'Neried', 25, 1440, false, 7);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 1, 365, 6500, true, 1);
INSERT INTO public.planet VALUES (2, 'Mercury', 0, 25, 3000, false, 1);
INSERT INTO public.planet VALUES (3, 'Venus', 0, 280, 7000, false, 1);
INSERT INTO public.planet VALUES (4, 'Mars', 2, 680, 4500, false, 1);
INSERT INTO public.planet VALUES (5, 'Jupiter', 62, 900, 75000, false, 1);
INSERT INTO public.planet VALUES (6, 'Saturn', 58, 1200, 67000, false, 1);
INSERT INTO public.planet VALUES (7, 'Neptune', 13, 1800, 50000, false, 1);
INSERT INTO public.planet VALUES (8, 'Uranus', 9, 2500, 30000, false, 1);
INSERT INTO public.planet VALUES (9, 'Proxima A', 4, 300, 7000, true, 2);
INSERT INTO public.planet VALUES (10, 'Proxima B', 2, 400, 6000, true, 2);
INSERT INTO public.planet VALUES (11, 'DFOEIJR 4234', 0, 200, 3000, false, 2);
INSERT INTO public.planet VALUES (12, 'DFOE243GDF234', 0, 3200, 3240, false, 6);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 8, 0.6, 1);
INSERT INTO public.star VALUES (2, 'Proxima Centauri', 5, 1.3, 1);
INSERT INTO public.star VALUES (3, 'DIUIJK 424', 0, 0.2, 5);
INSERT INTO public.star VALUES (4, 'OIMKLU 5', 0, 14, 3);
INSERT INTO public.star VALUES (5, 'PEIG 235', 3, 1.32, 2);
INSERT INTO public.star VALUES (6, 'DOOMG 235', 0, 2, 4);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: galgroup galgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galgroup
    ADD CONSTRAINT galgroup_name_key UNIQUE (name);


--
-- Name: galgroup galgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galgroup
    ADD CONSTRAINT galgroup_pkey PRIMARY KEY (galgroup_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy fk_galaxy_group; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT fk_galaxy_group FOREIGN KEY (galgroup_id) REFERENCES public.galgroup(galgroup_id);


--
-- Name: moon fk_moon_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_moon_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_planet_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_planet_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star fk_star_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_star_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

