--
-- PostgreSQL database dump
--

\restrict o457pbqGrz7tFAi1dED3tqRyeEzsXggixE3EINWBn7Z5ubDu4GcbsGkwvtyQu8V

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_permissions_user_id_20aca447_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_perm_permission_id_0b93982e_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_user_id_5f6f5a90_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_group_id_9afc8d0e_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.rooms_room_equipment DROP CONSTRAINT IF EXISTS rooms_room_equipment_room_id_8150c93c_fk_rooms_room_id;
ALTER TABLE IF EXISTS ONLY public.rooms_room_equipment DROP CONSTRAINT IF EXISTS rooms_room_equipment_equipment_id_cafd6700_fk_rooms_equ;
ALTER TABLE IF EXISTS ONLY public.rooms_room DROP CONSTRAINT IF EXISTS rooms_room_building_id_3f238d19_fk_rooms_building_id;
ALTER TABLE IF EXISTS ONLY public.reviews_review DROP CONSTRAINT IF EXISTS reviews_review_student_id_67d991fd_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.reviews_review DROP CONSTRAINT IF EXISTS reviews_review_room_id_88f19e2a_fk_rooms_room_id;
ALTER TABLE IF EXISTS ONLY public.reviews_review DROP CONSTRAINT IF EXISTS reviews_review_booking_id_c8b83bac_fk_bookings_booking_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.bookings_booking DROP CONSTRAINT IF EXISTS bookings_booking_student_id_b3b10513_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.bookings_booking DROP CONSTRAINT IF EXISTS bookings_booking_room_id_6f0fa517_fk_rooms_room_id;
ALTER TABLE IF EXISTS ONLY public.bookings_booking DROP CONSTRAINT IF EXISTS bookings_booking_processed_by_id_35f633eb_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
DROP INDEX IF EXISTS public.users_user_username_06e46fe6_like;
DROP INDEX IF EXISTS public.users_user_user_permissions_user_id_20aca447;
DROP INDEX IF EXISTS public.users_user_user_permissions_permission_id_0b93982e;
DROP INDEX IF EXISTS public.users_user_groups_user_id_5f6f5a90;
DROP INDEX IF EXISTS public.users_user_groups_group_id_9afc8d0e;
DROP INDEX IF EXISTS public.rooms_room_equipment_room_id_8150c93c;
DROP INDEX IF EXISTS public.rooms_room_equipment_equipment_id_cafd6700;
DROP INDEX IF EXISTS public.rooms_room_building_id_3f238d19;
DROP INDEX IF EXISTS public.reviews_review_student_id_67d991fd;
DROP INDEX IF EXISTS public.reviews_review_room_id_88f19e2a;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.bookings_booking_student_id_b3b10513;
DROP INDEX IF EXISTS public.bookings_booking_room_id_6f0fa517;
DROP INDEX IF EXISTS public.bookings_booking_processed_by_id_35f633eb;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
ALTER TABLE IF EXISTS ONLY public.users_user DROP CONSTRAINT IF EXISTS users_user_username_key;
ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_permissions_user_id_permission_id_43338c45_uniq;
ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.users_user DROP CONSTRAINT IF EXISTS users_user_pkey;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_user_id_group_id_b88eab82_uniq;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.rooms_room DROP CONSTRAINT IF EXISTS rooms_room_pkey;
ALTER TABLE IF EXISTS ONLY public.rooms_room_equipment DROP CONSTRAINT IF EXISTS rooms_room_equipment_room_id_equipment_id_71d5e5e8_uniq;
ALTER TABLE IF EXISTS ONLY public.rooms_room_equipment DROP CONSTRAINT IF EXISTS rooms_room_equipment_pkey;
ALTER TABLE IF EXISTS ONLY public.rooms_equipment DROP CONSTRAINT IF EXISTS rooms_equipment_pkey;
ALTER TABLE IF EXISTS ONLY public.rooms_building DROP CONSTRAINT IF EXISTS rooms_building_pkey;
ALTER TABLE IF EXISTS ONLY public.reviews_review DROP CONSTRAINT IF EXISTS reviews_review_pkey;
ALTER TABLE IF EXISTS ONLY public.reviews_review DROP CONSTRAINT IF EXISTS reviews_review_booking_id_key;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.bookings_booking DROP CONSTRAINT IF EXISTS bookings_booking_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
DROP TABLE IF EXISTS public.users_user_user_permissions;
DROP TABLE IF EXISTS public.users_user_groups;
DROP TABLE IF EXISTS public.users_user;
DROP TABLE IF EXISTS public.rooms_room_equipment;
DROP TABLE IF EXISTS public.rooms_room;
DROP TABLE IF EXISTS public.rooms_equipment;
DROP TABLE IF EXISTS public.rooms_building;
DROP TABLE IF EXISTS public.reviews_review;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.bookings_booking;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: bookings_booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bookings_booking (
    id bigint NOT NULL,
    booking_date date NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    processed_by_id bigint,
    room_id bigint NOT NULL,
    student_id bigint NOT NULL
);


--
-- Name: bookings_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.bookings_booking ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.bookings_booking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: reviews_review; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews_review (
    id bigint NOT NULL,
    rating integer NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    room_id bigint NOT NULL,
    student_id bigint NOT NULL,
    booking_id bigint,
    CONSTRAINT reviews_review_rating_check CHECK ((rating >= 0))
);


--
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.reviews_review ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reviews_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: rooms_building; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rooms_building (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    campus_area character varying(100) NOT NULL,
    opening_hours character varying(100) NOT NULL
);


--
-- Name: rooms_building_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.rooms_building ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.rooms_building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: rooms_equipment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rooms_equipment (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    status character varying(50) NOT NULL
);


--
-- Name: rooms_equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.rooms_equipment ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.rooms_equipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: rooms_room; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rooms_room (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    capacity integer NOT NULL,
    location character varying(200) NOT NULL,
    is_active boolean NOT NULL,
    building_id bigint NOT NULL,
    CONSTRAINT rooms_room_capacity_check CHECK ((capacity >= 0))
);


--
-- Name: rooms_room_equipment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rooms_room_equipment (
    id bigint NOT NULL,
    room_id bigint NOT NULL,
    equipment_id bigint NOT NULL
);


--
-- Name: rooms_room_equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.rooms_room_equipment ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.rooms_room_equipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: rooms_room_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.rooms_room ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.rooms_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    role character varying(20) NOT NULL
);


--
-- Name: users_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: users_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.users_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.users_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.users_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add building	7	add_building
26	Can change building	7	change_building
27	Can delete building	7	delete_building
28	Can view building	7	view_building
29	Can add equipment	8	add_equipment
30	Can change equipment	8	change_equipment
31	Can delete equipment	8	delete_equipment
32	Can view equipment	8	view_equipment
33	Can add room	9	add_room
34	Can change room	9	change_room
35	Can delete room	9	delete_room
36	Can view room	9	view_room
37	Can add booking	10	add_booking
38	Can change booking	10	change_booking
39	Can delete booking	10	delete_booking
40	Can view booking	10	view_booking
41	Can add review	11	add_review
42	Can change review	11	change_review
43	Can delete review	11	delete_review
44	Can view review	11	view_review
\.


