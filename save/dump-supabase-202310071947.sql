--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.3

-- Started on 2023-10-07 19:47:23

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
-- TOC entry 278 (class 1259 OID 17378)
-- Name: ingredient; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.ingredient (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name character varying NOT NULL,
    private boolean DEFAULT true NOT NULL,
    workspace_id uuid,
    brand text
);


ALTER TABLE public.ingredient OWNER TO supabase_admin;

--
-- TOC entry 280 (class 1259 OID 17485)
-- Name: macro; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.macro (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    kilocalorie bigint DEFAULT '0'::bigint NOT NULL,
    kilojoule bigint DEFAULT '0'::bigint NOT NULL,
    oily_material bigint DEFAULT '0'::bigint NOT NULL,
    saturated_fatty_acid bigint DEFAULT '0'::bigint NOT NULL,
    carbohydrate bigint DEFAULT '0'::bigint NOT NULL,
    sugar bigint DEFAULT '0'::bigint NOT NULL,
    alimentary_fiber bigint DEFAULT '0'::bigint NOT NULL,
    protein bigint DEFAULT '0'::bigint NOT NULL,
    salt bigint DEFAULT '0'::bigint NOT NULL,
    food_id uuid,
    meal_id uuid
);


ALTER TABLE public.macro OWNER TO supabase_admin;

--
-- TOC entry 286 (class 1259 OID 91036)
-- Name: meal; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.meal (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    nb_portion smallint NOT NULL,
    workspace_id uuid NOT NULL
);


ALTER TABLE public.meal OWNER TO supabase_admin;

--
-- TOC entry 279 (class 1259 OID 17420)
-- Name: meal_ingredient; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.meal_ingredient (
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    quantity double precision,
    food_id uuid NOT NULL,
    dish_id uuid NOT NULL,
    portion_id uuid,
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL
);


ALTER TABLE public.meal_ingredient OWNER TO supabase_admin;

--
-- TOC entry 285 (class 1259 OID 74637)
-- Name: portion; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.portion (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    food_id uuid NOT NULL,
    quantity double precision NOT NULL,
    unit character varying DEFAULT '255'::character varying NOT NULL
);


ALTER TABLE public.portion OWNER TO supabase_admin;

--
-- TOC entry 282 (class 1259 OID 33687)
-- Name: schedule; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.schedule (
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    step_id uuid NOT NULL,
    food_id uuid,
    quantity integer,
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    dish_id uuid,
    date timestamp with time zone DEFAULT now() NOT NULL,
    workspace_id uuid NOT NULL,
    portion_id uuid
);


ALTER TABLE public.schedule OWNER TO supabase_admin;

--
-- TOC entry 281 (class 1259 OID 33677)
-- Name: step; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.step (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name character varying DEFAULT '255'::character varying NOT NULL,
    "order" bigint NOT NULL
);


ALTER TABLE public.step OWNER TO supabase_admin;

