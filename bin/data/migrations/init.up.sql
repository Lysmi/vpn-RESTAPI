-- Table: public.payment_acts_view

-- DROP TABLE IF EXISTS public.payment_acts_view;

CREATE TABLE IF NOT EXISTS public.payment_acts_view
(
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    sum integer NOT NULL,
    date date NOT NULL,
    CONSTRAINT payment_act_pk PRIMARY KEY (id),
    CONSTRAINT payment_act_fk FOREIGN KEY (user_id)
        REFERENCES public.users_view (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.payment_acts_view
    OWNER to postgres;

-- Table: public.regions_view

-- DROP TABLE IF EXISTS public.regions_view;

CREATE TABLE IF NOT EXISTS public.regions_view
(
    id uuid NOT NULL,
    region_name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT region_pk PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.regions_view
    OWNER to postgres;
	
-- Table: public.sertificates_view

-- DROP TABLE IF EXISTS public.sertificates_view;

CREATE TABLE IF NOT EXISTS public.sertificates_view
(
    id uuid NOT NULL,
    private_key text COLLATE pg_catalog."default" NOT NULL,
    public_key text COLLATE pg_catalog."default" NOT NULL,
    server_id uuid NOT NULL,
    date_create date NOT NULL,
    CONSTRAINT sertificate_pk PRIMARY KEY (id),
    CONSTRAINT sertificate_fk FOREIGN KEY (server_id)
        REFERENCES public.servers_view (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sertificates_view
    OWNER to postgres;
	
-- Table: public.servers_view

-- DROP TABLE IF EXISTS public.servers_view;

CREATE TABLE IF NOT EXISTS public.servers_view
(
    id uuid NOT NULL,
    ip character varying COLLATE pg_catalog."default" NOT NULL,
    server_name character varying COLLATE pg_catalog."default" NOT NULL,
    count_users integer NOT NULL DEFAULT 0,
    region_id uuid NOT NULL,
    CONSTRAINT server_pk PRIMARY KEY (id),
    CONSTRAINT server_fk FOREIGN KEY (region_id)
        REFERENCES public.regions_view (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.servers_view
    OWNER to postgres;
	
-- Table: public.users_view

-- DROP TABLE IF EXISTS public.users_view;

CREATE TABLE IF NOT EXISTS public.users_view
(
    telegram_id text COLLATE pg_catalog."default" NOT NULL,
    username text COLLATE pg_catalog."default",
    current_sertificate_id uuid,
    balance integer NOT NULL DEFAULT 0,
    free_period_used boolean NOT NULL DEFAULT false,
    id uuid NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY (id),
    CONSTRAINT user_fk FOREIGN KEY (current_sertificate_id)
        REFERENCES public.sertificates_view (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

--TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users_view
    OWNER to postgres;