--
-- Data for Name: bookings_booking; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bookings_booking (id, booking_date, start_time, end_time, status, created_at, processed_by_id, room_id, student_id) FROM stdin;
1	2026-03-19	09:30:00	18:30:36	cancelled	2026-03-07 18:32:37.645+00	\N	1	2
2	2026-03-09	01:30:00	03:30:00	approved	2026-03-08 15:15:19.439+00	9	1	2
3	2026-03-13	05:30:00	10:30:00	approved	2026-03-08 16:57:04.49+00	9	1	2
4	2026-03-20	00:00:00	23:30:00	rejected	2026-03-12 22:05:54.42+00	9	3	2
5	2026-03-25	00:00:00	04:30:00	pending	2026-03-14 18:10:18.705+00	\N	2	2
6	2025-12-15	18:00:00	20:30:00	approved	2025-12-03 16:00:00+00	12	48	117
7	2026-04-19	09:00:00	11:00:00	rejected	2026-03-15 07:02:09.100776+00	16	16	113
8	2026-03-20	11:30:00	14:00:00	rejected	2026-03-15 03:30:00+00	15	59	153
9	2025-12-29	16:30:00	17:30:00	approved	2025-12-28 02:30:00+00	13	27	84
10	2026-02-09	09:00:00	11:30:00	approved	2026-02-07 21:00:00+00	12	42	101
11	2025-11-30	11:30:00	13:30:00	approved	2025-11-23 19:30:00+00	14	55	126
12	2026-04-02	08:00:00	10:30:00	pending	2026-03-15 11:49:09.125881+00	\N	11	37
13	2026-04-03	12:30:00	13:30:00	approved	2026-03-15 06:17:09.130074+00	12	32	123
14	2026-03-18	08:00:00	12:00:00	pending	2026-03-12 07:00:00+00	\N	29	155
15	2026-04-04	15:30:00	18:00:00	pending	2026-03-15 06:19:09.140708+00	\N	22	110
16	2026-03-23	12:30:00	14:00:00	rejected	2026-03-15 03:35:09.144681+00	12	1	32
17	2026-03-12	19:30:00	20:30:00	rejected	2026-03-10 13:30:00+00	9	48	170
18	2026-04-04	18:00:00	19:30:00	rejected	2026-03-15 01:04:09.152939+00	12	38	166
19	2026-02-11	19:30:00	22:00:00	approved	2026-02-09 15:30:00+00	13	63	128
20	2026-03-19	09:30:00	13:30:00	pending	2026-03-14 08:30:00+00	\N	24	145
21	2026-03-21	15:30:00	18:00:00	cancelled	2026-03-14 06:30:00+00	\N	48	113
22	2026-01-31	17:30:00	20:00:00	approved	2026-01-21 16:30:00+00	16	8	75
23	2026-03-31	15:00:00	16:30:00	pending	2026-03-15 11:43:09.173169+00	\N	37	38
24	2025-12-25	13:30:00	16:00:00	approved	2025-12-13 03:30:00+00	13	42	18
25	2026-03-28	09:30:00	11:00:00	cancelled	2026-03-15 03:38:09.181514+00	\N	61	167
26	2026-03-15	18:30:00	21:30:00	cancelled	2026-03-14 02:30:00+00	\N	27	168
27	2026-03-20	17:30:00	20:30:00	rejected	2026-03-15 12:30:00+00	12	42	19
28	2026-01-31	10:30:00	11:30:00	approved	2026-01-27 06:30:00+00	9	46	65
30	2026-04-11	10:00:00	12:00:00	cancelled	2026-03-15 18:12:09.207811+00	\N	54	53
31	2026-01-19	11:00:00	13:00:00	approved	2026-01-10 06:00:00+00	12	58	144
32	2026-03-24	10:00:00	14:00:00	approved	2026-03-09 08:00:00+00	9	55	129
33	2026-04-06	15:00:00	18:00:00	approved	2026-03-14 21:01:09.219464+00	9	33	173
34	2026-04-27	13:00:00	15:30:00	cancelled	2026-03-15 14:03:09.226837+00	\N	55	103
35	2026-02-06	14:30:00	17:00:00	approved	2026-01-21 13:30:00+00	9	17	46
36	2026-04-02	13:30:00	16:00:00	pending	2026-03-15 10:36:09.23501+00	\N	23	18
37	2026-04-03	08:00:00	10:00:00	pending	2026-03-15 06:25:09.240698+00	\N	67	126
38	2026-04-05	09:30:00	13:30:00	pending	2026-03-15 15:47:09.243921+00	\N	67	165
39	2025-11-23	09:30:00	11:00:00	approved	2025-11-08 17:30:00+00	15	39	25
40	2025-12-05	17:30:00	19:30:00	approved	2025-11-28 10:30:00+00	12	55	75
41	2026-01-25	15:00:00	18:00:00	approved	2026-01-12 22:00:00+00	16	55	85
42	2026-04-09	09:30:00	12:00:00	approved	2026-03-15 06:32:09.25833+00	14	32	102
43	2026-04-14	16:30:00	18:30:00	approved	2026-03-15 14:05:09.262261+00	16	34	47
44	2026-04-04	18:00:00	22:00:00	rejected	2026-03-15 11:57:09.266006+00	14	75	86
45	2026-03-09	16:00:00	18:00:00	approved	2026-02-26 15:00:00+00	13	42	72
46	2026-04-07	11:30:00	14:30:00	cancelled	2026-03-15 10:50:09.275393+00	\N	8	165
47	2026-03-13	11:00:00	12:30:00	approved	2026-03-08 03:00:00+00	12	34	165
48	2026-02-27	09:30:00	12:00:00	approved	2026-02-24 07:30:00+00	16	52	173
49	2026-01-21	08:00:00	11:00:00	approved	2026-01-10 05:00:00+00	13	55	91
50	2026-03-17	17:00:00	20:00:00	pending	2026-03-12 13:00:00+00	\N	49	49
51	2026-04-02	13:00:00	17:00:00	rejected	2026-03-15 16:07:09.295918+00	12	49	161
52	2026-01-15	09:00:00	11:00:00	approved	2025-12-27 13:00:00+00	12	28	24
53	2026-03-25	12:00:00	14:30:00	pending	2026-03-14 22:21:09.30219+00	\N	47	30
54	2025-12-06	14:00:00	16:30:00	approved	2025-11-18 23:00:00+00	14	5	94
55	2025-12-02	15:00:00	17:30:00	approved	2025-11-18 11:00:00+00	16	57	134
56	2026-03-23	09:00:00	11:30:00	pending	2026-03-15 02:06:09.317473+00	\N	17	158
57	2026-03-03	19:30:00	21:00:00	cancelled	2026-03-02 14:30:00+00	\N	4	61
58	2026-04-04	19:00:00	20:30:00	approved	2026-03-15 05:50:09.327652+00	13	67	78
59	2026-03-22	11:00:00	13:30:00	pending	2026-03-14 23:33:09.330913+00	\N	57	71
60	2026-01-19	11:30:00	13:30:00	approved	2026-01-12 01:30:00+00	15	67	150
61	2026-04-15	14:00:00	15:30:00	rejected	2026-03-15 08:58:09.338301+00	16	76	148
62	2026-04-10	15:30:00	17:30:00	cancelled	2026-03-14 21:32:09.34301+00	\N	7	104
63	2026-03-20	09:00:00	11:30:00	pending	2026-03-11 03:00:00+00	\N	20	134
64	2026-03-05	15:00:00	18:00:00	cancelled	2026-02-26 01:00:00+00	\N	55	122
65	2026-04-01	09:00:00	13:00:00	approved	2026-03-15 05:58:09.355069+00	14	49	42
66	2026-01-27	17:00:00	18:30:00	approved	2026-01-16 14:00:00+00	13	21	46
67	2026-01-30	12:30:00	14:30:00	rejected	2026-01-20 08:30:00+00	9	40	145
68	2026-02-04	10:00:00	11:30:00	approved	2026-01-20 06:00:00+00	14	16	65
69	2026-04-16	08:00:00	12:00:00	rejected	2026-03-15 02:35:09.371282+00	15	28	20
70	2026-02-17	17:00:00	19:00:00	cancelled	2026-02-09 00:00:00+00	\N	24	30
71	2026-03-12	12:00:00	14:00:00	cancelled	2026-03-09 01:00:00+00	\N	22	71
72	2026-02-17	16:00:00	20:00:00	approved	2026-02-06 01:00:00+00	14	52	148
73	2026-03-26	13:00:00	16:00:00	pending	2026-03-14 21:04:09.38718+00	\N	24	144
74	2026-04-03	14:00:00	17:00:00	rejected	2026-03-15 05:05:09.392612+00	16	67	160
75	2026-01-27	08:00:00	10:00:00	approved	2026-01-13 18:00:00+00	9	5	126
76	2025-11-16	18:00:00	20:00:00	approved	2025-11-12 04:00:00+00	13	67	165
77	2026-03-30	16:30:00	19:30:00	pending	2026-03-14 20:34:09.409327+00	\N	60	54
78	2025-12-25	19:30:00	21:30:00	approved	2025-12-22 09:30:00+00	13	34	103
79	2026-03-03	19:00:00	21:30:00	approved	2026-02-23 04:00:00+00	15	30	53
80	2026-04-06	12:00:00	14:00:00	rejected	2026-03-15 15:41:09.423833+00	14	67	35
81	2025-12-19	19:00:00	22:00:00	approved	2025-12-17 18:00:00+00	14	32	67
82	2025-12-08	09:00:00	11:00:00	approved	2025-11-29 16:00:00+00	15	7	72
83	2026-03-19	17:30:00	19:00:00	pending	2026-03-15 09:30:00+00	\N	43	168
84	2026-03-24	16:00:00	20:00:00	pending	2026-03-15 14:00:00+00	\N	15	86
85	2026-03-28	10:00:00	13:00:00	pending	2026-03-15 00:29:09.449052+00	\N	16	117
86	2026-04-10	16:30:00	18:30:00	approved	2026-03-15 11:32:09.45247+00	12	42	21
87	2026-03-02	14:00:00	17:00:00	cancelled	2026-02-24 04:00:00+00	\N	32	161
88	2026-04-01	17:30:00	20:30:00	cancelled	2026-03-15 01:26:09.461133+00	\N	22	140
89	2025-12-16	13:00:00	14:00:00	approved	2025-12-03 01:00:00+00	9	67	112
90	2026-03-29	12:00:00	14:30:00	cancelled	2026-03-15 13:45:09.466578+00	\N	52	46
91	2026-01-04	11:30:00	14:30:00	approved	2025-12-22 18:30:00+00	9	17	168
92	2026-02-13	12:00:00	14:30:00	approved	2026-02-01 04:00:00+00	13	54	120
93	2025-12-28	12:30:00	15:00:00	approved	2025-12-19 02:30:00+00	15	46	28
94	2026-02-18	17:00:00	20:00:00	approved	2026-02-05 04:00:00+00	15	32	82
95	2026-03-05	16:00:00	17:00:00	approved	2026-02-28 01:00:00+00	16	13	46
96	2026-03-21	09:00:00	10:30:00	approved	2026-03-07 00:00:00+00	13	8	143
97	2025-12-22	18:30:00	20:30:00	approved	2025-12-09 07:30:00+00	9	55	132
98	2025-12-18	09:00:00	13:00:00	approved	2025-12-05 22:00:00+00	13	32	132
100	2025-12-08	13:00:00	14:00:00	approved	2025-11-20 20:00:00+00	16	66	166
101	2026-03-29	17:30:00	20:00:00	approved	2026-03-15 09:57:09.519317+00	13	55	143
102	2026-03-20	16:30:00	19:00:00	approved	2026-03-14 23:11:09.525754+00	14	76	160
103	2026-02-04	13:00:00	14:00:00	approved	2026-01-25 21:00:00+00	14	28	161
104	2026-04-01	14:30:00	17:00:00	pending	2026-03-15 16:16:09.536993+00	\N	68	154
105	2026-03-26	14:30:00	15:30:00	approved	2026-03-13 10:30:00+00	15	28	117
106	2026-04-04	11:30:00	13:30:00	approved	2026-03-15 02:28:09.548958+00	16	5	124
108	2025-12-13	19:00:00	21:00:00	approved	2025-12-02 03:00:00+00	15	2	158
110	2025-12-31	14:30:00	16:00:00	approved	2025-12-13 12:30:00+00	13	63	161
111	2026-01-10	19:00:00	21:00:00	approved	2025-12-24 17:00:00+00	9	68	173
112	2026-01-05	19:00:00	21:00:00	approved	2026-01-02 13:00:00+00	12	55	131
113	2026-03-06	17:30:00	18:30:00	rejected	2026-03-02 16:30:00+00	15	63	106
114	2026-01-05	16:00:00	18:30:00	approved	2025-12-18 13:00:00+00	15	72	164
115	2025-12-06	18:00:00	21:00:00	approved	2025-11-23 04:00:00+00	16	48	56
116	2026-03-08	14:00:00	18:00:00	approved	2026-02-21 23:00:00+00	15	14	144
117	2026-01-10	10:30:00	14:30:00	approved	2025-12-31 22:30:00+00	9	21	148
118	2026-04-11	15:30:00	17:30:00	approved	2026-03-15 15:03:09.623692+00	15	28	152
119	2026-03-03	16:00:00	17:30:00	cancelled	2026-02-22 00:00:00+00	\N	73	137
120	2025-12-02	09:30:00	13:30:00	approved	2025-11-23 15:30:00+00	15	63	129
121	2026-02-18	10:00:00	11:30:00	cancelled	2026-02-08 03:00:00+00	\N	14	108
122	2026-04-08	13:30:00	14:30:00	approved	2026-03-15 14:30:09.653468+00	16	41	88
123	2025-12-13	13:30:00	17:30:00	approved	2025-11-25 22:30:00+00	16	66	166
124	2026-03-21	12:00:00	15:00:00	pending	2026-03-11 00:00:00+00	\N	2	146
125	2026-03-25	14:00:00	18:00:00	approved	2026-03-15 03:26:09.675168+00	14	67	57
126	2026-02-21	18:30:00	21:00:00	approved	2026-02-08 12:30:00+00	15	60	26
127	2026-02-18	10:30:00	12:30:00	approved	2026-02-09 07:30:00+00	9	5	20
128	2026-04-24	12:30:00	16:30:00	cancelled	2026-03-15 18:26:09.695006+00	\N	51	73
129	2026-03-10	19:00:00	21:00:00	approved	2026-03-03 16:00:00+00	14	48	98
130	2025-12-04	15:00:00	16:30:00	approved	2025-11-20 23:00:00+00	13	6	148
131	2026-01-11	16:30:00	18:30:00	approved	2026-01-04 05:30:00+00	16	73	150
132	2025-12-28	09:00:00	13:00:00	approved	2025-12-15 23:00:00+00	9	50	11
133	2026-02-06	15:30:00	19:30:00	rejected	2026-01-30 13:30:00+00	9	72	135
134	2026-03-17	09:30:00	13:30:00	rejected	2026-03-14 04:30:00+00	15	67	128
135	2026-04-12	17:00:00	20:00:00	approved	2026-03-15 15:25:09.754133+00	14	75	68
136	2026-03-08	18:30:00	21:00:00	approved	2026-02-19 05:30:00+00	14	63	47
137	2026-03-23	19:00:00	21:30:00	pending	2026-03-15 02:48:09.768997+00	\N	55	108
138	2025-12-06	11:00:00	14:00:00	approved	2025-11-19 19:00:00+00	15	34	161
139	2026-04-14	10:00:00	12:00:00	cancelled	2026-03-15 10:27:09.78406+00	\N	30	124
140	2026-02-15	08:00:00	11:00:00	approved	2026-02-12 16:00:00+00	15	59	11
141	2026-03-18	10:30:00	12:30:00	pending	2026-03-13 06:30:00+00	\N	58	46
142	2025-12-25	14:30:00	16:30:00	approved	2025-12-14 18:30:00+00	14	48	98
143	2026-01-07	19:00:00	20:00:00	approved	2026-01-01 11:00:00+00	16	1	143
144	2026-04-05	16:30:00	18:00:00	rejected	2026-03-15 18:31:09.809391+00	16	25	89
145	2026-04-10	17:30:00	20:00:00	approved	2026-03-15 09:38:09.814912+00	13	67	142
146	2026-03-05	11:30:00	14:30:00	approved	2026-02-18 21:30:00+00	16	30	11
147	2026-02-27	11:00:00	13:30:00	rejected	2026-02-20 07:00:00+00	9	73	113
148	2026-04-15	17:00:00	19:00:00	cancelled	2026-03-14 21:46:09.830853+00	\N	35	73
149	2026-03-29	12:30:00	13:30:00	pending	2026-03-15 18:18:09.834521+00	\N	24	79
150	2026-01-12	08:00:00	12:00:00	approved	2025-12-31 04:00:00+00	15	58	26
151	2026-02-18	14:00:00	15:00:00	rejected	2026-02-13 08:00:00+00	9	52	156
152	2026-04-20	09:00:00	11:00:00	cancelled	2026-03-15 11:25:09.851313+00	\N	61	136
99	2026-03-16	18:30:00	20:00:00	rejected	2026-03-11 12:30:00+00	\N	24	123
153	2026-03-20	10:30:00	12:30:00	pending	2026-03-15 09:11:09.857902+00	\N	58	163
154	2025-11-20	16:00:00	18:00:00	approved	2025-11-12 20:00:00+00	9	60	46
155	2026-03-19	12:00:00	13:00:00	cancelled	2026-03-15 14:14:09.868314+00	\N	3	62
156	2026-01-01	17:00:00	18:30:00	approved	2025-12-25 22:00:00+00	13	28	46
157	2026-04-03	15:30:00	18:30:00	pending	2026-03-15 17:59:09.880651+00	\N	56	47
158	2026-03-19	08:30:00	11:00:00	pending	2026-03-13 07:30:00+00	\N	5	133
159	2026-03-09	12:30:00	14:30:00	cancelled	2026-03-02 21:30:00+00	\N	77	61
160	2026-04-01	09:00:00	11:00:00	approved	2026-03-15 16:43:09.899844+00	14	1	146
161	2025-12-24	08:00:00	09:30:00	approved	2025-12-06 12:00:00+00	16	5	102
162	2026-03-03	09:00:00	11:00:00	rejected	2026-02-24 03:00:00+00	16	19	147
163	2025-12-10	11:00:00	13:30:00	approved	2025-12-08 01:00:00+00	16	5	165
164	2026-02-19	12:30:00	15:30:00	cancelled	2026-02-16 22:30:00+00	\N	30	20
165	2026-04-01	19:30:00	22:00:00	approved	2026-03-15 15:19:09.927696+00	12	24	46
166	2026-02-03	09:00:00	11:30:00	rejected	2026-01-26 03:00:00+00	14	31	64
167	2025-12-30	15:30:00	17:30:00	approved	2025-12-27 07:30:00+00	9	70	46
168	2026-03-14	10:00:00	11:30:00	rejected	2026-03-08 06:00:00+00	12	35	149
169	2026-03-10	09:00:00	10:30:00	approved	2026-02-24 14:00:00+00	12	18	47
170	2026-01-25	19:30:00	22:00:00	approved	2026-01-20 13:30:00+00	16	5	162
171	2026-02-15	17:00:00	20:00:00	cancelled	2026-02-13 00:00:00+00	\N	6	33
172	2025-12-04	09:30:00	13:30:00	approved	2025-11-26 22:30:00+00	15	67	124
173	2026-03-24	19:30:00	22:00:00	approved	2026-03-07 10:30:00+00	12	14	153
174	2026-02-05	15:00:00	16:00:00	approved	2026-01-18 06:00:00+00	12	5	140
175	2026-02-02	17:30:00	19:00:00	approved	2026-01-24 04:30:00+00	14	18	80
176	2026-04-02	16:00:00	17:00:00	rejected	2026-03-14 23:44:09.983185+00	9	46	101
177	2025-12-24	12:30:00	14:30:00	approved	2025-12-11 04:30:00+00	14	24	97
178	2026-02-10	19:00:00	20:30:00	approved	2026-01-25 09:00:00+00	14	55	82
179	2026-03-24	11:30:00	14:30:00	rejected	2026-03-15 05:30:09.998281+00	13	12	165
180	2026-02-04	18:30:00	20:30:00	approved	2026-01-30 23:30:00+00	14	67	102
181	2025-11-23	12:30:00	13:30:00	approved	2025-11-21 07:30:00+00	14	10	17
182	2026-04-22	19:00:00	22:00:00	cancelled	2026-03-15 18:08:10.011246+00	\N	29	28
183	2026-04-06	12:00:00	15:00:00	approved	2026-03-15 02:54:10.015472+00	14	24	116
184	2026-04-04	18:00:00	19:00:00	approved	2026-03-15 16:10:10.018979+00	13	5	39
185	2026-04-10	10:00:00	11:00:00	cancelled	2026-03-14 22:46:10.025785+00	\N	37	11
187	2026-04-02	15:00:00	16:30:00	cancelled	2026-03-14 21:42:10.038658+00	\N	66	158
188	2026-02-19	16:30:00	19:00:00	cancelled	2026-02-14 04:30:00+00	\N	73	140
189	2026-03-05	10:30:00	14:30:00	rejected	2026-03-04 03:30:00+00	15	67	126
190	2026-03-27	09:30:00	12:00:00	pending	2026-03-15 07:57:10.051984+00	\N	63	93
191	2026-04-07	11:00:00	12:30:00	approved	2026-03-14 20:13:10.059618+00	13	66	72
192	2026-04-09	17:00:00	19:00:00	rejected	2026-03-14 19:51:10.065291+00	13	69	158
193	2026-03-13	09:30:00	13:30:00	approved	2026-02-26 00:30:00+00	9	32	72
194	2026-03-30	13:00:00	15:00:00	pending	2026-03-15 14:21:10.077647+00	\N	62	139
195	2026-03-21	08:00:00	09:30:00	pending	2026-03-15 07:10:10.08037+00	\N	2	18
196	2026-03-08	14:30:00	17:00:00	cancelled	2026-02-22 06:30:00+00	\N	63	37
197	2026-02-27	13:00:00	16:00:00	cancelled	2026-02-22 08:00:00+00	\N	44	72
198	2026-01-17	14:30:00	15:30:00	approved	2025-12-30 01:30:00+00	13	48	167
199	2026-03-26	12:30:00	13:30:00	rejected	2026-03-15 08:23:10.096732+00	13	57	72
200	2026-02-24	11:00:00	12:30:00	approved	2026-02-07 07:00:00+00	16	71	72
201	2026-02-04	09:00:00	10:00:00	rejected	2026-01-29 02:00:00+00	15	70	106
202	2026-01-05	15:00:00	16:30:00	approved	2025-12-29 20:00:00+00	14	5	24
203	2026-03-24	11:00:00	12:00:00	pending	2026-03-12 05:00:00+00	\N	34	76
204	2026-04-09	10:00:00	13:00:00	approved	2026-03-15 11:30:10.120521+00	16	22	139
205	2026-03-24	18:00:00	20:30:00	rejected	2026-03-14 23:07:10.1268+00	14	62	113
206	2026-02-23	13:30:00	14:30:00	rejected	2026-02-14 07:30:00+00	16	58	133
207	2026-03-17	12:00:00	14:00:00	pending	2026-03-05 09:00:00+00	\N	63	111
208	2026-04-01	09:30:00	11:30:00	approved	2026-03-15 02:42:10.139651+00	15	55	56
209	2026-03-18	09:00:00	11:00:00	pending	2026-03-06 21:00:00+00	\N	67	11
210	2026-03-24	11:00:00	13:30:00	rejected	2026-03-15 16:18:10.149971+00	12	63	148
211	2025-11-30	18:30:00	21:30:00	approved	2025-11-15 08:30:00+00	14	42	54
212	2026-03-17	15:00:00	16:30:00	approved	2026-03-01 02:00:00+00	9	25	98
213	2026-02-11	09:30:00	11:00:00	approved	2026-01-29 17:30:00+00	9	28	134
214	2026-03-27	16:00:00	18:30:00	pending	2026-03-15 03:55:10.165881+00	\N	2	125
215	2026-02-13	10:30:00	13:30:00	rejected	2026-02-10 07:30:00+00	14	66	113
216	2026-03-30	15:00:00	16:30:00	approved	2026-03-15 05:46:10.175218+00	15	31	113
217	2026-02-01	18:00:00	21:00:00	approved	2026-01-23 17:00:00+00	13	13	78
218	2026-03-25	09:30:00	10:30:00	cancelled	2026-03-14 20:30:00+00	\N	19	20
219	2025-12-22	17:00:00	19:00:00	approved	2025-12-17 10:00:00+00	12	64	93
220	2026-01-28	19:30:00	22:00:00	approved	2026-01-25 17:30:00+00	14	1	128
221	2026-03-16	17:00:00	18:00:00	cancelled	2026-03-08 01:00:00+00	\N	58	106
223	2026-03-19	19:00:00	20:30:00	cancelled	2026-03-13 07:00:00+00	\N	18	48
224	2026-01-26	16:00:00	17:00:00	approved	2026-01-15 23:00:00+00	15	32	69
225	2026-02-22	19:00:00	22:00:00	approved	2026-02-13 06:00:00+00	9	2	165
226	2026-03-27	15:30:00	18:00:00	rejected	2026-03-15 16:21:10.222885+00	12	11	72
227	2026-03-06	16:30:00	19:30:00	approved	2026-02-28 06:30:00+00	15	17	105
228	2026-03-29	14:30:00	17:30:00	pending	2026-03-15 01:21:10.233319+00	\N	28	47
186	2026-03-16	17:00:00	18:30:00	rejected	2026-03-08 10:00:00+00	\N	48	126
229	2026-04-27	16:00:00	18:00:00	cancelled	2026-03-14 23:30:10.237117+00	\N	68	161
230	2026-03-20	15:30:00	18:00:00	pending	2026-03-09 12:30:00+00	\N	63	163
231	2026-01-31	17:30:00	18:30:00	approved	2026-01-17 05:30:00+00	16	5	166
384	2026-03-21	11:00:00	15:00:00	pending	2026-03-15 01:27:11.068831+00	\N	60	131
232	2026-04-01	16:30:00	18:00:00	approved	2026-03-15 00:39:10.251154+00	13	34	71
233	2026-02-08	12:30:00	14:30:00	rejected	2026-02-07 11:30:00+00	15	27	165
234	2025-12-29	11:00:00	13:00:00	approved	2025-12-18 00:00:00+00	15	5	136
235	2026-04-08	12:30:00	13:30:00	approved	2026-03-15 04:16:10.265729+00	13	11	92
236	2026-03-11	18:00:00	20:00:00	approved	2026-03-04 22:00:00+00	9	48	80
238	2025-11-21	08:00:00	09:00:00	approved	2025-11-04 15:00:00+00	12	70	97
239	2026-02-20	11:00:00	12:30:00	rejected	2026-02-12 03:00:00+00	13	43	47
240	2026-03-15	16:00:00	19:00:00	rejected	2026-03-09 14:00:00+00	16	1	81
241	2025-12-22	16:30:00	19:30:00	approved	2025-12-13 22:30:00+00	15	26	115
242	2026-03-06	17:30:00	20:00:00	approved	2026-02-25 21:30:00+00	13	64	48
243	2026-03-27	17:00:00	18:30:00	rejected	2026-03-15 17:04:10.300188+00	12	70	18
244	2026-04-11	12:30:00	15:30:00	approved	2026-03-15 04:04:10.303331+00	14	39	107
245	2026-02-12	15:00:00	17:00:00	approved	2026-02-02 13:00:00+00	12	25	168
246	2025-12-02	11:00:00	13:30:00	approved	2025-11-14 04:00:00+00	9	55	117
247	2026-02-01	10:00:00	12:00:00	rejected	2026-01-29 04:00:00+00	9	47	148
248	2026-02-21	19:00:00	21:30:00	cancelled	2026-02-18 04:00:00+00	\N	5	105
249	2026-03-28	08:00:00	12:00:00	approved	2026-03-14 22:43:10.327891+00	16	48	43
250	2026-03-10	19:30:00	21:00:00	approved	2026-03-03 14:30:00+00	13	63	26
251	2026-04-08	10:00:00	12:00:00	approved	2026-03-15 18:12:10.334142+00	12	69	51
252	2026-01-18	18:30:00	21:30:00	approved	2026-01-05 02:30:00+00	14	28	173
253	2026-03-01	16:00:00	19:00:00	rejected	2026-02-25 10:00:00+00	15	68	150
254	2026-03-30	09:30:00	10:30:00	approved	2026-03-14 23:31:10.350367+00	16	1	49
255	2026-04-15	11:00:00	15:00:00	rejected	2026-03-15 15:47:10.353939+00	13	28	126
256	2026-02-03	16:00:00	17:00:00	rejected	2026-01-31 10:00:00+00	15	33	159
257	2026-03-04	08:00:00	09:30:00	approved	2026-02-19 14:00:00+00	9	63	122
258	2026-02-26	16:00:00	17:00:00	approved	2026-02-10 01:00:00+00	13	45	74
259	2025-11-29	12:30:00	14:00:00	approved	2025-11-12 11:30:00+00	15	42	47
260	2026-01-31	13:30:00	15:00:00	approved	2026-01-23 08:30:00+00	13	56	28
261	2026-04-24	18:30:00	21:30:00	cancelled	2026-03-15 10:36:10.381467+00	\N	24	169
262	2025-12-19	10:30:00	14:30:00	approved	2025-12-05 23:30:00+00	16	31	68
263	2026-03-07	12:30:00	13:30:00	rejected	2026-02-28 06:30:00+00	12	35	46
264	2026-03-26	16:00:00	17:30:00	cancelled	2026-03-15 02:11:10.393496+00	\N	69	157
265	2026-02-28	15:00:00	17:30:00	rejected	2026-02-22 11:00:00+00	12	10	114
266	2026-04-14	17:00:00	20:00:00	rejected	2026-03-14 20:54:10.402829+00	12	52	144
267	2026-03-26	14:30:00	16:30:00	rejected	2026-03-15 06:21:10.408743+00	16	53	46
268	2026-03-24	09:00:00	11:00:00	pending	2026-03-12 21:00:00+00	\N	23	98
269	2026-03-26	16:30:00	19:00:00	pending	2026-03-15 14:42:10.414828+00	\N	47	144
270	2026-03-12	12:00:00	13:30:00	rejected	2026-03-06 09:00:00+00	13	13	28
271	2026-04-12	18:00:00	22:00:00	approved	2026-03-15 03:53:10.420971+00	15	28	75
272	2026-02-26	13:00:00	15:00:00	rejected	2026-02-17 08:00:00+00	9	54	133
273	2026-03-05	11:30:00	13:00:00	approved	2026-02-16 19:30:00+00	12	13	165
274	2026-02-12	19:00:00	21:30:00	rejected	2026-02-06 14:00:00+00	14	61	82
275	2025-12-11	17:30:00	19:30:00	approved	2025-12-05 06:30:00+00	12	1	126
276	2026-04-08	19:30:00	21:30:00	approved	2026-03-15 04:53:10.445481+00	15	56	135
277	2026-04-12	08:30:00	11:30:00	approved	2026-03-14 20:57:10.45014+00	15	32	72
278	2026-04-19	13:30:00	16:30:00	rejected	2026-03-14 23:09:10.45434+00	13	21	93
279	2026-03-19	19:30:00	21:30:00	pending	2026-03-08 13:30:00+00	\N	63	88
280	2026-03-02	13:00:00	14:30:00	rejected	2026-02-24 09:00:00+00	13	72	117
281	2026-02-10	19:00:00	22:00:00	rejected	2026-02-07 11:00:00+00	12	55	97
282	2026-03-29	13:30:00	16:00:00	rejected	2026-03-15 15:29:10.474115+00	16	32	65
283	2026-03-24	19:30:00	21:00:00	approved	2026-03-15 14:24:10.479148+00	9	18	27
284	2026-04-02	18:00:00	19:00:00	cancelled	2026-03-15 19:18:10.483925+00	\N	73	100
285	2026-03-20	13:30:00	15:00:00	approved	2026-03-09 10:30:00+00	15	72	11
286	2026-01-29	18:00:00	20:30:00	rejected	2026-01-19 13:00:00+00	15	75	47
287	2026-03-17	15:30:00	16:30:00	cancelled	2026-03-03 23:30:00+00	\N	34	45
288	2026-03-07	18:30:00	20:30:00	rejected	2026-03-01 11:30:00+00	9	22	34
289	2026-03-12	12:00:00	13:30:00	rejected	2026-03-06 11:00:00+00	16	28	134
290	2026-02-28	16:00:00	18:00:00	cancelled	2026-02-18 09:00:00+00	\N	10	139
291	2026-04-01	13:00:00	16:00:00	pending	2026-03-15 04:22:10.51835+00	\N	20	59
292	2026-03-02	14:00:00	15:30:00	rejected	2026-03-01 12:00:00+00	16	17	84
293	2026-03-21	18:30:00	21:00:00	cancelled	2026-03-13 00:30:00+00	\N	39	162
294	2025-12-05	13:00:00	15:30:00	approved	2025-12-03 18:00:00+00	15	52	92
295	2026-04-11	11:30:00	14:00:00	cancelled	2026-03-15 14:38:10.538758+00	\N	32	37
296	2026-03-18	17:00:00	18:00:00	approved	2026-03-07 09:00:00+00	12	42	142
297	2026-01-14	14:00:00	15:00:00	approved	2025-12-27 06:00:00+00	16	67	164
298	2026-04-12	11:30:00	13:30:00	approved	2026-03-15 05:14:10.549805+00	12	4	60
299	2026-03-03	15:00:00	16:30:00	cancelled	2026-02-20 22:00:00+00	\N	15	47
300	2026-03-23	10:30:00	13:30:00	approved	2026-03-12 15:30:00+00	16	11	70
301	2026-03-25	15:00:00	17:30:00	cancelled	2026-03-15 14:39:10.561394+00	\N	13	121
302	2026-03-22	18:30:00	20:00:00	pending	2026-03-15 13:30:00+00	\N	75	23
303	2026-04-12	16:30:00	18:00:00	approved	2026-03-15 18:24:10.575406+00	15	34	119
304	2026-02-14	08:30:00	10:30:00	cancelled	2026-02-11 17:30:00+00	\N	36	114
305	2026-02-09	17:00:00	19:00:00	approved	2026-01-29 21:00:00+00	15	20	155
306	2025-11-17	17:30:00	20:30:00	approved	2025-11-11 16:30:00+00	12	25	141
307	2026-04-22	18:00:00	19:00:00	cancelled	2026-03-15 18:06:10.600189+00	\N	33	165
308	2026-02-27	18:00:00	20:30:00	cancelled	2026-02-25 04:00:00+00	\N	16	20
309	2026-04-19	09:30:00	12:30:00	cancelled	2026-03-14 22:24:10.616188+00	\N	74	160
310	2025-11-22	09:00:00	10:30:00	approved	2025-11-20 07:00:00+00	15	63	156
311	2025-12-15	13:30:00	17:30:00	approved	2025-12-02 11:30:00+00	16	69	56
312	2026-02-14	08:30:00	11:30:00	approved	2026-01-30 06:30:00+00	16	61	165
313	2026-04-16	08:30:00	10:30:00	rejected	2026-03-15 06:23:10.63356+00	14	29	69
314	2026-03-07	15:00:00	18:00:00	approved	2026-02-17 11:00:00+00	13	67	98
315	2026-03-15	11:00:00	15:00:00	rejected	2026-03-05 10:00:00+00	15	17	75
316	2026-03-11	17:00:00	21:00:00	rejected	2026-03-03 12:00:00+00	13	74	134
317	2026-03-28	18:30:00	20:30:00	cancelled	2026-03-15 13:33:10.656653+00	\N	22	133
318	2026-03-18	08:00:00	12:00:00	pending	2026-03-13 03:00:00+00	\N	48	110
319	2026-04-16	10:30:00	12:30:00	rejected	2026-03-15 14:37:10.667136+00	13	48	42
320	2026-03-23	19:30:00	22:00:00	pending	2026-03-15 14:39:10.672973+00	\N	28	104
321	2026-04-15	12:30:00	15:30:00	cancelled	2026-03-15 19:05:10.678273+00	\N	58	92
322	2026-01-30	12:00:00	13:30:00	approved	2026-01-25 01:00:00+00	12	34	167
323	2025-12-16	18:00:00	21:00:00	approved	2025-12-06 14:00:00+00	15	51	150
324	2026-02-01	16:00:00	18:00:00	rejected	2026-01-31 15:00:00+00	14	74	173
325	2026-03-23	12:00:00	13:30:00	pending	2026-03-11 08:00:00+00	\N	24	82
326	2026-04-10	11:00:00	15:00:00	cancelled	2026-03-14 22:38:10.708609+00	\N	4	148
327	2026-01-16	12:00:00	13:30:00	approved	2026-01-08 00:00:00+00	13	51	75
328	2026-01-31	09:30:00	11:30:00	approved	2026-01-27 18:30:00+00	15	24	17
329	2025-12-29	10:30:00	11:30:00	approved	2025-12-17 19:30:00+00	15	48	103
330	2026-02-18	14:30:00	16:30:00	cancelled	2026-02-15 11:30:00+00	\N	4	28
331	2025-12-24	18:30:00	20:30:00	approved	2025-12-12 08:30:00+00	15	50	98
332	2026-03-22	14:30:00	16:30:00	approved	2026-03-15 09:30:00+00	13	24	163
333	2026-03-18	12:00:00	16:00:00	cancelled	2026-03-15 05:34:10.74364+00	\N	18	99
334	2026-02-28	17:30:00	19:30:00	approved	2026-02-26 14:30:00+00	15	18	157
335	2026-03-19	10:30:00	12:30:00	pending	2026-03-12 00:30:00+00	\N	48	158
336	2026-03-26	15:00:00	16:30:00	cancelled	2026-03-15 10:46:10.762282+00	\N	72	29
337	2026-04-26	19:00:00	22:00:00	cancelled	2026-03-14 21:59:10.767176+00	\N	18	155
338	2025-12-13	12:30:00	15:00:00	approved	2025-11-30 05:30:00+00	12	5	62
339	2026-03-29	12:30:00	16:30:00	cancelled	2026-03-15 13:49:10.780839+00	\N	76	130
340	2026-04-05	19:00:00	22:00:00	pending	2026-03-15 00:27:10.786175+00	\N	24	81
341	2025-12-20	15:30:00	18:00:00	approved	2025-12-02 03:30:00+00	12	62	54
342	2026-03-16	16:00:00	18:00:00	cancelled	2026-03-03 06:00:00+00	\N	5	141
343	2026-03-25	15:00:00	17:00:00	approved	2026-03-15 18:30:10.807358+00	16	42	108
344	2026-03-07	16:30:00	17:30:00	approved	2026-03-02 11:30:00+00	9	76	163
345	2026-01-08	10:00:00	11:00:00	approved	2025-12-24 00:00:00+00	15	1	167
346	2025-11-21	18:30:00	21:30:00	approved	2025-11-20 09:30:00+00	14	48	158
347	2026-03-21	15:30:00	17:00:00	pending	2026-03-14 03:30:00+00	\N	23	71
348	2025-11-18	18:00:00	21:00:00	approved	2025-11-04 13:00:00+00	16	42	70
349	2026-03-10	18:30:00	22:00:00	rejected	2026-02-28 14:30:00+00	16	21	156
350	2026-03-21	19:30:00	21:00:00	pending	2026-03-09 16:30:00+00	\N	63	92
351	2026-03-27	09:00:00	11:30:00	approved	2026-03-14 19:40:10.86101+00	14	28	134
352	2026-03-16	10:00:00	14:00:00	rejected	2026-03-08 08:00:00+00	12	65	94
353	2026-04-06	09:30:00	11:00:00	cancelled	2026-03-15 08:12:10.870248+00	\N	18	108
354	2026-03-21	15:30:00	17:30:00	pending	2026-03-15 12:25:10.883048+00	\N	16	148
355	2026-04-02	17:30:00	20:30:00	pending	2026-03-15 00:36:10.891122+00	\N	39	103
356	2026-03-23	17:00:00	19:30:00	pending	2026-03-15 16:14:10.89831+00	\N	5	150
357	2026-03-22	19:00:00	20:00:00	pending	2026-03-14 09:00:00+00	\N	34	83
358	2026-03-30	19:00:00	21:00:00	approved	2026-03-12 15:00:00+00	9	63	152
359	2026-02-28	18:30:00	20:30:00	approved	2026-02-24 07:30:00+00	12	56	28
360	2026-04-05	08:00:00	09:00:00	pending	2026-03-15 07:03:10.927718+00	\N	18	144
361	2026-04-08	08:00:00	09:00:00	cancelled	2026-03-14 22:42:10.933535+00	\N	22	26
362	2026-03-31	13:30:00	14:30:00	approved	2026-03-15 11:16:10.939414+00	14	28	150
363	2026-02-15	10:30:00	12:30:00	cancelled	2026-02-05 17:30:00+00	\N	11	70
364	2026-03-25	09:00:00	10:30:00	pending	2026-03-15 02:50:10.951239+00	\N	42	130
365	2026-03-17	16:30:00	18:00:00	pending	2026-03-06 15:30:00+00	\N	42	28
366	2025-12-23	17:30:00	19:30:00	approved	2025-12-07 13:30:00+00	15	32	99
367	2026-02-16	14:00:00	18:00:00	approved	2026-01-30 20:00:00+00	9	58	11
368	2025-12-14	16:30:00	20:30:00	approved	2025-12-06 21:30:00+00	16	25	168
369	2026-03-24	09:00:00	12:00:00	approved	2026-03-15 16:34:10.974641+00	12	42	156
370	2026-02-23	13:00:00	16:00:00	approved	2026-02-17 12:00:00+00	16	28	135
371	2026-02-02	12:30:00	14:30:00	approved	2026-01-19 08:30:00+00	16	73	128
372	2026-03-22	17:00:00	20:00:00	approved	2026-03-15 07:42:10.996398+00	15	22	18
373	2025-12-11	12:00:00	16:00:00	approved	2025-11-26 05:00:00+00	12	1	67
374	2026-02-19	13:30:00	14:30:00	approved	2026-02-02 09:30:00+00	16	17	161
375	2025-12-07	14:00:00	16:00:00	approved	2025-11-19 04:00:00+00	14	25	145
376	2026-01-11	11:30:00	14:00:00	approved	2026-01-10 05:30:00+00	9	7	158
377	2026-04-01	12:30:00	15:30:00	pending	2026-03-15 10:09:11.025539+00	\N	58	126
378	2026-03-13	13:00:00	14:30:00	cancelled	2026-02-27 11:00:00+00	\N	72	33
379	2026-03-24	12:00:00	15:00:00	pending	2026-03-15 07:19:11.035836+00	\N	26	43
380	2025-12-14	10:30:00	13:30:00	approved	2025-12-01 22:30:00+00	16	11	125
381	2026-01-03	18:30:00	20:30:00	approved	2025-12-28 02:30:00+00	15	5	115
382	2025-12-23	13:00:00	17:00:00	approved	2025-12-18 21:00:00+00	16	5	22
383	2026-02-24	15:30:00	18:30:00	cancelled	2026-02-21 14:30:00+00	\N	41	173
385	2025-11-25	12:00:00	13:30:00	approved	2025-11-13 05:00:00+00	12	24	151
386	2026-03-06	08:30:00	10:00:00	rejected	2026-03-01 02:30:00+00	9	40	47
387	2026-03-22	10:00:00	12:00:00	rejected	2026-03-15 02:50:11.085044+00	14	26	141
388	2026-02-18	19:30:00	20:30:00	cancelled	2026-02-16 12:30:00+00	\N	65	156
389	2026-04-09	09:30:00	12:30:00	cancelled	2026-03-15 17:55:11.096421+00	\N	45	40
390	2025-12-20	11:00:00	12:00:00	approved	2025-12-18 05:00:00+00	13	32	64
391	2026-03-31	11:00:00	12:30:00	approved	2026-03-15 00:36:11.10872+00	16	1	88
392	2026-04-03	10:00:00	11:00:00	approved	2026-03-15 00:30:11.113898+00	13	67	68
393	2026-03-07	15:30:00	18:00:00	rejected	2026-02-26 11:30:00+00	9	75	28
394	2026-02-26	18:30:00	20:00:00	rejected	2026-02-25 16:30:00+00	15	9	22
395	2025-11-26	13:00:00	14:30:00	approved	2025-11-13 17:00:00+00	9	63	166
396	2026-03-10	15:00:00	17:00:00	cancelled	2026-02-24 23:00:00+00	\N	37	148
397	2026-04-27	10:30:00	13:30:00	cancelled	2026-03-15 01:39:11.139507+00	\N	44	169
398	2026-02-04	17:00:00	18:30:00	rejected	2026-01-26 12:00:00+00	16	55	66
399	2026-03-23	18:00:00	20:00:00	approved	2026-03-15 03:08:11.151156+00	15	30	102
400	2026-01-17	13:00:00	15:00:00	approved	2026-01-10 04:00:00+00	13	27	72
401	2026-03-23	14:30:00	17:00:00	pending	2026-03-15 05:54:11.159517+00	\N	9	167
402	2026-03-21	15:00:00	17:00:00	pending	2026-03-14 20:53:11.163507+00	\N	24	156
403	2026-02-27	08:00:00	10:30:00	approved	2026-02-16 00:00:00+00	16	51	49
404	2025-12-02	15:30:00	18:00:00	approved	2025-11-20 01:30:00+00	14	19	28
405	2026-04-02	16:30:00	17:30:00	rejected	2026-03-15 14:31:11.177385+00	9	67	85
406	2026-02-27	19:30:00	20:30:00	rejected	2026-02-23 12:30:00+00	12	23	124
407	2026-01-21	17:30:00	18:30:00	approved	2026-01-05 08:30:00+00	9	72	62
408	2026-01-07	12:00:00	14:30:00	approved	2025-12-27 02:00:00+00	14	12	29
409	2026-03-23	10:30:00	13:00:00	pending	2026-03-15 11:27:11.199316+00	\N	5	20
410	2026-02-18	19:30:00	20:30:00	approved	2026-02-13 08:30:00+00	16	75	77
411	2026-02-24	18:00:00	20:00:00	rejected	2026-02-16 17:00:00+00	16	66	88
412	2026-01-14	18:30:00	21:00:00	approved	2026-01-08 11:30:00+00	12	67	47
413	2026-02-16	09:00:00	10:00:00	approved	2026-01-30 23:00:00+00	15	18	114
414	2026-03-26	15:30:00	16:30:00	pending	2026-03-15 15:32:11.231899+00	\N	1	161
415	2026-03-26	10:00:00	13:00:00	rejected	2026-03-15 13:16:11.236324+00	14	21	48
416	2025-11-30	17:30:00	19:00:00	approved	2025-11-25 23:30:00+00	15	67	20
417	2026-04-04	14:30:00	15:30:00	cancelled	2026-03-15 10:15:11.248234+00	\N	23	67
418	2026-01-06	13:30:00	15:00:00	approved	2025-12-23 12:30:00+00	13	11	165
419	2026-04-04	14:00:00	15:30:00	approved	2026-03-15 02:10:11.259405+00	12	6	47
420	2026-03-27	15:00:00	16:00:00	rejected	2026-03-15 18:49:11.263564+00	9	9	174
421	2025-12-18	11:30:00	14:30:00	approved	2025-12-14 16:30:00+00	9	5	133
422	2026-03-07	10:30:00	12:30:00	approved	2026-02-24 00:30:00+00	13	34	156
423	2026-02-05	13:30:00	15:00:00	approved	2026-01-24 10:30:00+00	9	67	81
424	2026-03-12	12:30:00	14:30:00	rejected	2026-03-02 07:30:00+00	9	14	168
425	2026-02-13	18:00:00	22:00:00	approved	2026-01-31 03:00:00+00	9	48	98
426	2026-03-29	08:00:00	09:30:00	pending	2026-03-15 18:46:11.287593+00	\N	1	65
427	2026-04-19	19:30:00	22:00:00	rejected	2026-03-15 15:44:11.294681+00	15	66	174
428	2026-04-13	15:00:00	17:00:00	rejected	2026-03-14 20:32:11.299541+00	12	4	70
429	2026-04-07	17:30:00	21:30:00	cancelled	2026-03-15 16:17:11.305978+00	\N	53	22
430	2025-12-30	12:00:00	14:00:00	approved	2025-12-16 06:00:00+00	16	48	113
431	2026-03-10	08:30:00	12:30:00	cancelled	2026-02-28 02:30:00+00	\N	25	72
432	2026-04-02	13:30:00	15:00:00	pending	2026-03-15 09:28:11.323563+00	\N	65	104
433	2026-01-08	13:30:00	15:00:00	approved	2025-12-26 06:30:00+00	14	36	117
434	2026-03-25	19:30:00	21:30:00	approved	2026-03-10 23:30:00+00	13	33	98
435	2026-03-17	18:00:00	21:00:00	approved	2026-03-05 17:00:00+00	14	48	22
436	2026-04-17	10:30:00	11:30:00	rejected	2026-03-15 18:55:11.348162+00	13	27	44
437	2026-03-21	08:00:00	10:00:00	cancelled	2026-03-12 06:00:00+00	\N	5	155
438	2026-02-21	12:00:00	13:30:00	rejected	2026-02-17 08:00:00+00	14	6	140
439	2025-12-03	17:30:00	19:00:00	approved	2025-11-15 05:30:00+00	15	23	46
440	2025-11-26	17:30:00	20:00:00	approved	2025-11-24 04:30:00+00	16	18	133
441	2026-03-27	19:30:00	21:30:00	pending	2026-03-15 11:58:11.37575+00	\N	10	150
442	2026-01-30	08:00:00	10:30:00	rejected	2026-01-24 05:00:00+00	14	77	167
443	2026-04-13	19:30:00	20:30:00	cancelled	2026-03-15 07:43:11.382731+00	\N	64	135
444	2026-02-08	15:00:00	17:00:00	approved	2026-01-26 04:00:00+00	15	1	26
445	2026-03-26	13:00:00	14:00:00	approved	2026-03-12 10:00:00+00	13	28	168
446	2026-03-10	08:30:00	11:00:00	approved	2026-03-02 13:30:00+00	12	1	65
447	2026-03-17	18:00:00	20:00:00	pending	2026-03-11 10:00:00+00	\N	64	81
448	2026-04-14	14:30:00	17:00:00	cancelled	2026-03-14 19:36:11.405495+00	\N	39	166
449	2025-11-19	11:30:00	12:30:00	approved	2025-10-31 20:30:00+00	12	53	140
450	2026-03-05	13:30:00	16:30:00	approved	2026-03-04 08:30:00+00	12	42	103
451	2026-03-21	17:00:00	18:30:00	cancelled	2026-03-07 01:00:00+00	\N	26	25
452	2026-01-16	16:00:00	20:00:00	approved	2025-12-30 12:00:00+00	12	70	128
453	2026-03-09	09:30:00	10:30:00	approved	2026-02-24 16:30:00+00	13	9	140
454	2026-02-17	11:00:00	12:30:00	approved	2026-02-14 10:00:00+00	9	25	113
455	2025-11-28	10:00:00	12:00:00	approved	2025-11-11 07:00:00+00	16	11	164
456	2026-03-04	17:30:00	19:30:00	approved	2026-02-22 15:30:00+00	12	7	165
457	2026-03-06	14:30:00	17:00:00	cancelled	2026-03-01 09:30:00+00	\N	78	71
458	2026-04-18	12:30:00	15:00:00	cancelled	2026-03-15 11:53:11.447093+00	\N	57	72
459	2026-02-13	19:30:00	20:30:00	cancelled	2026-02-07 05:30:00+00	\N	65	61
460	2026-04-16	11:00:00	14:00:00	rejected	2026-03-15 07:29:11.458381+00	9	34	30
461	2026-01-05	16:30:00	20:30:00	approved	2025-12-23 09:30:00+00	9	24	134
462	2026-03-02	19:00:00	21:00:00	approved	2026-02-24 04:00:00+00	16	14	157
463	2026-01-22	14:30:00	15:30:00	approved	2026-01-15 10:30:00+00	15	11	165
464	2026-02-20	15:00:00	16:30:00	rejected	2026-02-14 09:00:00+00	13	61	163
465	2026-02-16	13:30:00	14:30:00	cancelled	2026-02-10 22:30:00+00	\N	65	140
466	2026-01-26	18:00:00	19:30:00	approved	2026-01-18 17:00:00+00	15	27	124
467	2026-03-28	08:30:00	11:00:00	pending	2026-03-15 11:00:11.492252+00	\N	47	114
468	2026-04-02	16:30:00	19:30:00	pending	2026-03-15 12:15:11.496325+00	\N	11	84
469	2026-03-26	14:00:00	16:00:00	pending	2026-03-14 08:00:00+00	\N	63	113
470	2026-03-04	19:30:00	22:00:00	cancelled	2026-02-27 05:30:00+00	\N	27	162
471	2025-11-21	11:30:00	12:30:00	approved	2025-11-16 06:30:00+00	9	11	140
472	2026-04-16	15:00:00	19:00:00	rejected	2026-03-15 03:50:11.514126+00	15	4	46
473	2026-02-03	10:00:00	13:00:00	approved	2026-01-31 17:00:00+00	9	71	98
474	2025-11-29	08:00:00	10:00:00	approved	2025-11-21 04:00:00+00	13	15	113
475	2026-03-30	13:00:00	14:30:00	approved	2026-03-15 02:25:11.527531+00	14	8	41
476	2026-03-26	10:30:00	14:30:00	pending	2026-03-15 16:12:11.531687+00	\N	62	158
477	2026-02-14	11:30:00	14:30:00	approved	2026-02-09 04:30:00+00	16	54	71
478	2026-04-29	16:30:00	19:30:00	cancelled	2026-03-15 05:37:11.542839+00	\N	63	148
479	2026-01-30	10:30:00	13:00:00	approved	2026-01-26 04:30:00+00	14	23	148
480	2026-03-03	09:30:00	11:30:00	rejected	2026-02-25 03:30:00+00	15	26	169
481	2026-02-15	10:30:00	12:30:00	approved	2026-02-07 08:30:00+00	16	24	102
482	2026-03-10	12:00:00	14:00:00	approved	2026-02-26 11:00:00+00	15	10	150
483	2026-04-04	15:00:00	16:00:00	rejected	2026-03-15 03:10:11.567241+00	15	15	98
484	2025-11-18	10:00:00	12:00:00	approved	2025-11-14 14:00:00+00	16	32	92
485	2026-04-16	18:30:00	21:30:00	cancelled	2026-03-14 19:35:11.579264+00	\N	51	29
486	2026-03-28	14:30:00	17:30:00	approved	2026-03-15 11:37:11.583644+00	14	23	65
487	2026-03-19	11:00:00	14:00:00	cancelled	2026-03-09 03:00:00+00	\N	62	142
488	2026-03-28	09:30:00	11:00:00	pending	2026-03-15 09:57:11.594519+00	\N	24	113
489	2026-03-28	10:30:00	14:30:00	pending	2026-03-15 12:29:11.600313+00	\N	71	128
490	2026-02-06	19:00:00	21:30:00	approved	2026-01-22 18:00:00+00	16	41	11
491	2026-04-02	18:00:00	19:30:00	rejected	2026-03-14 23:43:11.612869+00	15	14	25
492	2026-02-16	11:00:00	14:00:00	rejected	2026-02-09 08:00:00+00	12	22	22
493	2025-12-20	08:30:00	12:30:00	approved	2025-12-14 22:30:00+00	13	74	117
494	2026-03-30	19:00:00	20:30:00	approved	2026-03-15 13:52:11.626329+00	12	24	143
495	2026-04-01	19:30:00	21:00:00	approved	2026-03-15 08:56:11.629662+00	9	61	157
496	2026-03-31	10:00:00	14:00:00	approved	2026-03-15 00:51:11.632969+00	14	47	65
497	2026-03-18	15:00:00	17:30:00	approved	2026-03-09 11:00:00+00	15	7	46
498	2026-01-30	15:00:00	17:00:00	approved	2026-01-17 03:00:00+00	14	28	146
499	2026-03-24	18:30:00	20:00:00	pending	2026-03-15 09:52:11.647028+00	\N	34	82
500	2026-02-12	14:00:00	15:30:00	approved	2026-02-03 07:00:00+00	15	24	20
501	2026-04-07	19:00:00	20:00:00	approved	2026-03-15 01:18:11.656953+00	12	11	128
502	2026-03-16	13:30:00	16:00:00	approved	2026-03-01 08:30:00+00	16	63	50
503	2026-03-13	12:30:00	16:30:00	rejected	2026-03-10 06:30:00+00	9	18	26
504	2026-02-06	19:30:00	22:00:00	rejected	2026-02-02 11:30:00+00	9	51	161
505	2026-02-02	10:00:00	14:00:00	approved	2026-01-30 07:00:00+00	15	55	47
507	2026-02-19	12:00:00	14:00:00	rejected	2026-02-10 09:00:00+00	9	16	11
508	2026-04-23	14:30:00	17:30:00	cancelled	2026-03-14 23:02:11.692186+00	\N	5	35
509	2026-04-01	10:30:00	13:00:00	pending	2026-03-15 05:43:11.696557+00	\N	42	104
510	2026-02-26	09:00:00	10:00:00	approved	2026-02-13 15:00:00+00	12	18	73
511	2026-02-01	11:30:00	13:30:00	approved	2026-01-21 00:30:00+00	9	67	71
512	2026-03-31	19:30:00	22:00:00	pending	2026-03-15 14:34:11.713485+00	\N	64	76
513	2025-12-25	14:30:00	17:00:00	approved	2025-12-19 04:30:00+00	13	28	113
514	2025-12-13	17:00:00	19:00:00	approved	2025-12-07 15:00:00+00	14	48	158
515	2026-04-05	12:00:00	15:00:00	rejected	2026-03-14 22:34:11.729503+00	14	61	88
516	2025-11-19	18:00:00	19:30:00	approved	2025-11-09 07:00:00+00	16	63	119
517	2026-02-20	11:30:00	13:00:00	rejected	2026-02-16 10:30:00+00	15	39	161
518	2026-03-03	13:30:00	15:30:00	approved	2026-02-22 03:30:00+00	9	34	72
519	2026-01-08	14:00:00	16:30:00	approved	2025-12-26 18:00:00+00	16	55	158
520	2026-02-10	10:00:00	11:30:00	approved	2026-01-23 06:00:00+00	13	70	36
521	2026-03-19	18:00:00	21:00:00	pending	2026-03-09 14:00:00+00	\N	34	98
522	2026-01-23	11:00:00	13:00:00	approved	2026-01-11 10:00:00+00	14	34	47
523	2026-03-23	10:30:00	13:00:00	pending	2026-03-15 02:30:00+00	\N	64	158
524	2026-01-05	12:30:00	13:30:00	approved	2025-12-31 01:30:00+00	14	39	150
525	2026-01-26	11:00:00	14:00:00	approved	2026-01-15 15:00:00+00	12	42	88
526	2026-04-02	18:30:00	22:00:00	cancelled	2026-03-14 20:56:11.779326+00	\N	15	134
527	2026-03-03	09:30:00	12:00:00	approved	2026-02-19 07:30:00+00	12	55	43
528	2026-04-06	19:30:00	22:00:00	approved	2026-03-14 21:55:11.792718+00	13	25	54
529	2026-02-04	09:30:00	13:30:00	approved	2026-01-20 18:30:00+00	13	12	88
530	2026-01-20	19:00:00	22:00:00	approved	2026-01-05 01:00:00+00	12	50	94
531	2026-04-15	16:30:00	20:30:00	rejected	2026-03-14 20:13:11.811354+00	9	76	163
532	2025-11-15	12:30:00	16:30:00	approved	2025-11-02 04:30:00+00	15	22	67
533	2026-03-01	17:30:00	19:30:00	cancelled	2026-02-26 09:30:00+00	\N	52	108
534	2025-12-19	15:00:00	17:00:00	approved	2025-12-15 09:00:00+00	15	55	47
535	2026-01-03	19:00:00	21:30:00	approved	2025-12-20 14:00:00+00	16	1	72
536	2026-03-16	16:30:00	17:30:00	rejected	2026-03-07 08:30:00+00	12	63	122
537	2026-01-31	18:00:00	21:00:00	rejected	2026-01-25 14:00:00+00	16	3	128
538	2026-04-08	17:00:00	18:00:00	approved	2026-03-15 03:53:11.857158+00	16	60	82
539	2025-12-28	12:30:00	15:00:00	approved	2025-12-24 23:30:00+00	12	69	150
540	2026-01-11	13:00:00	15:30:00	approved	2025-12-24 07:00:00+00	16	5	62
541	2025-12-20	11:30:00	15:30:00	approved	2025-12-14 20:30:00+00	9	7	126
543	2025-12-03	17:30:00	20:00:00	approved	2025-11-30 06:30:00+00	16	16	113
544	2026-04-05	17:00:00	18:00:00	pending	2026-03-15 01:12:11.887231+00	\N	37	43
545	2026-04-25	12:00:00	13:00:00	cancelled	2026-03-15 00:05:11.895501+00	\N	77	113
546	2025-12-06	18:30:00	21:30:00	approved	2025-11-28 04:30:00+00	15	28	164
547	2026-03-17	09:00:00	10:30:00	pending	2026-03-11 06:00:00+00	\N	34	122
548	2026-02-02	12:00:00	13:30:00	approved	2026-01-15 08:00:00+00	16	48	154
549	2026-04-01	13:30:00	16:00:00	pending	2026-03-15 17:13:11.918477+00	\N	32	151
550	2026-03-24	17:00:00	21:00:00	pending	2026-03-14 20:36:11.923575+00	\N	52	158
551	2026-02-24	11:00:00	15:00:00	rejected	2026-02-21 09:00:00+00	13	35	54
552	2026-03-17	16:00:00	18:00:00	rejected	2026-03-10 12:00:00+00	13	41	109
553	2026-03-23	10:30:00	12:00:00	approved	2026-03-07 05:30:00+00	12	6	166
554	2026-02-24	14:30:00	16:00:00	cancelled	2026-02-17 03:30:00+00	\N	8	37
555	2026-02-23	17:00:00	18:30:00	approved	2026-02-22 01:00:00+00	13	49	123
556	2026-01-30	14:00:00	15:00:00	approved	2026-01-28 12:00:00+00	12	32	126
557	2025-12-31	10:30:00	12:00:00	approved	2025-12-19 08:30:00+00	13	5	148
558	2026-02-15	16:00:00	18:00:00	approved	2026-02-13 13:00:00+00	14	68	46
559	2026-02-17	10:30:00	11:30:00	cancelled	2026-02-08 09:30:00+00	\N	67	53
560	2026-04-12	11:30:00	14:00:00	approved	2026-03-15 19:21:11.967541+00	16	5	148
561	2026-04-13	12:30:00	14:00:00	approved	2026-03-14 22:21:11.970328+00	14	15	148
562	2026-03-26	14:00:00	18:00:00	cancelled	2026-03-15 12:26:11.976346+00	\N	61	63
563	2026-02-27	09:30:00	13:30:00	approved	2026-02-21 14:30:00+00	12	55	114
564	2026-04-18	14:00:00	18:00:00	rejected	2026-03-15 00:27:11.984875+00	16	5	98
565	2026-01-26	16:00:00	18:00:00	approved	2026-01-16 15:00:00+00	12	17	86
566	2025-12-24	13:00:00	15:00:00	approved	2025-12-19 19:00:00+00	14	55	158
567	2026-03-24	15:00:00	17:00:00	pending	2026-03-15 15:11:11.9987+00	\N	11	46
568	2026-03-30	11:00:00	14:00:00	cancelled	2026-03-15 00:12:12.001402+00	\N	51	155
569	2026-01-25	11:30:00	15:30:00	approved	2026-01-14 00:30:00+00	15	72	113
570	2026-01-03	08:00:00	10:30:00	approved	2025-12-31 04:00:00+00	13	19	71
571	2025-11-23	18:00:00	20:00:00	approved	2025-11-18 14:00:00+00	16	21	34
572	2026-02-23	12:30:00	13:30:00	rejected	2026-02-18 04:30:00+00	9	60	34
573	2026-04-24	08:00:00	09:00:00	cancelled	2026-03-15 13:31:12.022483+00	\N	4	121
574	2026-02-19	15:00:00	16:00:00	cancelled	2026-02-06 11:00:00+00	\N	38	109
575	2026-03-02	09:30:00	10:30:00	rejected	2026-02-24 08:30:00+00	16	37	162
576	2026-04-14	18:30:00	20:00:00	approved	2026-03-15 02:46:12.035992+00	12	21	71
577	2025-12-13	16:30:00	17:30:00	approved	2025-12-05 23:30:00+00	12	4	115
578	2026-02-04	14:00:00	15:30:00	approved	2026-02-02 00:00:00+00	14	34	126
579	2026-03-07	11:30:00	12:30:00	approved	2026-03-02 16:30:00+00	14	32	60
580	2026-04-06	10:30:00	13:00:00	rejected	2026-03-14 22:27:12.051234+00	13	12	107
581	2026-04-02	11:00:00	13:30:00	pending	2026-03-15 04:40:12.055847+00	\N	42	63
582	2026-04-25	19:00:00	20:30:00	cancelled	2026-03-14 19:37:12.061834+00	\N	59	19
583	2026-03-26	14:30:00	17:30:00	cancelled	2026-03-15 06:30:00+00	\N	50	134
584	2026-03-27	11:30:00	14:00:00	pending	2026-03-14 21:24:12.071291+00	\N	11	126
585	2026-02-22	08:00:00	09:00:00	approved	2026-02-09 12:00:00+00	15	65	48
586	2026-01-09	09:00:00	13:00:00	approved	2025-12-29 16:00:00+00	9	4	87
587	2025-12-20	11:30:00	12:30:00	approved	2025-12-04 02:30:00+00	14	55	151
588	2026-02-15	08:00:00	09:30:00	approved	2026-02-05 07:00:00+00	15	11	131
589	2026-02-13	12:30:00	15:00:00	approved	2026-02-09 11:30:00+00	15	67	40
590	2025-12-10	11:30:00	12:30:00	approved	2025-11-26 08:30:00+00	14	19	163
591	2025-12-07	19:00:00	22:00:00	approved	2025-12-03 08:00:00+00	14	5	29
592	2026-03-08	08:00:00	10:30:00	approved	2026-02-24 06:00:00+00	12	55	158
593	2026-02-03	12:00:00	14:30:00	rejected	2026-02-01 11:00:00+00	14	17	173
594	2026-01-09	11:30:00	15:30:00	approved	2025-12-25 08:30:00+00	14	54	146
595	2026-03-31	11:30:00	14:30:00	pending	2026-03-15 12:14:12.11958+00	\N	8	158
596	2026-03-19	13:30:00	16:00:00	cancelled	2026-03-13 09:30:00+00	\N	2	20
597	2026-03-10	10:00:00	13:00:00	approved	2026-03-03 19:00:00+00	9	62	151
598	2026-02-10	10:30:00	12:30:00	approved	2026-01-27 01:30:00+00	15	60	126
599	2026-04-09	10:30:00	12:00:00	cancelled	2026-03-15 11:56:12.135432+00	\N	64	49
600	2026-04-04	16:30:00	20:30:00	pending	2026-03-15 06:41:12.142852+00	\N	58	157
601	2026-01-07	08:00:00	11:00:00	approved	2025-12-27 16:00:00+00	9	48	108
602	2026-03-09	18:00:00	22:00:00	approved	2026-03-03 15:00:00+00	15	37	165
603	2026-03-29	16:30:00	18:30:00	approved	2026-03-13 09:30:00+00	14	64	126
604	2026-03-05	18:00:00	19:30:00	approved	2026-03-02 03:00:00+00	15	28	173
605	2026-02-13	09:30:00	12:00:00	rejected	2026-02-10 02:30:00+00	13	30	168
606	2025-12-15	14:00:00	17:00:00	approved	2025-12-06 10:00:00+00	13	58	165
607	2026-03-25	14:30:00	15:30:00	pending	2026-03-15 01:45:12.174767+00	\N	33	163
608	2026-03-14	09:30:00	11:30:00	rejected	2026-03-05 01:30:00+00	15	56	144
609	2026-01-19	09:30:00	13:30:00	approved	2026-01-09 07:30:00+00	14	14	79
610	2026-02-20	16:00:00	18:30:00	approved	2026-02-03 00:00:00+00	9	55	55
611	2026-02-24	10:30:00	12:00:00	approved	2026-02-12 19:30:00+00	14	24	89
612	2026-03-08	11:00:00	14:00:00	rejected	2026-03-05 06:00:00+00	9	33	123
613	2026-04-13	17:00:00	19:00:00	approved	2026-03-15 07:58:12.202127+00	15	60	75
614	2026-03-30	08:30:00	10:30:00	pending	2026-03-14 23:04:12.206156+00	\N	26	85
615	2026-03-23	17:00:00	19:30:00	cancelled	2026-03-14 22:20:12.211499+00	\N	49	106
616	2026-01-21	13:30:00	16:30:00	approved	2026-01-09 01:30:00+00	13	55	91
617	2026-04-26	13:00:00	15:30:00	cancelled	2026-03-14 20:27:12.217081+00	\N	10	163
618	2026-01-26	09:00:00	10:30:00	approved	2026-01-08 08:00:00+00	12	5	82
619	2026-02-20	17:00:00	19:00:00	approved	2026-02-06 13:00:00+00	12	34	125
620	2025-12-04	08:30:00	09:30:00	approved	2025-11-25 07:30:00+00	13	34	110
621	2026-03-03	18:30:00	20:30:00	approved	2026-02-15 10:30:00+00	16	64	107
622	2026-04-08	08:30:00	09:30:00	approved	2026-03-15 15:20:12.246601+00	13	72	173
623	2026-02-23	19:30:00	21:00:00	approved	2026-02-22 03:30:00+00	13	28	160
624	2026-04-16	14:00:00	16:30:00	rejected	2026-03-14 20:14:12.253147+00	15	25	71
625	2026-02-17	11:30:00	13:00:00	rejected	2026-02-08 08:30:00+00	14	6	166
626	2025-12-02	10:00:00	12:00:00	approved	2025-11-19 20:00:00+00	15	58	36
627	2026-01-16	16:00:00	17:30:00	approved	2025-12-31 03:00:00+00	13	1	98
628	2025-12-24	08:30:00	10:30:00	approved	2025-12-22 19:30:00+00	14	63	109
629	2026-03-30	14:00:00	17:00:00	pending	2026-03-14 21:56:12.278805+00	\N	32	144
630	2026-02-06	15:00:00	18:00:00	approved	2026-01-27 23:00:00+00	9	28	43
631	2026-03-12	19:30:00	22:00:00	rejected	2026-03-05 12:30:00+00	14	24	47
632	2025-12-10	11:00:00	13:00:00	approved	2025-12-08 02:00:00+00	13	48	47
633	2026-04-03	09:30:00	13:30:00	pending	2026-03-15 13:24:12.294919+00	\N	46	131
634	2026-03-17	14:00:00	15:30:00	pending	2026-03-15 03:00:00+00	\N	22	95
635	2025-12-21	17:00:00	19:00:00	approved	2025-12-15 08:00:00+00	13	67	174
636	2026-03-18	13:00:00	16:00:00	pending	2026-03-08 10:00:00+00	\N	76	113
637	2026-03-30	15:00:00	18:00:00	cancelled	2026-03-15 06:01:12.310794+00	\N	44	165
638	2026-04-07	19:00:00	21:00:00	cancelled	2026-03-14 22:42:12.316086+00	\N	36	122
639	2026-03-17	08:30:00	11:00:00	pending	2026-03-05 22:30:00+00	\N	32	168
640	2025-12-26	08:00:00	11:00:00	approved	2025-12-12 06:00:00+00	12	21	150
641	2026-01-05	17:30:00	18:30:00	approved	2026-01-03 16:30:00+00	9	23	17
642	2026-03-06	08:00:00	10:00:00	approved	2026-02-25 16:00:00+00	13	48	136
643	2026-03-29	11:00:00	15:00:00	approved	2026-03-11 15:00:00+00	14	61	148
644	2026-03-26	16:30:00	18:00:00	pending	2026-03-15 17:54:12.347236+00	\N	59	170
645	2026-03-27	10:00:00	14:00:00	cancelled	2026-03-15 06:00:12.353223+00	\N	9	157
646	2026-02-04	17:30:00	19:30:00	approved	2026-01-17 00:30:00+00	15	32	134
647	2026-01-01	17:30:00	19:00:00	approved	2025-12-19 11:30:00+00	12	61	113
648	2026-03-26	19:00:00	21:00:00	pending	2026-03-14 22:22:12.366592+00	\N	42	144
649	2025-12-22	12:00:00	13:00:00	approved	2025-12-15 09:00:00+00	9	73	44
650	2026-03-20	12:00:00	13:30:00	approved	2026-03-15 11:35:12.37383+00	16	55	108
651	2026-01-23	08:30:00	10:30:00	approved	2026-01-19 07:30:00+00	12	61	140
652	2025-11-29	10:00:00	12:30:00	approved	2025-11-27 01:00:00+00	14	5	169
653	2026-01-16	17:30:00	20:30:00	approved	2025-12-31 09:30:00+00	9	11	156
654	2026-02-25	19:30:00	22:00:00	approved	2026-02-07 07:30:00+00	14	11	158
655	2026-03-07	11:00:00	13:30:00	approved	2026-03-04 22:00:00+00	9	24	72
656	2026-03-24	17:00:00	19:30:00	cancelled	2026-03-11 03:00:00+00	\N	52	66
657	2026-01-21	10:00:00	13:00:00	approved	2026-01-03 16:00:00+00	15	63	43
658	2026-04-04	16:00:00	19:00:00	approved	2026-03-15 04:14:12.403887+00	15	41	133
659	2026-04-06	10:00:00	13:00:00	approved	2026-03-15 00:09:12.410781+00	14	38	137
660	2026-01-26	14:30:00	17:30:00	approved	2026-01-11 19:30:00+00	16	42	159
661	2025-12-28	18:30:00	19:30:00	approved	2025-12-15 08:30:00+00	13	63	47
662	2026-01-16	18:00:00	22:00:00	approved	2026-01-15 05:00:00+00	12	26	113
663	2026-04-05	16:30:00	19:00:00	pending	2026-03-15 09:02:12.429678+00	\N	69	150
664	2026-03-28	17:30:00	20:30:00	approved	2026-03-15 14:52:12.438344+00	12	24	45
665	2026-04-02	16:30:00	18:30:00	pending	2026-03-15 13:36:12.44526+00	\N	24	46
666	2026-04-13	19:00:00	21:30:00	cancelled	2026-03-15 11:09:12.451756+00	\N	22	48
667	2026-03-15	16:30:00	19:30:00	cancelled	2026-03-03 13:30:00+00	\N	48	26
668	2025-12-04	16:30:00	17:30:00	approved	2025-11-18 11:30:00+00	12	69	94
669	2025-12-06	19:30:00	21:30:00	approved	2025-11-30 16:30:00+00	9	24	18
670	2026-02-05	17:30:00	19:30:00	approved	2026-01-25 04:30:00+00	15	7	51
671	2026-04-04	09:30:00	12:30:00	rejected	2026-03-15 16:13:12.470922+00	16	34	46
672	2025-12-02	15:30:00	19:30:00	approved	2025-11-25 23:30:00+00	13	63	158
673	2026-01-19	11:00:00	12:00:00	approved	2026-01-15 02:00:00+00	12	71	43
674	2026-03-19	16:30:00	20:30:00	pending	2026-03-15 11:30:00+00	\N	23	70
675	2026-03-15	17:30:00	19:00:00	cancelled	2026-03-01 00:30:00+00	\N	24	49
676	2026-01-23	16:30:00	17:30:00	approved	2026-01-12 08:30:00+00	14	1	65
677	2026-04-11	19:00:00	21:30:00	approved	2026-03-14 23:06:12.500337+00	15	24	48
678	2026-03-14	15:00:00	16:30:00	rejected	2026-03-08 14:00:00+00	12	56	25
679	2026-03-24	14:00:00	16:30:00	pending	2026-03-15 08:54:12.510363+00	\N	24	39
680	2026-03-18	18:30:00	21:00:00	pending	2026-03-06 08:30:00+00	\N	55	124
681	2026-01-16	08:30:00	12:30:00	approved	2026-01-01 14:30:00+00	9	46	2
682	2026-01-05	09:00:00	13:00:00	approved	2025-12-22 08:00:00+00	9	36	2
683	2026-01-07	19:00:00	21:30:00	approved	2026-01-04 16:00:00+00	9	24	2
684	2025-12-07	14:00:00	18:00:00	approved	2025-11-20 05:00:00+00	9	26	2
685	2026-01-07	14:00:00	16:30:00	approved	2026-01-02 03:00:00+00	9	11	2
686	2026-01-03	17:00:00	21:00:00	approved	2025-12-16 08:00:00+00	9	58	2
687	2025-11-21	16:00:00	17:00:00	approved	2025-11-14 04:00:00+00	9	52	2
688	2026-03-10	18:00:00	20:00:00	approved	2026-02-27 04:00:00+00	9	17	2
689	2025-12-11	16:00:00	18:30:00	approved	2025-12-02 11:00:00+00	9	49	2
690	2025-12-04	09:30:00	12:30:00	approved	2025-12-02 19:30:00+00	9	53	2
691	2025-11-15	09:30:00	11:00:00	approved	2025-11-08 03:30:00+00	9	8	2
692	2025-10-08	15:00:00	17:30:00	approved	2025-09-23 21:00:00+00	9	46	2
693	2025-11-24	10:30:00	13:00:00	approved	2025-11-17 06:30:00+00	9	30	2
694	2025-11-15	08:30:00	10:30:00	approved	2025-11-06 16:30:00+00	9	47	2
695	2026-01-23	19:30:00	22:00:00	approved	2026-01-07 03:30:00+00	9	4	2
696	2025-11-30	08:30:00	12:30:00	approved	2025-11-18 20:30:00+00	9	49	2
697	2025-11-28	13:00:00	15:00:00	approved	2025-11-22 22:00:00+00	9	49	2
698	2025-12-11	11:00:00	13:30:00	approved	2025-12-10 04:00:00+00	9	52	2
699	2025-12-25	08:00:00	10:30:00	approved	2025-12-22 18:00:00+00	9	34	2
700	2026-01-24	12:30:00	15:00:00	approved	2026-01-20 02:30:00+00	9	62	2
701	2025-11-01	17:00:00	19:00:00	approved	2025-10-25 14:00:00+00	9	58	2
702	2025-10-27	17:30:00	21:30:00	approved	2025-10-12 23:30:00+00	9	9	2
703	2025-11-18	13:00:00	14:30:00	approved	2025-11-02 09:00:00+00	9	75	2
704	2025-11-08	10:00:00	11:30:00	approved	2025-10-28 04:00:00+00	9	36	2
705	2025-10-25	11:00:00	13:00:00	approved	2025-10-23 16:00:00+00	9	5	2
706	2026-02-09	19:00:00	22:00:00	approved	2026-02-05 01:00:00+00	9	49	2
707	2026-01-13	14:00:00	15:00:00	approved	2026-01-11 20:00:00+00	9	66	2
708	2025-12-25	12:00:00	13:00:00	approved	2025-12-08 03:00:00+00	9	78	2
709	2026-02-02	17:00:00	21:00:00	approved	2026-01-22 00:00:00+00	9	9	2
710	2025-10-30	13:30:00	15:00:00	approved	2025-10-15 07:30:00+00	9	57	2
711	2026-02-03	10:00:00	12:30:00	approved	2026-01-16 23:00:00+00	9	39	2
712	2026-03-01	15:00:00	17:30:00	approved	2026-02-19 14:00:00+00	9	75	2
713	2025-10-22	18:00:00	20:00:00	approved	2025-10-19 16:00:00+00	9	2	2
714	2026-02-07	14:30:00	18:30:00	approved	2026-01-24 22:30:00+00	9	34	2
715	2025-11-01	08:30:00	11:30:00	approved	2025-10-30 23:30:00+00	9	5	2
716	2025-10-07	09:30:00	11:00:00	approved	2025-09-28 05:30:00+00	9	2	2
717	2026-02-01	13:00:00	16:00:00	approved	2026-01-21 12:00:00+00	9	59	2
718	2025-11-14	15:30:00	17:30:00	approved	2025-11-13 13:30:00+00	9	38	2
719	2025-10-27	19:30:00	22:00:00	approved	2025-10-18 10:30:00+00	9	46	2
720	2026-01-28	19:30:00	22:00:00	approved	2026-01-18 16:30:00+00	9	49	2
721	2026-02-28	12:00:00	14:00:00	approved	2026-02-14 19:00:00+00	9	75	2
722	2025-10-21	09:30:00	11:00:00	approved	2025-10-07 15:30:00+00	9	4	2
723	2026-02-03	15:00:00	16:00:00	approved	2026-01-18 07:00:00+00	9	63	2
724	2025-11-18	16:00:00	18:00:00	approved	2025-11-01 07:00:00+00	9	75	2
725	2025-12-16	15:00:00	16:00:00	approved	2025-12-11 19:00:00+00	9	20	2
726	2025-10-22	11:00:00	12:00:00	approved	2025-10-08 05:00:00+00	9	47	2
727	2026-03-05	16:30:00	18:00:00	approved	2026-02-17 15:30:00+00	9	59	2
728	2025-10-22	10:30:00	13:30:00	approved	2025-10-20 09:30:00+00	9	46	2
729	2025-10-08	19:30:00	22:00:00	approved	2025-09-24 23:30:00+00	9	58	2
730	2025-12-23	13:30:00	16:30:00	approved	2025-12-21 11:30:00+00	9	72	2
731	2026-01-07	08:00:00	10:30:00	approved	2025-12-24 03:00:00+00	9	71	2
732	2025-11-08	14:00:00	17:00:00	approved	2025-10-21 23:00:00+00	9	78	2
733	2026-03-08	15:30:00	17:00:00	approved	2026-03-07 06:30:00+00	9	68	2
734	2025-11-25	11:00:00	12:00:00	approved	2025-11-11 20:00:00+00	9	46	2
735	2026-01-24	18:00:00	19:30:00	approved	2026-01-20 17:00:00+00	9	19	2
736	2026-01-20	08:30:00	10:30:00	approved	2026-01-14 20:30:00+00	9	62	2
737	2025-12-28	10:30:00	13:30:00	approved	2025-12-18 20:30:00+00	9	15	2
738	2026-01-16	09:30:00	10:30:00	approved	2026-01-03 08:30:00+00	9	18	2
739	2026-03-04	17:00:00	18:00:00	approved	2026-03-03 04:00:00+00	9	59	2
740	2025-12-11	10:00:00	11:00:00	approved	2025-12-10 08:00:00+00	9	9	2
741	2025-10-07	15:30:00	17:00:00	approved	2025-09-25 00:30:00+00	9	15	2
742	2026-02-24	17:30:00	21:30:00	approved	2026-02-09 12:30:00+00	9	32	2
743	2025-10-15	10:30:00	14:30:00	approved	2025-10-11 00:30:00+00	9	2	2
744	2026-01-10	11:00:00	13:00:00	approved	2025-12-30 16:00:00+00	9	34	2
745	2025-10-19	10:30:00	13:00:00	approved	2025-10-02 18:30:00+00	9	2	2
746	2025-11-09	15:30:00	19:30:00	approved	2025-11-05 20:30:00+00	9	19	2
747	2025-11-26	13:30:00	15:00:00	approved	2025-11-23 23:30:00+00	9	17	2
748	2025-12-10	16:30:00	17:30:00	approved	2025-11-23 03:30:00+00	9	36	2
749	2026-03-02	18:30:00	20:30:00	approved	2026-02-27 07:30:00+00	9	48	2
750	2025-11-24	15:30:00	17:00:00	approved	2025-11-10 01:30:00+00	9	42	2
751	2025-12-29	14:30:00	15:30:00	approved	2025-12-22 08:30:00+00	9	75	2
752	2025-10-18	12:00:00	14:00:00	approved	2025-10-15 09:00:00+00	9	46	2
753	2026-03-06	09:30:00	12:00:00	approved	2026-02-25 08:30:00+00	9	2	2
754	2025-12-04	14:30:00	17:30:00	approved	2025-11-26 03:30:00+00	9	76	2
755	2025-12-09	16:30:00	20:30:00	approved	2025-12-01 15:30:00+00	9	52	2
756	2025-11-24	10:30:00	12:00:00	approved	2025-11-15 18:30:00+00	9	76	2
757	2025-11-19	12:00:00	16:00:00	approved	2025-11-15 00:00:00+00	9	46	2
758	2025-11-15	08:30:00	10:00:00	approved	2025-11-12 00:30:00+00	9	52	2
759	2026-02-10	18:00:00	20:30:00	approved	2026-01-29 00:00:00+00	9	75	2
760	2025-12-04	18:00:00	21:00:00	approved	2025-12-01 08:00:00+00	9	49	2
761	2026-02-06	13:30:00	16:00:00	approved	2026-01-24 02:30:00+00	9	34	2
762	2025-11-22	10:00:00	12:00:00	approved	2025-11-09 08:00:00+00	9	52	2
763	2025-11-23	12:00:00	13:00:00	approved	2025-11-12 00:00:00+00	9	58	2
764	2025-11-23	16:30:00	18:30:00	approved	2025-11-18 11:30:00+00	9	58	2
765	2026-01-08	08:30:00	10:00:00	approved	2026-01-04 05:30:00+00	9	52	2
766	2026-01-02	16:30:00	18:00:00	approved	2025-12-20 04:30:00+00	9	62	2
767	2026-02-24	19:00:00	20:30:00	approved	2026-02-06 09:00:00+00	9	48	2
768	2025-11-10	11:30:00	13:30:00	approved	2025-11-09 05:30:00+00	9	57	2
769	2026-03-06	08:00:00	09:30:00	approved	2026-02-28 13:00:00+00	9	58	2
770	2025-11-23	19:30:00	22:00:00	approved	2025-11-20 17:30:00+00	9	12	2
771	2026-03-10	08:30:00	10:00:00	approved	2026-03-05 01:30:00+00	9	54	2
772	2025-10-31	19:00:00	21:00:00	approved	2025-10-30 05:00:00+00	9	34	2
773	2025-12-21	17:00:00	19:30:00	approved	2025-12-04 13:00:00+00	9	58	2
774	2026-01-24	19:00:00	22:00:00	approved	2026-01-18 04:00:00+00	9	62	2
775	2025-10-29	13:30:00	15:30:00	approved	2025-10-22 02:30:00+00	9	6	2
776	2025-11-09	17:30:00	20:00:00	approved	2025-11-02 08:30:00+00	9	70	2
777	2026-02-03	14:00:00	15:30:00	approved	2026-01-29 06:00:00+00	9	2	2
778	2025-11-14	19:30:00	22:00:00	approved	2025-10-31 04:30:00+00	9	34	2
779	2026-01-01	13:00:00	16:00:00	approved	2025-12-15 12:00:00+00	9	9	2
780	2025-10-17	18:00:00	21:00:00	approved	2025-10-03 00:00:00+00	9	51	2
781	2026-01-31	17:30:00	21:30:00	approved	2026-01-23 04:30:00+00	9	34	2
782	2026-02-23	13:30:00	14:30:00	approved	2026-02-09 04:30:00+00	9	36	2
783	2026-02-10	17:00:00	19:00:00	approved	2026-01-24 14:00:00+00	9	15	2
784	2026-01-11	14:00:00	15:00:00	approved	2026-01-02 20:00:00+00	9	37	2
785	2025-10-26	15:00:00	17:00:00	approved	2025-10-19 13:00:00+00	9	15	2
786	2025-10-29	14:00:00	16:30:00	approved	2025-10-10 22:00:00+00	9	64	2
787	2025-11-02	15:00:00	17:00:00	approved	2025-10-26 06:00:00+00	9	71	2
788	2026-02-01	13:00:00	14:30:00	approved	2026-01-22 09:00:00+00	9	49	2
789	2026-02-21	08:00:00	09:00:00	approved	2026-02-11 18:00:00+00	9	34	2
790	2025-10-29	13:00:00	15:30:00	approved	2025-10-14 05:00:00+00	9	61	2
791	2026-01-19	17:00:00	18:00:00	approved	2026-01-13 05:00:00+00	9	52	2
792	2025-10-23	16:00:00	19:00:00	approved	2025-10-19 10:00:00+00	9	75	2
793	2025-11-28	15:30:00	18:30:00	approved	2025-11-12 23:30:00+00	9	9	2
794	2026-04-12	16:30:00	18:30:00	approved	2026-03-15 00:48:18.489003+00	9	64	2
795	2026-03-26	14:30:00	15:30:00	approved	2026-03-15 15:23:18.492224+00	9	52	2
796	2026-04-09	13:30:00	17:30:00	approved	2026-03-15 02:38:18.494387+00	9	15	2
797	2026-04-07	10:00:00	14:00:00	approved	2026-03-15 09:33:18.496397+00	9	71	2
798	2026-04-01	11:00:00	12:00:00	approved	2026-03-15 07:08:18.499365+00	9	8	2
799	2026-04-13	09:00:00	11:00:00	approved	2026-03-15 17:36:18.502511+00	9	28	2
800	2026-04-03	16:00:00	19:00:00	approved	2026-03-15 10:20:18.5047+00	9	5	2
801	2026-04-09	09:30:00	11:30:00	approved	2026-03-15 10:03:18.506728+00	9	11	2
802	2026-03-25	15:00:00	19:00:00	approved	2026-03-15 06:56:18.508699+00	9	13	2
803	2026-03-17	15:30:00	19:30:00	approved	2026-03-11 21:30:00+00	9	17	2
804	2026-04-14	15:30:00	17:30:00	approved	2026-03-15 18:18:18.512463+00	9	17	2
805	2026-03-19	16:00:00	18:30:00	approved	2026-03-15 09:00:00+00	9	46	2
806	2026-04-04	16:30:00	19:00:00	approved	2026-03-15 04:15:18.517004+00	9	10	2
807	2026-04-10	15:00:00	17:00:00	approved	2026-03-15 15:42:18.520775+00	9	9	2
808	2026-03-23	15:00:00	19:00:00	approved	2026-03-14 23:00:00+00	9	25	2
809	2026-03-19	09:30:00	10:30:00	approved	2026-03-15 00:40:18.525488+00	9	42	2
810	2026-03-18	19:30:00	22:00:00	approved	2026-03-10 06:30:00+00	9	64	2
811	2026-04-01	09:30:00	13:30:00	approved	2026-03-14 20:08:18.529625+00	9	75	2
812	2026-03-23	13:30:00	17:30:00	approved	2026-03-09 03:30:00+00	9	4	2
813	2026-03-24	16:00:00	20:00:00	approved	2026-03-08 00:00:00+00	9	4	2
814	2026-04-09	13:00:00	14:30:00	approved	2026-03-15 03:08:18.538432+00	9	71	2
815	2026-03-28	17:30:00	20:00:00	approved	2026-03-15 18:25:18.540562+00	9	17	2
816	2026-04-18	18:00:00	21:00:00	approved	2026-03-15 00:51:18.542683+00	9	34	2
817	2026-04-06	19:00:00	21:00:00	approved	2026-03-15 11:31:18.54468+00	9	15	2
818	2026-03-27	18:00:00	20:00:00	approved	2026-03-09 11:00:00+00	9	19	2
819	2026-03-23	14:30:00	17:30:00	approved	2026-03-15 07:30:00+00	9	71	2
820	2026-04-02	17:00:00	19:00:00	approved	2026-03-14 21:13:18.553351+00	9	9	2
821	2026-03-18	13:30:00	17:30:00	approved	2026-03-03 17:30:00+00	9	46	2
822	2026-04-18	13:00:00	15:00:00	approved	2026-03-15 00:16:18.557871+00	9	42	2
823	2026-03-29	15:00:00	16:30:00	approved	2026-03-15 17:49:18.560035+00	9	62	2
824	2026-03-27	19:00:00	22:00:00	approved	2026-03-15 01:39:18.562098+00	9	38	2
825	2026-03-31	16:30:00	18:30:00	approved	2026-03-15 16:23:18.564792+00	9	48	2
826	2026-04-17	17:00:00	20:00:00	approved	2026-03-15 00:12:18.568639+00	9	34	2
827	2026-03-20	16:30:00	19:00:00	approved	2026-03-09 05:30:00+00	9	78	2
828	2026-03-28	13:30:00	16:30:00	approved	2026-03-10 09:30:00+00	9	28	2
829	2026-04-19	11:30:00	13:00:00	approved	2026-03-15 02:40:18.575586+00	9	69	2
830	2026-03-23	15:00:00	18:00:00	approved	2026-03-11 11:00:00+00	9	34	2
831	2026-03-29	13:30:00	14:30:00	approved	2026-03-14 22:21:18.579326+00	9	58	2
832	2026-04-04	14:00:00	15:30:00	approved	2026-03-15 04:37:18.581617+00	9	2	2
833	2026-04-19	14:00:00	18:00:00	approved	2026-03-15 12:23:18.584702+00	9	17	2
834	2026-04-19	09:30:00	13:30:00	approved	2026-03-15 11:37:18.587207+00	9	62	2
835	2026-03-30	10:00:00	12:00:00	approved	2026-03-15 13:51:18.589264+00	9	38	2
836	2026-04-18	12:30:00	14:30:00	approved	2026-03-15 11:29:18.591123+00	9	74	2
837	2026-03-26	18:00:00	20:00:00	approved	2026-03-15 11:24:18.593003+00	9	4	2
838	2026-04-09	13:30:00	15:00:00	approved	2026-03-15 06:37:18.594765+00	9	36	2
839	2026-03-17	15:30:00	17:00:00	approved	2026-02-27 22:30:00+00	9	9	2
840	2026-03-20	10:30:00	12:30:00	approved	2026-03-09 00:30:00+00	9	15	2
841	2026-04-19	08:00:00	10:30:00	approved	2026-03-15 13:28:18.60073+00	9	49	2
842	2026-03-17	09:30:00	12:30:00	approved	2026-03-05 23:30:00+00	9	28	2
843	2026-03-22	14:30:00	18:30:00	approved	2026-03-11 12:30:00+00	9	49	2
844	2026-03-18	15:00:00	16:00:00	approved	2026-03-15 05:05:18.608508+00	9	54	2
845	2026-03-24	19:30:00	22:00:00	approved	2026-03-06 03:30:00+00	9	71	2
846	2026-04-02	16:00:00	18:00:00	approved	2026-03-15 12:52:18.612202+00	9	2	2
847	2026-03-26	11:30:00	15:30:00	approved	2026-03-09 00:30:00+00	9	6	2
848	2026-03-25	13:00:00	16:00:00	approved	2026-03-14 21:27:18.61677+00	9	75	2
849	2026-03-28	17:00:00	19:00:00	approved	2026-03-15 14:54:18.619613+00	9	6	2
850	2026-04-02	14:00:00	17:00:00	approved	2026-03-15 06:09:18.622339+00	9	58	2
851	2026-04-15	08:30:00	09:30:00	approved	2026-03-15 11:26:18.624195+00	9	34	2
852	2026-04-03	14:00:00	15:00:00	approved	2026-03-15 05:56:18.626179+00	9	42	2
853	2026-04-03	10:00:00	12:30:00	approved	2026-03-15 15:00:00+00	9	2	2
854	2026-03-29	17:00:00	19:00:00	approved	2026-03-15 08:46:18.630158+00	9	75	2
855	2026-03-26	11:00:00	12:00:00	approved	2026-03-10 20:00:00+00	9	46	2
856	2026-04-03	14:30:00	16:00:00	approved	2026-03-15 11:21:18.635071+00	9	25	2
857	2026-04-03	13:30:00	16:00:00	approved	2026-03-14 20:56:18.637973+00	9	62	2
858	2026-04-08	12:30:00	14:00:00	approved	2026-03-14 21:23:18.639891+00	9	27	2
859	2026-03-18	19:00:00	22:00:00	approved	2026-03-07 02:00:00+00	9	17	2
860	2026-03-28	14:30:00	18:30:00	approved	2026-03-15 05:09:18.643565+00	9	52	2
861	2026-04-01	17:30:00	19:00:00	approved	2026-03-15 19:00:18.645311+00	9	58	2
862	2026-04-14	13:00:00	15:00:00	approved	2026-03-14 21:40:18.647158+00	9	49	2
863	2026-04-09	19:00:00	21:00:00	approved	2026-03-14 21:46:18.649176+00	9	2	2
864	2026-04-12	15:00:00	16:30:00	approved	2026-03-15 01:04:18.651243+00	9	17	2
865	2026-03-19	11:00:00	12:00:00	approved	2026-03-15 10:00:00+00	9	60	2
866	2026-04-07	12:00:00	13:30:00	approved	2026-03-15 05:55:18.656887+00	9	15	2
867	2026-03-20	18:00:00	19:30:00	approved	2026-03-09 23:00:00+00	9	6	2
868	2026-03-18	13:30:00	15:30:00	approved	2026-03-15 11:30:00+00	9	52	2
869	2026-03-22	16:00:00	17:00:00	approved	2026-03-15 03:00:18.662896+00	9	4	2
870	2026-03-27	13:00:00	15:00:00	approved	2026-03-15 04:39:18.665236+00	9	52	2
871	2026-04-15	18:00:00	19:30:00	approved	2026-03-15 07:52:18.668628+00	9	7	2
872	2026-04-17	11:00:00	13:00:00	approved	2026-03-15 12:07:18.671208+00	9	52	2
873	2026-03-31	10:00:00	11:30:00	approved	2026-03-14 20:00:00+00	9	2	2
874	2026-03-24	11:30:00	12:30:00	approved	2026-03-15 02:56:18.675789+00	9	58	2
875	2026-04-14	10:00:00	11:00:00	approved	2026-03-15 04:23:18.677805+00	9	74	2
876	2026-03-29	17:00:00	19:30:00	rejected	2026-03-15 06:23:18.679773+00	9	49	2
877	2026-02-14	15:30:00	18:30:00	rejected	2026-02-10 10:30:00+00	9	4	2
878	2026-03-10	08:00:00	09:30:00	rejected	2026-02-28 00:00:00+00	9	57	2
879	2026-02-11	17:30:00	21:30:00	rejected	2026-02-06 09:30:00+00	9	52	2
880	2026-02-10	17:30:00	19:30:00	rejected	2026-02-04 11:30:00+00	9	4	2
881	2026-03-31	08:00:00	09:30:00	rejected	2026-03-15 13:09:18.693695+00	9	75	2
882	2026-03-07	12:00:00	14:00:00	rejected	2026-03-05 10:00:00+00	9	70	2
883	2026-03-16	11:30:00	14:30:00	rejected	2026-03-15 04:30:00+00	9	46	2
884	2026-03-08	13:30:00	14:30:00	rejected	2026-03-03 09:30:00+00	9	46	2
885	2026-02-07	12:30:00	15:00:00	rejected	2026-02-02 06:30:00+00	9	75	2
886	2026-03-08	16:00:00	17:30:00	rejected	2026-02-26 15:00:00+00	9	71	2
887	2026-02-21	08:30:00	10:00:00	rejected	2026-02-15 07:30:00+00	9	48	2
888	2026-03-03	18:00:00	20:30:00	rejected	2026-02-27 13:00:00+00	9	75	2
889	2026-03-18	13:30:00	16:00:00	rejected	2026-03-15 01:42:18.711953+00	9	4	2
890	2026-03-15	17:30:00	21:30:00	rejected	2026-03-14 16:30:00+00	9	75	2
891	2026-04-04	14:30:00	16:30:00	rejected	2026-03-15 09:57:18.716205+00	9	16	2
892	2026-03-06	10:30:00	13:30:00	rejected	2026-02-28 06:30:00+00	9	4	2
893	2026-02-10	16:00:00	17:30:00	rejected	2026-02-08 12:00:00+00	9	49	2
894	2026-03-28	08:00:00	10:30:00	rejected	2026-03-15 10:49:18.722191+00	9	2	2
895	2026-04-03	11:30:00	14:30:00	rejected	2026-03-14 23:03:18.724133+00	9	7	2
896	2026-03-25	10:30:00	12:30:00	rejected	2026-03-15 13:36:18.726039+00	9	17	2
897	2026-03-05	08:00:00	09:30:00	rejected	2026-03-04 02:00:00+00	9	52	2
898	2026-04-09	16:00:00	17:30:00	rejected	2026-03-14 23:54:18.729532+00	9	63	2
899	2026-03-08	08:00:00	10:30:00	rejected	2026-03-07 02:00:00+00	9	4	2
900	2026-04-08	15:00:00	18:00:00	rejected	2026-03-15 15:22:18.73329+00	9	46	2
901	2026-03-11	15:00:00	17:00:00	rejected	2026-03-04 11:00:00+00	9	30	2
902	2026-03-10	18:30:00	20:00:00	rejected	2026-03-01 11:30:00+00	9	49	2
903	2026-02-19	13:30:00	16:30:00	rejected	2026-02-09 11:30:00+00	9	30	2
904	2026-02-12	14:00:00	16:00:00	rejected	2026-02-09 12:00:00+00	9	52	2
905	2026-03-30	16:30:00	18:30:00	rejected	2026-03-15 03:26:18.742009+00	9	63	2
906	2026-04-04	19:30:00	22:00:00	rejected	2026-03-15 15:22:18.743733+00	9	46	2
907	2026-03-30	10:00:00	13:00:00	rejected	2026-03-15 08:11:18.745409+00	9	2	2
908	2026-04-04	12:30:00	14:00:00	pending	2026-03-15 02:16:18.74711+00	\N	34	2
909	2026-03-27	12:00:00	16:00:00	pending	2026-03-15 06:09:18.749141+00	\N	46	2
910	2026-04-06	15:30:00	18:00:00	pending	2026-03-15 19:08:18.751087+00	\N	25	2
911	2026-04-02	08:00:00	10:30:00	pending	2026-03-15 12:06:18.752924+00	\N	13	2
912	2026-03-27	12:30:00	15:30:00	pending	2026-03-15 09:56:18.754627+00	\N	34	2
913	2026-04-06	18:30:00	21:30:00	pending	2026-03-15 06:34:18.756676+00	\N	17	2
914	2026-04-02	11:00:00	13:00:00	pending	2026-03-15 19:24:18.758765+00	\N	72	2
915	2026-03-17	17:00:00	18:00:00	pending	2026-03-05 14:00:00+00	\N	46	2
916	2026-03-27	19:00:00	21:30:00	pending	2026-03-15 14:21:18.762776+00	\N	58	2
917	2026-03-17	08:00:00	10:30:00	pending	2026-03-15 01:00:00+00	\N	71	2
918	2026-03-20	09:00:00	13:00:00	pending	2026-03-11 21:00:00+00	\N	46	2
919	2026-03-31	17:30:00	19:30:00	pending	2026-03-15 16:09:18.768323+00	\N	52	2
920	2026-03-26	19:30:00	21:00:00	pending	2026-03-15 02:16:18.770239+00	\N	10	2
921	2026-03-22	10:00:00	11:30:00	pending	2026-03-13 09:00:00+00	\N	9	2
922	2026-04-03	15:30:00	18:30:00	pending	2026-03-15 07:32:18.773847+00	\N	46	2
923	2026-04-05	09:30:00	11:00:00	pending	2026-03-15 02:19:18.775498+00	\N	34	2
924	2026-03-25	08:00:00	12:00:00	pending	2026-03-13 02:00:00+00	\N	4	2
925	2026-03-25	15:30:00	18:00:00	pending	2026-03-15 09:53:18.778901+00	\N	2	2
926	2026-03-17	13:00:00	14:30:00	pending	2026-03-07 03:00:00+00	\N	19	2
928	2026-03-30	10:30:00	12:30:00	pending	2026-03-15 19:28:18.784388+00	\N	67	2
929	2026-03-25	11:30:00	12:30:00	pending	2026-03-15 05:30:00+00	\N	17	2
930	2026-03-27	18:30:00	20:00:00	pending	2026-03-14 22:18:18.787793+00	\N	36	2
931	2026-04-07	17:30:00	20:30:00	pending	2026-03-15 15:06:18.789605+00	\N	75	2
932	2026-03-20	11:00:00	12:30:00	pending	2026-03-13 07:00:00+00	\N	9	2
933	2026-03-31	19:00:00	21:00:00	pending	2026-03-15 06:14:18.792839+00	\N	4	2
934	2026-03-22	18:30:00	21:30:00	pending	2026-03-12 13:30:00+00	\N	9	2
935	2026-04-04	13:00:00	14:30:00	pending	2026-03-15 13:50:18.796132+00	\N	9	2
936	2026-04-04	17:30:00	20:30:00	pending	2026-03-14 23:28:18.797942+00	\N	49	2
938	2026-03-27	10:00:00	12:00:00	pending	2026-03-15 03:54:18.80186+00	\N	58	2
939	2026-03-17	08:30:00	11:30:00	pending	2026-03-15 08:56:18.803571+00	\N	49	2
940	2026-03-22	15:30:00	18:00:00	pending	2026-03-15 04:29:18.805378+00	\N	52	2
941	2026-03-18	18:30:00	21:00:00	pending	2026-03-15 04:56:18.807156+00	\N	49	2
943	2026-03-31	16:30:00	19:00:00	pending	2026-03-14 21:46:18.810588+00	\N	2	2
944	2026-03-17	13:30:00	16:00:00	pending	2026-03-06 09:30:00+00	\N	59	2
945	2026-03-29	18:00:00	22:00:00	pending	2026-03-15 16:29:18.814598+00	\N	22	2
946	2026-03-19	15:30:00	16:30:00	pending	2026-03-07 04:30:00+00	\N	58	2
947	2026-03-26	16:30:00	18:30:00	cancelled	2026-03-15 00:01:18.818063+00	\N	32	2
948	2026-03-16	14:00:00	16:30:00	cancelled	2026-03-02 13:00:00+00	\N	46	2
949	2026-03-27	19:00:00	21:00:00	cancelled	2026-03-14 18:00:00+00	\N	75	2
950	2026-02-21	17:00:00	19:30:00	cancelled	2026-02-19 04:00:00+00	\N	71	2
951	2026-03-21	17:30:00	20:00:00	cancelled	2026-03-15 18:22:18.824591+00	\N	34	2
952	2026-04-09	15:30:00	16:30:00	cancelled	2026-03-15 01:37:18.826303+00	\N	25	2
953	2026-04-17	14:00:00	15:30:00	cancelled	2026-03-15 09:13:18.828076+00	\N	71	2
954	2026-03-18	15:00:00	16:30:00	cancelled	2026-03-13 02:00:00+00	\N	27	2
955	2026-04-03	16:00:00	18:00:00	cancelled	2026-03-15 00:41:18.831691+00	\N	71	2
956	2026-03-02	16:30:00	20:30:00	cancelled	2026-02-25 03:30:00+00	\N	42	2
957	2026-04-11	17:30:00	18:30:00	cancelled	2026-03-15 02:54:18.835212+00	\N	53	2
958	2026-04-17	16:30:00	19:00:00	cancelled	2026-03-15 13:44:18.8369+00	\N	4	2
959	2026-03-22	16:00:00	18:30:00	cancelled	2026-03-14 04:00:00+00	\N	2	2
960	2026-03-15	09:30:00	12:30:00	cancelled	2026-03-01 19:30:00+00	\N	63	2
961	2026-03-15	08:30:00	10:30:00	cancelled	2026-03-08 21:30:00+00	\N	58	2
962	2026-02-22	10:30:00	12:00:00	cancelled	2026-02-15 02:30:00+00	\N	17	2
963	2026-03-19	12:30:00	16:30:00	cancelled	2026-03-07 03:30:00+00	\N	31	2
964	2026-02-16	11:00:00	12:30:00	cancelled	2026-02-13 06:00:00+00	\N	52	2
965	2026-03-14	13:30:00	15:30:00	cancelled	2026-03-02 09:30:00+00	\N	9	2
966	2026-02-23	08:30:00	10:00:00	cancelled	2026-02-19 01:30:00+00	\N	17	2
967	2026-04-08	08:00:00	11:00:00	cancelled	2026-03-15 16:36:18.85311+00	\N	15	2
968	2026-03-31	18:00:00	19:00:00	cancelled	2026-03-15 11:08:18.854868+00	\N	38	2
969	2026-04-04	12:30:00	15:00:00	cancelled	2026-03-15 15:13:18.856581+00	\N	15	2
970	2026-04-09	10:30:00	12:30:00	cancelled	2026-03-15 18:30:18.858216+00	\N	34	2
971	2026-03-18	16:30:00	19:00:00	cancelled	2026-03-05 05:30:00+00	\N	52	2
972	2026-03-23	12:00:00	14:30:00	cancelled	2026-03-14 22:38:18.861566+00	\N	9	2
973	2026-04-15	15:30:00	19:30:00	cancelled	2026-03-14 22:30:18.863319+00	\N	49	2
974	2026-04-12	11:00:00	12:30:00	cancelled	2026-03-14 21:05:18.865504+00	\N	2	2
975	2026-04-15	17:00:00	18:30:00	cancelled	2026-03-15 15:40:18.86737+00	\N	71	2
937	2026-03-16	15:00:00	17:30:00	rejected	2026-03-09 14:00:00+00	\N	19	2
942	2026-03-16	10:30:00	13:00:00	rejected	2026-03-08 00:30:00+00	\N	33	2
927	2026-03-16	16:30:00	17:30:00	rejected	2026-03-11 08:30:00+00	\N	15	2
29	2026-03-16	15:00:00	17:30:00	rejected	2026-03-09 14:00:00+00	\N	16	50
107	2026-03-16	08:00:00	10:00:00	rejected	2026-03-11 06:00:00+00	\N	11	163
109	2026-03-16	08:30:00	10:30:00	rejected	2026-03-13 23:30:00+00	\N	30	165
222	2026-03-16	14:00:00	16:00:00	rejected	2026-03-09 07:00:00+00	\N	55	148
237	2026-03-16	14:30:00	16:30:00	rejected	2026-03-10 05:30:00+00	\N	57	87
506	2026-03-16	15:00:00	18:00:00	rejected	2026-03-07 12:00:00+00	\N	20	33
542	2026-03-16	10:30:00	13:30:00	rejected	2026-03-15 02:30:00+00	\N	5	29
976	2026-03-20	10:00:00	11:00:00	pending	2026-03-16 21:25:10.323519+00	\N	79	176
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	users	user
7	rooms	building
8	rooms	equipment
9	rooms	room
10	bookings	booking
11	reviews	review
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-03-15 02:15:54.484088+00
2	contenttypes	0002_remove_content_type_name	2026-03-15 02:15:54.492712+00
3	auth	0001_initial	2026-03-15 02:15:54.53096+00
4	auth	0002_alter_permission_name_max_length	2026-03-15 02:15:54.536053+00
5	auth	0003_alter_user_email_max_length	2026-03-15 02:15:54.54147+00
6	auth	0004_alter_user_username_opts	2026-03-15 02:15:54.546711+00
7	auth	0005_alter_user_last_login_null	2026-03-15 02:15:54.552726+00
8	auth	0006_require_contenttypes_0002	2026-03-15 02:15:54.555708+00
9	auth	0007_alter_validators_add_error_messages	2026-03-15 02:15:54.561945+00
10	auth	0008_alter_user_username_max_length	2026-03-15 02:15:54.568228+00
11	auth	0009_alter_user_last_name_max_length	2026-03-15 02:15:54.60742+00
12	auth	0010_alter_group_name_max_length	2026-03-15 02:15:54.613681+00
13	auth	0011_update_proxy_permissions	2026-03-15 02:15:54.619145+00
14	auth	0012_alter_user_first_name_max_length	2026-03-15 02:15:54.627751+00
15	users	0001_initial	2026-03-15 02:15:54.78074+00
16	admin	0001_initial	2026-03-15 02:15:54.803857+00
17	admin	0002_logentry_remove_auto_add	2026-03-15 02:15:54.812218+00
18	admin	0003_logentry_add_action_flag_choices	2026-03-15 02:15:54.822546+00
19	rooms	0001_initial	2026-03-15 02:15:54.864113+00
20	bookings	0001_initial	2026-03-15 02:15:54.870754+00
21	bookings	0002_initial	2026-03-15 02:15:54.917354+00
22	reviews	0001_initial	2026-03-15 02:15:54.94409+00
23	reviews	0002_initial	2026-03-15 02:15:54.964258+00
24	reviews	0003_review_booking	2026-03-15 02:15:54.982095+00
25	sessions	0001_initial	2026-03-15 02:15:54.997895+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
r71kk3s4ha9pmcf4ndkgkttr1wd7oj3g	.eJxVjMsOwiAURP-FtSE8BVy67zeQe7koVQNJaVfGf5cmXegs55yZN4uwrSVuPS9xJnZhgZ1-O4T0zHUH9IB6bzy1ui4z8l3hB-18apRf18P9OyjQy1gLTCCUVwKFdMF4q4yyGqVX9gySQrY2kAtJGCK0HgZ1Nxe014rcCPt8AbINNmU:1w1bNC:jXdQyrO-S8H63bi2ConSOIFod_7EczFm1AvQl8U5KcU	2026-03-29 02:38:34.668004+00
\.