--
-- TOC entry 283 (class 1259 OID 50061)
-- Name: workspace; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.workspace (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.workspace OWNER TO supabase_admin;

--
-- TOC entry 284 (class 1259 OID 50072)
-- Name: workspace_user; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.workspace_user (
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id uuid NOT NULL,
    workspace_id uuid NOT NULL
);


ALTER TABLE public.workspace_user OWNER TO supabase_admin;

--
-- TOC entry 3855 (class 0 OID 17378)
-- Dependencies: 278
-- Data for Name: ingredient; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.ingredient (id, created_at, updated_at, name, private, workspace_id, brand) FROM stdin;
67c84cf4-baf7-42f8-98d4-fca03c6c6508	2023-05-15 05:25:50.235177+00	2023-07-17 05:50:14.4+00	Pain de mie	t	c38a542f-1521-4708-ba92-9c26fb4f03b6	Harry
312ec758-8ad5-4d85-9e6c-fdda63db95e8	2023-05-13 07:04:34.4466+00	2023-07-17 05:50:49.462+00	Jambon blanc le bon Paris -25% de sel	t	c38a542f-1521-4708-ba92-9c26fb4f03b6	Herta
7915a32f-d6f8-4854-bab4-b90fbfe10204	2023-05-15 05:26:41.475747+00	2023-05-23 05:47:11.86+00	Leerdammer léger	t	c38a542f-1521-4708-ba92-9c26fb4f03b6	Leerdammer
\.


--
-- TOC entry 3857 (class 0 OID 17485)
-- Dependencies: 280
-- Data for Name: macro; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.macro (id, created_at, updated_at, kilocalorie, kilojoule, oily_material, saturated_fatty_acid, carbohydrate, sugar, alimentary_fiber, protein, salt, food_id, meal_id) FROM stdin;
fb53293f-ea2d-4be8-9d0b-7840981b52cc	2023-05-15 05:26:41.706432+00	2023-05-23 05:47:11.887+00	262	0	0	0	0	0	0	0	0	7915a32f-d6f8-4854-bab4-b90fbfe10204	\N
4f71465e-7da9-4e46-8b6d-f134f90763c7	2023-05-15 05:25:50.289234+00	2023-07-17 05:50:14.508+00	268	0	0	0	0	0	0	0	0	67c84cf4-baf7-42f8-98d4-fca03c6c6508	\N
618dbd14-7a95-40ea-944d-084a7765cf45	2023-05-13 07:04:34.520253+00	2023-07-17 05:50:49.485+00	114	0	0	0	0	0	0	0	0	312ec758-8ad5-4d85-9e6c-fdda63db95e8	\N
\.


--
-- TOC entry 3863 (class 0 OID 91036)
-- Dependencies: 286
-- Data for Name: meal; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.meal (id, created_at, updated_at, name, nb_portion, workspace_id) FROM stdin;
5a93d964-7590-4592-80bd-3e5a6c42661b	2023-06-21 05:20:16.706642+00	2023-06-21 05:20:16.706642+00	test1	2	c38a542f-1521-4708-ba92-9c26fb4f03b6
f8acbe49-4795-47ed-b97e-bade916cd8aa	2023-06-21 05:20:37.629987+00	2023-06-21 05:20:37.629987+00	test2	2	c38a542f-1521-4708-ba92-9c26fb4f03b6
d526e416-a7e5-47ff-8722-52fbed7aae90	2023-06-21 05:20:44.988638+00	2023-06-21 05:20:44.988638+00	test3	6	c38a542f-1521-4708-ba92-9c26fb4f03b6
4689859b-3592-4246-80f7-0f4f43896663	2023-06-21 05:20:50.89108+00	2023-06-21 05:20:50.89108+00	test4	7	c38a542f-1521-4708-ba92-9c26fb4f03b6
87c046e3-05c2-482c-87e4-510dac072c64	2023-06-21 05:20:59.893853+00	2023-06-21 05:20:59.893853+00	test5	12	c38a542f-1521-4708-ba92-9c26fb4f03b6
e1e8d8f3-ab9d-434a-8588-fbf72d84a3f8	2023-07-06 05:33:44.199781+00	2023-07-06 05:33:44.199781+00	test	12	c38a542f-1521-4708-ba92-9c26fb4f03b6
3276a6db-5058-49e9-9697-b9012b74294f	2023-05-15 05:29:33.75363+00	2023-07-17 05:50:57.982+00	Croque Monsieur	1	c38a542f-1521-4708-ba92-9c26fb4f03b6
\.


--
-- TOC entry 3856 (class 0 OID 17420)
-- Dependencies: 279
-- Data for Name: meal_ingredient; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.meal_ingredient (created_at, updated_at, quantity, food_id, dish_id, portion_id, id) FROM stdin;
2023-05-15 05:29:33.819014+00	2023-07-06 05:33:44.21+00	3	67c84cf4-baf7-42f8-98d4-fca03c6c6508	e1e8d8f3-ab9d-434a-8588-fbf72d84a3f8	\N	ee254afb-ce26-41db-a681-353f59ce630c
2023-05-15 05:29:33.801874+00	2023-07-17 05:50:58.008+00	1	7915a32f-d6f8-4854-bab4-b90fbfe10204	3276a6db-5058-49e9-9697-b9012b74294f	625715e2-cf78-4332-99de-51a3130d2b6f	a6c5c53d-c900-4e20-bd51-67510f694a2f
2023-05-15 05:35:29.386652+00	2023-07-17 05:50:58.009+00	1	312ec758-8ad5-4d85-9e6c-fdda63db95e8	3276a6db-5058-49e9-9697-b9012b74294f	bd9ad3cb-f0f0-4151-b19b-5f75c3e0df16	bb16dee8-9ac2-4ea1-83ce-1df9b4b1af92
\.


--
-- TOC entry 3862 (class 0 OID 74637)
-- Dependencies: 285
-- Data for Name: portion; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.portion (id, created_at, updated_at, food_id, quantity, unit) FROM stdin;
625715e2-cf78-4332-99de-51a3130d2b6f	2023-05-15 05:26:41.708973+00	2023-05-15 05:26:41.708973+00	7915a32f-d6f8-4854-bab4-b90fbfe10204	8	Tranche
a3d61bb5-abf7-45d4-9fed-652bad743bd0	2023-07-17 05:50:14.526208+00	2023-07-17 05:50:14.526208+00	67c84cf4-baf7-42f8-98d4-fca03c6c6508	49	Tranche
bd9ad3cb-f0f0-4151-b19b-5f75c3e0df16	2023-07-17 05:50:49.800196+00	2023-07-17 05:50:49.800196+00	312ec758-8ad5-4d85-9e6c-fdda63db95e8	80	Tranche
\.


--
-- TOC entry 3859 (class 0 OID 33687)
-- Dependencies: 282
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.schedule (created_at, updated_at, step_id, food_id, quantity, id, dish_id, date, workspace_id, portion_id) FROM stdin;
2023-06-07 05:26:24.691856+00	2023-06-07 05:26:24.691856+00	ff634331-938d-4ae3-b3dd-dfb5ec51cd7f	7915a32f-d6f8-4854-bab4-b90fbfe10204	2	dceedb60-4213-42e5-8823-1c259b33e3b8	\N	2023-06-17 07:29:06+00	c38a542f-1521-4708-ba92-9c26fb4f03b6	625715e2-cf78-4332-99de-51a3130d2b6f
2023-06-07 05:26:32.90828+00	2023-06-07 05:26:32.90828+00	ff634331-938d-4ae3-b3dd-dfb5ec51cd7f	\N	3	2bd022ac-c17a-4ec2-957e-1915b69eb5c2	3276a6db-5058-49e9-9697-b9012b74294f	2023-06-18 07:29:06+00	c38a542f-1521-4708-ba92-9c26fb4f03b6	\N
2023-06-07 05:26:15.860685+00	2023-06-07 05:26:15.860685+00	853e2281-c893-4705-8463-38bafe76a59e	\N	2	14a56e85-61fd-44ed-93c7-5b041f6c361a	3276a6db-5058-49e9-9697-b9012b74294f	2023-06-19 07:29:06+00	c38a542f-1521-4708-ba92-9c26fb4f03b6	\N
2023-06-07 05:26:05.634572+00	2023-06-07 05:26:05.634572+00	ff634331-938d-4ae3-b3dd-dfb5ec51cd7f	312ec758-8ad5-4d85-9e6c-fdda63db95e8	123	996fbdf8-fa45-4389-9b8b-bdfce487dc4e	\N	2023-06-20 07:29:06+00	c38a542f-1521-4708-ba92-9c26fb4f03b6	\N
2023-06-07 05:26:40.395918+00	2023-06-07 05:26:40.395918+00	f5259136-3ad6-49c1-9123-002e0af5e79a	312ec758-8ad5-4d85-9e6c-fdda63db95e8	123	000ce1f2-21f1-4196-bef9-c3459de48445	\N	2023-06-21 07:29:06+00	c38a542f-1521-4708-ba92-9c26fb4f03b6	\N
\.


--
-- TOC entry 3858 (class 0 OID 33677)
-- Dependencies: 281
-- Data for Name: step; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.step (id, created_at, updated_at, name, "order") FROM stdin;
0922c9b6-09ed-4340-846b-756ca054b028	2023-04-25 04:49:01.793636+00	2023-04-25 04:49:01.793636+00	breakfast	1
ff634331-938d-4ae3-b3dd-dfb5ec51cd7f	2023-04-25 04:49:10.917337+00	2023-04-25 04:49:10.917337+00	lunch	2
853e2281-c893-4705-8463-38bafe76a59e	2023-04-25 04:49:21.744972+00	2023-04-25 04:49:21.744972+00	dinner	3
f5259136-3ad6-49c1-9123-002e0af5e79a	2023-04-25 04:50:04.010545+00	2023-04-25 04:50:04.010545+00	snack	4
\.


--
-- TOC entry 3860 (class 0 OID 50061)
-- Dependencies: 283
-- Data for Name: workspace; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.workspace (id, created_at, updated_at) FROM stdin;
c38a542f-1521-4708-ba92-9c26fb4f03b6	2023-04-29 07:41:10.508789+00	2023-04-29 07:41:10.508789+00
\.


--
-- TOC entry 3861 (class 0 OID 50072)
-- Dependencies: 284
-- Data for Name: workspace_user; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.workspace_user (created_at, updated_at, user_id, workspace_id) FROM stdin;
2023-04-29 07:41:24.325595+00	2023-04-29 07:41:24.325595+00	6399b133-0619-4782-be28-8679301799e2	c38a542f-1521-4708-ba92-9c26fb4f03b6
\.


--
-- TOC entry 3688 (class 2606 OID 107408)
-- Name: meal dish_id_key; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.meal
    ADD CONSTRAINT dish_id_key UNIQUE (id);


--
-- TOC entry 3690 (class 2606 OID 91048)
-- Name: meal dish_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.meal
    ADD CONSTRAINT dish_pkey PRIMARY KEY (id);


--
-- TOC entry 3666 (class 2606 OID 123809)
-- Name: meal_ingredient food_dish_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.meal_ingredient
    ADD CONSTRAINT food_dish_pkey PRIMARY KEY (id);


--
-- TOC entry 3662 (class 2606 OID 107410)
-- Name: ingredient food_id_key; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT food_id_key UNIQUE (id);


--
-- TOC entry 3664 (class 2606 OID 17387)
-- Name: ingredient food_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT food_pkey PRIMARY KEY (id);


--
-- TOC entry 3668 (class 2606 OID 107406)
-- Name: macro macro_id_key; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.macro
    ADD CONSTRAINT macro_id_key UNIQUE (id);


--
-- TOC entry 3670 (class 2606 OID 17494)
-- Name: macro macro_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.macro
    ADD CONSTRAINT macro_pkey PRIMARY KEY (id);


--
-- TOC entry 3684 (class 2606 OID 107412)
-- Name: portion portion_id_key; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.portion
    ADD CONSTRAINT portion_id_key UNIQUE (id);


--
-- TOC entry 3686 (class 2606 OID 74647)
-- Name: portion portion_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.portion
    ADD CONSTRAINT portion_pkey PRIMARY KEY (id);


--
-- TOC entry 3676 (class 2606 OID 156579)
-- Name: schedule schedule_step_id_key; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_step_id_key UNIQUE (id);


--
-- TOC entry 3678 (class 2606 OID 164770)
-- Name: schedule schedule_step_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_step_pkey PRIMARY KEY (id);


--
-- TOC entry 3672 (class 2606 OID 107416)
-- Name: step step_id_key; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.step
    ADD CONSTRAINT step_id_key UNIQUE (id);


--
-- TOC entry 3674 (class 2606 OID 33686)
-- Name: step step_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.step
    ADD CONSTRAINT step_pkey PRIMARY KEY (id);


--
-- TOC entry 3680 (class 2606 OID 107418)
-- Name: workspace workspace_id_key; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.workspace
    ADD CONSTRAINT workspace_id_key UNIQUE (id);


--
-- TOC entry 3682 (class 2606 OID 50071)
-- Name: workspace workspace_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.workspace
    ADD CONSTRAINT workspace_pkey PRIMARY KEY (id);


--
-- TOC entry 3691 (class 2606 OID 181168)
-- Name: ingredient ingredient_workspace_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_workspace_id_fkey FOREIGN KEY (workspace_id) REFERENCES public.workspace(id) ON DELETE CASCADE;


--
-- TOC entry 3695 (class 2606 OID 181158)
-- Name: macro macro_food_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.macro
    ADD CONSTRAINT macro_food_id_fkey FOREIGN KEY (food_id) REFERENCES public.ingredient(id);


--
-- TOC entry 3696 (class 2606 OID 181163)
-- Name: macro macro_meal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.macro
    ADD CONSTRAINT macro_meal_id_fkey FOREIGN KEY (meal_id) REFERENCES public.meal(id);


--
-- TOC entry 3692 (class 2606 OID 181178)
-- Name: meal_ingredient meal_ingredient_dish_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.meal_ingredient
    ADD CONSTRAINT meal_ingredient_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.meal(id);


--
-- TOC entry 3693 (class 2606 OID 181173)
-- Name: meal_ingredient meal_ingredient_food_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.meal_ingredient
    ADD CONSTRAINT meal_ingredient_food_id_fkey FOREIGN KEY (food_id) REFERENCES public.ingredient(id);


--
-- TOC entry 3694 (class 2606 OID 181183)
-- Name: meal_ingredient meal_ingredient_portion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.meal_ingredient
    ADD CONSTRAINT meal_ingredient_portion_id_fkey FOREIGN KEY (portion_id) REFERENCES public.portion(id) ON DELETE SET NULL;


--
-- TOC entry 3705 (class 2606 OID 181148)
-- Name: meal meal_workspace_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.meal
    ADD CONSTRAINT meal_workspace_id_fkey FOREIGN KEY (workspace_id) REFERENCES public.workspace(id) ON DELETE CASCADE;


--
-- TOC entry 3704 (class 2606 OID 181188)
-- Name: portion portion_food_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.portion
    ADD CONSTRAINT portion_food_id_fkey FOREIGN KEY (food_id) REFERENCES public.ingredient(id);


--
-- TOC entry 3697 (class 2606 OID 173032)
-- Name: schedule schedule_dish_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.meal(id) ON DELETE CASCADE;


--
-- TOC entry 3698 (class 2606 OID 173027)
-- Name: schedule schedule_food_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_food_id_fkey FOREIGN KEY (food_id) REFERENCES public.ingredient(id) ON DELETE SET NULL;


--
-- TOC entry 3699 (class 2606 OID 173052)
-- Name: schedule schedule_portion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_portion_id_fkey FOREIGN KEY (portion_id) REFERENCES public.portion(id) ON DELETE SET NULL;


--
-- TOC entry 3700 (class 2606 OID 173022)
-- Name: schedule schedule_step_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_step_id_fkey FOREIGN KEY (step_id) REFERENCES public.step(id) ON DELETE CASCADE;


--
-- TOC entry 3701 (class 2606 OID 173037)
-- Name: schedule schedule_workspace_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_workspace_id_fkey FOREIGN KEY (workspace_id) REFERENCES public.workspace(id) ON DELETE CASCADE;


--
-- TOC entry 3702 (class 2606 OID 173042)
-- Name: workspace_user workspace_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.workspace_user
    ADD CONSTRAINT workspace_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 3703 (class 2606 OID 173047)
-- Name: workspace_user workspace_user_workspace_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.workspace_user
    ADD CONSTRAINT workspace_user_workspace_id_fkey FOREIGN KEY (workspace_id) REFERENCES public.workspace(id) ON DELETE CASCADE;


--
-- TOC entry 3869 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE ingredient; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.ingredient TO postgres;
GRANT ALL ON TABLE public.ingredient TO anon;
GRANT ALL ON TABLE public.ingredient TO authenticated;
GRANT ALL ON TABLE public.ingredient TO service_role;


--
-- TOC entry 3870 (class 0 OID 0)
-- Dependencies: 280
-- Name: TABLE macro; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.macro TO postgres;
GRANT ALL ON TABLE public.macro TO anon;
GRANT ALL ON TABLE public.macro TO authenticated;
GRANT ALL ON TABLE public.macro TO service_role;


--
-- TOC entry 3871 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE meal; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.meal TO postgres;
GRANT ALL ON TABLE public.meal TO anon;
GRANT ALL ON TABLE public.meal TO authenticated;
GRANT ALL ON TABLE public.meal TO service_role;


--
-- TOC entry 3872 (class 0 OID 0)
-- Dependencies: 279
-- Name: TABLE meal_ingredient; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.meal_ingredient TO postgres;
GRANT ALL ON TABLE public.meal_ingredient TO anon;
GRANT ALL ON TABLE public.meal_ingredient TO authenticated;
GRANT ALL ON TABLE public.meal_ingredient TO service_role;


--
-- TOC entry 3873 (class 0 OID 0)
-- Dependencies: 285
-- Name: TABLE portion; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.portion TO postgres;
GRANT ALL ON TABLE public.portion TO anon;
GRANT ALL ON TABLE public.portion TO authenticated;
GRANT ALL ON TABLE public.portion TO service_role;


--
-- TOC entry 3874 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE schedule; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.schedule TO postgres;
GRANT ALL ON TABLE public.schedule TO anon;
GRANT ALL ON TABLE public.schedule TO authenticated;
GRANT ALL ON TABLE public.schedule TO service_role;


--
-- TOC entry 3875 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE step; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.step TO postgres;
GRANT ALL ON TABLE public.step TO anon;
GRANT ALL ON TABLE public.step TO authenticated;
GRANT ALL ON TABLE public.step TO service_role;


--
-- TOC entry 3876 (class 0 OID 0)
-- Dependencies: 283
-- Name: TABLE workspace; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.workspace TO postgres;
GRANT ALL ON TABLE public.workspace TO anon;
GRANT ALL ON TABLE public.workspace TO authenticated;
GRANT ALL ON TABLE public.workspace TO service_role;


--
-- TOC entry 3877 (class 0 OID 0)
-- Dependencies: 284
-- Name: TABLE workspace_user; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.workspace_user TO postgres;
GRANT ALL ON TABLE public.workspace_user TO anon;
GRANT ALL ON TABLE public.workspace_user TO authenticated;
GRANT ALL ON TABLE public.workspace_user TO service_role;


-- Completed on 2023-10-07 19:47:23

--
-- PostgreSQL database dump complete
--