--
-- Data for Name: reviews_review; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reviews_review (id, rating, comment, created_at, room_id, student_id, booking_id) FROM stdin;
1	5	Good room for study.	2026-03-07 18:32:04.912+00	1	2	\N
2	5	Good room for study.	2026-03-07 18:32:16.075+00	1	2	\N
3	5	Good room for study.	2026-03-12 15:29:57.455+00	1	2	\N
4	5	111	2026-03-12 16:39:31.727+00	1	2	2
5	5	饿13额1	2026-03-13 16:43:31.262+00	1	2	3
6	2	The room was usable but had some issues. The space felt noisy compared with similar rooms nearby. Collaboration Suite LB-404 felt less suitable than expected.	2025-11-28 14:00:00+00	32	92	484
7	5	Great study space for a group session. The room stayed quiet for the full session. Collaboration Suite SAB-202 was a good fit for a group of 10.	2026-02-17 07:30:00+00	16	65	68
8	3	The booking worked but the room was average. The room was usable, but the ventilation could be better. Quiet Pod RB-404 felt less suitable than expected.	2025-12-04 06:30:00+00	55	117	246
9	5	Very smooth booking experience. The equipment list matched what was available on arrival. Room 101 was a good fit for a group of 6.	2026-01-16 08:00:00+00	1	167	345
10	5	Quiet room with everything we needed. The layout worked well for both laptops and discussion. Collaboration Suite RB-505 was a good fit for a group of 10.	2025-11-30 14:30:00+00	63	119	516
11	3	The booking worked but the room was average. It worked for the session, though the setup was only average. Collaboration Suite SAB-505 felt less suitable than expected.	2025-12-22 01:00:00+00	51	150	323
12	4	Useful room and easy to find. The location was convenient between classes. Collaboration Suite AL-202 was a good fit for a group of 6.	2025-12-04 14:00:00+00	18	133	440
13	3	The booking worked but the room was average. The room was usable, but the ventilation could be better. Workshop Room RB-303 felt less suitable than expected.	2025-12-12 12:00:00+00	48	47	632
14	2	Not ideal for a long session. The space felt noisy compared with similar rooms nearby. Quiet Pod RB-404 felt less suitable than expected.	2026-03-09 07:00:00+00	55	43	527
15	5	Excellent room for revision. The equipment list matched what was available on arrival. Study Room RLC-404 was a good fit for a group of 4.	2025-12-12 17:30:00+00	19	163	590
16	4	Comfortable space for a study block. The layout worked well for both laptops and discussion. Collaboration Suite RLC-202 was a good fit for a group of 10.	2026-01-24 23:30:00+00	11	165	463
17	3	The booking worked but the room was average. The room was fine, although it felt a little cramped at peak time. Study Room WMB-101 felt less suitable than expected.	2026-01-16 02:30:00+00	12	29	408
18	1	This booking was frustrating to use. The room was harder to access than expected during a busy period. Room 202 felt less suitable than expected.	2026-02-28 13:00:00+00	2	165	225
19	4	Useful room and easy to find. There were enough sockets and seating for everyone in the group. Quiet Pod RB-404 was a good fit for a group of 2.	2026-03-05 09:30:00+00	55	114	563
20	4	Good option for a project meeting. The room stayed quiet for the full session. Study Room RB-202 was a good fit for a group of 7.	2026-03-15 06:35:12.521772+00	42	72	45
21	4	Solid room overall. The room stayed quiet for the full session. Study Room JMSL-303 was a good fit for a group of 8.	2026-02-10 15:30:00+00	41	11	490
22	4	Comfortable space for a study block. There were enough sockets and seating for everyone in the group. Study Room AL-612 was a good fit for a group of 4.	2026-01-01 19:00:00+00	69	150	539
23	5	Excellent room for revision. The equipment list matched what was available on arrival. Seminar Room BOB-303 was a good fit for a group of 13.	2026-01-15 16:30:00+00	24	134	461
24	4	Good option for a project meeting. The equipment list matched what was available on arrival. Quiet Pod SAB-404 was a good fit for a group of 2.	2026-02-23 23:30:00+00	25	113	454
25	5	Great study space for a group session. The layout worked well for both laptops and discussion. Project Room WMB-505 was a good fit for a group of 11.	2025-12-18 08:00:00+00	58	165	606
26	4	Comfortable space for a study block. The equipment list matched what was available on arrival. Study Room AL-208 was a good fit for a group of 6.	2026-03-12 12:30:00+00	56	28	359
27	4	Solid room overall. The equipment list matched what was available on arrival. Project Room RB-101 was a good fit for a group of 10.	2026-01-16 08:00:00+00	7	158	376
28	4	Good option for a project meeting. The room stayed quiet for the full session. Collaboration Suite AL-113 was a good fit for a group of 6.	2026-02-02 07:30:00+00	72	62	407
29	5	Great study space for a group session. The layout worked well for both laptops and discussion. Project Room RLC-101 was a good fit for a group of 9.	2025-12-24 12:30:00+00	5	133	421
30	5	Quiet room with everything we needed. The layout worked well for both laptops and discussion. Study Room KHSC-107 was a good fit for a group of 6.	2026-02-16 00:30:00+00	70	36	520
31	2	Not ideal for a long session. The space felt noisy compared with similar rooms nearby. Collaboration Suite RB-505 felt less suitable than expected.	2025-12-07 03:30:00+00	63	158	672
32	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Project Room SAB-303 was a good fit for a group of 10.	2025-12-06 03:00:00+00	23	46	439
33	5	Quiet room with everything we needed. The location was convenient between classes. Collaboration Suite WMB-606 was a good fit for a group of 7.	2026-02-08 17:30:00+00	67	71	511
34	4	Good option for a project meeting. The location was convenient between classes. Collaboration Suite RB-505 was a good fit for a group of 10.	2026-01-24 20:00:00+00	63	43	657
35	4	Solid room overall. The equipment list matched what was available on arrival. Study Room RB-202 was a good fit for a group of 7.	2026-01-04 17:00:00+00	42	18	24
36	4	Comfortable space for a study block. There were enough sockets and seating for everyone in the group. Collaboration Suite WMB-606 was a good fit for a group of 7.	2026-02-17 12:00:00+00	67	40	589
37	5	Great study space for a group session. The layout worked well for both laptops and discussion. Study Room RB-202 was a good fit for a group of 7.	2025-12-09 17:30:00+00	42	54	211
38	5	Quiet room with everything we needed. The layout worked well for both laptops and discussion. Study Room LB-606 was a good fit for a group of 5.	2025-12-31 07:00:00+00	62	54	341
39	4	Solid room overall. The equipment list matched what was available on arrival. Collaboration Suite WMB-606 was a good fit for a group of 7.	2026-01-26 11:00:00+00	67	164	297
40	5	Quiet room with everything we needed. The layout worked well for both laptops and discussion. Project Room RB-101 was a good fit for a group of 10.	2025-12-23 09:30:00+00	7	126	541
41	3	The room was acceptable. The room was fine, although it felt a little cramped at peak time. Collaboration Suite AL-404 felt less suitable than expected.	2025-12-29 17:00:00+00	28	113	513
42	5	Great study space for a group session. The layout worked well for both laptops and discussion. Collaboration Suite RB-505 was a good fit for a group of 10.	2026-01-10 08:00:00+00	63	161	110
43	5	Great study space for a group session. The room stayed quiet for the full session. Project Room RLC-101 was a good fit for a group of 9.	2026-02-09 18:30:00+00	5	166	231
44	4	Good option for a project meeting. The layout worked well for both laptops and discussion. Quiet Pod SAB-404 was a good fit for a group of 2.	2025-11-20 10:30:00+00	25	141	306
45	4	Useful room and easy to find. The equipment list matched what was available on arrival. Collaboration Suite LB-404 was a good fit for a group of 11.	2026-02-08 07:30:00+00	32	134	646
46	5	Very smooth booking experience. There were enough sockets and seating for everyone in the group. Collaboration Suite AL-202 was a good fit for a group of 6.	2026-02-19 01:00:00+00	18	114	413
47	5	Great study space for a group session. The room stayed quiet for the full session. Project Room RB-101 was a good fit for a group of 10.	2026-03-06 12:30:00+00	7	165	456
48	4	Good option for a project meeting. The layout worked well for both laptops and discussion. Room 101 was a good fit for a group of 6.	2025-12-21 19:30:00+00	1	126	275
49	5	Quiet room with everything we needed. There were enough sockets and seating for everyone in the group. Collaboration Suite RB-505 was a good fit for a group of 10.	2026-02-14 16:00:00+00	63	128	19
50	3	A decent option for short sessions. The room was fine, although it felt a little cramped at peak time. Project Room RLC-101 felt less suitable than expected.	2025-12-21 00:00:00+00	5	62	338
51	5	Great study space for a group session. The room stayed quiet for the full session. Study Room RB-202 was a good fit for a group of 7.	2025-12-10 05:00:00+00	42	47	259
52	1	This booking was frustrating to use. It worked in the end, but the setup did not suit group work. Study Room KHSC-107 felt less suitable than expected.	2026-01-25 06:00:00+00	70	128	452
53	4	Solid room overall. There were enough sockets and seating for everyone in the group. Quiet Pod SAB-404 was a good fit for a group of 2.	2025-12-13 13:00:00+00	25	145	375
54	3	A decent option for short sessions. The booking itself was easy, but the space could be cleaner. Study Room AL-612 felt less suitable than expected.	2025-12-15 14:30:00+00	69	94	668
55	4	Useful room and easy to find. The layout worked well for both laptops and discussion. Project Room KHSC-101 was a good fit for a group of 13.	2026-02-13 15:00:00+00	8	75	22
56	5	Very smooth booking experience. The room stayed quiet for the full session. Collaboration Suite AL-404 was a good fit for a group of 10.	2026-03-06 08:00:00+00	28	160	623
57	4	Useful room and easy to find. There were enough sockets and seating for everyone in the group. Quiet Pod RB-404 was a good fit for a group of 2.	2026-01-25 12:30:00+00	55	91	616
58	5	Very smooth booking experience. The equipment list matched what was available on arrival. Collaboration Suite SAB-505 was a good fit for a group of 9.	2026-03-08 01:30:00+00	51	49	403
59	3	A decent option for short sessions. The booking itself was easy, but the space could be cleaner. Project Room RLC-101 felt less suitable than expected.	2026-01-08 01:30:00+00	5	24	202
60	5	Very smooth booking experience. The layout worked well for both laptops and discussion. Study Room KHSC-202 was a good fit for a group of 4.	2026-03-11 01:30:00+00	34	156	422
61	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Project Room LB-303 was a good fit for a group of 8.	2026-02-17 01:00:00+00	17	46	35
62	5	Great study space for a group session. The location was convenient between classes. Study Room AL-208 was a good fit for a group of 6.	2026-02-04 14:00:00+00	56	28	260
63	4	Comfortable space for a study block. The equipment list matched what was available on arrival. Project Room RLC-101 was a good fit for a group of 9.	2026-01-28 05:00:00+00	5	162	170
64	5	Great study space for a group session. The equipment list matched what was available on arrival. Collaboration Suite WMB-606 was a good fit for a group of 7.	2026-02-06 06:30:00+00	67	102	180
65	5	Quiet room with everything we needed. The location was convenient between classes. Quiet Pod RB-404 was a good fit for a group of 2.	2025-12-21 20:30:00+00	55	151	587
66	5	Quiet room with everything we needed. There were enough sockets and seating for everyone in the group. Seminar Room BOB-303 was a good fit for a group of 13.	2026-03-13 09:30:00+00	24	72	655
67	4	Good option for a project meeting. The layout worked well for both laptops and discussion. Study Room KHSC-107 was a good fit for a group of 6.	2025-12-01 07:00:00+00	70	97	238
68	4	Good option for a project meeting. The location was convenient between classes. Quiet Pod AL-511 was a good fit for a group of 2.	2026-02-24 05:30:00+00	61	165	312
69	5	Excellent room for revision. The location was convenient between classes. Room 202 was a good fit for a group of 10.	2025-12-18 06:00:00+00	2	158	108
70	3	A decent option for short sessions. It worked for the session, though the setup was only average. Quiet Pod RB-404 felt less suitable than expected.	2026-02-01 22:00:00+00	55	85	41
71	5	Very smooth booking experience. The layout worked well for both laptops and discussion. Workshop Room RB-303 was a good fit for a group of 21.	2025-12-16 12:00:00+00	48	56	115
72	5	Excellent room for revision. The layout worked well for both laptops and discussion. Seminar Room RLC-107 was a good fit for a group of 18.	2026-02-03 00:30:00+00	46	65	28
73	4	Solid room overall. The room stayed quiet for the full session. Collaboration Suite RB-505 was a good fit for a group of 10.	2025-11-28 03:30:00+00	63	166	395
74	5	Very smooth booking experience. The room stayed quiet for the full session. Focus Booth AL-606 was a good fit for a group of 2.	2026-01-06 18:30:00+00	50	98	331
75	3	The room was acceptable. The booking itself was easy, but the space could be cleaner. Seminar Room BOB-303 felt less suitable than expected.	2025-12-03 22:30:00+00	24	151	385
76	2	The room was usable but had some issues. A few of the facilities listed online were not ready when we arrived. Project Room WMB-505 felt less suitable than expected.	2025-12-03 23:00:00+00	58	36	626
77	2	The room was usable but had some issues. The room was harder to access than expected during a busy period. Collaboration Suite WMB-606 felt less suitable than expected.	2026-01-24 05:00:00+00	67	47	412
78	5	Very smooth booking experience. The room stayed quiet for the full session. Workshop Room RB-303 was a good fit for a group of 21.	2026-02-07 19:30:00+00	48	154	548
79	2	The room was usable but had some issues. A few of the facilities listed online were not ready when we arrived. Collaboration Suite AL-202 felt less suitable than expected.	2026-02-27 05:00:00+00	18	73	510
80	4	Good option for a project meeting. The location was convenient between classes. Project Room RLC-101 was a good fit for a group of 9.	2025-12-31 23:00:00+00	5	136	234
81	4	Useful room and easy to find. There were enough sockets and seating for everyone in the group. Study Room KHSC-202 was a good fit for a group of 4.	2026-02-14 16:30:00+00	34	126	578
82	5	Excellent room for revision. The location was convenient between classes. Study Room RB-202 was a good fit for a group of 7.	2026-01-29 14:30:00+00	42	159	660
83	5	Very smooth booking experience. The equipment list matched what was available on arrival. Study Room RB-202 was a good fit for a group of 7.	2025-11-24 16:00:00+00	42	70	348
84	5	Very smooth booking experience. The layout worked well for both laptops and discussion. Project Room RLC-101 was a good fit for a group of 9.	2026-01-07 13:30:00+00	5	115	381
85	5	Excellent room for revision. The location was convenient between classes. Collaboration Suite LB-404 was a good fit for a group of 11.	2025-12-29 11:30:00+00	32	99	366
86	5	Quiet room with everything we needed. The location was convenient between classes. Study Room TALC-101 was a good fit for a group of 4.	2026-03-11 10:30:00+00	9	140	453
87	5	Quiet room with everything we needed. There were enough sockets and seating for everyone in the group. Collaboration Suite AL-404 was a good fit for a group of 10.	2026-02-01 13:00:00+00	28	146	498
88	3	The booking worked but the room was average. The booking itself was easy, but the space could be cleaner. Collaboration Suite AL-404 felt less suitable than expected.	2026-02-21 16:00:00+00	28	134	213
89	1	This booking was frustrating to use. The room was harder to access than expected during a busy period. Collaboration Suite LB-404 felt less suitable than expected.	2025-12-20 08:00:00+00	32	67	81
90	3	The room was acceptable. The room was usable, but the ventilation could be better. Collaboration Suite AL-113 felt less suitable than expected.	2026-02-04 19:30:00+00	72	113	569
91	5	Very smooth booking experience. The layout worked well for both laptops and discussion. Study Room RLC-404 was a good fit for a group of 4.	2025-12-11 01:00:00+00	19	28	404
92	2	Not ideal for a long session. It worked in the end, but the setup did not suit group work. Study Room RB-202 felt less suitable than expected.	2026-02-12 22:30:00+00	42	101	10
93	5	Great study space for a group session. The equipment list matched what was available on arrival. Quiet Pod RB-404 was a good fit for a group of 2.	2026-03-14 04:35:12.521772+00	55	158	592
94	2	Not ideal for a long session. The space felt noisy compared with similar rooms nearby. Collaboration Suite RLC-303 felt less suitable than expected.	2026-01-26 18:30:00+00	14	79	609
95	4	Comfortable space for a study block. There were enough sockets and seating for everyone in the group. Study Room RB-202 was a good fit for a group of 7.	2026-03-15 15:35:12.521772+00	42	103	450
96	5	Very smooth booking experience. The location was convenient between classes. Workshop Room KHSC-505 was a good fit for a group of 16.	2026-03-11 18:30:00+00	64	107	621
97	5	Very smooth booking experience. The location was convenient between classes. Study Room SAB-101 was a good fit for a group of 8.	2026-03-14 04:00:00+00	10	150	482
98	4	Good option for a project meeting. There were enough sockets and seating for everyone in the group. Project Room RLC-101 was a good fit for a group of 9.	2026-02-11 05:00:00+00	5	140	174
99	3	The booking worked but the room was average. The room was usable, but the ventilation could be better. Project Room RLC-101 felt less suitable than expected.	2025-12-08 03:30:00+00	5	169	652
100	4	Comfortable space for a study block. The room stayed quiet for the full session. Collaboration Suite LB-404 was a good fit for a group of 11.	2026-02-07 12:00:00+00	32	69	224
101	4	Useful room and easy to find. The layout worked well for both laptops and discussion. Collaboration Suite RLC-303 was a good fit for a group of 8.	2026-03-15 14:35:12.521772+00	14	144	116
102	3	A decent option for short sessions. The room was fine, although it felt a little cramped at peak time. Workshop Room RB-303 felt less suitable than expected.	2026-03-15 00:35:12.521772+00	48	80	236
103	3	A decent option for short sessions. The room was usable, but the ventilation could be better. Project Room WMB-505 felt less suitable than expected.	2026-01-20 01:00:00+00	58	26	150
104	4	Good option for a project meeting. There were enough sockets and seating for everyone in the group. Room 101 was a good fit for a group of 6.	2026-01-28 08:30:00+00	1	65	676
105	4	Good option for a project meeting. The equipment list matched what was available on arrival. Quiet Pod WMB-404 was a good fit for a group of 3.	2026-03-13 17:30:00+00	30	11	146
106	4	Useful room and easy to find. The location was convenient between classes. Collaboration Suite AL-404 was a good fit for a group of 10.	2026-01-22 16:30:00+00	28	173	252
107	5	Excellent room for revision. The room stayed quiet for the full session. Project Room RLC-101 was a good fit for a group of 9.	2025-12-14 02:00:00+00	5	29	591
108	3	A decent option for short sessions. The booking itself was easy, but the space could be cleaner. Study Room SAB-606 felt less suitable than expected.	2026-02-17 03:30:00+00	54	120	92
109	5	Quiet room with everything we needed. The layout worked well for both laptops and discussion. Collaboration Suite WMB-606 was a good fit for a group of 7.	2025-12-15 04:30:00+00	67	124	172
110	4	Comfortable space for a study block. The room stayed quiet for the full session. Project Room LB-303 was a good fit for a group of 8.	2026-01-11 21:30:00+00	17	168	91
111	1	The room did not meet expectations. The space felt noisy compared with similar rooms nearby. Study Room SAB-606 felt less suitable than expected.	2026-02-22 04:30:00+00	54	71	477
112	4	Good option for a project meeting. The location was convenient between classes. Workshop Room ERC-303 was a good fit for a group of 22.	2026-01-17 01:00:00+00	36	117	433
113	2	The room was usable but had some issues. The room was harder to access than expected during a busy period. Quiet Pod RB-404 felt less suitable than expected.	2025-12-07 04:30:00+00	55	75	40
114	5	Very smooth booking experience. The equipment list matched what was available on arrival. Study Room LB-505 was a good fit for a group of 4.	2026-03-06 04:00:00+00	52	173	48
115	3	The booking worked but the room was average. It worked for the session, though the setup was only average. Collaboration Suite RB-505 felt less suitable than expected.	2026-01-06 23:30:00+00	63	47	661
116	5	Very smooth booking experience. The layout worked well for both laptops and discussion. Project Room RLC-101 was a good fit for a group of 9.	2026-02-07 21:00:00+00	5	126	75
117	4	Solid room overall. The layout worked well for both laptops and discussion. Study Room KHSC-202 was a good fit for a group of 4.	2026-02-09 16:30:00+00	34	167	322
118	3	The room was acceptable. The booking itself was easy, but the space could be cleaner. Quiet Pod AL-303 felt less suitable than expected.	2026-01-03 04:30:00+00	27	84	9
119	2	Not ideal for a long session. The room was harder to access than expected during a busy period. Study Room SAB-107 felt less suitable than expected.	2026-02-12 19:30:00+00	60	126	598
120	5	Great study space for a group session. The location was convenient between classes. Collaboration Suite KHSC-606 was a good fit for a group of 8.	2025-12-16 09:00:00+00	66	166	100
121	4	Good option for a project meeting. The layout worked well for both laptops and discussion. Collaboration Suite RLC-202 was a good fit for a group of 10.	2025-11-28 01:30:00+00	11	140	471
122	3	The room was acceptable. The room was fine, although it felt a little cramped at peak time. Collaboration Suite AL-404 felt less suitable than expected.	2025-12-12 00:30:00+00	28	164	546
123	4	Good option for a project meeting. The layout worked well for both laptops and discussion. Study Room SAB-101 was a good fit for a group of 8.	2025-12-03 01:30:00+00	10	17	181
124	4	Solid room overall. The location was convenient between classes. Study Room ERC-404 was a good fit for a group of 4.	2026-02-09 20:30:00+00	73	128	371
125	4	Good option for a project meeting. The room stayed quiet for the full session. Project Room LB-303 was a good fit for a group of 8.	2026-03-10 16:30:00+00	17	105	227
126	2	Not ideal for a long session. The room was harder to access than expected during a busy period. Project Room RLC-101 felt less suitable than expected.	2026-01-19 22:30:00+00	5	62	540
127	4	Useful room and easy to find. The location was convenient between classes. Seminar Room BOB-404 was a good fit for a group of 18.	2025-12-28 06:30:00+00	26	115	241
128	3	A decent option for short sessions. The room was fine, although it felt a little cramped at peak time. Collaboration Suite JMSL-404 felt less suitable than expected.	2026-03-04 20:00:00+00	65	48	585
129	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Collaboration Suite RB-505 was a good fit for a group of 10.	2025-11-27 11:30:00+00	63	156	310
130	4	Good option for a project meeting. There were enough sockets and seating for everyone in the group. Study Room RLC-404 was a good fit for a group of 4.	2026-01-08 01:30:00+00	19	71	570
131	1	The room did not meet expectations. A few of the facilities listed online were not ready when we arrived. Study Room JMSL-202 felt less suitable than expected.	2025-12-05 22:00:00+00	15	113	474
132	5	Very smooth booking experience. There were enough sockets and seating for everyone in the group. Project Room LB-303 was a good fit for a group of 8.	2026-02-28 18:30:00+00	17	161	374
133	5	Great study space for a group session. The equipment list matched what was available on arrival. Collaboration Suite RB-505 was a good fit for a group of 10.	2025-12-06 10:30:00+00	63	129	120
134	3	A decent option for short sessions. The booking itself was easy, but the space could be cleaner. Quiet Pod RB-404 felt less suitable than expected.	2025-12-20 21:00:00+00	55	47	534
135	4	Solid room overall. The layout worked well for both laptops and discussion. Collaboration Suite RLC-202 was a good fit for a group of 10.	2025-12-21 11:30:00+00	11	125	380
136	1	The room did not meet expectations. The space felt noisy compared with similar rooms nearby. Room 101 felt less suitable than expected.	2026-01-26 20:30:00+00	1	98	627
137	2	Not ideal for a long session. The space felt noisy compared with similar rooms nearby. Collaboration Suite RB-505 felt less suitable than expected.	2026-03-15 02:35:12.521772+00	63	26	250
138	4	Good option for a project meeting. The location was convenient between classes. Quiet Pod RB-404 was a good fit for a group of 2.	2026-02-12 07:00:00+00	55	47	505
139	1	The room did not meet expectations. A few of the facilities listed online were not ready when we arrived. Quiet Pod RB-404 felt less suitable than expected.	2025-12-06 18:30:00+00	55	126	11
140	4	Solid room overall. There were enough sockets and seating for everyone in the group. Study Room RLC-309 was a good fit for a group of 4.	2026-02-27 04:30:00+00	49	123	555
141	4	Comfortable space for a study block. The location was convenient between classes. Project Room RLC-101 was a good fit for a group of 9.	2026-01-02 05:00:00+00	5	22	382
142	4	Solid room overall. There were enough sockets and seating for everyone in the group. Collaboration Suite WMB-606 was a good fit for a group of 7.	2025-12-23 02:00:00+00	67	174	635
143	5	Quiet room with everything we needed. The layout worked well for both laptops and discussion. Quiet Pod RB-404 was a good fit for a group of 2.	2026-02-23 04:30:00+00	55	55	610
144	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Collaboration Suite AL-113 was a good fit for a group of 6.	2026-01-15 06:30:00+00	72	164	114
145	5	Quiet room with everything we needed. The layout worked well for both laptops and discussion. Workshop Room RB-303 was a good fit for a group of 21.	2026-03-15 09:35:12.521772+00	48	98	129
146	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Seminar Room RLC-107 was a good fit for a group of 18.	2026-01-02 15:00:00+00	46	28	93
147	5	Great study space for a group session. The location was convenient between classes. Room 101 was a good fit for a group of 6.	2026-02-04 18:00:00+00	1	128	220
148	4	Solid room overall. The room stayed quiet for the full session. Collaboration Suite AL-202 was a good fit for a group of 6.	2026-03-13 00:30:00+00	18	47	169
149	4	Good option for a project meeting. The equipment list matched what was available on arrival. Collaboration Suite LB-404 was a good fit for a group of 11.	2026-03-10 02:30:00+00	32	60	579
150	4	Useful room and easy to find. There were enough sockets and seating for everyone in the group. Collaboration Suite WMB-606 was a good fit for a group of 7.	2026-01-31 21:30:00+00	67	150	60
151	4	Good option for a project meeting. The equipment list matched what was available on arrival. Workshop Room RB-303 was a good fit for a group of 21.	2025-11-26 06:30:00+00	48	158	346
152	4	Solid room overall. The equipment list matched what was available on arrival. Quiet Pod SAB-404 was a good fit for a group of 2.	2025-12-17 21:30:00+00	25	168	368
153	5	Excellent room for revision. The equipment list matched what was available on arrival. Study Room RB-606 was a good fit for a group of 6.	2026-02-19 03:00:00+00	68	46	558
154	5	Excellent room for revision. The location was convenient between classes. Study Room RB-202 was a good fit for a group of 7.	2026-02-06 09:00:00+00	42	88	525
155	5	Great study space for a group session. The room stayed quiet for the full session. Collaboration Suite AL-202 was a good fit for a group of 6.	2026-02-05 16:00:00+00	18	80	175
156	5	Great study space for a group session. The room stayed quiet for the full session. Collaboration Suite AL-404 was a good fit for a group of 10.	2026-03-08 22:30:00+00	28	173	604
157	5	Quiet room with everything we needed. The room stayed quiet for the full session. Collaboration Suite AL-309 was a good fit for a group of 7.	2025-12-04 19:30:00+00	57	134	55
158	4	Comfortable space for a study block. The equipment list matched what was available on arrival. Study Room LB-202 was a good fit for a group of 4.	2026-01-12 06:00:00+00	4	87	586
159	4	Solid room overall. The room stayed quiet for the full session. Project Room ASB-101 was a good fit for a group of 14.	2026-01-01 11:30:00+00	31	68	262
160	3	The booking worked but the room was average. The room was fine, although it felt a little cramped at peak time. Collaboration Suite AL-404 felt less suitable than expected.	2026-02-12 13:00:00+00	28	161	103
161	4	Solid room overall. There were enough sockets and seating for everyone in the group. Study Room KHSC-107 was a good fit for a group of 6.	2026-01-10 18:30:00+00	70	46	167
162	5	Quiet room with everything we needed. The layout worked well for both laptops and discussion. Seminar Room BOB-303 was a good fit for a group of 13.	2025-12-30 03:30:00+00	24	97	177
163	2	The room was usable but had some issues. The room was harder to access than expected during a busy period. Project Room WMB-505 felt less suitable than expected.	2026-01-21 23:00:00+00	58	144	31
164	4	Good option for a project meeting. The room stayed quiet for the full session. Quiet Pod AL-511 was a good fit for a group of 2.	2026-01-04 17:00:00+00	61	113	647
165	4	Solid room overall. The layout worked well for both laptops and discussion. Project Room SAB-303 was a good fit for a group of 10.	2026-02-10 06:00:00+00	23	148	479
166	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Project Room RLC-101 was a good fit for a group of 9.	2026-02-23 23:30:00+00	5	20	127
167	4	Good option for a project meeting. There were enough sockets and seating for everyone in the group. Study Room KHSC-202 was a good fit for a group of 4.	2025-12-09 07:30:00+00	34	110	620
168	4	Useful room and easy to find. The equipment list matched what was available on arrival. Quiet Pod RB-404 was a good fit for a group of 2.	2026-01-06 08:00:00+00	55	158	566
169	5	Great study space for a group session. The layout worked well for both laptops and discussion. Workshop Room KHSC-505 was a good fit for a group of 16.	2026-03-14 11:35:12.521772+00	64	48	242
170	4	Good option for a project meeting. The room stayed quiet for the full session. Seminar Room BOB-202 was a good fit for a group of 15.	2025-12-06 02:30:00+00	6	148	130
171	5	Excellent room for revision. There were enough sockets and seating for everyone in the group. Project Room WMB-505 was a good fit for a group of 11.	2026-02-25 09:00:00+00	58	11	367
172	4	Useful room and easy to find. The room stayed quiet for the full session. Collaboration Suite WMB-606 was a good fit for a group of 7.	2025-11-21 03:00:00+00	67	165	76
173	3	The room was acceptable. It worked for the session, though the setup was only average. Seminar Room BOB-303 felt less suitable than expected.	2026-02-10 14:30:00+00	24	17	328
174	5	Great study space for a group session. The location was convenient between classes. Collaboration Suite AL-404 was a good fit for a group of 10.	2026-02-12 21:00:00+00	28	43	630
175	4	Solid room overall. The room stayed quiet for the full session. Study Room KHSC-202 was a good fit for a group of 4.	2026-01-03 01:30:00+00	34	103	78
176	5	Great study space for a group session. The equipment list matched what was available on arrival. Collaboration Suite SAB-505 was a good fit for a group of 9.	2026-01-24 16:30:00+00	51	75	327
177	5	Excellent room for revision. The layout worked well for both laptops and discussion. Collaboration Suite LB-404 was a good fit for a group of 11.	2026-02-11 13:00:00+00	32	126	556
178	3	The booking worked but the room was average. The room was usable, but the ventilation could be better. Study Room SAB-208 felt less suitable than expected.	2025-12-26 16:30:00+00	74	117	493
179	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Collaboration Suite WMB-606 was a good fit for a group of 7.	2025-12-07 14:00:00+00	67	20	416
180	2	Not ideal for a long session. It worked in the end, but the setup did not suit group work. Project Room RB-101 felt less suitable than expected.	2025-12-17 22:00:00+00	7	72	82
181	3	A decent option for short sessions. The room was usable, but the ventilation could be better. Study Room SAB-107 felt less suitable than expected.	2025-11-23 20:00:00+00	60	46	154
182	5	Great study space for a group session. The equipment list matched what was available on arrival. Seminar Room BOB-404 was a good fit for a group of 18.	2026-01-21 02:00:00+00	26	113	662
183	4	Solid room overall. There were enough sockets and seating for everyone in the group. Seminar Room BOB-303 was a good fit for a group of 13.	2026-02-23 20:30:00+00	24	102	481
184	1	The room did not meet expectations. It worked in the end, but the setup did not suit group work. Seminar Room RLC-505 felt less suitable than expected.	2026-03-15 06:35:12.521772+00	37	165	602
185	3	The room was acceptable. The room was fine, although it felt a little cramped at peak time. Focus Booth WMB-303 felt less suitable than expected.	2026-01-01 13:00:00+00	21	150	640
186	5	Great study space for a group session. The equipment list matched what was available on arrival. Collaboration Suite KHSC-303 was a good fit for a group of 11.	2025-11-29 06:00:00+00	39	25	39
187	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Collaboration Suite RLC-202 was a good fit for a group of 10.	2026-02-16 21:30:00+00	11	131	588
188	5	Quiet room with everything we needed. The layout worked well for both laptops and discussion. Study Room KHSC-202 was a good fit for a group of 4.	2026-02-25 15:00:00+00	34	125	619
189	2	Not ideal for a long session. The space felt noisy compared with similar rooms nearby. Focus Booth WMB-303 felt less suitable than expected.	2026-01-19 05:30:00+00	21	148	117
190	5	Quiet room with everything we needed. The location was convenient between classes. Seminar Room KHSC-208 was a good fit for a group of 18.	2026-03-01 09:30:00+00	71	72	200
191	4	Useful room and easy to find. The layout worked well for both laptops and discussion. Study Room KHSC-202 was a good fit for a group of 4.	2025-12-10 12:00:00+00	34	161	138
192	5	Excellent room for revision. The location was convenient between classes. Quiet Pod AL-303 was a good fit for a group of 2.	2026-01-27 01:30:00+00	27	124	466
193	5	Quiet room with everything we needed. There were enough sockets and seating for everyone in the group. Project Room LB-303 was a good fit for a group of 8.	2026-01-27 05:00:00+00	17	86	565
194	3	The booking worked but the room was average. The booking itself was easy, but the space could be cleaner. Quiet Pod AL-303 felt less suitable than expected.	2026-01-19 03:00:00+00	27	72	400
195	4	Good option for a project meeting. The equipment list matched what was available on arrival. Collaboration Suite WMB-606 was a good fit for a group of 7.	2025-12-25 07:00:00+00	67	112	89
196	2	Not ideal for a long session. The room was harder to access than expected during a busy period. Study Room SAB-107 felt less suitable than expected.	2026-02-25 12:00:00+00	60	26	126
197	4	Good option for a project meeting. The room stayed quiet for the full session. Workshop Room SAB-309 was a good fit for a group of 15.	2026-02-26 03:30:00+00	75	77	410
198	4	Useful room and easy to find. The location was convenient between classes. Study Room RB-606 was a good fit for a group of 6.	2026-01-19 14:00:00+00	68	173	111
199	5	Great study space for a group session. The equipment list matched what was available on arrival. Quiet Pod RB-404 was a good fit for a group of 2.	2026-01-16 07:00:00+00	55	131	112
200	5	Quiet room with everything we needed. The layout worked well for both laptops and discussion. Collaboration Suite AL-404 was a good fit for a group of 10.	2026-01-10 09:30:00+00	28	46	156
201	4	Good option for a project meeting. The room stayed quiet for the full session. Project Room RLC-101 was a good fit for a group of 9.	2026-01-11 04:00:00+00	5	148	557
202	3	The booking worked but the room was average. It worked for the session, though the setup was only average. Collaboration Suite RB-505 felt less suitable than expected.	2026-01-01 09:30:00+00	63	109	628
203	4	Good option for a project meeting. The room stayed quiet for the full session. Quiet Pod SAB-404 was a good fit for a group of 2.	2026-02-20 12:00:00+00	25	168	245
204	5	Quiet room with everything we needed. The room stayed quiet for the full session. Quiet Pod RB-404 was a good fit for a group of 2.	2026-01-27 22:00:00+00	55	91	49
205	4	Solid room overall. The location was convenient between classes. Collaboration Suite RB-505 was a good fit for a group of 10.	2026-03-14 01:00:00+00	63	47	136
206	5	Excellent room for revision. The layout worked well for both laptops and discussion. Collaboration Suite AL-404 was a good fit for a group of 10.	2026-01-26 01:00:00+00	28	24	52
207	3	The booking worked but the room was average. The room was usable, but the ventilation could be better. Study Room AL-214 felt less suitable than expected.	2026-03-14 11:35:12.521772+00	76	163	344
208	1	The room did not meet expectations. It worked in the end, but the setup did not suit group work. Seminar Room BOB-303 felt less suitable than expected.	2026-03-06 22:00:00+00	24	89	611
209	4	Good option for a project meeting. The layout worked well for both laptops and discussion. Study Room WMB-101 was a good fit for a group of 8.	2026-02-13 16:30:00+00	12	88	529
210	4	Solid room overall. The room stayed quiet for the full session. Collaboration Suite LB-404 was a good fit for a group of 11.	2025-12-25 04:00:00+00	32	64	390
211	4	Solid room overall. There were enough sockets and seating for everyone in the group. Project Room SAB-303 was a good fit for a group of 10.	2026-01-14 00:30:00+00	23	17	641
212	3	The booking worked but the room was average. The room was fine, although it felt a little cramped at peak time. Room 101 felt less suitable than expected.	2026-01-14 21:00:00+00	1	143	143
213	1	The room did not meet expectations. The space felt noisy compared with similar rooms nearby. Workshop Room RB-303 felt less suitable than expected.	2026-03-15 13:00:00+00	48	136	642
214	4	Good option for a project meeting. The layout worked well for both laptops and discussion. Study Room AL-410 was a good fit for a group of 5.	2026-02-19 20:00:00+00	59	11	140
215	5	Quiet room with everything we needed. The location was convenient between classes. Quiet Pod WMB-404 was a good fit for a group of 3.	2026-03-14 01:30:00+00	30	53	79
216	5	Very smooth booking experience. The location was convenient between classes. Focus Booth WMB-303 was a good fit for a group of 1.	2025-11-28 23:00:00+00	21	34	571
217	4	Good option for a project meeting. There were enough sockets and seating for everyone in the group. Focus Booth AL-606 was a good fit for a group of 2.	2026-01-01 14:00:00+00	50	11	132
218	5	Great study space for a group session. The layout worked well for both laptops and discussion. Project Room RB-101 was a good fit for a group of 10.	2026-02-15 14:30:00+00	7	51	670
219	4	Solid room overall. The equipment list matched what was available on arrival. Collaboration Suite RLC-202 was a good fit for a group of 10.	2026-01-19 06:30:00+00	11	156	653
220	2	The room was usable but had some issues. The space felt noisy compared with similar rooms nearby. Study Room AL-101 felt less suitable than expected.	2026-02-13 04:00:00+00	13	78	217
221	4	Useful room and easy to find. The location was convenient between classes. Collaboration Suite KHSC-303 was a good fit for a group of 11.	2026-01-14 05:30:00+00	39	150	524
222	5	Great study space for a group session. The location was convenient between classes. Collaboration Suite RLC-202 was a good fit for a group of 10.	2026-03-09 14:00:00+00	11	158	654
223	3	The booking worked but the room was average. The room was fine, although it felt a little cramped at peak time. Study Room ERC-101 felt less suitable than expected.	2025-11-23 22:30:00+00	22	67	532
224	3	A decent option for short sessions. It worked for the session, though the setup was only average. Collaboration Suite RLC-303 felt less suitable than expected.	2026-03-09 05:00:00+00	14	157	462
225	3	The room was acceptable. The room was usable, but the ventilation could be better. Project Room RLC-101 felt less suitable than expected.	2025-12-23 05:30:00+00	5	165	163
226	4	Useful room and easy to find. The layout worked well for both laptops and discussion. Study Room KHSC-202 was a good fit for a group of 4.	2026-03-15 08:35:12.521772+00	34	165	47
227	4	Solid room overall. The equipment list matched what was available on arrival. Workshop Room RB-303 was a good fit for a group of 21.	2025-12-13 23:00:00+00	48	158	514
228	5	Quiet room with everything we needed. There were enough sockets and seating for everyone in the group. Collaboration Suite WMB-606 was a good fit for a group of 7.	2026-03-15 10:35:12.521772+00	67	98	314
229	5	Excellent room for revision. The layout worked well for both laptops and discussion. Study Room AL-612 was a good fit for a group of 4.	2025-12-25 16:30:00+00	69	56	311
230	3	The room was acceptable. The room was usable, but the ventilation could be better. Study Room KHSC-202 felt less suitable than expected.	2026-03-05 22:30:00+00	34	72	518
231	5	Great study space for a group session. The location was convenient between classes. Study Room AL-101 was a good fit for a group of 7.	2026-03-14 20:35:12.521772+00	13	46	95
232	4	Comfortable space for a study block. The layout worked well for both laptops and discussion. Study Room LB-202 was a good fit for a group of 4.	2025-12-24 08:30:00+00	4	115	577
233	4	Comfortable space for a study block. The equipment list matched what was available on arrival. Study Room KHSC-202 was a good fit for a group of 4.	2026-01-31 17:00:00+00	34	47	522
234	4	Solid room overall. There were enough sockets and seating for everyone in the group. Study Room ERC-404 was a good fit for a group of 4.	2026-01-18 02:30:00+00	73	150	131
235	5	Very smooth booking experience. The room stayed quiet for the full session. Workshop Room RB-303 was a good fit for a group of 21.	2025-12-31 17:30:00+00	48	103	329
236	3	The booking worked but the room was average. The room was usable, but the ventilation could be better. Seminar Room KHSC-208 felt less suitable than expected.	2026-02-09 11:00:00+00	71	98	473
237	5	Excellent room for revision. The room stayed quiet for the full session. Collaboration Suite LB-404 was a good fit for a group of 11.	2026-02-27 15:00:00+00	32	82	94
238	2	The room was usable but had some issues. It worked in the end, but the setup did not suit group work. Workshop Room RB-303 felt less suitable than expected.	2026-01-15 02:00:00+00	48	108	601
239	3	The booking worked but the room was average. The room was usable, but the ventilation could be better. Seminar Room BOB-303 felt less suitable than expected.	2025-12-17 13:30:00+00	24	18	669
240	5	Quiet room with everything we needed. There were enough sockets and seating for everyone in the group. Quiet Pod RB-404 was a good fit for a group of 2.	2026-01-14 00:30:00+00	55	158	519
241	4	Good option for a project meeting. The layout worked well for both laptops and discussion. Quiet Pod RB-404 was a good fit for a group of 2.	2026-02-21 04:30:00+00	55	82	178
242	4	Useful room and easy to find. The location was convenient between classes. Workshop Room RB-303 was a good fit for a group of 21.	2026-01-03 17:00:00+00	48	113	430
243	3	The room was acceptable. It worked for the session, though the setup was only average. Room 101 felt less suitable than expected.	2026-02-13 10:00:00+00	1	26	444
244	4	Useful room and easy to find. The layout worked well for both laptops and discussion. Project Room RLC-101 was a good fit for a group of 9.	2026-01-28 19:30:00+00	5	82	618
245	3	The booking worked but the room was average. The room was usable, but the ventilation could be better. Room 101 felt less suitable than expected.	2025-12-19 12:00:00+00	1	67	373
246	4	Comfortable space for a study block. The location was convenient between classes. Project Room RLC-101 was a good fit for a group of 9.	2025-12-30 16:30:00+00	5	102	161
247	5	Great study space for a group session. There were enough sockets and seating for everyone in the group. Collaboration Suite WMB-606 was a good fit for a group of 7.	2026-02-12 05:00:00+00	67	81	423
248	4	Comfortable space for a study block. The layout worked well for both laptops and discussion. Collaboration Suite KHSC-606 was a good fit for a group of 8.	2025-12-21 03:30:00+00	66	166	123
249	5	Great study space for a group session. The equipment list matched what was available on arrival. Study Room WMB-202 was a good fit for a group of 8.	2026-02-12 15:00:00+00	20	155	305
250	2	The room was usable but had some issues. A few of the facilities listed online were not ready when we arrived. Quiet Pod AL-511 felt less suitable than expected.	2026-01-27 09:30:00+00	61	140	651
251	4	Solid room overall. The location was convenient between classes. Collaboration Suite SAB-202 was a good fit for a group of 10.	2025-12-08 14:00:00+00	16	113	543
252	5	Excellent room for revision. The equipment list matched what was available on arrival. Workshop Room RB-303 was a good fit for a group of 21.	2025-12-31 19:30:00+00	48	98	142
253	3	A decent option for short sessions. The room was fine, although it felt a little cramped at peak time. Study Room TALC-404 felt less suitable than expected.	2026-03-06 22:00:00+00	45	74	258
254	4	Useful room and easy to find. The location was convenient between classes. Room 101 was a good fit for a group of 6.	2026-03-13 09:00:00+00	1	65	446
255	3	The room was acceptable. The room was usable, but the ventilation could be better. Focus Booth WMB-303 felt less suitable than expected.	2026-02-05 12:30:00+00	21	46	66
256	3	The booking worked but the room was average. The booking itself was easy, but the space could be cleaner. Collaboration Suite LB-404 felt less suitable than expected.	2026-03-14 05:35:12.521772+00	32	72	193
257	5	Excellent room for revision. The room stayed quiet for the full session. Collaboration Suite RLC-202 was a good fit for a group of 10.	2025-12-06 18:00:00+00	11	164	455
258	4	Comfortable space for a study block. The room stayed quiet for the full session. Workshop Room RB-303 was a good fit for a group of 21.	2026-02-21 17:00:00+00	48	98	425
259	1	The room did not meet expectations. A few of the facilities listed online were not ready when we arrived. Study Room ERC-404 felt less suitable than expected.	2025-12-23 16:00:00+00	73	44	649
260	4	Solid room overall. The location was convenient between classes. Seminar Room KHSC-208 was a good fit for a group of 18.	2026-01-30 11:00:00+00	71	43	673
261	5	Excellent room for revision. The layout worked well for both laptops and discussion. Study Room KHSC-202 was a good fit for a group of 4.	2025-11-02 07:00:00+00	34	2	772
262	4	Comfortable space for a study block. The equipment list matched what was available on arrival. Study Room LB-505 was a good fit for a group of 4.	2025-12-16 00:30:00+00	52	2	755
263	4	Good option for a project meeting. The equipment list matched what was available on arrival. Study Room JMSL-202 was a good fit for a group of 4.	2025-10-13 08:00:00+00	15	2	741
264	3	A decent option for short sessions. The room was usable, but the ventilation could be better. Collaboration Suite SAB-505 felt less suitable than expected.	2025-10-24 11:00:00+00	51	2	780
265	5	Excellent room for revision. The room stayed quiet for the full session. Study Room RLC-309 was a good fit for a group of 4.	2025-12-07 13:00:00+00	49	2	697
266	3	The room was acceptable. It worked for the session, though the setup was only average. Study Room WMB-101 felt less suitable than expected.	2025-11-29 12:00:00+00	12	2	770
267	5	Very smooth booking experience. There were enough sockets and seating for everyone in the group. Quiet Pod WMB-404 was a good fit for a group of 3.	2025-11-26 12:00:00+00	30	2	693
268	5	Quiet room with everything we needed. The room stayed quiet for the full session. Seminar Room BOB-303 was a good fit for a group of 13.	2026-01-11 17:30:00+00	24	2	683
269	5	Quiet room with everything we needed. The location was convenient between classes. Seminar Room BOB-404 was a good fit for a group of 18.	2025-12-10 10:00:00+00	26	2	684
270	4	Solid room overall. The equipment list matched what was available on arrival. Workshop Room SAB-309 was a good fit for a group of 15.	2025-11-20 19:30:00+00	75	2	703
271	3	The room was acceptable. The room was usable, but the ventilation could be better. Workshop Room RB-303 felt less suitable than expected.	2026-03-03 21:30:00+00	48	2	749
272	1	This booking was frustrating to use. It worked in the end, but the setup did not suit group work. Study Room JMSL-202 felt less suitable than expected.	2026-01-07 08:30:00+00	15	2	737
273	5	Very smooth booking experience. There were enough sockets and seating for everyone in the group. Seminar Room RLC-107 was a good fit for a group of 18.	2025-10-28 00:00:00+00	46	2	752
274	2	The room was usable but had some issues. The room was harder to access than expected during a busy period. Study Room WMB-202 felt less suitable than expected.	2025-12-18 06:00:00+00	20	2	725
275	4	Comfortable space for a study block. The equipment list matched what was available on arrival. Workshop Room SAB-309 was a good fit for a group of 15.	2026-03-04 19:30:00+00	75	2	712
276	4	Useful room and easy to find. The room stayed quiet for the full session. Study Room KHSC-202 was a good fit for a group of 4.	2026-01-17 00:00:00+00	34	2	744
277	5	Excellent room for revision. There were enough sockets and seating for everyone in the group. Project Room WMB-505 was a good fit for a group of 11.	2025-12-30 21:30:00+00	58	2	773
278	4	Solid room overall. The equipment list matched what was available on arrival. Room 202 was a good fit for a group of 10.	2025-10-31 16:00:00+00	2	2	713
279	5	Quiet room with everything we needed. The room stayed quiet for the full session. Seminar Room RLC-107 was a good fit for a group of 18.	2025-11-03 15:00:00+00	46	2	719
280	5	Excellent room for revision. The room stayed quiet for the full session. Study Room RB-606 was a good fit for a group of 6.	2026-03-15 01:00:00+00	68	2	733
281	5	Very smooth booking experience. The equipment list matched what was available on arrival. Seminar Room RLC-107 was a good fit for a group of 18.	2025-10-16 19:30:00+00	46	2	692
282	5	Very smooth booking experience. The location was convenient between classes. Study Room KHSC-202 was a good fit for a group of 4.	2026-02-14 12:30:00+00	34	2	714
283	1	This booking was frustrating to use. The room was harder to access than expected during a busy period. Room 202 felt less suitable than expected.	2025-10-26 05:00:00+00	2	2	745
284	4	Good option for a project meeting. The location was convenient between classes. Study Room KHSC-202 was a good fit for a group of 4.	2026-02-14 13:00:00+00	34	2	761
285	4	Comfortable space for a study block. The room stayed quiet for the full session. Workshop Room RB-303 was a good fit for a group of 21.	2026-03-01 23:30:00+00	48	2	767
286	5	Great study space for a group session. The layout worked well for both laptops and discussion. Collaboration Suite AL-107 was a good fit for a group of 8.	2025-12-10 08:30:00+00	53	2	690
287	5	Excellent room for revision. The room stayed quiet for the full session. Workshop Room ERC-303 was a good fit for a group of 22.	2026-02-26 19:30:00+00	36	2	782
288	4	Good option for a project meeting. There were enough sockets and seating for everyone in the group. Focus Booth RLC-208 was a good fit for a group of 1.	2025-10-26 01:00:00+00	47	2	726
289	4	Solid room overall. The layout worked well for both laptops and discussion. Study Room RB-202 was a good fit for a group of 7.	2025-11-26 14:00:00+00	42	2	750
290	4	Useful room and easy to find. The location was convenient between classes. Collaboration Suite AL-309 was a good fit for a group of 7.	2025-11-15 20:30:00+00	57	2	768
291	3	The room was acceptable. The room was fine, although it felt a little cramped at peak time. Workshop Room SAB-309 felt less suitable than expected.	2025-11-20 19:00:00+00	75	2	724
292	5	Quiet room with everything we needed. There were enough sockets and seating for everyone in the group. Study Room LB-505 was a good fit for a group of 4.	2025-12-18 23:30:00+00	52	2	698
293	3	The room was acceptable. The booking itself was easy, but the space could be cleaner. Study Room RLC-309 felt less suitable than expected.	2025-12-13 21:30:00+00	49	2	689
294	5	Excellent room for revision. The equipment list matched what was available on arrival. Study Room KHSC-107 was a good fit for a group of 6.	2025-11-15 03:00:00+00	70	2	776
295	3	The booking worked but the room was average. The room was fine, although it felt a little cramped at peak time. Project Room RLC-101 felt less suitable than expected.	2025-11-08 08:30:00+00	5	2	715
296	4	Solid room overall. The layout worked well for both laptops and discussion. Study Room LB-505 was a good fit for a group of 4.	2026-01-17 06:00:00+00	52	2	765
297	5	Excellent room for revision. The location was convenient between classes. Workshop Room ERC-303 was a good fit for a group of 22.	2026-01-11 02:00:00+00	36	2	682
298	4	Useful room and easy to find. The layout worked well for both laptops and discussion. Study Room RLC-309 was a good fit for a group of 4.	2026-02-12 11:00:00+00	49	2	706
299	4	Solid room overall. The location was convenient between classes. Study Room KHSC-202 was a good fit for a group of 4.	2026-02-09 02:30:00+00	34	2	781
300	5	Excellent room for revision. There were enough sockets and seating for everyone in the group. Workshop Room KHSC-505 was a good fit for a group of 16.	2025-11-07 00:30:00+00	64	2	786
301	4	Comfortable space for a study block. The location was convenient between classes. Study Room LB-202 was a good fit for a group of 4.	2025-10-23 19:00:00+00	4	2	722
302	3	A decent option for short sessions. The booking itself was easy, but the space could be cleaner. Study Room LB-505 felt less suitable than expected.	2025-11-27 09:00:00+00	52	2	762
303	2	The room was usable but had some issues. A few of the facilities listed online were not ready when we arrived. Seminar Room RLC-107 felt less suitable than expected.	2026-01-23 07:30:00+00	46	2	681
304	3	A decent option for short sessions. It worked for the session, though the setup was only average. Workshop Room SAB-309 felt less suitable than expected.	2026-02-15 19:30:00+00	75	2	759
305	4	Comfortable space for a study block. The layout worked well for both laptops and discussion. Seminar Room KHSC-208 was a good fit for a group of 18.	2025-11-03 23:00:00+00	71	2	787
306	4	Good option for a project meeting. The equipment list matched what was available on arrival. Study Room LB-505 was a good fit for a group of 4.	2025-11-29 17:00:00+00	52	2	687
307	4	Comfortable space for a study block. The equipment list matched what was available on arrival. Workshop Room ERC-303 was a good fit for a group of 22.	2025-12-17 04:30:00+00	36	2	748
308	4	Useful room and easy to find. The location was convenient between classes. Study Room LB-606 was a good fit for a group of 5.	2026-01-04 22:00:00+00	62	2	766
309	2	Not ideal for a long session. The room was harder to access than expected during a busy period. Study Room SAB-606 felt less suitable than expected.	2026-03-13 10:00:00+00	54	2	771
310	3	The booking worked but the room was average. The booking itself was easy, but the space could be cleaner. Room 202 felt less suitable than expected.	2026-03-14 22:00:00+00	2	2	753
311	5	Very smooth booking experience. There were enough sockets and seating for everyone in the group. Workshop Room SAB-309 was a good fit for a group of 15.	2025-11-02 23:00:00+00	75	2	792
312	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Study Room RLC-309 was a good fit for a group of 4.	2025-12-14 22:00:00+00	49	2	760
313	4	Solid room overall. The location was convenient between classes. Room 202 was a good fit for a group of 10.	2025-10-13 19:00:00+00	2	2	716
314	5	Quiet room with everything we needed. The room stayed quiet for the full session. Study Room AL-410 was a good fit for a group of 5.	2026-02-06 17:00:00+00	59	2	717
315	4	Comfortable space for a study block. There were enough sockets and seating for everyone in the group. Study Room JMSL-202 was a good fit for a group of 4.	2025-10-30 05:00:00+00	15	2	785
316	4	Useful room and easy to find. The layout worked well for both laptops and discussion. Study Room TALC-101 was a good fit for a group of 4.	2025-12-16 21:00:00+00	9	2	740
317	5	Very smooth booking experience. The room stayed quiet for the full session. Study Room LB-505 was a good fit for a group of 4.	2025-11-21 08:00:00+00	52	2	758
318	5	Quiet room with everything we needed. The layout worked well for both laptops and discussion. Study Room JMSL-202 was a good fit for a group of 4.	2026-02-18 22:00:00+00	15	2	783
319	5	Great study space for a group session. The layout worked well for both laptops and discussion. Study Room AL-214 was a good fit for a group of 8.	2025-11-26 01:00:00+00	76	2	756
320	5	Excellent room for revision. The location was convenient between classes. Study Room KHSC-202 was a good fit for a group of 4.	2026-01-02 06:30:00+00	34	2	699
321	4	Solid room overall. The layout worked well for both laptops and discussion. Study Room LB-202 was a good fit for a group of 4.	2026-01-25 20:00:00+00	4	2	695
322	5	Great study space for a group session. The location was convenient between classes. Study Room KHSC-202 was a good fit for a group of 4.	2026-02-25 21:00:00+00	34	2	789
323	1	The room did not meet expectations. It worked in the end, but the setup did not suit group work. Collaboration Suite RLC-202 felt less suitable than expected.	2026-01-14 19:30:00+00	11	2	685
324	5	Great study space for a group session. The equipment list matched what was available on arrival. Collaboration Suite AL-202 was a good fit for a group of 6.	2026-01-21 04:30:00+00	18	2	738
325	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Project Room WMB-505 was a good fit for a group of 11.	2026-03-13 03:30:00+00	58	2	769
326	1	This booking was frustrating to use. A few of the facilities listed online were not ready when we arrived. Study Room LB-606 felt less suitable than expected.	2026-01-28 03:00:00+00	62	2	700
327	4	Useful room and easy to find. The equipment list matched what was available on arrival. Study Room RLC-404 was a good fit for a group of 4.	2025-11-15 10:30:00+00	19	2	746
328	4	Comfortable space for a study block. The location was convenient between classes. Workshop Room ERC-303 was a good fit for a group of 22.	2025-11-14 06:30:00+00	36	2	704
329	5	Quiet room with everything we needed. There were enough sockets and seating for everyone in the group. Seminar Room RLC-107 was a good fit for a group of 18.	2025-11-28 19:00:00+00	46	2	757
330	4	Comfortable space for a study block. The room stayed quiet for the full session. Study Room AL-214 was a good fit for a group of 8.	2025-12-09 05:30:00+00	76	2	754
331	5	Great study space for a group session. The layout worked well for both laptops and discussion. Seminar Room RLC-511 was a good fit for a group of 15.	2025-11-12 12:00:00+00	78	2	732
332	4	Useful room and easy to find. The location was convenient between classes. Project Room WMB-505 was a good fit for a group of 11.	2026-01-08 11:00:00+00	58	2	686
333	4	Comfortable space for a study block. There were enough sockets and seating for everyone in the group. Project Room LB-303 was a good fit for a group of 8.	2025-11-27 09:00:00+00	17	2	747
334	5	Great study space for a group session. The equipment list matched what was available on arrival. Study Room RLC-309 was a good fit for a group of 4.	2025-12-07 03:30:00+00	49	2	696
335	4	Solid room overall. The layout worked well for both laptops and discussion. Collaboration Suite RB-505 was a good fit for a group of 10.	2026-02-11 09:00:00+00	63	2	723
336	4	Useful room and easy to find. The equipment list matched what was available on arrival. Project Room RLC-101 was a good fit for a group of 9.	2025-10-29 10:00:00+00	5	2	705
337	4	Comfortable space for a study block. There were enough sockets and seating for everyone in the group. Project Room WMB-505 was a good fit for a group of 11.	2025-12-01 14:30:00+00	58	2	764
338	4	Useful room and easy to find. The room stayed quiet for the full session. Project Room WMB-505 was a good fit for a group of 11.	2025-11-25 22:00:00+00	58	2	763
339	4	Useful room and easy to find. The equipment list matched what was available on arrival. Study Room LB-505 was a good fit for a group of 4.	2026-01-23 07:00:00+00	52	2	791
340	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Study Room KHSC-202 was a good fit for a group of 4.	2025-11-22 04:00:00+00	34	2	778
341	5	Excellent room for revision. The location was convenient between classes. Collaboration Suite KHSC-606 was a good fit for a group of 8.	2026-01-21 08:00:00+00	66	2	707
342	3	The room was acceptable. It worked for the session, though the setup was only average. Seminar Room RLC-107 felt less suitable than expected.	2025-11-28 15:00:00+00	46	2	734
343	3	The room was acceptable. It worked for the session, though the setup was only average. Collaboration Suite AL-113 felt less suitable than expected.	2025-12-26 08:30:00+00	72	2	730
344	5	Quiet room with everything we needed. The equipment list matched what was available on arrival. Seminar Room RLC-505 was a good fit for a group of 10.	2026-01-18 01:00:00+00	37	2	784
345	4	Comfortable space for a study block. The location was convenient between classes. Workshop Room SAB-309 was a good fit for a group of 15.	2026-01-04 04:30:00+00	75	2	751
346	4	Solid room overall. The equipment list matched what was available on arrival. Focus Booth RLC-208 was a good fit for a group of 1.	2025-11-20 02:30:00+00	47	2	694
347	2	Not ideal for a long session. A few of the facilities listed online were not ready when we arrived. Study Room TALC-101 felt less suitable than expected.	2026-01-07 04:00:00+00	9	2	779
348	3	The room was acceptable. The room was usable, but the ventilation could be better. Quiet Pod AL-511 felt less suitable than expected.	2025-11-05 17:30:00+00	61	2	790
349	5	Great study space for a group session. The layout worked well for both laptops and discussion. Room 202 was a good fit for a group of 10.	2025-10-17 21:30:00+00	2	2	743
350	4	Useful room and easy to find. There were enough sockets and seating for everyone in the group. Collaboration Suite LB-404 was a good fit for a group of 11.	2026-03-05 09:30:00+00	32	2	742
351	4	Solid room overall. The layout worked well for both laptops and discussion. Collaboration Suite KHSC-303 was a good fit for a group of 11.	2026-02-05 19:30:00+00	39	2	711
352	3	The booking worked but the room was average. The booking itself was easy, but the space could be cleaner. Seminar Room BOB-202 felt less suitable than expected.	2025-11-08 04:30:00+00	6	2	775
353	4	Comfortable space for a study block. There were enough sockets and seating for everyone in the group. Study Room RLC-309 was a good fit for a group of 4.	2026-01-31 09:00:00+00	49	2	720
354	3	A decent option for short sessions. The room was usable, but the ventilation could be better. Study Room AL-410 felt less suitable than expected.	2026-03-11 15:00:00+00	59	2	739
355	4	Solid room overall. The layout worked well for both laptops and discussion. Study Room RLC-309 was a good fit for a group of 4.	2026-02-02 18:30:00+00	49	2	788
\.


--
-- Data for Name: rooms_building; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rooms_building (id, name, campus_area, opening_hours) FROM stdin;
1	Library Building	Main Campus	08:00-22:00
2	James McCune Smith Learning Hub	West End Campus	00:00-23:59
3	Boyd Orr Building	Main Campus	00:00-23:59
4	Anderson Library	Main Campus	08:00-22:00
5	Teaching and Learning Centre	Main Campus	08:00-21:30
6	Adam Smith Building	Main Campus	08:30-20:00
7	Rankine Building	West End Campus	08:00-22:00
8	St Andrews Building	West End Campus	08:00-21:00
9	Engineering Research Centre	North Campus	07:30-22:30
10	Kelvin Hall Study Centre	West End Campus	09:00-21:00
11	Wolfson Medical Building	South Campus	07:00-20:30
12	Riverside Learning Commons	Riverside Campus	08:00-23:00
13	Tmp Building	Main	08:00-20:00
\.


--
-- Data for Name: rooms_equipment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rooms_equipment (id, name, status) FROM stdin;
1	Projector	available
2	Whiteboard	available
3	Power Socket	available
4	Monitor	available
5	Computer	available
6	Television	unavailable
7	HDMI Display	maintenance
8	Dual Monitors	available
9	Video Conferencing	limited
10	Power Sockets	available
11	Moveable Tables	available
12	Smart Screen	available
13	Lecture Capture	available
14	Accessible Desk	available
15	Air Purifier	maintenance
16	Acoustic Panels	available
17	Printer Access	available
18	Window Blinds	available
\.


--
-- Data for Name: rooms_room; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rooms_room (id, name, capacity, location, is_active, building_id) FROM stdin;
1	Room 101	6	First Floor	t	1
2	Room 202	10	Second Floor	t	2
3	1028 Lab	50	Ten Floor	f	3
4	Study Room LB-202	4	Level 2, North Wing	t	1
5	Project Room RLC-101	9	Level 1, South Wing	t	12
6	Seminar Room BOB-202	15	Level 2, Central Wing	t	3
7	Project Room RB-101	10	Level 1, North Wing	t	7
8	Project Room KHSC-101	13	Level 1, South Wing	t	10
9	Study Room TALC-101	4	Level 1, West Wing	t	5
10	Study Room SAB-101	8	Level 1, North Wing	t	8
11	Collaboration Suite RLC-202	10	Level 2, West Wing	t	12
12	Study Room WMB-101	8	Level 1, West Wing	t	11
13	Study Room AL-101	7	Level 1, Central Wing	t	4
14	Collaboration Suite RLC-303	8	Level 3, West Wing	t	12
15	Study Room JMSL-202	4	Level 2, North Wing	t	2
16	Collaboration Suite SAB-202	10	Level 2, Central Wing	t	8
17	Project Room LB-303	8	Level 3, East Wing	t	1
18	Collaboration Suite AL-202	6	Level 2, North Wing	t	4
19	Study Room RLC-404	4	Level 4, South Wing	t	12
20	Study Room WMB-202	8	Level 2, East Wing	t	11
21	Focus Booth WMB-303	1	Level 3, North Wing	t	11
22	Study Room ERC-101	7	Level 1, Central Wing	t	9
23	Project Room SAB-303	10	Level 3, East Wing	t	8
24	Seminar Room BOB-303	13	Level 3, West Wing	t	3
25	Quiet Pod SAB-404	2	Level 4, Central Wing	t	8
26	Seminar Room BOB-404	18	Level 4, East Wing	t	3
27	Quiet Pod AL-303	2	Level 3, West Wing	t	4
28	Collaboration Suite AL-404	10	Level 4, West Wing	t	4
29	Workshop Room TALC-202	17	Level 2, North Wing	t	5
30	Quiet Pod WMB-404	3	Level 4, West Wing	t	11
31	Project Room ASB-101	14	Level 1, North Wing	t	6
32	Collaboration Suite LB-404	11	Level 4, West Wing	t	1
33	Study Room ASB-202	4	Level 2, Central Wing	t	6
34	Study Room KHSC-202	4	Level 2, North Wing	t	10
35	Quiet Pod ERC-202	4	Level 2, South Wing	f	9
36	Workshop Room ERC-303	22	Level 3, North Wing	t	9
37	Seminar Room RLC-505	10	Level 5, West Wing	t	12
38	Seminar Room RLC-606	15	Level 6, Central Wing	t	12
39	Collaboration Suite KHSC-303	11	Level 3, West Wing	t	10
40	Workshop Room TALC-303	24	Level 3, North Wing	f	5
41	Study Room JMSL-303	8	Level 3, North Wing	t	2
42	Study Room RB-202	7	Level 2, East Wing	t	7
43	Collaboration Suite KHSC-404	7	Level 4, Central Wing	t	10
44	Focus Booth AL-505	1	Level 5, West Wing	f	4
45	Study Room TALC-404	5	Level 4, South Wing	t	5
46	Seminar Room RLC-107	18	Level 1, East Wing	t	12
47	Focus Booth RLC-208	1	Level 2, West Wing	t	12
48	Workshop Room RB-303	21	Level 3, West Wing	t	7
49	Study Room RLC-309	4	Level 3, East Wing	t	12
50	Focus Booth AL-606	2	Level 6, Central Wing	t	4
51	Collaboration Suite SAB-505	9	Level 5, East Wing	t	8
52	Study Room LB-505	4	Level 5, East Wing	t	1
53	Collaboration Suite AL-107	8	Level 1, Central Wing	t	4
54	Study Room SAB-606	6	Level 6, East Wing	t	8
55	Quiet Pod RB-404	2	Level 4, East Wing	t	7
56	Study Room AL-208	6	Level 2, South Wing	t	4
57	Collaboration Suite AL-309	7	Level 3, South Wing	t	4
58	Project Room WMB-505	11	Level 5, North Wing	t	11
59	Study Room AL-410	5	Level 4, East Wing	t	4
60	Study Room SAB-107	6	Level 1, West Wing	t	8
61	Quiet Pod AL-511	2	Level 5, East Wing	t	4
62	Study Room LB-606	5	Level 6, East Wing	t	1
63	Collaboration Suite RB-505	10	Level 5, East Wing	t	7
64	Workshop Room KHSC-505	16	Level 5, East Wing	t	10
65	Collaboration Suite JMSL-404	8	Level 4, North Wing	t	2
66	Collaboration Suite KHSC-606	8	Level 6, North Wing	t	10
67	Collaboration Suite WMB-606	7	Level 6, Central Wing	t	11
68	Study Room RB-606	6	Level 6, West Wing	t	7
69	Study Room AL-612	4	Level 6, East Wing	t	4
70	Study Room KHSC-107	6	Level 1, South Wing	t	10
71	Seminar Room KHSC-208	18	Level 2, North Wing	t	10
72	Collaboration Suite AL-113	6	Level 1, West Wing	t	4
73	Study Room ERC-404	4	Level 4, Central Wing	t	9
74	Study Room SAB-208	7	Level 2, North Wing	t	8
75	Workshop Room SAB-309	15	Level 3, Central Wing	t	8
76	Study Room AL-214	8	Level 2, Central Wing	t	4
77	Workshop Room RLC-410	23	Level 4, Central Wing	f	12
78	Seminar Room RLC-511	15	Level 5, West Wing	t	12
79	Tmp Room	4	L1	t	13
\.


--
-- Data for Name: rooms_room_equipment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rooms_room_equipment (id, room_id, equipment_id) FROM stdin;
1	1	1
2	1	2
3	2	3
4	2	4
5	3	2
6	3	5
7	4	1
8	4	15
9	5	4
10	5	5
11	6	4
12	6	6
13	6	7
14	6	15
15	6	18
16	7	17
17	7	11
18	7	4
19	7	7
20	8	9
21	8	11
22	8	12
23	8	13
24	9	1
25	9	2
26	9	4
27	9	6
28	10	11
29	10	4
30	10	14
31	10	15
32	11	3
33	11	5
34	11	8
35	11	12
36	11	13
37	12	1
38	12	14
39	13	2
40	13	5
41	13	14
42	13	7
43	14	18
44	14	12
45	14	14
46	15	17
47	15	11
48	15	4
49	16	3
50	16	7
51	16	10
52	16	12
53	16	15
54	17	10
55	17	6
56	18	8
57	18	18
58	18	13
59	19	16
60	19	17
61	19	10
62	19	4
63	20	17
64	20	11
65	20	5
66	20	14
67	21	17
68	22	3
69	22	4
70	23	10
71	23	3
72	23	12
73	23	7
74	24	5
75	24	6
76	24	10
77	24	11
78	24	13
79	24	15
80	25	18
81	25	11
82	25	7
83	26	8
84	26	5
85	26	13
86	26	14
87	27	16
88	27	12
89	27	15
90	28	1
91	28	5
92	28	8
93	28	13
94	28	15
95	29	18
96	29	2
97	29	13
98	30	10
99	30	2
100	30	6
101	31	17
102	31	18
103	32	1
104	32	2
105	32	6
106	32	7
107	32	14
108	33	18
109	33	3
110	33	14
111	33	15
112	34	2
113	34	15
114	35	16
115	35	9
116	36	8
117	36	10
118	36	12
119	36	7
120	37	1
121	37	6
122	37	9
123	37	11
124	37	12
125	37	14
126	38	8
127	38	2
128	38	13
129	38	6
130	39	12
131	39	5
132	39	14
133	39	6
134	40	1
135	40	4
136	40	6
137	40	15
138	41	9
139	41	4
140	41	13
141	42	17
142	42	10
143	43	2
144	43	9
145	43	11
146	43	13
147	43	15
148	44	6
149	44	15
150	45	9
151	45	12
152	46	5
153	46	10
154	46	11
155	46	15
156	46	18
157	47	18
158	47	6
159	48	8
160	48	3
161	48	12
162	48	6
163	49	16
164	49	11
165	49	4
166	50	2
167	50	12
168	51	17
169	51	13
170	51	14
171	52	9
172	52	18
173	52	11
174	53	9
175	53	2
176	53	18
177	54	11
178	54	12
179	55	17
180	55	2
181	56	17
182	56	11
183	56	6
184	57	2
185	57	7
186	57	14
187	57	15
188	57	16
189	58	16
190	58	17
191	58	12
192	58	7
193	59	8
194	59	9
195	59	5
196	59	6
197	60	17
198	60	11
199	60	4
200	61	4
201	61	5
202	61	14
203	62	11
204	62	14
205	62	7
206	63	8
207	63	9
208	63	14
209	63	15
210	64	5
211	64	6
212	64	7
213	64	11
214	64	16
215	65	17
216	65	2
217	65	13
218	66	1
219	66	7
220	66	10
221	66	11
222	66	15
223	67	16
224	67	9
225	67	2
226	67	4
227	68	13
228	68	6
229	69	10
230	69	18
231	69	2
232	70	17
233	70	18
234	70	11
235	71	2
236	71	7
237	71	8
238	71	11
239	71	18
240	72	17
241	72	10
242	72	11
243	72	6
244	73	1
245	73	2
246	73	4
247	74	8
248	74	18
249	74	13
250	74	6
251	75	17
252	75	10
253	75	3
254	76	9
255	76	6
256	77	5
257	77	7
258	77	8
259	77	12
260	77	15
261	78	6
262	78	9
263	78	13
264	78	14
265	78	16
266	78	17
\.


--
-- Data for Name: users_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, role) FROM stdin;
2	pbkdf2_sha256$1000000$7IphwbIJDdgSZ4aBTWdzFJ$DGfLyps/i86SLnJiTq4pXCX6BbhfYvSJvzJ/Nyi9Xs4=	\N	f	student1			student1@test.com	f	t	2026-03-07 16:58:45.579+00	student
11	pbkdf2_sha256$1000000$wECrSUP6Coafi6TCpDLYnM$WGdj9jqsoPI5ziNBfGYpPntT2pieQK4CKdiB9+BheEc=	\N	f	test			te@qq.com	f	t	2026-03-14 20:45:02.012+00	student
9	pbkdf2_sha256$1000000$9MwgD2U1iUrKVSHzKsST1b$u9+elzBvFA1ha8+y3510LL8ka+0ILMIjZBBa2wwu2RE=	2026-03-15 02:38:34.664815+00	t	admin			2@q.com	t	t	2026-03-10 19:26:02+00	admin
12	pbkdf2_sha256$1000000$M0eCNpUDoD3YLFH3ncj7NW$Jp5cDPM4Zrd0Z2tOwoUCK4atJqIZy2ctPJuq4VFJ1t0=	\N	f	admin_ops_01	Campus	Operations	admin_ops_01@studynest.local	t	t	2025-07-22 11:25:04.046487+00	admin
13	pbkdf2_sha256$1000000$c3tipJYYW40dD5pZN1fKX8$bUfp5gCGSKTD1N0cJI23Hpr2s1C88YAr1f98SH1oUdY=	\N	f	admin_rooms_02	Megan	Stewart	admin_rooms_02@studynest.local	t	t	2025-07-31 16:13:05.134902+00	admin
14	pbkdf2_sha256$1000000$vYJs1mtxjDLrHLmKd2wtYT$5+XqeeUOV+y4eHrIW3N2DgMlKGS3NaaFfyQF8xlY+mU=	\N	f	admin_support_03	Daniel	McLean	admin_support_03@studynest.local	t	t	2025-07-07 17:42:06.332542+00	admin
15	pbkdf2_sha256$1000000$6fUH001vFrkaqIkzHnbv9M$WyHltfLYNop3ttlkJNGMG4ir+NvG45kjlGR53vFDgPk=	\N	f	admin_services_04	Priya	Patel	admin_services_04@studynest.local	t	t	2025-02-27 20:31:07.334873+00	admin
16	pbkdf2_sha256$1000000$n3eibREmb5gwr3Lb9ziKWF$GmEgo490ngUimIroKb3hAaSSLYuMmM+TcGBRHGvRN4M=	\N	f	admin_review_05	Oliver	Fraser	admin_review_05@studynest.local	t	t	2026-01-09 20:17:08.261169+00	admin
17	pbkdf2_sha256$1000000$5CGnAVOU06ujaIbEriPF2S$LZlDEnhXqXV5FmQs2ClG8leB+NzuWgjTuI2jj+YBG7g=	\N	f	student_001	Sophie	Hughes	student_001@student.studynest.local	f	t	2026-02-02 10:05:09.116286+00	student
18	pbkdf2_sha256$1000000$XkgvzuqfBnsnjAZmAYZGHF$iJ/VlY0mcLk+k2oWh2ThyKWurC7XhyZxHzGhKr6BltY=	\N	f	student_002	Jack	Kelly	student_002@student.studynest.local	f	f	2025-07-25 21:31:10.065086+00	student
19	pbkdf2_sha256$1000000$Jfonjrxr4TnnLHBnIxdxJN$ib5kDv8380p0/n8/wCXiuw06MtoJWvq8j0qKsmVnOBo=	\N	f	student_003	Eva	Kelly	student_003@student.studynest.local	f	t	2025-03-03 17:28:11.11297+00	student
20	pbkdf2_sha256$1000000$NokoBTJz6apn8wy5ZFRMDt$SgUGUkMnjIaWWFIiWWz5B+t9q7YHDmvq97WIHJMHoXI=	\N	f	student_004	Eva	Hall	student_004@student.studynest.local	f	t	2025-06-17 11:23:12.507088+00	student
21	pbkdf2_sha256$1000000$CK0fiTB6RfVhypE6wekia9$VffxcsGmvbqfFu9EquobNEomPOKnuR0LmONdSOtmq7A=	\N	f	student_005	Callum	Kelly	student_005@student.studynest.local	f	t	2025-03-13 09:23:13.818422+00	student
22	pbkdf2_sha256$1000000$XpeHhjMX8HJUMflwO3BsGN$Oj8QYdPawHTzfuzezLBcnSrDr2a4HUvHUquyQ0anEeY=	\N	f	student_006	Lucas	Foster	student_006@student.studynest.local	f	t	2025-10-15 00:33:14.856946+00	student
23	pbkdf2_sha256$1000000$2SPDDaOmnik31eCO0CAbvN$pMx3SD8O9KESnQlA2NPM51k/QrNbWzBsAdAi9RVP7KE=	\N	f	student_007	Jack	Patel	student_007@student.studynest.local	f	t	2025-08-22 05:42:16.036464+00	student
24	pbkdf2_sha256$1000000$i9dfJzHjclfWRlx47N3573$F9aOqbZQyylY2SDk59fotfmidC1o8k1GWSWogpGEp2E=	\N	f	student_008	Zoe	Carter	student_008@student.studynest.local	f	t	2025-08-24 09:54:17.100529+00	student
25	pbkdf2_sha256$1000000$EptA01y0Vlb3AjmPPzpvAH$rq7OJ3swZ0+ztbPfjeY5lvUD2D4OihH8m8Q1fWnmmRU=	\N	f	student_009	Eva	Anderson	student_009@student.studynest.local	f	t	2025-04-27 09:05:18.002885+00	student
26	pbkdf2_sha256$1000000$NuAiYH8SMaDGJ8Jn2Lru2o$Yi6i4gJrkQxc/QcwyIO0dseLgha+CZbsE0PNo/f3eh0=	\N	f	student_010	Grace	Campbell	student_010@student.studynest.local	f	t	2025-05-02 10:16:18.868833+00	student
27	pbkdf2_sha256$1000000$IrDgxkqP8gDNtVGWe2Vtht$M8yauvrHzD+GYYsvxkPDdIM9D0N5pDNnfKP8sGGJ6iA=	\N	f	student_011	Emily	Roberts	student_011@student.studynest.local	f	t	2025-12-29 20:49:19.86983+00	student
28	pbkdf2_sha256$1000000$OHXocCPm38Vn2OruGvltQZ$fLvizx6MKYIGE3ONvA4q47bEJpxbnXHhW4Qd/K6PjRc=	\N	f	student_012	Alex	Taylor	student_012@student.studynest.local	f	t	2026-02-04 05:26:20.947783+00	student
29	pbkdf2_sha256$1000000$BWOMp8noXQF0w29W7Xe6ae$pmmmwyS75AnQm8RBxcRjJTNu/vSoM7eSvop/N7JnOKU=	\N	f	student_013	Eva	Hamilton	student_013@student.studynest.local	f	t	2025-01-22 11:35:22.029887+00	student
30	pbkdf2_sha256$1000000$gVrL302zVwU1YzbGxnN8D6$6EDJ2T42x8Z5tx/NeMBnvmcKnH1QfEXnyhnow5AjREI=	\N	f	student_014	Sophie	Wilson	student_014@student.studynest.local	f	t	2025-05-24 08:33:23.014746+00	student
31	pbkdf2_sha256$1000000$nebtYyUzbFsD2BubSL5rhv$DrOyzb5DvJIS4gXhs+5FXmZUaD1N+j126+/SLODREPc=	\N	f	student_015	Harry	Taylor	student_015@student.studynest.local	f	t	2025-09-19 13:25:24.003707+00	student
32	pbkdf2_sha256$1000000$rpAJmVXRZvflsBFsURYEqm$Rj0zcBlu2vLgftAKjSLs4JclThBMaG7+xUKFqpNtDPM=	\N	f	student_016	Hannah	Morris	student_016@student.studynest.local	f	t	2025-06-25 01:18:25.228601+00	student
33	pbkdf2_sha256$1000000$ys3RhXDIM73HJd9k1bLr12$xotPnm6DfeXGBPfgmKGeDshJPCA7rk39OYD+FTcKLDQ=	\N	f	student_017	Thomas	Walker	student_017@student.studynest.local	f	t	2025-11-23 19:51:26.290121+00	student
34	pbkdf2_sha256$1000000$nD8aXddYD4ybAPYHlgEofk$ZpbsghWSqa4z2dQoanLo2qVwny+JcT+jlYhrbvy4ea4=	\N	f	student_018	Thomas	Wilson	student_018@student.studynest.local	f	t	2026-02-23 20:37:27.275327+00	student
35	pbkdf2_sha256$1000000$m6kZEqEcLScS7QXIz9WTei$BQEfBfsWtvy2qhovgLytiYoA60HmSAkRElB7JjGH/1A=	\N	f	student_019	Oliver	Brown	student_019@student.studynest.local	f	t	2025-09-07 23:09:28.190408+00	student
36	pbkdf2_sha256$1000000$IHPPYS2EwpYYCMtvwB565J$zFtjAfMoJrK+5MMB6ovamzYIc98VygKVBdqcNJk4UvQ=	\N	f	student_020	Zoe	Brown	student_020@student.studynest.local	f	t	2025-08-04 09:08:29.051546+00	student
37	pbkdf2_sha256$1000000$rvU5pE8sKYj4KCxNZVI3PA$txWixOdrdgKW+6Sl+t/cDgLQvO06vs5srPMPyP5RBN0=	\N	f	student_021	Emily	Walker	student_021@student.studynest.local	f	t	2025-08-01 22:10:29.932358+00	student
38	pbkdf2_sha256$1000000$Eq6Xiy537UFHWdGwDz3uKr$wZGkCgA4IqqUQTh1KlU/GrSdvvYcnGoz2bjQXyxa548=	\N	f	student_022	Hannah	Brown	student_022@student.studynest.local	f	f	2025-02-15 11:13:30.933847+00	student
39	pbkdf2_sha256$1000000$SVhDww1G4pQIJg61tJFOJN$VphaznjINNpBtw3/9XHPOkRH34S+nWAq7Ixsrz5qCjs=	\N	f	student_023	Alex	Thompson	student_023@student.studynest.local	f	t	2025-08-04 15:36:32.113603+00	student
40	pbkdf2_sha256$1000000$C7qQm8uBH2yKu8OouhcsoC$UdAmVm4zXqi3GtAbVfk51ZJ0wFNKLxmZLbz5FdloEww=	\N	f	student_024	Eva	Martin	student_024@student.studynest.local	f	t	2026-01-05 10:04:33.19802+00	student
41	pbkdf2_sha256$1000000$zTMNzW1zwJony2ga8zLQAm$S6/XKE7mkia/IaNOxSrTnrO74Ohfb4LSRUnACYP2xJQ=	\N	f	student_025	Noah	Young	student_025@student.studynest.local	f	t	2026-02-26 13:27:34.839911+00	student
42	pbkdf2_sha256$1000000$tWrkRwtbHPgiQ3T3WrbJnz$atUb2NnC5LgDFjv+W63EGWgsOW2Xr6Fr5jyhAlgLG54=	\N	f	student_026	Olivia	Martin	student_026@student.studynest.local	f	t	2025-04-28 13:06:36.976037+00	student
43	pbkdf2_sha256$1000000$AAwQzAEBQ3Wp7NiA1j7M87$2oWG0QkMppsp54VVltY3pLpd1oGTpV8ikhb+hATt0cY=	\N	f	student_027	Mia	Smith	student_027@student.studynest.local	f	t	2025-07-14 09:17:38.74239+00	student
44	pbkdf2_sha256$1000000$1QMfSXnjOPI69C404D8MzM$tsv15Tsa14yUDu/qVLJw8T/LczyQrWK/pOYZxQzu2ts=	\N	f	student_028	Thomas	Wilson	student_028@student.studynest.local	f	t	2025-02-23 11:01:40.21202+00	student
45	pbkdf2_sha256$1000000$1vMTBTfTTEciemOWO8JVrN$bqHciWR1uPWTTQPdrlUIT5A6dXinJ7cjuRhXbJ6RNL8=	\N	f	student_029	Emily	MacDonald	student_029@student.studynest.local	f	t	2025-09-18 14:14:42.105691+00	student
46	pbkdf2_sha256$1000000$UGOEiHoUDolRykeXJcf54P$+bpM36PAKufjvtdrsu/TDJ7MFmDXOG91kj9XGGgXxNc=	\N	f	student_030	Amelia	Hamilton	student_030@student.studynest.local	f	t	2026-02-24 01:22:43.759974+00	student
47	pbkdf2_sha256$1000000$OzNKlrGRhU5xwbar3dcjgn$nNXpR8ZZ+mv6SRpK31FIOBEK2PtPHyBJBwjCZe9l5+c=	\N	f	student_031	Amelia	Edwards	student_031@student.studynest.local	f	t	2025-10-12 15:57:45.159427+00	student
48	pbkdf2_sha256$1000000$vKcylNypKa4YM4uCyjsJo6$TvNKaRT6dG+XrSyrVDr5+ryf1DB5rjwcqa4hXfUD3vM=	\N	f	student_032	Thea	Hughes	student_032@student.studynest.local	f	t	2025-07-17 18:58:46.580237+00	student
49	pbkdf2_sha256$1000000$RBcfob5UA4KT7YtBOQeB3b$BpY/J00FSGGS8csYpct84NZr/XPrSDST9M83Hg3H3wU=	\N	f	student_033	Harry	Martin	student_033@student.studynest.local	f	t	2026-02-02 03:38:47.711089+00	student
50	pbkdf2_sha256$1000000$fXAE54karvQ65XEIF8fVCy$Rx3nID79gKL9AZFl1yzjcvCAcDjEzpVk094gTXPFP/M=	\N	f	student_034	Zoe	Kelly	student_034@student.studynest.local	f	t	2025-07-13 14:56:48.687911+00	student
51	pbkdf2_sha256$1000000$ispfD3sNqUc4REIyUCshW6$S0LsxoUAXyHZBQta+9WESWF8vaX1+Ib5sudnJjfMwrw=	\N	f	student_035	Ruby	Mitchell	student_035@student.studynest.local	f	t	2025-02-21 05:59:49.634096+00	student
52	pbkdf2_sha256$1000000$DjGdYNVQla2RJjBGxSgHY4$xhkRrGKmNLHNJmbnDKwZlUXuHMKazlPc72aC1N226sA=	\N	f	student_036	Mason	Evans	student_036@student.studynest.local	f	t	2025-12-08 00:05:50.559759+00	student
53	pbkdf2_sha256$1000000$8G9L7hxG4VpqE7KUUNocgI$Oos7u6SMBvR4yptdqqNmqApucjWIyZswB8WqvppdiNY=	\N	f	student_037	Leo	Foster	student_037@student.studynest.local	f	t	2025-05-25 20:59:51.476835+00	student
54	pbkdf2_sha256$1000000$71D2w1mf1qciUBNgUDnU1L$ePB/PgiLaC9d9QR2FK/4WI8p41sWfjKBN5XfdDqC7CQ=	\N	f	student_038	Liam	Scott	student_038@student.studynest.local	f	f	2026-02-06 04:56:52.385029+00	student
55	pbkdf2_sha256$1000000$SRLTxgli65JfaZgjXJU5Nq$7Wm5JTXF6/9c9obbTCA8XBZeJGigDcjpDfBIsKRpvT4=	\N	f	student_039	William	MacDonald	student_039@student.studynest.local	f	f	2025-12-15 23:57:53.340833+00	student
56	pbkdf2_sha256$1000000$0vaIWYuLZhOv7iZEGnpoWq$XffIbYfOnRKhcQNoPQiyczO+uOKj67voWGkXZf9umk4=	\N	f	student_040	Olivia	Anderson	student_040@student.studynest.local	f	t	2025-03-10 17:30:54.22683+00	student
57	pbkdf2_sha256$1000000$DPGafzWZo1WsFPOHa5Ctqc$E7mndCjkrRbSSCvIXoYG+eH3PO6yxg8R6Sk69ErFHwA=	\N	f	student_041	Mia	Martin	student_041@student.studynest.local	f	t	2025-01-28 05:35:55.26415+00	student
58	pbkdf2_sha256$1000000$1MzhfSnTuRNU6P78736g6J$FJgNIxRK8DsSdawtYm6JXaqOxXddTw/HxdGLdipT24Q=	\N	f	student_042	Zoe	Roberts	student_042@student.studynest.local	f	t	2025-03-23 16:45:56.42471+00	student
59	pbkdf2_sha256$1000000$VOtw1w7QubaR3rF4haMhgI$WJuQ4qgNzumEs6GnDU/ZmQxavxSf9ZD+/hkClwLtO4k=	\N	f	student_043	Amelia	Young	student_043@student.studynest.local	f	f	2025-12-28 19:15:57.715459+00	student
60	pbkdf2_sha256$1000000$TfG0Uen6y3JfV5hBgI9Kv6$KzNcWGuiPUrGKiRFKmRtEQbXFUkQodrj+QvOhOBWEFw=	\N	f	student_044	Grace	MacDonald	student_044@student.studynest.local	f	t	2025-04-21 16:21:58.812905+00	student
61	pbkdf2_sha256$1000000$Cc7XkdAAM2EWCF5XAsShIX$V0WY4TDesC7rbHZcYRmaWKYYQtSR6gLKzovfN/+LK0k=	\N	f	student_045	Mason	Lewis	student_045@student.studynest.local	f	t	2025-03-08 05:05:59.833279+00	student
62	pbkdf2_sha256$1000000$yVuUE0fEmoLhMqj8DeiEwK$pP6xhZrSHoBgGXFbGnv5JYuzWa1nLX+9NjFDZbI+KvY=	\N	f	student_046	Emily	Mitchell	student_046@student.studynest.local	f	t	2025-09-19 18:35:00.889559+00	student
63	pbkdf2_sha256$1000000$sXLuTHYVOunfX5uXXbiLeq$mXM1BF07EbRmFtb7dLwbNna27Ig/PTzJIrEY0CcJKT8=	\N	f	student_047	Benjamin	Lewis	student_047@student.studynest.local	f	t	2025-02-12 21:04:01.936913+00	student
64	pbkdf2_sha256$1000000$3kyzRsswMnvajJkmx2BYYx$WyET+Lr+CefQpVTYe1K6+AsTgRlQ3Oj/wWRfutqbACs=	\N	f	student_048	Thea	Brown	student_048@student.studynest.local	f	f	2025-08-12 15:21:02.873684+00	student
65	pbkdf2_sha256$1000000$O7EWbb4bUgMfLDQLKSl6Oh$h1sOQesYTW9YIyqFUG9ziK1eKoxWbkSqKuD4nayf0KQ=	\N	f	student_049	Eva	Kelly	student_049@student.studynest.local	f	t	2025-12-12 18:23:03.850991+00	student
66	pbkdf2_sha256$1000000$YIHwy307DVAHJO63TSjR3A$gByuiQSKzfuzCnu9O4suDPGMB/l53MQwmYsIDHMFnAU=	\N	f	student_050	Mia	MacDonald	student_050@student.studynest.local	f	f	2025-02-09 02:30:04.833234+00	student
67	pbkdf2_sha256$1000000$gm7dwvQgu7eoUkR0FUsjHA$BKLxmnmRV4O3Uuf75Z8VAWmpXBQFyFXt2iIAb/D0l5o=	\N	f	student_051	James	Scott	student_051@student.studynest.local	f	t	2025-06-16 04:11:05.85658+00	student
68	pbkdf2_sha256$1000000$gxQyR3LHEpM1gvLyK9PRRO$k+HuHw4wt0YaGVoVQ5EDp9UIgPJzK/gm0cd5y+p6/go=	\N	f	student_052	Eleanor	Foster	student_052@student.studynest.local	f	t	2025-05-20 02:04:06.939175+00	student
69	pbkdf2_sha256$1000000$sEw5a7c0DWEpiruBPZzGf1$JSUfP5dtPsZK4TkRjgxSm5s/zKVRcgRy3OZtya2R4/g=	\N	f	student_053	Emily	Walker	student_053@student.studynest.local	f	f	2025-04-11 04:18:07.964642+00	student
70	pbkdf2_sha256$1000000$leRen2zvTaxtAhpRCwNzqQ$+UiN/YQtanEn8ygu2hqm0t4m+nRfyW7FWpEcu9GmEgc=	\N	f	student_054	Alex	Thompson	student_054@student.studynest.local	f	t	2025-09-19 01:01:08.912804+00	student
71	pbkdf2_sha256$1000000$uE82ixnYx3MGT0oZthuLID$3mDNIn0fYVROfr0Z13mhI8GrLQtQM7I3pQobiH0bKDM=	\N	f	student_055	James	Foster	student_055@student.studynest.local	f	t	2026-01-03 17:27:09.952412+00	student
72	pbkdf2_sha256$1000000$sujDD7qIvHGj4DTvTgsowe$AnqEIRj4Cz6ImMwrZD2q5HibZldeNZz+R0+umnghZFA=	\N	f	student_056	Lewis	Morris	student_056@student.studynest.local	f	t	2026-02-28 01:47:11.069024+00	student
73	pbkdf2_sha256$1000000$2HgUJE5fWIDZCOKOvyAda9$q6d/tXAshEnW8HZL/r5MwZhWHVprKjrRxyE6/qsIbek=	\N	f	student_057	Oscar	Graham	student_057@student.studynest.local	f	t	2025-07-25 18:59:12.031822+00	student
74	pbkdf2_sha256$1000000$wM1uPFEfFH1ymxkAR1jiXk$AHKW/uGiizlOyjLIGtyC0fOg510AtUiKPS6yrKvm27E=	\N	f	student_058	Grace	Smith	student_058@student.studynest.local	f	t	2025-04-23 08:40:12.978541+00	student
75	pbkdf2_sha256$1000000$SjUAHe0PYEYwPFZjWdzhZG$YHQOV/8eE5nAGsLIayU+I/HFYKvnU7YBbOCZ0ewXidk=	\N	f	student_059	Eva	Evans	student_059@student.studynest.local	f	f	2025-12-18 16:48:13.95676+00	student
76	pbkdf2_sha256$1000000$JtGc0SaxJtw2y6yL6Godx2$URhLzs0ZLYfbUi2P1b+B2fHvFcipnrvpc9A6lTdAjK8=	\N	f	student_060	Callum	Roberts	student_060@student.studynest.local	f	t	2025-06-02 10:10:15.078636+00	student
77	pbkdf2_sha256$1000000$kgWFsQXeAmgPSWq2nq2d58$P3/jp6v7dua6BNjRatLzWfywu9N6FRXOA3CJrbVJ2Ys=	\N	f	student_061	Benjamin	Campbell	student_061@student.studynest.local	f	t	2025-01-30 11:33:16.117384+00	student
78	pbkdf2_sha256$1000000$hSnOgoHlegDvtetrFFpmUu$R6BtW8HtABBORnFXVf+OTl+2mIV/FZDNQbMSsUqwKNE=	\N	f	student_062	Leo	Smith	student_062@student.studynest.local	f	t	2025-05-13 04:09:17.161805+00	student
79	pbkdf2_sha256$1000000$1XveIlJCGGjOmMS8Ukf4OJ$vb5s74JHuc4Qze+eDxAuzWrUMybFbsi286y5p0JDX1g=	\N	f	student_063	Ethan	Young	student_063@student.studynest.local	f	t	2025-07-09 19:50:18.465442+00	student
80	pbkdf2_sha256$1000000$rwwT3L9WopahKbArdq0AJA$jdtcl4L9M2gZzqU2KZX0yP7paq05eXaxKnYnrya3zps=	\N	f	student_064	Thomas	Bailey	student_064@student.studynest.local	f	t	2026-01-24 18:37:19.63696+00	student
81	pbkdf2_sha256$1000000$vXABaJAnjKRdF2NIwWj0tC$0XPxAk3QS91LU9IzfavdPm3230Qmx/OEM9d4miwk9dE=	\N	f	student_065	Jack	Hall	student_065@student.studynest.local	f	t	2025-07-29 13:26:20.655206+00	student
82	pbkdf2_sha256$1000000$FeV95OUWmOsiGiInwRTsU8$WRdiCsgDurxRyOJK4Fnk0sm4cmZ8TYNIkVcbNf+So2M=	\N	f	student_066	Ruby	Scott	student_066@student.studynest.local	f	t	2025-02-24 15:22:21.690443+00	student
83	pbkdf2_sha256$1000000$UoRbYeIGSL44W22VyGDiJX$DlYEyFiun3FlplKxiv3MHdCnrp3MSfLc8pJC7YZUGGM=	\N	f	student_067	Lewis	Anderson	student_067@student.studynest.local	f	t	2025-09-15 20:52:22.689593+00	student
84	pbkdf2_sha256$1000000$3F6RAQZXrxHcEJxCqQWq1s$hUis/SaMYbvIy/U813chCjcHlT3Q41ydJoeMIxSUSiw=	\N	f	student_068	Grace	Campbell	student_068@student.studynest.local	f	t	2025-04-15 23:40:23.668368+00	student
85	pbkdf2_sha256$1000000$ahvTE6eSOZFroq6LJjy2N7$lHKwV/Z/mXs1TxdjywARoJUM+axM0CN5Ro1MPCjLcbM=	\N	f	student_069	Ella	Reid	student_069@student.studynest.local	f	t	2025-10-09 10:22:24.664674+00	student
86	pbkdf2_sha256$1000000$vRz6otFLZpAXUPfvlPdn3k$eMKIP9XEhoocHDPvFsXy5SPwkLHgdo0Vo/L2wf/lW7g=	\N	f	student_070	Lewis	Lewis	student_070@student.studynest.local	f	t	2025-07-08 14:44:25.637981+00	student
87	pbkdf2_sha256$1000000$dUL6komQfD6x3TgvlpT8pN$V83gI3co9n7+cnzDplpjJNYn5ZTq8+eXLQ5SS7QdFLY=	\N	f	student_071	Hannah	Davies	student_071@student.studynest.local	f	t	2025-08-18 18:48:26.683368+00	student
88	pbkdf2_sha256$1000000$W7YeYoSI7X8RV8RwFOrm27$BMtAfWNql/8jc4KALbY7F1zZNI5vyvo+McadbyaSal0=	\N	f	student_072	Sophie	Taylor	student_072@student.studynest.local	f	f	2026-02-27 19:09:27.708839+00	student
89	pbkdf2_sha256$1000000$3afUhrTY6rrQPC37hHiY5U$qem/yTvQ3MDvlJ5/HYXt0HY1JM/6/nqLL+Tr3DgZems=	\N	f	student_073	Alex	Thompson	student_073@student.studynest.local	f	t	2025-12-26 16:30:28.678879+00	student
90	pbkdf2_sha256$1000000$OEzloQiFAIyMrecUAzzc1I$15A8I9kQUh2exdjIiO6f+Uo5Mm+BxSA0+5eHHdo8U6o=	\N	f	student_074	Alex	Campbell	student_074@student.studynest.local	f	f	2025-10-15 20:37:29.720427+00	student
91	pbkdf2_sha256$1000000$YueY69gzfxtilt5X5KX7Si$eeL/5NPPhD7Bo+HmGDjJ0yvVy99hTpBsIMZJJZSgpTw=	\N	f	student_075	Thomas	Jackson	student_075@student.studynest.local	f	t	2025-04-19 08:04:30.796278+00	student
92	pbkdf2_sha256$1000000$2a7M7gPtnlOnMXEPVdGXyZ$oymj9m1WODjDqIT08+MDrBhDu3GtIXVeXnvDk3Y6XDQ=	\N	f	student_076	Chloe	Jackson	student_076@student.studynest.local	f	f	2025-04-23 12:43:31.796287+00	student
93	pbkdf2_sha256$1000000$sGy3TEJjIX4LXInEQjHerH$1Vj77CE03lklVhCKSJnmBvRZ2MatUyK2Oo+YN3v+/mA=	\N	f	student_077	Ruby	Foster	student_077@student.studynest.local	f	t	2025-04-18 01:22:32.811708+00	student
94	pbkdf2_sha256$1000000$Uq6IOskZHcJOYCNJzjT08l$3Lcm1RIFVUNFUmHYrr735dF6Gs90AUaDhwceOXtJVsI=	\N	f	student_078	Eleanor	MacDonald	student_078@student.studynest.local	f	t	2026-01-02 12:21:33.8114+00	student
95	pbkdf2_sha256$1000000$5mHtnSdH2g4LYSpVFWaTH9$Df323YkPdfcaVht2lBkbBPBe0QHdtrxYQd6ESa+wWV0=	\N	f	student_079	Thea	Martin	student_079@student.studynest.local	f	t	2025-02-05 01:27:34.896938+00	student
96	pbkdf2_sha256$1000000$4gPhWm3ZkxVFyqiDCeyGJH$OyhoodSkoF2f72C0t3vzOpWtkNJb+UUyQbX7FcwGw9A=	\N	f	student_080	Ethan	Wilson	student_080@student.studynest.local	f	t	2025-05-20 15:03:35.854456+00	student
97	pbkdf2_sha256$1000000$4P9rEQhlQFANP3TyOtwy46$Xzpn4MGG/V+IPTuFJMHH2UJVlL/yF3n7tKSUR1Bu2LA=	\N	f	student_081	Thomas	Bailey	student_081@student.studynest.local	f	t	2025-05-06 16:22:36.831797+00	student
98	pbkdf2_sha256$1000000$ydMlGDiVI5ZFr3LaxUE3X8$/sJn1wUGVIAaHqHX622ObXiWRqW9pHW8uPdAt6BwoO0=	\N	f	student_082	Emily	Smith	student_082@student.studynest.local	f	t	2025-09-20 13:31:37.852861+00	student
99	pbkdf2_sha256$1000000$KV3223Bp7TtipcFIEPcnjC$Ext9x89hgN2pHrBCDIleXdtCSdrqitG/DiRApMpIW84=	\N	f	student_083	Oscar	Kelly	student_083@student.studynest.local	f	t	2025-05-29 17:30:38.892923+00	student
100	pbkdf2_sha256$1000000$IXgsKTenqmLmzDaBXFkm35$aptV67ZIcYEuDZqgwW7CL4XOmeO4eA0msL+MeIkFo/s=	\N	f	student_084	Zoe	Scott	student_084@student.studynest.local	f	t	2025-09-07 17:50:39.906235+00	student
101	pbkdf2_sha256$1000000$OkdtgZKTiRth3aFQ1umpP8$ZjKDjmxqbRD3gmzuajj4Vgqx0x7PCeVmXjUk/KeX3yM=	\N	f	student_085	Ruby	Clark	student_085@student.studynest.local	f	t	2025-02-28 08:06:40.951876+00	student
102	pbkdf2_sha256$1000000$Zti9s4j8Zk3GT8pCF84jN9$tW9kncE7i0uBWjk9KSrW/e8p4VpaSDqf4i8bZWN+N7s=	\N	f	student_086	Thea	Graham	student_086@student.studynest.local	f	t	2025-07-21 06:31:41.896666+00	student
103	pbkdf2_sha256$1000000$gGbfR3iha77SZVhizez2I7$TednurU1GBy9Q8JTv50mRI3YjpKRWWDjx9KHejRGGkg=	\N	f	student_087	Hannah	MacDonald	student_087@student.studynest.local	f	t	2025-11-21 12:41:42.838777+00	student
104	pbkdf2_sha256$1000000$4b00gAkv5NXD1qdatLdNgh$YUZPrb+SMA39J061n6HaFHq7htLkaWi7EhD3vpNbS1g=	\N	f	student_088	Ethan	Hall	student_088@student.studynest.local	f	t	2025-10-12 07:44:43.748572+00	student
105	pbkdf2_sha256$1000000$fLE71gMzlpd89jtxdp6muw$jQTZvxQ7YJPxTD+LYYqz5MU19Rz/pWqicpm48ETnP7Y=	\N	f	student_089	Callum	Carter	student_089@student.studynest.local	f	t	2025-05-08 19:26:44.689607+00	student
106	pbkdf2_sha256$1000000$bO2xpQeLxLsLtwintqIldX$KLTX+ryku6xUNsbN/I+Elab491RTSvVsh5nTZNLwbY8=	\N	f	student_090	Jack	Bailey	student_090@student.studynest.local	f	t	2025-03-31 01:45:45.625715+00	student
107	pbkdf2_sha256$1000000$PFAwOtQTnFzRIXr4Gu3LXk$mtlcIpsr2EcCyZZ/ybPMTR++Bhsiv84URr3GJcHFWHw=	\N	f	student_091	Noah	Smith	student_091@student.studynest.local	f	t	2025-10-30 21:47:46.635619+00	student
108	pbkdf2_sha256$1000000$sSzDjA0vo8zUFSIMIQQdLg$ukrZ0Dohyaoe03RjD+OJThIg6HgS8t+R0LgBGPh1AUI=	\N	f	student_092	Lucas	Brown	student_092@student.studynest.local	f	t	2025-08-03 07:36:47.579247+00	student
109	pbkdf2_sha256$1000000$m5A6tTSDWzGcd1C4kENsZN$2YqHfBikpiOi8eHHOSg5/0I6ZvwicTprKzj/+Z22SdU=	\N	f	student_093	Grace	Hughes	student_093@student.studynest.local	f	f	2025-01-22 23:58:48.614504+00	student
110	pbkdf2_sha256$1000000$aX1NevXVRHu83SBNFie2ig$UZZKx48Rx9lRsCb2HN1vfRGsLPNUwZ0Fz5kesAdyjUs=	\N	f	student_094	Oscar	Graham	student_094@student.studynest.local	f	t	2025-03-16 12:02:49.584382+00	student
111	pbkdf2_sha256$1000000$ZCPFqh0pWuWBlJmB3PhQWB$jcs9MWmetgoFmQZOu/ZTpUX6aYfHbmEpecj5SqHPHU4=	\N	f	student_095	Sophie	Lewis	student_095@student.studynest.local	f	t	2025-10-09 01:26:50.860891+00	student
112	pbkdf2_sha256$1000000$g7zK7m3KYvhxU2KIRyXSsZ$qg/WxbzOHGXj6xEX1YSLvbrXkguLHD8lJbQjHUBgCHs=	\N	f	student_096	Mia	Carter	student_096@student.studynest.local	f	t	2025-07-08 18:20:51.999108+00	student
113	pbkdf2_sha256$1000000$CWEBcePFBCzJCUqsKOOsbl$ED/nP2tJtDu7kzwqsQ4Gh9WieGdciV7KzzsSNeUSies=	\N	f	student_097	Chloe	Jackson	student_097@student.studynest.local	f	t	2025-01-27 15:52:52.961711+00	student
114	pbkdf2_sha256$1000000$GRM1i3EWxpVuRTjtUHfnJp$4RoYbA594cQBea8UKOrIEF8jBeLYShoHcDHQZ8jgbI8=	\N	f	student_098	Liam	Reid	student_098@student.studynest.local	f	t	2025-08-23 18:09:54.399652+00	student
115	pbkdf2_sha256$1000000$86OBcv95LXJJa2OKQXwWou$/O/5kfhMGJg9ilm2mw7T5XF/KIjRQE1NtP5QbaqZyDA=	\N	f	student_099	Ruby	Carter	student_099@student.studynest.local	f	t	2025-09-25 16:12:55.639751+00	student
116	pbkdf2_sha256$1000000$GEqjEuAmvnFsF3gXthtxpd$NmidKKSewb9DHBgyyKhGFqkqPSOo44wwDNy5I+V5uZI=	\N	f	student_100	Daniel	Evans	student_100@student.studynest.local	f	t	2026-02-24 07:13:57.009174+00	student
117	pbkdf2_sha256$1000000$u3Uon7hgqgBUa6l8M4226M$I3yQQlHZ3l3VUBYG/oxRk8czz7Z48OrffZZEnyxhYYI=	\N	f	student_101	Daniel	Smith	student_101@student.studynest.local	f	t	2025-07-22 15:04:58.298998+00	student
118	pbkdf2_sha256$1000000$XFN7MCZ8oFnzUE9hXZWOCH$d2w9iyJfxiPZssoqAOVFQGhZF1DFcYC8F04w8xih4oo=	\N	f	student_102	Oliver	Brown	student_102@student.studynest.local	f	t	2025-02-19 06:17:59.309028+00	student
119	pbkdf2_sha256$1000000$1kWk4BvhlIFLQDTbCkhUEC$fGiicv5rkInxSH2BNCa4o0tR2j0AqxZ4I4vj8mecK4w=	\N	f	student_103	Ella	Morris	student_103@student.studynest.local	f	t	2025-02-23 06:00:00.575437+00	student
120	pbkdf2_sha256$1000000$vycfmHEKXhoIAGniTL9Gih$FgJupVOh/vEhPKkIsCXMDqJajN4P/BBMnnwsClMCZlY=	\N	f	student_104	Thomas	Foster	student_104@student.studynest.local	f	t	2025-03-15 08:19:01.655696+00	student
121	pbkdf2_sha256$1000000$NhaboeSlIrQFRjRczLQlUX$S9l3fgDAizFclqcZ514dOwzjUFz4TeAxj8XZVwto/XQ=	\N	f	student_105	Benjamin	Foster	student_105@student.studynest.local	f	t	2026-01-17 03:38:02.852457+00	student
122	pbkdf2_sha256$1000000$dExpxNsGxI9SV31fgqPRBE$NWI6HjS6tqYFvPbQqZcFgKfiFUCm85ClQd0wvXvBXbA=	\N	f	student_106	James	Hamilton	student_106@student.studynest.local	f	t	2025-01-19 07:44:03.903497+00	student
123	pbkdf2_sha256$1000000$wzNzXiCJmD1ItdbQtOGsWd$BLU3tZ8DUTkeJfvgTINlFn8etbob2PR5ILY4GQT8P4Q=	\N	f	student_107	Lucas	Carter	student_107@student.studynest.local	f	t	2025-05-06 01:41:05.171092+00	student
124	pbkdf2_sha256$1000000$DKHYdun1JlAwtG0zZrjK0x$YGqmzb2h8daFJtiVzPjYZP9BHOPaa/qGE6elvcOwAW8=	\N	f	student_108	Lewis	Hall	student_108@student.studynest.local	f	t	2025-06-29 12:08:06.507452+00	student
125	pbkdf2_sha256$1000000$MPgEdoALHcI6NQ1cHL0eGl$AM4LBnHWqNUAPM2sJ+jrAsJnfYOx0Lgn8+cZIxKGrmQ=	\N	f	student_109	Amelia	Grant	student_109@student.studynest.local	f	t	2025-07-31 19:34:07.643336+00	student
126	pbkdf2_sha256$1000000$pVgRNZIiTNXBrdqezk9Ard$EWm1f9ntC8MbaKzhF+xmEjuqiMWPl5o53qw4a/IL42w=	\N	f	student_110	Jack	Lewis	student_110@student.studynest.local	f	t	2025-04-09 22:29:08.793847+00	student
127	pbkdf2_sha256$1000000$REjwLqISzqokXfu7cqVMnR$jHCPqcIGd+4PxNZxYYRVaK1iL49LhkH4wNg2djp5FeM=	\N	f	student_111	Oscar	Carter	student_111@student.studynest.local	f	t	2025-03-06 06:41:09.899911+00	student
128	pbkdf2_sha256$1000000$ksvzoiWPqSuruZe2C79BKp$KDhs6LLXpxTTga7uupriSmLtsOklZ2bNtktrf4s1qbI=	\N	f	student_112	Alex	Campbell	student_112@student.studynest.local	f	t	2025-12-12 21:22:10.911324+00	student
129	pbkdf2_sha256$1000000$Ar8HxIEVvjM7qGCnVWGfHI$Wewt4QFB4JZ8JjZZidS/IM6UEgK+eCoXb11ux1vwllk=	\N	f	student_113	Jack	Morris	student_113@student.studynest.local	f	t	2025-07-21 01:02:11.996937+00	student
130	pbkdf2_sha256$1000000$zHVZkgJNBssFKz6gWsFgxR$5PehDb1gG00xFIay5EKwUAVJDQqwGyhGSxlK5vRq9BQ=	\N	f	student_114	Liam	Grant	student_114@student.studynest.local	f	t	2025-12-27 03:30:13.354046+00	student
131	pbkdf2_sha256$1000000$2Iwv94Gr9OaPEuJsGV8qUH$CeFPZadcdVhdYKui5DtGWgE1zOhO25GyjLzYJYBuIVw=	\N	f	student_115	Eva	Roberts	student_115@student.studynest.local	f	t	2025-07-07 23:01:14.584073+00	student
132	pbkdf2_sha256$1000000$oGJFd2advEjsQ8rwLhEmqE$LzTzPL7sk//pqrFMtw7vUc4pfrDQv3wskNWkdQWaWTk=	\N	f	student_116	Ava	Patel	student_116@student.studynest.local	f	t	2025-04-30 12:35:15.647307+00	student
133	pbkdf2_sha256$1000000$smjvXmqPFajqbsdQQ16cog$jzu0/VRydAhXUCbq/dgDcI5aYczn3LUWIqiGS0gkEbs=	\N	f	student_117	Lucas	Clark	student_117@student.studynest.local	f	t	2025-06-26 23:53:17.149306+00	student
134	pbkdf2_sha256$1000000$o6FeQYPVRgmOUKqcyfZNuX$Uq7Nhvi0ui9hota4kNaesyxJwo497HQDFr3B9f/IHrg=	\N	f	student_118	William	Hall	student_118@student.studynest.local	f	t	2025-05-02 15:09:18.350433+00	student
135	pbkdf2_sha256$1000000$ZaugUwRKaUsCVBRbNTrUqW$T3jqHcEFCXD2/gW1lPkkxK/GDqj2VXKub5YQqNDxOlU=	\N	f	student_119	Eva	Foster	student_119@student.studynest.local	f	t	2025-09-12 17:05:19.620166+00	student
136	pbkdf2_sha256$1000000$Lc9Br3eApt5QFdyandCfFv$f+QDMeulPvlKi19vUgZiRLPByP9hdHW6Sh0kg6zLdbU=	\N	f	student_120	Chloe	Smith	student_120@student.studynest.local	f	t	2025-06-20 03:48:20.923648+00	student
137	pbkdf2_sha256$1000000$gIX9g2xFqAq5wSLxhMjiFI$4aJXcI/vx/ZzdSx9tE0Zn2AT/uf4n1Tp0aez1ccc1BU=	\N	f	student_121	James	Mitchell	student_121@student.studynest.local	f	t	2025-06-17 18:47:22.283327+00	student
138	pbkdf2_sha256$1000000$P8bYz2S5nHMgmBPJFw8l80$B2j/0yCetqPkk8ttfe3onYQcldiCj/fv4XuuH3oU7Zk=	\N	f	student_122	Noah	Reid	student_122@student.studynest.local	f	t	2025-07-26 02:34:23.594299+00	student
139	pbkdf2_sha256$1000000$aLWV0rVuA2cmFvFGPlOS5l$MKoemcHt8Oiu7PD0aKfrotZM2vfR57nHQhdE69sIo+k=	\N	f	student_123	Callum	Graham	student_123@student.studynest.local	f	t	2025-11-29 12:09:24.772521+00	student
140	pbkdf2_sha256$1000000$84nURHeGrwyJ8cniq0dsCR$zxfKGFaCz3KDM9+4fXcX0U/1CwnPa+squy+ZFGgOLCY=	\N	f	student_124	Jack	Carter	student_124@student.studynest.local	f	t	2026-01-12 14:08:26.12434+00	student
141	pbkdf2_sha256$1000000$s0aFW2e3bXsO3mGRRl8IZY$ILT0rIlyJer1/T34FzpC0Qvnscc5wiLm367hgca14xw=	\N	f	student_125	James	Hamilton	student_125@student.studynest.local	f	t	2025-12-30 01:07:27.443513+00	student
142	pbkdf2_sha256$1000000$5FYUm3dLWEDd0TvVufIfIs$0kXtgGD1OqFGgAViL7IaRdBYhGYUfV/mtWbG1viOdxU=	\N	f	student_126	James	Young	student_126@student.studynest.local	f	f	2025-06-28 00:49:28.523317+00	student
143	pbkdf2_sha256$1000000$3v17WM0ufVnLphBNvybM9e$RZ6bElFCxj4vko74IfgAIG0aAEJnRxmd6CKefIadmkY=	\N	f	student_127	James	Jackson	student_127@student.studynest.local	f	t	2025-03-14 11:46:29.777533+00	student
144	pbkdf2_sha256$1000000$oWH1whjo3gD9eABJSxUsCv$0gZudGCmW4xK1Z+Dfsbh8QtOp5bzROcjfbsOe3PfkDc=	\N	f	student_128	Jack	MacDonald	student_128@student.studynest.local	f	t	2025-07-06 04:58:31.043916+00	student
145	pbkdf2_sha256$1000000$5eHmI5erBHqCc0kiYlsUk1$gaRJubRjgC2uKYIn4/NvHuk2nOZL0LezZtJdfjjlIKg=	\N	f	student_129	Hannah	Brown	student_129@student.studynest.local	f	t	2025-07-05 03:09:32.312443+00	student
146	pbkdf2_sha256$1000000$vCNba6qQymMHh5nV7oiMCw$7VoDTfdvFHXRZoYjueVEKRTt8x+GV+vXnSe/x5D9kQQ=	\N	f	student_130	Thomas	Thompson	student_130@student.studynest.local	f	t	2025-01-30 03:06:33.495258+00	student
147	pbkdf2_sha256$1000000$1Pz3qCCgUMlroEJEA7DL1J$/Fa6Ss51PzQJ6Ewlk7Db7YLO4J8Y2EDuL31u21rFDqk=	\N	f	student_131	Mason	Hamilton	student_131@student.studynest.local	f	t	2025-10-10 18:33:34.528605+00	student
148	pbkdf2_sha256$1000000$K3SIcss6ifXPUVNNeGVwQi$K31hbdTK45SQ6F3Acls1/GXEursWFEgBdR0nnBExoY8=	\N	f	student_132	Emily	Morris	student_132@student.studynest.local	f	t	2025-09-22 16:06:35.654528+00	student
149	pbkdf2_sha256$1000000$A0qQVIdNuQDbyJ52XOhCYo$fz/TKUFhZsI827lvhVvF3JB6BXinAxz9P4tOPrMbrwY=	\N	f	student_133	Liam	Edwards	student_133@student.studynest.local	f	t	2026-02-13 17:52:36.744593+00	student
150	pbkdf2_sha256$1000000$dvOIcgrqF0lKJPjpTxYoC4$aSt05qk4jeIt7JjsRRIej+28LpZJgSujStxCwq1l8V0=	\N	f	student_134	Jack	Taylor	student_134@student.studynest.local	f	t	2025-07-16 03:13:37.857598+00	student
151	pbkdf2_sha256$1000000$2aMLFZNG37OPBA0yhRKLiS$GtQvtr9zXamDMSKFy4TSfEq8PGJ5wNdUv6kOkoqdvEI=	\N	f	student_135	Ruby	Hughes	student_135@student.studynest.local	f	t	2025-08-09 12:58:39.123444+00	student
152	pbkdf2_sha256$1000000$WtNjyCviTMNNrktE9AwTxT$mgJU8vWECkKD/TVn3zCY0EpExzvSzGhnc//+5OJJqbk=	\N	f	student_136	Alex	Taylor	student_136@student.studynest.local	f	t	2025-08-31 18:30:40.511662+00	student
153	pbkdf2_sha256$1000000$kic8gvnrkOhY3CnpMn2I24$n0m/6qcBLe5GT5nAexUqjSBnWH/AQboOOCoYk+F8xqI=	\N	f	student_137	William	Lewis	student_137@student.studynest.local	f	t	2025-12-03 17:25:41.935899+00	student
154	pbkdf2_sha256$1000000$q06zsOxpEUjSyBPNWnC1Zd$ewSumlaa2b48uy1pLc63yXy0FZPG7WXelLexAR+bAlw=	\N	f	student_138	Thomas	Smith	student_138@student.studynest.local	f	t	2025-01-31 04:06:43.077531+00	student
155	pbkdf2_sha256$1000000$PzRIakaMgXl3lWWqJdVZaR$Iau974yJtUOGuU/tGK5FO1/z/7Iaf4MY2tM3jDrOqRQ=	\N	f	student_139	Thomas	Reid	student_139@student.studynest.local	f	t	2025-07-06 05:59:44.057371+00	student
156	pbkdf2_sha256$1000000$AvOboXPSY1Pdkoo4OIvET7$g198iMi3mT++jIVujRvprdf9mWHsM3dcJRB/V1NqC5o=	\N	f	student_140	Noah	Carter	student_140@student.studynest.local	f	t	2025-08-17 02:17:45.065953+00	student
157	pbkdf2_sha256$1000000$1Ht7OwVaKxd6kwhpTmPkIB$0Gxe0pCh45HO7uNrPIlN0t6e/+VLuYQwqzUCck7oB2o=	\N	f	student_141	Oscar	Foster	student_141@student.studynest.local	f	t	2025-09-22 16:10:46.086985+00	student
158	pbkdf2_sha256$1000000$58w98t9wfiwDYPdyEiNKre$qrZdn+i9h5hywloE2YpjSQGMlzwuNTExRd+xGI7Oc+o=	\N	f	student_142	Ella	Kelly	student_142@student.studynest.local	f	t	2025-08-25 08:28:47.229885+00	student
159	pbkdf2_sha256$1000000$pbQVtMhcLAa7GFEVD4sEcq$vWT25Fed5ACAaHcnlhaMahAzVTVnDeAOjU1vM7F0BEE=	\N	f	student_143	Noah	Young	student_143@student.studynest.local	f	t	2025-02-02 20:00:48.492551+00	student
160	pbkdf2_sha256$1000000$MAw7RrkZ0mYclJEr9vYxL4$/Uiw7QGuJWPXZunOvQkBZWotsfvHiNxbHULr0A8HdSc=	\N	f	student_144	Lucas	Evans	student_144@student.studynest.local	f	t	2025-11-30 02:15:49.516059+00	student
161	pbkdf2_sha256$1000000$iiOGfWzVHEfM5saWJCI4VK$dTpWRyZjdA+ZGgEpdu+1wEBQF82TAocT8Aq9TidbKWI=	\N	f	student_145	Eva	Campbell	student_145@student.studynest.local	f	t	2026-01-10 19:30:50.55648+00	student
162	pbkdf2_sha256$1000000$MRYftdXD4Er4vMijUJ9zVF$BRYtUjqx+njrpmJ17QX0zucF6KJ7Rn1ewIDAIscxQE0=	\N	f	student_146	Lewis	Reid	student_146@student.studynest.local	f	t	2025-11-13 06:30:51.842412+00	student
163	pbkdf2_sha256$1000000$8TXEz87hVWLXUZcP1YwPQH$ApBB1MvxJq+9+dQ8tf80zl9mZnBTAifYe++qlwur+Cw=	\N	f	student_147	Thea	Patel	student_147@student.studynest.local	f	f	2025-04-04 00:33:52.832243+00	student
164	pbkdf2_sha256$1000000$SR53YnyMIEAjNCFwLKS2dc$V/I2UJGa5CNf/fCuZyVVjkxIcWQH1lcKD+dz921qUoU=	\N	f	student_148	James	Young	student_148@student.studynest.local	f	t	2025-06-19 18:17:54.18619+00	student
165	pbkdf2_sha256$1000000$MgwykRlnUZW6DNCCx0PgSy$rWraLUyLHqyaivge/8mqQgQ4NI+4WqY1n2/xXU9UtOM=	\N	f	student_149	Grace	Carter	student_149@student.studynest.local	f	t	2026-01-02 07:38:55.364375+00	student
166	pbkdf2_sha256$1000000$krh4e5QCJ7pqh7jiTCU5fK$mKFLx0M1dU0eixQHT2T6JhtxQDE3JxqG/7WH/fwpFLg=	\N	f	student_150	Eleanor	Morris	student_150@student.studynest.local	f	t	2025-06-19 16:45:56.676433+00	student
167	pbkdf2_sha256$1000000$HoYjOSogs3QKTR97cFh45X$LdQc0X6mj2gpaatJWp1U2NVp5zhEZWny6WRBNcyLCbA=	\N	f	student_151	Ella	Thompson	student_151@student.studynest.local	f	t	2025-10-25 11:39:58.056658+00	student
168	pbkdf2_sha256$1000000$LlEOL0AlOuf1jMbV7stFCp$yW394/IQldIgs9kxn82FzHttuWvZ/LWKIjukxVhka34=	\N	f	student_152	Mia	Thompson	student_152@student.studynest.local	f	t	2026-02-24 03:58:59.510554+00	student
169	pbkdf2_sha256$1000000$aJrvdSpqZ68K8hes3XvqNi$UJ8YBS8lpKHhf1Umo6pqh8p9zHG8jEfExdavTovaQek=	\N	f	student_153	Ella	Taylor	student_153@student.studynest.local	f	t	2025-12-08 05:05:01.115667+00	student
170	pbkdf2_sha256$1000000$rAdMX3nXPLBfS2Hwtgw7bR$G0Uay4Zo3GmzBJMo4taWlCHQ8vqRIx7CnLKy5S9tzyg=	\N	f	student_154	Thomas	Morris	student_154@student.studynest.local	f	f	2025-07-20 18:21:02.488079+00	student
171	pbkdf2_sha256$1000000$u16WjeghvZPhYWMkLZK5sf$yBX2BaUnnz7c2/aV27ba+viGCXv6OfdGbcstHd8V5rg=	\N	f	student_155	Grace	Brown	student_155@student.studynest.local	f	t	2025-12-09 16:23:04.092478+00	student
172	pbkdf2_sha256$1000000$B0xTwinkO0RMiIzOtHR84u$s1NXmS40l4eTLQSAIj8DVpeXK1udNmhpzgPuvhWE6qs=	\N	f	student_156	Chloe	Carter	student_156@student.studynest.local	f	t	2025-05-18 01:29:05.522348+00	student
173	pbkdf2_sha256$1000000$z9BMduA3xPy3UYQ7BqdcUL$EZTGLEd/rWuDVbIKbmm9Kp3y2j17lhAxTwZ+vvd6I1Q=	\N	f	student_157	William	Thompson	student_157@student.studynest.local	f	t	2025-07-11 21:11:07.078027+00	student
174	pbkdf2_sha256$1000000$1SnNPzmSmEsPxO63v3j7ux$cp9YIJQ6nIw7shHSl04C9g7kzF8Ntd8+MoRvn9qweDA=	\N	f	student_158	Sophie	Scott	student_158@student.studynest.local	f	t	2025-08-23 15:43:08.423094+00	student
175	pbkdf2_sha256$1000000$qkJ7I8utgd7rQxr9nmde5F$LZ8TTpvUUsSjV3M4j3B9OVVmLBRty8a2nJNGKwZHMnQ=	\N	f	tmp_admin_check			tmp@x.com	f	t	2026-03-16 21:25:07.960482+00	admin
176	pbkdf2_sha256$1000000$iewCiFBiLhbcsWfhVft61s$NNYAM8VPyvo1vIVeoXq2W7z5VYCUWtCKTbwdaJrZD7I=	\N	f	tmp_student_check			tmpstudent@x.com	f	t	2026-03-16 21:25:09.390555+00	student
\.


--
-- Data for Name: users_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: users_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 52, true);


--
-- Name: bookings_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bookings_booking_id_seq', 976, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 13, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 26, true);


--
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 355, true);


--
-- Name: rooms_building_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rooms_building_id_seq', 13, true);


--
-- Name: rooms_equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rooms_equipment_id_seq', 18, true);


--
-- Name: rooms_room_equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rooms_room_equipment_id_seq', 266, true);


--
-- Name: rooms_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rooms_room_id_seq', 79, true);


--
-- Name: users_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_user_groups_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_user_id_seq', 176, true);


--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: bookings_booking bookings_booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_booking
    ADD CONSTRAINT bookings_booking_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: reviews_review reviews_review_booking_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_review
    ADD CONSTRAINT reviews_review_booking_id_key UNIQUE (booking_id);


--
-- Name: reviews_review reviews_review_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_review
    ADD CONSTRAINT reviews_review_pkey PRIMARY KEY (id);


--
-- Name: rooms_building rooms_building_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms_building
    ADD CONSTRAINT rooms_building_pkey PRIMARY KEY (id);


--
-- Name: rooms_equipment rooms_equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms_equipment
    ADD CONSTRAINT rooms_equipment_pkey PRIMARY KEY (id);


--
-- Name: rooms_room_equipment rooms_room_equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms_room_equipment
    ADD CONSTRAINT rooms_room_equipment_pkey PRIMARY KEY (id);


--
-- Name: rooms_room_equipment rooms_room_equipment_room_id_equipment_id_71d5e5e8_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms_room_equipment
    ADD CONSTRAINT rooms_room_equipment_room_id_equipment_id_71d5e5e8_uniq UNIQUE (room_id, equipment_id);


--
-- Name: rooms_room rooms_room_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms_room
    ADD CONSTRAINT rooms_room_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups users_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups users_user_groups_user_id_group_id_b88eab82_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_group_id_b88eab82_uniq UNIQUE (user_id, group_id);


--
-- Name: users_user users_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_permission_id_43338c45_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_permission_id_43338c45_uniq UNIQUE (user_id, permission_id);


--
-- Name: users_user users_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_username_key UNIQUE (username);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: bookings_booking_processed_by_id_35f633eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_booking_processed_by_id_35f633eb ON public.bookings_booking USING btree (processed_by_id);


--
-- Name: bookings_booking_room_id_6f0fa517; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_booking_room_id_6f0fa517 ON public.bookings_booking USING btree (room_id);


--
-- Name: bookings_booking_student_id_b3b10513; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_booking_student_id_b3b10513 ON public.bookings_booking USING btree (student_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: reviews_review_room_id_88f19e2a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_review_room_id_88f19e2a ON public.reviews_review USING btree (room_id);


--
-- Name: reviews_review_student_id_67d991fd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_review_student_id_67d991fd ON public.reviews_review USING btree (student_id);


--
-- Name: rooms_room_building_id_3f238d19; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rooms_room_building_id_3f238d19 ON public.rooms_room USING btree (building_id);


--
-- Name: rooms_room_equipment_equipment_id_cafd6700; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rooms_room_equipment_equipment_id_cafd6700 ON public.rooms_room_equipment USING btree (equipment_id);


--
-- Name: rooms_room_equipment_room_id_8150c93c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rooms_room_equipment_room_id_8150c93c ON public.rooms_room_equipment USING btree (room_id);


--
-- Name: users_user_groups_group_id_9afc8d0e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_user_groups_group_id_9afc8d0e ON public.users_user_groups USING btree (group_id);


--
-- Name: users_user_groups_user_id_5f6f5a90; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_user_groups_user_id_5f6f5a90 ON public.users_user_groups USING btree (user_id);


--
-- Name: users_user_user_permissions_permission_id_0b93982e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_user_user_permissions_permission_id_0b93982e ON public.users_user_user_permissions USING btree (permission_id);


--
-- Name: users_user_user_permissions_user_id_20aca447; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_user_user_permissions_user_id_20aca447 ON public.users_user_user_permissions USING btree (user_id);


--
-- Name: users_user_username_06e46fe6_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_user_username_06e46fe6_like ON public.users_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bookings_booking bookings_booking_processed_by_id_35f633eb_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_booking
    ADD CONSTRAINT bookings_booking_processed_by_id_35f633eb_fk_users_user_id FOREIGN KEY (processed_by_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bookings_booking bookings_booking_room_id_6f0fa517_fk_rooms_room_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_booking
    ADD CONSTRAINT bookings_booking_room_id_6f0fa517_fk_rooms_room_id FOREIGN KEY (room_id) REFERENCES public.rooms_room(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bookings_booking bookings_booking_student_id_b3b10513_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_booking
    ADD CONSTRAINT bookings_booking_student_id_b3b10513_fk_users_user_id FOREIGN KEY (student_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews_review reviews_review_booking_id_c8b83bac_fk_bookings_booking_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_review
    ADD CONSTRAINT reviews_review_booking_id_c8b83bac_fk_bookings_booking_id FOREIGN KEY (booking_id) REFERENCES public.bookings_booking(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews_review reviews_review_room_id_88f19e2a_fk_rooms_room_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_review
    ADD CONSTRAINT reviews_review_room_id_88f19e2a_fk_rooms_room_id FOREIGN KEY (room_id) REFERENCES public.rooms_room(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews_review reviews_review_student_id_67d991fd_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_review
    ADD CONSTRAINT reviews_review_student_id_67d991fd_fk_users_user_id FOREIGN KEY (student_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: rooms_room rooms_room_building_id_3f238d19_fk_rooms_building_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms_room
    ADD CONSTRAINT rooms_room_building_id_3f238d19_fk_rooms_building_id FOREIGN KEY (building_id) REFERENCES public.rooms_building(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: rooms_room_equipment rooms_room_equipment_equipment_id_cafd6700_fk_rooms_equ; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms_room_equipment
    ADD CONSTRAINT rooms_room_equipment_equipment_id_cafd6700_fk_rooms_equ FOREIGN KEY (equipment_id) REFERENCES public.rooms_equipment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: rooms_room_equipment rooms_room_equipment_room_id_8150c93c_fk_rooms_room_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms_room_equipment
    ADD CONSTRAINT rooms_room_equipment_room_id_8150c93c_fk_rooms_room_id FOREIGN KEY (room_id) REFERENCES public.rooms_room(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_group_id_9afc8d0e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_user_id_5f6f5a90_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_perm_permission_id_0b93982e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_perm_permission_id_0b93982e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_20aca447_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict o457pbqGrz7tFAi1dED3tqRyeEzsXggixE3EINWBn7Z5ubDu4GcbsGkwvtyQu8V

