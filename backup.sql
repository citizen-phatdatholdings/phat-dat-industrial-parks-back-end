--
-- PostgreSQL database dump
--

\restrict 4zNlkAoPIvyMQazcGxH4fm20fj91M01yqal4oAIaQkN8VxHiyDHSDeXkU5cJTIO

-- Dumped from database version 16.14
-- Dumped by pg_dump version 16.14

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
-- Name: contact_submissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.contact_submissions (
    id integer NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort integer,
    date_created timestamp with time zone,
    full_name character varying(255),
    email character varying(255),
    phone character varying(255),
    interest character varying(255),
    message text,
    ip_address character varying(255),
    user_agent text,
    turnstile_token character varying(255)
);


ALTER TABLE public.contact_submissions OWNER TO directus;

--
-- Name: contact_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.contact_submissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_submissions_id_seq OWNER TO directus;

--
-- Name: contact_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.contact_submissions_id_seq OWNED BY public.contact_submissions.id;


--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO directus;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO directus;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO directus;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_notifications_id_seq OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO directus;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO directus;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json,
    visual_editor_urls json
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO directus;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO directus;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO directus;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_webhooks_id_seq OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: project_connectivity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.project_connectivity (
    id integer NOT NULL,
    sort integer,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    project integer,
    destination character varying(255) DEFAULT NULL::character varying,
    destination_en character varying(255),
    distance character varying(255)
);


ALTER TABLE public.project_connectivity OWNER TO directus;

--
-- Name: project_connectivity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.project_connectivity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_connectivity_id_seq OWNER TO directus;

--
-- Name: project_connectivity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.project_connectivity_id_seq OWNED BY public.project_connectivity.id;


--
-- Name: project_specs; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.project_specs (
    id integer NOT NULL,
    sort integer,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    project integer,
    label character varying(255),
    label_en character varying(255),
    value character varying(255),
    value_en character varying(255)
);


ALTER TABLE public.project_specs OWNER TO directus;

--
-- Name: project_specs_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.project_specs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_specs_id_seq OWNER TO directus;

--
-- Name: project_specs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.project_specs_id_seq OWNED BY public.project_specs.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort integer,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    slug character varying(255) DEFAULT NULL::character varying,
    province character varying(255),
    name character varying(255) DEFAULT NULL::character varying,
    location character varying(255),
    location_en character varying(255),
    area character varying(255),
    type character varying(255),
    type_en character varying(255),
    detail text,
    detail_en text,
    image uuid,
    video_url character varying(255),
    street_view_url character varying(255),
    connectivity_title character varying(255) DEFAULT 'Vị trí chiến lược, kết nối liên vùng phía Nam'::character varying,
    connectivity_title_en character varying(255) DEFAULT 'Strategic location, Southern regional connectivity'::character varying,
    connectivity_description character varying(255),
    connectivity_description_en character varying(255),
    leasing_hotline character varying(255),
    leasing_email character varying(255),
    brochure uuid,
    pin boolean
);


ALTER TABLE public.projects OWNER TO directus;

--
-- Name: projects_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.projects_files (
    id integer NOT NULL,
    projects_id integer,
    directus_files_id uuid
);


ALTER TABLE public.projects_files OWNER TO directus;

--
-- Name: projects_files_1; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.projects_files_1 (
    id integer NOT NULL,
    projects_id integer,
    directus_files_id uuid
);


ALTER TABLE public.projects_files_1 OWNER TO directus;

--
-- Name: projects_files_1_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.projects_files_1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_files_1_id_seq OWNER TO directus;

--
-- Name: projects_files_1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.projects_files_1_id_seq OWNED BY public.projects_files_1.id;


--
-- Name: projects_files_2; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.projects_files_2 (
    id integer NOT NULL,
    projects_id integer,
    directus_files_id uuid
);


ALTER TABLE public.projects_files_2 OWNER TO directus;

--
-- Name: projects_files_2_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.projects_files_2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_files_2_id_seq OWNER TO directus;

--
-- Name: projects_files_2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.projects_files_2_id_seq OWNED BY public.projects_files_2.id;


--
-- Name: projects_files_3; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.projects_files_3 (
    id integer NOT NULL,
    projects_id integer,
    directus_files_id uuid
);


ALTER TABLE public.projects_files_3 OWNER TO directus;

--
-- Name: projects_files_3_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.projects_files_3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_files_3_id_seq OWNER TO directus;

--
-- Name: projects_files_3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.projects_files_3_id_seq OWNED BY public.projects_files_3.id;


--
-- Name: projects_files_4; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.projects_files_4 (
    id integer NOT NULL,
    projects_id integer,
    directus_files_id uuid
);


ALTER TABLE public.projects_files_4 OWNER TO directus;

--
-- Name: projects_files_4_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.projects_files_4_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_files_4_id_seq OWNER TO directus;

--
-- Name: projects_files_4_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.projects_files_4_id_seq OWNED BY public.projects_files_4.id;


--
-- Name: projects_files_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.projects_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_files_id_seq OWNER TO directus;

--
-- Name: projects_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.projects_files_id_seq OWNED BY public.projects_files.id;


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO directus;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: provinces; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.provinces (
    id character varying(255) NOT NULL,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    name character varying(255),
    name_en character varying(255)
);


ALTER TABLE public.provinces OWNER TO directus;

--
-- Name: site_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.site_settings (
    id integer NOT NULL,
    user_updated uuid,
    date_updated timestamp with time zone,
    address character varying(255),
    map_url character varying(255),
    phone character varying(255),
    email character varying(255),
    zalo character varying(255),
    facebook character varying(255),
    linkedin character varying(255),
    youtube character varying(255)
);


ALTER TABLE public.site_settings OWNER TO directus;

--
-- Name: site_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.site_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.site_settings_id_seq OWNER TO directus;

--
-- Name: site_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.site_settings_id_seq OWNED BY public.site_settings.id;


--
-- Name: contact_submissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.contact_submissions ALTER COLUMN id SET DEFAULT nextval('public.contact_submissions_id_seq'::regclass);


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: project_connectivity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.project_connectivity ALTER COLUMN id SET DEFAULT nextval('public.project_connectivity_id_seq'::regclass);


--
-- Name: project_specs id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.project_specs ALTER COLUMN id SET DEFAULT nextval('public.project_specs_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: projects_files id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files ALTER COLUMN id SET DEFAULT nextval('public.projects_files_id_seq'::regclass);


--
-- Name: projects_files_1 id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_1 ALTER COLUMN id SET DEFAULT nextval('public.projects_files_1_id_seq'::regclass);


--
-- Name: projects_files_2 id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_2 ALTER COLUMN id SET DEFAULT nextval('public.projects_files_2_id_seq'::regclass);


--
-- Name: projects_files_3 id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_3 ALTER COLUMN id SET DEFAULT nextval('public.projects_files_3_id_seq'::regclass);


--
-- Name: projects_files_4 id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_4 ALTER COLUMN id SET DEFAULT nextval('public.projects_files_4_id_seq'::regclass);


--
-- Name: site_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.site_settings ALTER COLUMN id SET DEFAULT nextval('public.site_settings_id_seq'::regclass);


--
-- Data for Name: contact_submissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.contact_submissions (id, status, sort, date_created, full_name, email, phone, interest, message, ip_address, user_agent, turnstile_token) FROM stdin;
17	draft	\N	2026-05-29 02:16:13.431+00	Nguyen Van A	a@gmail.com	0909999999	Đầu tư	Xin tư vấn	\N	\N	TOKEN
18	draft	\N	2026-06-02 01:30:29.541+00	Nguyen Van A	a@gmail.com	0909999999	Đầu tư	Xin tư vấn	\N	\N	TOKEN
\.


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
f22342f3-ce2e-4acd-bba8-71e1b400dba9	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
db3e95e8-7367-4b42-a2a3-b64c179c9b8a	68f80b85-61f1-494b-813b-77b830a38535	\N	3b61c147-f5e6-49cb-9d2c-03418029cd72	\N
2e79a50e-4d60-482b-947f-d39a17eb776d	\N	93696281-13e7-4677-b2cb-d083e9951e20	d8282123-159d-4ea1-a12d-3c816ccb39f4	\N
1acae373-369e-4c13-b1fc-953e7153be4a	89f0d9ce-ec46-46c6-aa43-de555a2173db	\N	d8282123-159d-4ea1-a12d-3c816ccb39f4	1
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:12:05.462+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_users	4adcfb7a-871c-4c08-a7ae-b11e89651916	http://localhost:8055
2	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:20:13.052+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_roles	caa3bd9d-b08f-4ff3-9192-310c2c8e182d	http://localhost:8055
3	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:20:13.108+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_roles	89f0d9ce-ec46-46c6-aa43-de555a2173db	http://localhost:8055
4	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:20:43.158+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_users	93696281-13e7-4677-b2cb-d083e9951e20	http://localhost:8055
5	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:20:43.164+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_roles	89f0d9ce-ec46-46c6-aa43-de555a2173db	http://localhost:8055
6	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:21:06.956+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_roles	caa3bd9d-b08f-4ff3-9192-310c2c8e182d	http://localhost:8055
7	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:21:27.093+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
8	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:21:36.319+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_access	2e79a50e-4d60-482b-947f-d39a17eb776d	http://localhost:8055
9	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:21:36.324+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
10	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:22:17.33+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_access	1acae373-369e-4c13-b1fc-953e7153be4a	http://localhost:8055
11	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:22:17.337+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_roles	89f0d9ce-ec46-46c6-aa43-de555a2173db	http://localhost:8055
12	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:22:51.368+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
13	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:22:51.371+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
14	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:22:51.374+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	3	http://localhost:8055
15	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:22:51.376+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	site_settings	http://localhost:8055
16	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:25:36.55+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	4	http://localhost:8055
17	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:25:54.313+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	5	http://localhost:8055
18	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:26:06.015+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	6	http://localhost:8055
19	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:26:15.024+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	7	http://localhost:8055
20	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:26:27.884+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	8	http://localhost:8055
21	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:26:33.81+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	9	http://localhost:8055
22	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:26:38.859+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	10	http://localhost:8055
23	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:26:43.362+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	11	http://localhost:8055
24	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:27:16.519+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	site_settings	1	http://localhost:8055
25	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:27:44.319+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	1	http://localhost:8055
26	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:27:44.323+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
27	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:33:49.691+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	site_settings	1	http://localhost:8055
28	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:38:53.147+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_users	93696281-13e7-4677-b2cb-d083e9951e20	http://localhost:8055
29	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:47:22.423+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	1	http://localhost:8055
30	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:47:22.435+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
31	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:51:19.396+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	12	http://localhost:8055
32	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:51:19.404+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	13	http://localhost:8055
33	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:51:19.407+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	14	http://localhost:8055
34	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:51:19.409+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	15	http://localhost:8055
35	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:51:19.411+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	16	http://localhost:8055
36	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:51:19.413+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	provinces	http://localhost:8055
37	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:31.571+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	provinces	http://localhost:8055
38	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:31.582+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	12	http://localhost:8055
39	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:31.583+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	13	http://localhost:8055
40	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:31.584+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	14	http://localhost:8055
41	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:31.585+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	15	http://localhost:8055
42	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:31.586+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	16	http://localhost:8055
43	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:47.673+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	17	http://localhost:8055
44	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:47.679+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	18	http://localhost:8055
45	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:47.684+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	19	http://localhost:8055
46	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:47.686+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	20	http://localhost:8055
47	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:47.689+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	21	http://localhost:8055
48	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:47.693+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	provinces	http://localhost:8055
49	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:52:55.065+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	22	http://localhost:8055
50	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:53:00.402+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	23	http://localhost:8055
51	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:53:20.257+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	provinces	vinh-phuc	http://localhost:8055
52	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:54:32.777+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	24	http://localhost:8055
53	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:54:32.792+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	25	http://localhost:8055
54	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:54:32.796+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	26	http://localhost:8055
55	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:54:32.801+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	27	http://localhost:8055
56	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:54:32.805+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	28	http://localhost:8055
57	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:54:32.811+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	29	http://localhost:8055
58	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:54:32.817+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	30	http://localhost:8055
59	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:54:32.822+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
60	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:54:40.197+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	31	http://localhost:8055
61	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:55:10.095+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	32	http://localhost:8055
62	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:55:16.85+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	33	http://localhost:8055
63	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:55:23.8+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	34	http://localhost:8055
64	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:55:28.376+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	35	http://localhost:8055
65	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:55:33.523+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	36	http://localhost:8055
66	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:05:08.476+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	37	http://localhost:8055
67	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:05:14.652+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	38	http://localhost:8055
68	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:06:38.389+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	39	http://localhost:8055
69	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:06:47.896+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_folders	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	http://localhost:8055
70	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:07:03.208+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	39	http://localhost:8055
71	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:07:17.259+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	40	http://localhost:8055
72	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:07:31.439+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	41	http://localhost:8055
73	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:09:34.455+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	42	http://localhost:8055
74	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:09:34.458+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	43	http://localhost:8055
75	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:09:34.462+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	44	http://localhost:8055
76	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:09:34.463+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	45	http://localhost:8055
77	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:09:34.468+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	46	http://localhost:8055
78	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:09:34.471+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	project_gallery	http://localhost:8055
79	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:10:08.599+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	47	http://localhost:8055
80	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:11:00.933+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	48	http://localhost:8055
81	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:14:36.21+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	49	http://localhost:8055
82	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:14:36.3+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	50	http://localhost:8055
83	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:14:36.302+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	projects_files	http://localhost:8055
84	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:14:36.32+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	51	http://localhost:8055
85	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:14:36.363+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	52	http://localhost:8055
86	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:14:49.355+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	b211bdcc-e144-432b-95f5-5eeafb7825e2	http://localhost:8055
87	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:14:49.355+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	a237bbc2-d65b-4c3c-91f6-96cd241f7a34	http://localhost:8055
88	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:14:49.355+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	5500af5d-2fff-4cfe-a260-6079cc0f4071	http://localhost:8055
89	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:10.828+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	project_gallery	http://localhost:8055
90	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:10.832+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	42	http://localhost:8055
91	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:10.832+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	43	http://localhost:8055
92	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:10.833+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	44	http://localhost:8055
93	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:10.834+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	45	http://localhost:8055
94	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:10.834+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	46	http://localhost:8055
95	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:10.835+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	47	http://localhost:8055
96	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:10.835+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	48	http://localhost:8055
97	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:29.6+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	projects_files	http://localhost:8055
98	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:29.603+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	50	http://localhost:8055
99	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:29.604+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	51	http://localhost:8055
100	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:29.606+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	52	http://localhost:8055
101	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:29.612+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	49	http://localhost:8055
102	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:41.614+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	53	http://localhost:8055
103	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:41.698+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	54	http://localhost:8055
104	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:41.699+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	projects_files	http://localhost:8055
105	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:41.717+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	55	http://localhost:8055
106	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:15:41.761+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	56	http://localhost:8055
107	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:16:02.581+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	57	http://localhost:8055
108	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:16:02.654+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	58	http://localhost:8055
109	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:16:02.655+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	projects_files_1	http://localhost:8055
110	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:16:02.669+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	59	http://localhost:8055
111	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:16:02.712+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	60	http://localhost:8055
112	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:16:11.177+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	61	http://localhost:8055
113	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:16:15.987+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	62	http://localhost:8055
114	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:16:56.535+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	63	http://localhost:8055
115	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:17:12.396+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	64	http://localhost:8055
116	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:17:30.699+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	65	http://localhost:8055
117	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:17:38.576+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	66	http://localhost:8055
118	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:17:48.997+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	67	http://localhost:8055
119	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:17:58.797+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	68	http://localhost:8055
120	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:18:25.722+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	69	http://localhost:8055
121	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:18:37.669+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	70	http://localhost:8055
122	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:19:27.779+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	71	http://localhost:8055
123	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:19:27.781+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	72	http://localhost:8055
124	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:19:27.783+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	73	http://localhost:8055
125	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:19:27.785+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	74	http://localhost:8055
126	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:19:27.786+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	75	http://localhost:8055
127	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:19:27.787+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	76	http://localhost:8055
128	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:19:27.788+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	project_specs	http://localhost:8055
129	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:19:49.534+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	77	http://localhost:8055
130	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:19:55.4+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	78	http://localhost:8055
131	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:19:59.386+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	79	http://localhost:8055
132	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:20:04.752+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	80	http://localhost:8055
133	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:20:09.649+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	81	http://localhost:8055
134	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:20:27.489+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	82	http://localhost:8055
135	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:20:27.496+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	83	http://localhost:8055
136	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:20:27.506+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	84	http://localhost:8055
137	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:20:27.508+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	85	http://localhost:8055
138	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:20:27.51+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	86	http://localhost:8055
139	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:20:27.513+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	87	http://localhost:8055
140	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:20:27.517+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	project_connectivity	http://localhost:8055
141	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:20:50.386+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	88	http://localhost:8055
142	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:20:57.279+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	89	http://localhost:8055
143	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:21:02.745+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	90	http://localhost:8055
144	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:21:12.523+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	89	http://localhost:8055
145	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:21:18.104+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	91	http://localhost:8055
146	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:23:02.42+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	4af7065e-102d-4414-8525-a6980fee0939	http://localhost:8055
147	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:24:23.161+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	53	http://localhost:8055
148	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:25:11.857+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	92	http://localhost:8055
149	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:25:12.014+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	93	http://localhost:8055
150	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:25:12.017+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	projects_files_2	http://localhost:8055
151	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:25:12.052+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	94	http://localhost:8055
152	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:25:12.12+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	95	http://localhost:8055
153	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:25:23.566+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	92	http://localhost:8055
154	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:25:36.907+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	92	http://localhost:8055
155	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:10.352+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	96	http://localhost:8055
156	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:10.448+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	97	http://localhost:8055
157	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:10.45+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	projects_files_3	http://localhost:8055
158	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:10.47+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	98	http://localhost:8055
159	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:10.522+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	99	http://localhost:8055
160	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:24.104+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	100	http://localhost:8055
161	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:24.235+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	101	http://localhost:8055
162	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:24.237+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	projects_files_4	http://localhost:8055
163	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:24.257+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	102	http://localhost:8055
164	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:24.315+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	103	http://localhost:8055
165	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:32.738+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	53	http://localhost:8055
166	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:26:35.665+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	57	http://localhost:8055
167	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:28:47.768+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	787ebd3f-dccb-4ae6-9e2c-1db6343adcf0	http://localhost:8055
168	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:28.779+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	5fbaf40b-b7c2-4e46-8976-c9407b352624	http://localhost:8055
170	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:36.976+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	e668742f-8bd5-4fb9-8fc0-64398abee559	http://localhost:8055
169	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:36.975+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	25d246e2-28fe-4a2e-98bc-87b3539b620b	http://localhost:8055
171	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:36.977+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	71c655cc-a9e5-4c97-9495-95952d0a7f9e	http://localhost:8055
172	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:36.989+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	f32ccce2-b31d-4894-a907-404679617812	http://localhost:8055
173	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:36.992+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	0d1c7b9b-ebe5-49e1-96cd-a2063cd88e84	http://localhost:8055
174	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:42.563+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	3c2a2598-491f-4fd2-9182-804b3a8e76c0	http://localhost:8055
176	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:42.569+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	0101113a-b58d-4cb8-8fc7-dfc8fcef8436	http://localhost:8055
175	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:42.568+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	8867ecc0-d8ee-4ddc-92ea-016243960d7b	http://localhost:8055
177	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:44.258+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects_files_4	1	http://localhost:8055
178	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:44.261+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects_files_4	2	http://localhost:8055
179	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:44.263+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects_files_4	3	http://localhost:8055
180	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:44.279+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects_files_3	1	http://localhost:8055
181	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:44.286+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects_files_3	2	http://localhost:8055
182	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:44.29+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects_files_3	3	http://localhost:8055
183	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:44.296+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects_files_3	4	http://localhost:8055
184	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:44.3+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects_files_3	5	http://localhost:8055
185	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:44.303+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects	1	http://localhost:8055
186	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:48.625+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects	1	http://localhost:8055
187	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:30:36.394+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	project_specs	1	http://localhost:8055
188	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:31:07.45+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	project_connectivity	1	http://localhost:8055
189	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:33:52.813+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	104	http://localhost:8055
190	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:34:37.203+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	105	http://localhost:8055
191	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:35:36.321+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	2	http://localhost:8055
192	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:35:36.325+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
193	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:40:56.681+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	project_specs	2	http://localhost:8055
194	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:40:56.685+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects	1	http://localhost:8055
195	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:44:57.193+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	3	http://localhost:8055
196	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:44:57.198+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	4	http://localhost:8055
197	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:44:57.201+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
198	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:46:27.136+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	4	http://localhost:8055
199	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:46:27.15+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	3	http://localhost:8055
200	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:46:27.157+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
201	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:55:29.432+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	8492eaba-6be7-4a0f-9d8b-b06434196074	http://localhost:8055
202	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:55:30.839+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects	1	http://localhost:8055
203	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:59:18.162+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	5	http://localhost:8055
204	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:59:18.178+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
205	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:59:59.431+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	5	http://localhost:8055
206	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:59:59.435+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
207	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:00:50.538+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	6	http://localhost:8055
208	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:00:50.544+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
209	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:06:55.887+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	7	http://localhost:8055
210	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:06:55.896+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
211	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:11:14.808+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	2	http://localhost:8055
212	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:11:14.815+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
213	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:15:57.911+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	8	http://localhost:8055
214	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:15:57.931+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	9	http://localhost:8055
215	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:15:57.941+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
216	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:33:09.526+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	0f3b43bb-b324-4a5a-a2a1-1e1e79a6ac18	http://localhost:8055
217	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:33:11.17+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	projects	1	http://localhost:8055
218	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:39:31.457+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	site_settings	1	http://localhost:8055
219	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:05:46.8+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	site_settings	http://localhost:8055
220	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:07:05.781+00	162.159.140.98	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_files	9df5b257-842a-48cd-88fe-13585d4a0b48	http://localhost:8055
221	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:07:07.67+00	162.159.140.98	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_settings	1	http://localhost:8055
222	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:07:29.391+00	162.159.140.98	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_settings	1	http://localhost:8055
223	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:42:11.361+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	106	http://localhost:8055
224	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:42:11.367+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	107	http://localhost:8055
225	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:42:11.37+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	108	http://localhost:8055
226	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:42:11.371+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	109	http://localhost:8055
227	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:42:11.373+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	contact_submissions	http://localhost:8055
228	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:42:23.566+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	110	http://localhost:8055
229	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:42:30.954+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	111	http://localhost:8055
230	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:42:38.55+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	112	http://localhost:8055
231	login	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:04:25.238+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_users	4adcfb7a-871c-4c08-a7ae-b11e89651916	http://localhost:8055
232	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:04:48.755+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	113	http://localhost:8055
233	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:05:03.386+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	114	http://localhost:8055
234	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:05:53.142+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	115	http://localhost:8055
235	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:07:27.532+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	116	http://localhost:8055
236	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:09:19.395+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	http://localhost:8055
237	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:15:23.512+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_operations	d48a734a-3a8d-41fd-add0-747b582118e3	http://localhost:8055
320	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:14:09.948+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	7	http://localhost:8055
238	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:15:23.52+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_operations	f9b2832a-1600-4ab7-a772-dfac0afaed41	http://localhost:8055
239	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:15:23.533+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	http://localhost:8055
241	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:24:29.246+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_operations	5643b85b-7c38-4500-8f36-d721a7b2683e	http://localhost:8055
242	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:24:29.261+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_operations	d48a734a-3a8d-41fd-add0-747b582118e3	http://localhost:8055
243	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:24:29.274+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_operations	f9b2832a-1600-4ab7-a772-dfac0afaed41	http://localhost:8055
244	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:24:29.283+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	http://localhost:8055
240	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:16:09.798+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	http://localhost:8055
245	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:26:09.812+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_fields	117	http://localhost:8055
246	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:27:10.547+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	10	http://localhost:8055
247	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:27:10.552+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
248	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:30:15.132+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	1	\N
249	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:30:15.172+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	\N
250	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:31:01.23+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	2	\N
251	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:31:01.262+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	\N
252	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:31:41.866+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	1	http://localhost:8055
253	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:31:41.87+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	2	http://localhost:8055
254	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:32:40.67+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	10	http://localhost:8055
255	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:32:40.682+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
256	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:33:03.881+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	10	http://localhost:8055
257	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:33:03.891+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
258	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:33:06.455+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	3	\N
259	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:33:06.467+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	\N
260	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:34:05.398+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	4	\N
261	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:34:05.438+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	\N
262	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:34:20.091+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	10	http://localhost:8055
263	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:34:20.093+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
264	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:34:22.686+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	5	\N
265	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:34:22.715+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	\N
266	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:35:09.713+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	http://localhost:8055
267	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:36:35.326+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	http://localhost:8055
268	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:36:42.862+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	http://localhost:8055
269	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:37:25.549+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	http://localhost:8055
270	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:53:18.783+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	http://localhost:8055
271	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:58:08.272+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_operations	5dd84a50-19f1-48f1-ab80-ebb3c260540b	http://localhost:8055
272	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:58:08.293+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	http://localhost:8055
273	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:59:36.946+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	6	\N
274	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:59:36.976+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
275	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:59:53.23+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	10	http://localhost:8055
276	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 01:59:53.237+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	http://localhost:8055
277	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:59:55.259+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	7	\N
278	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 01:59:55.273+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
279	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:01:59.508+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
280	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:02:03.806+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	project_specs	http://localhost:8055
281	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:02:06.87+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	project_connectivity	http://localhost:8055
283	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:02:18.2+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	contact_submissions	http://localhost:8055
282	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:02:12.533+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_collections	contact_submissions	http://localhost:8055
284	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:03:20.946+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	8	\N
285	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:03:20.959+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
286	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:04:38.504+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	11	http://localhost:8055
287	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:04:38.509+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
288	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:04:43.464+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	9	\N
289	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:04:43.473+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
290	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:05:42.46+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	12	http://localhost:8055
291	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:05:42.466+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	13	http://localhost:8055
292	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:05:42.469+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	14	http://localhost:8055
293	create	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:05:42.473+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	15	http://localhost:8055
294	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:05:42.476+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	11	http://localhost:8055
295	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:05:42.478+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
296	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:06:59.437+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	10	\N
297	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:06:59.448+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
298	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:08:11.925+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	11	\N
299	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:08:11.933+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
300	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:14.169+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	3	http://localhost:8055
301	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:14.171+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	4	http://localhost:8055
302	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:14.172+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	5	http://localhost:8055
303	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:14.173+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	7	http://localhost:8055
304	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:14.174+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	8	http://localhost:8055
305	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:14.174+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	6	http://localhost:8055
306	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:14.175+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	11	http://localhost:8055
307	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:14.175+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	9	http://localhost:8055
308	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:13:17.725+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	12	\N
309	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:13:17.732+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
310	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:13:22.245+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	13	\N
311	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:13:22.255+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
312	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:26.688+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	12	http://localhost:8055
313	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:26.69+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	10	http://localhost:8055
314	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:48.73+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	11	http://localhost:8055
315	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:48.731+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	12	http://localhost:8055
316	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:48.732+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	13	http://localhost:8055
317	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:48.733+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	14	http://localhost:8055
318	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:48.733+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_permissions	15	http://localhost:8055
319	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:13:48.734+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
321	update	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:14:09.95+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
322	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:14:47.939+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	14	\N
323	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:14:47.946+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
324	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:14:56.57+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	15	\N
325	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:14:56.579+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
326	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:16:11.589+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	16	\N
327	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:16:11.603+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
328	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:16:13.432+00	192.168.65.1	PostmanRuntime/7.54.0	contact_submissions	17	\N
329	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-05-29 02:16:13.442+00	192.168.65.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
330	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:16:26.064+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	13	http://localhost:8055
331	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:16:26.066+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	14	http://localhost:8055
332	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:16:26.066+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	15	http://localhost:8055
333	delete	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 02:16:26.066+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	contact_submissions	16	http://localhost:8055
334	login	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-31 06:59:57.601+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_users	4adcfb7a-871c-4c08-a7ae-b11e89651916	http://localhost:8055
335	login	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-06-02 00:42:35.512+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	directus_users	4adcfb7a-871c-4c08-a7ae-b11e89651916	http://localhost:8055
336	create	93696281-13e7-4677-b2cb-d083e9951e20	2026-06-02 01:30:29.55+00	172.18.0.1	PostmanRuntime/7.54.0	contact_submissions	18	\N
337	run	93696281-13e7-4677-b2cb-d083e9951e20	2026-06-02 01:30:29.586+00	172.18.0.1	PostmanRuntime/7.54.0	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	\N
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
provinces	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
projects_files	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
projects_files_1	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
projects_files_2	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
projects_files_3	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
projects_files_4	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
site_settings	settings	\N	\N	f	t	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
projects	\N	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	\N	\N	open	\N	t
project_specs	\N	\N	\N	f	f	\N	\N	t	\N	\N	sort	all	\N	\N	\N	\N	open	\N	t
project_connectivity	\N	\N	\N	f	f	\N	\N	t	\N	\N	sort	all	\N	\N	\N	\N	open	\N	t
contact_submissions	\N	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	\N	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
1	site_settings	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
2	site_settings	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	2	half	\N	\N	\N	f	\N	\N	\N
3	site_settings	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
4	site_settings	address	\N	input	{"placeholder":"39 Phạm Ngọc Thạch, Phường Xuân Hoà, TP. Hồ Chí Minh","iconLeft":"add_location"}	\N	\N	f	f	4	full	\N	\N	\N	t	\N	\N	\N
5	site_settings	map_url	\N	input	{"placeholder":"https://www.google.com/maps"}	\N	\N	f	f	5	full	\N	\N	\N	t	\N	\N	\N
6	site_settings	phone	\N	input	{"iconLeft":"headphones"}	\N	\N	f	f	6	full	\N	\N	\N	t	\N	\N	\N
7	site_settings	email	\N	input	{"iconLeft":"attach_email"}	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
8	site_settings	zalo	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	f	\N	\N	\N
9	site_settings	facebook	\N	input	\N	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N
10	site_settings	linkedin	\N	input	\N	\N	\N	f	f	10	full	\N	\N	\N	f	\N	\N	\N
11	site_settings	youtube	\N	input	\N	\N	\N	f	f	11	full	\N	\N	\N	f	\N	\N	\N
17	provinces	id	\N	input	\N	\N	\N	f	f	1	full	\N	\N	\N	f	\N	\N	\N
18	provinces	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	2	half	\N	\N	\N	f	\N	\N	\N
19	provinces	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
20	provinces	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N
21	provinces	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	5	half	\N	\N	\N	f	\N	\N	\N
22	provinces	name	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	t	\N	\N	\N
23	provinces	name_en	\N	input	\N	\N	\N	f	f	7	full	\N	\N	\N	t	\N	\N	\N
24	projects	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
25	projects	status	\N	select-dropdown	{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]}	labels	{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]}	f	f	2	full	\N	\N	\N	f	\N	\N	\N
26	projects	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
27	projects	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N
28	projects	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	5	half	\N	\N	\N	f	\N	\N	\N
29	projects	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	6	half	\N	\N	\N	f	\N	\N	\N
30	projects	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	7	half	\N	\N	\N	f	\N	\N	\N
31	projects	slug	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	t	\N	\N	\N
32	projects	province	m2o	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N
33	projects	name	\N	input	\N	\N	\N	f	f	10	full	\N	\N	\N	t	\N	\N	\N
34	projects	location	\N	input	\N	\N	\N	f	f	11	full	\N	\N	\N	t	\N	\N	\N
35	projects	location_en	\N	input	\N	\N	\N	f	f	12	full	\N	\N	\N	t	\N	\N	\N
36	projects	area	\N	input	\N	\N	\N	f	f	13	full	\N	\N	\N	t	\N	\N	\N
37	projects	type	\N	input	\N	\N	\N	f	f	14	full	\N	\N	\N	t	\N	\N	\N
38	projects	type_en	\N	input	\N	\N	\N	f	f	15	full	\N	\N	\N	t	\N	\N	\N
39	projects	detail	\N	input-rich-text-html	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"}	\N	\N	f	f	16	full	\N	\N	\N	t	\N	\N	\N
40	projects	detail_en	\N	input-rich-text-html	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"}	\N	\N	f	f	17	full	\N	\N	\N	t	\N	\N	\N
41	projects	image	file	file-image	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"}	\N	\N	f	f	18	full	\N	\N	\N	t	\N	\N	\N
54	projects_files	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
55	projects_files	projects_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
56	projects_files	directus_files_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
58	projects_files_1	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
59	projects_files_1	projects_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
60	projects_files_1	directus_files_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
61	projects	video_url	\N	input	\N	\N	\N	f	f	21	full	\N	\N	\N	f	\N	\N	\N
62	projects	street_view_url	\N	input	\N	\N	\N	f	f	22	full	\N	\N	\N	f	\N	\N	\N
63	projects	connectivity_title	\N	input	\N	\N	\N	f	f	23	full	\N	\N	\N	f	\N	\N	\N
64	projects	connectivity_title_en	\N	input	\N	\N	\N	f	f	24	full	\N	\N	\N	f	\N	\N	\N
65	projects	connectivity_description	\N	input	\N	\N	\N	f	f	25	full	\N	\N	\N	t	\N	\N	\N
66	projects	connectivity_description_en	\N	input	\N	\N	\N	f	f	26	full	\N	\N	\N	t	\N	\N	\N
67	projects	leasing_hotline	\N	input	\N	\N	\N	f	f	27	full	\N	\N	\N	t	\N	\N	\N
68	projects	leasing_email	\N	input	\N	\N	\N	f	f	28	full	\N	\N	\N	t	\N	\N	\N
69	projects	brochure	file	file	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"}	\N	\N	f	f	29	full	\N	\N	\N	t	\N	\N	\N
70	projects	pin	cast-boolean	boolean	\N	\N	\N	f	f	30	full	\N	\N	\N	f	\N	\N	\N
71	project_specs	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
72	project_specs	sort	\N	input	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
73	project_specs	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	3	half	\N	\N	\N	f	\N	\N	\N
74	project_specs	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	\N	\N	f	\N	\N	\N
75	project_specs	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	5	half	\N	\N	\N	f	\N	\N	\N
76	project_specs	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	6	half	\N	\N	\N	f	\N	\N	\N
77	project_specs	project	m2o	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	7	full	\N	\N	\N	t	\N	\N	\N
78	project_specs	label	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	t	\N	\N	\N
79	project_specs	label_en	\N	input	\N	\N	\N	f	f	9	full	\N	\N	\N	t	\N	\N	\N
80	project_specs	value	\N	input	\N	\N	\N	f	f	10	full	\N	\N	\N	t	\N	\N	\N
81	project_specs	value_en	\N	input	\N	\N	\N	f	f	11	full	\N	\N	\N	t	\N	\N	\N
82	project_connectivity	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
83	project_connectivity	sort	\N	input	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
84	project_connectivity	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	3	half	\N	\N	\N	f	\N	\N	\N
85	project_connectivity	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	\N	\N	f	\N	\N	\N
86	project_connectivity	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	5	half	\N	\N	\N	f	\N	\N	\N
87	project_connectivity	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	6	half	\N	\N	\N	f	\N	\N	\N
88	project_connectivity	project	m2o	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	7	full	\N	\N	\N	t	\N	\N	\N
90	project_connectivity	destination_en	\N	input	\N	\N	\N	f	f	9	full	\N	\N	\N	t	\N	\N	\N
89	project_connectivity	destination	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	t	\N	\N	\N
91	project_connectivity	distance	\N	input	\N	\N	\N	f	f	10	full	\N	\N	\N	t	\N	\N	\N
93	projects_files_2	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
94	projects_files_2	projects_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
95	projects_files_2	directus_files_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
96	projects	image_plans	files	files	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"}	\N	\N	f	f	31	full	\N	\N	\N	f	\N	\N	\N
97	projects_files_3	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
98	projects_files_3	projects_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
99	projects_files_3	directus_files_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
100	projects	image_gallery	files	files	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"}	\N	\N	f	f	32	full	\N	\N	\N	f	\N	\N	\N
101	projects_files_4	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
102	projects_files_4	projects_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
103	projects_files_4	directus_files_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
104	projects	project_specs	o2m	list-o2m	\N	\N	\N	f	f	33	full	\N	\N	\N	f	\N	\N	\N
105	projects	project_connectivity	o2m	list-o2m	\N	\N	\N	f	f	34	full	\N	\N	\N	f	\N	\N	\N
106	contact_submissions	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
107	contact_submissions	status	\N	select-dropdown	{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]}	labels	{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]}	f	f	2	full	\N	\N	\N	f	\N	\N	\N
108	contact_submissions	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
109	contact_submissions	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	\N	\N	f	\N	\N	\N
110	contact_submissions	full_name	\N	input	\N	\N	\N	f	f	5	full	\N	\N	\N	t	\N	\N	\N
111	contact_submissions	email	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	t	\N	\N	\N
112	contact_submissions	phone	\N	input	\N	\N	\N	f	f	7	full	\N	\N	\N	t	\N	\N	\N
113	contact_submissions	interest	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	t	\N	\N	\N
114	contact_submissions	message	\N	input-multiline	\N	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N
115	contact_submissions	ip_address	\N	input	\N	\N	\N	f	f	10	full	\N	\N	\N	f	\N	\N	\N
116	contact_submissions	user_agent	\N	input-multiline	\N	\N	\N	f	f	11	full	\N	\N	\N	f	\N	\N	\N
117	contact_submissions	turnstile_token	\N	input	\N	\N	\N	f	f	12	full	\N	\N	\N	t	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
5500af5d-2fff-4cfe-a260-6079cc0f4071	local	5500af5d-2fff-4cfe-a260-6079cc0f4071.png	project_terra.png	Project Terra	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:14:49.353+00	\N	2026-05-28 14:14:49.403+00	\N	1163117	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:14:49.401+00
b211bdcc-e144-432b-95f5-5eeafb7825e2	local	b211bdcc-e144-432b-95f5-5eeafb7825e2.png	project_nexus.png	Project Nexus	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:14:49.348+00	\N	2026-05-28 14:14:49.402+00	\N	963990	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:14:49.401+00
a237bbc2-d65b-4c3c-91f6-96cd241f7a34	local	a237bbc2-d65b-4c3c-91f6-96cd241f7a34.png	project_vina.png	Project Vina	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:14:49.349+00	\N	2026-05-28 14:14:49.42+00	\N	1098847	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:14:49.417+00
4af7065e-102d-4414-8525-a6980fee0939	local	4af7065e-102d-4414-8525-a6980fee0939.png	project_aurora.png	Project Aurora	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:23:02.417+00	\N	2026-05-28 14:23:02.45+00	\N	1081730	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:23:02.449+00
787ebd3f-dccb-4ae6-9e2c-1db6343adcf0	local	787ebd3f-dccb-4ae6-9e2c-1db6343adcf0.png	project_terra.png	Project Terra	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:28:47.763+00	\N	2026-05-28 14:28:47.79+00	\N	1163117	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:28:47.789+00
5fbaf40b-b7c2-4e46-8976-c9407b352624	local	5fbaf40b-b7c2-4e46-8976-c9407b352624.png	news_industrial.png	News Industrial	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:28.772+00	\N	2026-05-28 14:29:28.807+00	\N	1168423	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:29:28.806+00
71c655cc-a9e5-4c97-9495-95952d0a7f9e	local	71c655cc-a9e5-4c97-9495-95952d0a7f9e.png	project_nexus.png	Project Nexus	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:36.973+00	\N	2026-05-28 14:29:37.009+00	\N	963990	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:29:37.005+00
e668742f-8bd5-4fb9-8fc0-64398abee559	local	e668742f-8bd5-4fb9-8fc0-64398abee559.png	project_terra.png	Project Terra	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:36.972+00	\N	2026-05-28 14:29:37.019+00	\N	1163117	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:29:37.012+00
25d246e2-28fe-4a2e-98bc-87b3539b620b	local	25d246e2-28fe-4a2e-98bc-87b3539b620b.png	project_vina.png	Project Vina	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:36.971+00	\N	2026-05-28 14:29:37.043+00	\N	1098847	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:29:37.042+00
0d1c7b9b-ebe5-49e1-96cd-a2063cd88e84	local	0d1c7b9b-ebe5-49e1-96cd-a2063cd88e84.png	green_industrial_park.png	Green Industrial Park	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:36.989+00	\N	2026-05-28 14:29:37.05+00	\N	1076970	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:29:37.048+00
f32ccce2-b31d-4894-a907-404679617812	local	f32ccce2-b31d-4894-a907-404679617812.png	project_aurora.png	Project Aurora	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:36.984+00	\N	2026-05-28 14:29:37.053+00	\N	1081730	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:29:37.052+00
3c2a2598-491f-4fd2-9182-804b3a8e76c0	local	3c2a2598-491f-4fd2-9182-804b3a8e76c0.png	White-Background.png	White Background	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:42.56+00	\N	2026-05-28 14:29:42.588+00	\N	1072127	1717	916	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:29:42.587+00
0101113a-b58d-4cb8-8fc7-dfc8fcef8436	local	0101113a-b58d-4cb8-8fc7-dfc8fcef8436.png	Red-Background.png	Red Background	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:42.567+00	\N	2026-05-28 14:29:42.603+00	\N	1403615	1717	916	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:29:42.601+00
8867ecc0-d8ee-4ddc-92ea-016243960d7b	local	8867ecc0-d8ee-4ddc-92ea-016243960d7b.png	preload-images.png	Preload Images	image/png	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:42.565+00	\N	2026-05-28 14:29:42.612+00	\N	2054078	1727	911	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-28 14:29:42.611+00
8492eaba-6be7-4a0f-9d8b-b06434196074	local	8492eaba-6be7-4a0f-9d8b-b06434196074.jpeg	IMG_8075.jpeg	Img 8075	image/jpeg	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:55:29.425+00	\N	2026-05-28 14:55:29.552+00	\N	3767942	4284	5712	\N	\N	\N	\N	\N	{"ifd0":{"Make":"Apple","Model":"iPhone Air"},"exif":{"FNumber":1.6,"ExposureTime":0.01,"FocalLength":5.960000038146973,"ISOSpeedRatings":50}}	\N	\N	\N	\N	2026-05-28 14:55:29.551+00
0f3b43bb-b324-4a5a-a2a1-1e1e79a6ac18	local	0f3b43bb-b324-4a5a-a2a1-1e1e79a6ac18.pdf	png2pdf.pdf	Png2pdf	application/pdf	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:33:09.411+00	\N	2026-05-28 15:33:09.624+00	\N	279026	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-05-28 15:33:09.61+00
9df5b257-842a-48cd-88fe-13585d4a0b48	local	9df5b257-842a-48cd-88fe-13585d4a0b48.png	logo-only-white.png	Logo Only White	image/png	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-29 00:07:05.777+00	\N	2026-05-29 00:07:05.805+00	\N	94195	1024	1024	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-05-29 00:07:05.804+00
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
052aff35-edb1-436e-be64-80b0b07c4155	Send Email	bolt	\N	\N	active	event	all	{"type":"action","scope":["items.create"],"collections":["contact_submissions"]}	5dd84a50-19f1-48f1-ab80-ebb3c260540b	2026-05-29 01:37:25.546+00	4adcfb7a-871c-4c08-a7ae-b11e89651916
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
d49cfbb4-7232-4ad2-8487-6315c94ed1b4	projects	\N
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2026-05-28 13:11:19.979058+00
20201029A	Remove System Relations	2026-05-28 13:11:19.980901+00
20201029B	Remove System Collections	2026-05-28 13:11:19.982582+00
20201029C	Remove System Fields	2026-05-28 13:11:19.985797+00
20201105A	Add Cascade System Relations	2026-05-28 13:11:20.00141+00
20201105B	Change Webhook URL Type	2026-05-28 13:11:20.0045+00
20210225A	Add Relations Sort Field	2026-05-28 13:11:20.007238+00
20210304A	Remove Locked Fields	2026-05-28 13:11:20.008571+00
20210312A	Webhooks Collections Text	2026-05-28 13:11:20.010931+00
20210331A	Add Refresh Interval	2026-05-28 13:11:20.011904+00
20210415A	Make Filesize Nullable	2026-05-28 13:11:20.013957+00
20210416A	Add Collections Accountability	2026-05-28 13:11:20.015256+00
20210422A	Remove Files Interface	2026-05-28 13:11:20.016121+00
20210506A	Rename Interfaces	2026-05-28 13:11:20.022042+00
20210510A	Restructure Relations	2026-05-28 13:11:20.028286+00
20210518A	Add Foreign Key Constraints	2026-05-28 13:11:20.031305+00
20210519A	Add System Fk Triggers	2026-05-28 13:11:20.04042+00
20210521A	Add Collections Icon Color	2026-05-28 13:11:20.041259+00
20210525A	Add Insights	2026-05-28 13:11:20.046822+00
20210608A	Add Deep Clone Config	2026-05-28 13:11:20.047499+00
20210626A	Change Filesize Bigint	2026-05-28 13:11:20.051036+00
20210716A	Add Conditions to Fields	2026-05-28 13:11:20.0517+00
20210721A	Add Default Folder	2026-05-28 13:11:20.053269+00
20210802A	Replace Groups	2026-05-28 13:11:20.054689+00
20210803A	Add Required to Fields	2026-05-28 13:11:20.055417+00
20210805A	Update Groups	2026-05-28 13:11:20.056441+00
20210805B	Change Image Metadata Structure	2026-05-28 13:11:20.057727+00
20210811A	Add Geometry Config	2026-05-28 13:11:20.058393+00
20210831A	Remove Limit Column	2026-05-28 13:11:20.059127+00
20210903A	Add Auth Provider	2026-05-28 13:11:20.063482+00
20210907A	Webhooks Collections Not Null	2026-05-28 13:11:20.064963+00
20210910A	Move Module Setup	2026-05-28 13:11:20.065791+00
20210920A	Webhooks URL Not Null	2026-05-28 13:11:20.06738+00
20210924A	Add Collection Organization	2026-05-28 13:11:20.068508+00
20210927A	Replace Fields Group	2026-05-28 13:11:20.070557+00
20210927B	Replace M2M Interface	2026-05-28 13:11:20.071151+00
20210929A	Rename Login Action	2026-05-28 13:11:20.071698+00
20211007A	Update Presets	2026-05-28 13:11:20.073337+00
20211009A	Add Auth Data	2026-05-28 13:11:20.074015+00
20211016A	Add Webhook Headers	2026-05-28 13:11:20.074623+00
20211103A	Set Unique to User Token	2026-05-28 13:11:20.076013+00
20211103B	Update Special Geometry	2026-05-28 13:11:20.076598+00
20211104A	Remove Collections Listing	2026-05-28 13:11:20.077325+00
20211118A	Add Notifications	2026-05-28 13:11:20.081241+00
20211211A	Add Shares	2026-05-28 13:11:20.085953+00
20211230A	Add Project Descriptor	2026-05-28 13:11:20.086635+00
20220303A	Remove Default Project Color	2026-05-28 13:11:20.088659+00
20220308A	Add Bookmark Icon and Color	2026-05-28 13:11:20.089519+00
20220314A	Add Translation Strings	2026-05-28 13:11:20.0901+00
20220322A	Rename Field Typecast Flags	2026-05-28 13:11:20.091196+00
20220323A	Add Field Validation	2026-05-28 13:11:20.091865+00
20220325A	Fix Typecast Flags	2026-05-28 13:11:20.093009+00
20220325B	Add Default Language	2026-05-28 13:11:20.095094+00
20220402A	Remove Default Value Panel Icon	2026-05-28 13:11:20.096632+00
20220429A	Add Flows	2026-05-28 13:11:20.1061+00
20220429B	Add Color to Insights Icon	2026-05-28 13:11:20.106756+00
20220429C	Drop Non Null From IP of Activity	2026-05-28 13:11:20.107319+00
20220429D	Drop Non Null From Sender of Notifications	2026-05-28 13:11:20.10791+00
20220614A	Rename Hook Trigger to Event	2026-05-28 13:11:20.108423+00
20220801A	Update Notifications Timestamp Column	2026-05-28 13:11:20.110219+00
20220802A	Add Custom Aspect Ratios	2026-05-28 13:11:20.111001+00
20220826A	Add Origin to Accountability	2026-05-28 13:11:20.111813+00
20230401A	Update Material Icons	2026-05-28 13:11:20.114396+00
20230525A	Add Preview Settings	2026-05-28 13:11:20.115096+00
20230526A	Migrate Translation Strings	2026-05-28 13:11:20.11809+00
20230721A	Require Shares Fields	2026-05-28 13:11:20.119484+00
20230823A	Add Content Versioning	2026-05-28 13:11:20.124474+00
20230927A	Themes	2026-05-28 13:11:20.128812+00
20231009A	Update CSV Fields to Text	2026-05-28 13:11:20.130061+00
20231009B	Update Panel Options	2026-05-28 13:11:20.130767+00
20231010A	Add Extensions	2026-05-28 13:11:20.132092+00
20231215A	Add Focalpoints	2026-05-28 13:11:20.132997+00
20240122A	Add Report URL Fields	2026-05-28 13:11:20.13385+00
20240204A	Marketplace	2026-05-28 13:11:20.13974+00
20240305A	Change Useragent Type	2026-05-28 13:11:20.14249+00
20240311A	Deprecate Webhooks	2026-05-28 13:11:20.145845+00
20240422A	Public Registration	2026-05-28 13:11:20.147557+00
20240515A	Add Session Window	2026-05-28 13:11:20.14824+00
20240701A	Add Tus Data	2026-05-28 13:11:20.149073+00
20240716A	Update Files Date Fields	2026-05-28 13:11:20.150758+00
20240806A	Permissions Policies	2026-05-28 13:11:20.162177+00
20240817A	Update Icon Fields Length	2026-05-28 13:11:20.167884+00
20240909A	Separate Comments	2026-05-28 13:11:20.171293+00
20240909B	Consolidate Content Versioning	2026-05-28 13:11:20.171959+00
20240924A	Migrate Legacy Comments	2026-05-28 13:11:20.174198+00
20240924B	Populate Versioning Deltas	2026-05-28 13:11:20.175903+00
20250224A	Visual Editor	2026-05-28 13:11:20.177023+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
5dd84a50-19f1-48f1-ab80-ebb3c260540b	ecitizen@phatdatholdings.com.vn	ecitizen_phatdatholdings_com_vn	mail	19	1	{"subject":"test","body":"test"}	\N	\N	052aff35-edb1-436e-be64-80b0b07c4155	2026-05-29 01:58:08.27+00	4adcfb7a-871c-4c08-a7ae-b11e89651916
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
1	site_settings	read	\N	\N	\N	map_url,address,email,zalo,phone,youtube,linkedin,facebook	d8282123-159d-4ea1-a12d-3c816ccb39f4
4	project_connectivity	read	\N	\N	\N	destination,destination_en,distance	d8282123-159d-4ea1-a12d-3c816ccb39f4
3	project_specs	read	\N	\N	\N	label,value,value_en,label_en	d8282123-159d-4ea1-a12d-3c816ccb39f4
6	directus_files	read	{"_and":[{"folder":{"name":{"_contains":"projects"}}}]}	\N	\N	\N	d8282123-159d-4ea1-a12d-3c816ccb39f4
2	projects	read	{"_and":[{"status":{"_eq":"published"}}]}	\N	\N	status,sort,slug,province,name,location,location_en,area,type,type_en,detail,detail_en,image,video_url,street_view_url,connectivity_title,connectivity_title_en,connectivity_description,connectivity_description_en,leasing_hotline,leasing_email,brochure,pin,image_plans,image_gallery,project_specs,project_connectivity	d8282123-159d-4ea1-a12d-3c816ccb39f4
8	projects_files_3	read	\N	\N	\N	directus_files_id	d8282123-159d-4ea1-a12d-3c816ccb39f4
9	projects_files_4	read	\N	\N	\N	directus_files_id	d8282123-159d-4ea1-a12d-3c816ccb39f4
10	contact_submissions	create	\N	\N	\N	*	d8282123-159d-4ea1-a12d-3c816ccb39f4
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
3b61c147-f5e6-49cb-9d2c-03418029cd72	Administrator	verified	$t:admin_description	\N	f	t	t
d8282123-159d-4ea1-a12d-3c816ccb39f4	Website PDIP	badge	\N	\N	f	f	f
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	\N	directus_users	\N	cards	{"cards":{"sort":["email"],"page":1}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":4}}	\N	\N	bookmark	\N
2	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"page":1}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N	bookmark	\N
3	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	\N	provinces	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
6	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	\N	project_specs	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
7	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	\N	contact_submissions	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
8	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	\N	project_connectivity	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
4	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	\N	projects	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	site_settings	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
4	provinces	user_created	directus_users	\N	\N	\N	\N	\N	nullify
5	provinces	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
6	projects	user_created	directus_users	\N	\N	\N	\N	\N	nullify
7	projects	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
8	projects	province	provinces	\N	\N	\N	\N	\N	nullify
9	projects	image	directus_files	\N	\N	\N	\N	\N	nullify
16	projects_files_1	directus_files_id	directus_files	\N	\N	\N	projects_id	\N	nullify
18	projects	brochure	directus_files	\N	\N	\N	\N	\N	nullify
19	project_specs	user_created	directus_users	\N	\N	\N	\N	\N	nullify
20	project_specs	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
22	project_connectivity	user_created	directus_users	\N	\N	\N	\N	\N	nullify
23	project_connectivity	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
25	projects_files_2	directus_files_id	directus_files	\N	\N	\N	projects_id	\N	nullify
26	projects_files_2	projects_id	projects	\N	\N	\N	directus_files_id	\N	nullify
27	projects_files_3	directus_files_id	directus_files	\N	\N	\N	projects_id	\N	nullify
28	projects_files_3	projects_id	projects	image_plans	\N	\N	directus_files_id	\N	nullify
29	projects_files_4	directus_files_id	directus_files	\N	\N	\N	projects_id	\N	nullify
30	projects_files_4	projects_id	projects	image_gallery	\N	\N	directus_files_id	\N	nullify
17	projects_files_1	projects_id	projects	\N	\N	\N	directus_files_id	\N	nullify
21	project_specs	project	projects	project_specs	\N	\N	\N	\N	nullify
24	project_connectivity	project	projects	project_connectivity	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_roles	caa3bd9d-b08f-4ff3-9192-310c2c8e182d	{"name":"Phat Dat Industrial Park Website"}	{"name":"Phat Dat Industrial Park Website"}	\N	\N
2	3	directus_roles	89f0d9ce-ec46-46c6-aa43-de555a2173db	{"name":"Phat Dat Industrial Park Website"}	{"name":"Phat Dat Industrial Park Website"}	\N	\N
3	4	directus_users	93696281-13e7-4677-b2cb-d083e9951e20	{"first_name":"PDIP Website","token":"**********","role":"89f0d9ce-ec46-46c6-aa43-de555a2173db"}	{"first_name":"PDIP Website","token":"**********","role":"89f0d9ce-ec46-46c6-aa43-de555a2173db"}	\N	\N
4	7	directus_policies	d8282123-159d-4ea1-a12d-3c816ccb39f4	{"name":"Website PDIP","admin_access":false,"app_access":false}	{"name":"Website PDIP","admin_access":false,"app_access":false}	\N	\N
5	8	directus_access	2e79a50e-4d60-482b-947f-d39a17eb776d	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","user":{"id":"93696281-13e7-4677-b2cb-d083e9951e20"}}	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","user":{"id":"93696281-13e7-4677-b2cb-d083e9951e20"}}	\N	\N
6	10	directus_access	1acae373-369e-4c13-b1fc-953e7153be4a	{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","policy":{"id":"d8282123-159d-4ea1-a12d-3c816ccb39f4"},"sort":1}	{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","policy":{"id":"d8282123-159d-4ea1-a12d-3c816ccb39f4"},"sort":1}	\N	\N
7	12	directus_fields	1	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"site_settings"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"site_settings"}	\N	\N
8	13	directus_fields	2	{"sort":2,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"site_settings"}	{"sort":2,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"site_settings"}	\N	\N
9	14	directus_fields	3	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"site_settings"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"site_settings"}	\N	\N
10	15	directus_collections	site_settings	{"singleton":true,"collection":"site_settings"}	{"singleton":true,"collection":"site_settings"}	\N	\N
11	16	directus_fields	4	{"sort":4,"interface":"input","special":null,"required":true,"options":{"placeholder":"39 Phạm Ngọc Thạch, Phường Xuân Hoà, TP. Hồ Chí Minh","iconLeft":"add_location"},"collection":"site_settings","field":"address"}	{"sort":4,"interface":"input","special":null,"required":true,"options":{"placeholder":"39 Phạm Ngọc Thạch, Phường Xuân Hoà, TP. Hồ Chí Minh","iconLeft":"add_location"},"collection":"site_settings","field":"address"}	\N	\N
12	17	directus_fields	5	{"sort":5,"interface":"input","special":null,"required":true,"options":{"placeholder":"https://www.google.com/maps"},"collection":"site_settings","field":"map_url"}	{"sort":5,"interface":"input","special":null,"required":true,"options":{"placeholder":"https://www.google.com/maps"},"collection":"site_settings","field":"map_url"}	\N	\N
13	18	directus_fields	6	{"sort":6,"interface":"input","special":null,"required":true,"options":{"iconLeft":"headphones"},"collection":"site_settings","field":"phone"}	{"sort":6,"interface":"input","special":null,"required":true,"options":{"iconLeft":"headphones"},"collection":"site_settings","field":"phone"}	\N	\N
14	19	directus_fields	7	{"sort":7,"interface":"input","special":null,"options":{"iconLeft":"attach_email"},"collection":"site_settings","field":"email"}	{"sort":7,"interface":"input","special":null,"options":{"iconLeft":"attach_email"},"collection":"site_settings","field":"email"}	\N	\N
15	20	directus_fields	8	{"sort":8,"interface":"input","special":null,"collection":"site_settings","field":"zalo"}	{"sort":8,"interface":"input","special":null,"collection":"site_settings","field":"zalo"}	\N	\N
16	21	directus_fields	9	{"sort":9,"interface":"input","special":null,"collection":"site_settings","field":"facebook"}	{"sort":9,"interface":"input","special":null,"collection":"site_settings","field":"facebook"}	\N	\N
17	22	directus_fields	10	{"sort":10,"interface":"input","special":null,"collection":"site_settings","field":"linkedin"}	{"sort":10,"interface":"input","special":null,"collection":"site_settings","field":"linkedin"}	\N	\N
18	23	directus_fields	11	{"sort":11,"interface":"input","special":null,"collection":"site_settings","field":"youtube"}	{"sort":11,"interface":"input","special":null,"collection":"site_settings","field":"youtube"}	\N	\N
19	24	site_settings	1	{"address":"39 Phạm Ngọc Thạch, Phường Xuân Hoà, TP. Hồ Chí Minh","map_url":"https://www.google.com/maps?q=39+Ph%E1%BA%A1m+Ng%E1%BB%8Dc+Th%E1%BA%A1ch,+Ph%C6%B0%E1%BB%9Dng+Xu%C3%A2n+Ho%C3%A0,+TP.+H%E1%BB%93+Ch%C3%AD+Minh","phone":"0988204060","email":"contactt@phatdatip.vn","facebook":"https://www.facebook.com/mktechvn"}	{"address":"39 Phạm Ngọc Thạch, Phường Xuân Hoà, TP. Hồ Chí Minh","map_url":"https://www.google.com/maps?q=39+Ph%E1%BA%A1m+Ng%E1%BB%8Dc+Th%E1%BA%A1ch,+Ph%C6%B0%E1%BB%9Dng+Xu%C3%A2n+Ho%C3%A0,+TP.+H%E1%BB%93+Ch%C3%AD+Minh","phone":"0988204060","email":"contactt@phatdatip.vn","facebook":"https://www.facebook.com/mktechvn"}	\N	\N
20	25	directus_permissions	1	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["map_url","address","email","zalo","phone"],"presets":null,"collection":"site_settings","action":"read"}	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["map_url","address","email","zalo","phone"],"presets":null,"collection":"site_settings","action":"read"}	\N	\N
21	27	site_settings	1	{"id":1,"user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T13:33:49.684Z","address":"39 Phạm Ngọc Thạch, Phường Xuân Hoà, TP. Hồ Chí Minh","map_url":"https://www.google.com/maps?q=39+Ph%E1%BA%A1m+Ng%E1%BB%8Dc+Th%E1%BA%A1ch,+Ph%C6%B0%E1%BB%9Dng+Xu%C3%A2n+Ho%C3%A0,+TP.+H%E1%BB%93+Ch%C3%AD+Minh","phone":"0988204060","email":"contactt@phatdatip.vn","zalo":null,"facebook":"https://www.facebook.com/mktechvn","linkedin":"https://www.google.com/maps/place/39+Ph%E1%BA%A1m+Ng%E1%BB%8Dc+Th%E1%BA%A1ch,+P,+Xu%C3%A2n+H%C3%B2a,+H%E1%BB%93+Ch%C3%AD+Minh,+Vietnam/@10.7845622,106.6908757,17z/data=!3m1!4b1!4m6!3m5!1s0x31752f33fbae5a31:0x6a50a18b72facf1e!8m2!3d10.7845622!4d106.6934506","youtube":null}	{"linkedin":"https://www.google.com/maps/place/39+Ph%E1%BA%A1m+Ng%E1%BB%8Dc+Th%E1%BA%A1ch,+P,+Xu%C3%A2n+H%C3%B2a,+H%E1%BB%93+Ch%C3%AD+Minh,+Vietnam/@10.7845622,106.6908757,17z/data=!3m1!4b1!4m6!3m5!1s0x31752f33fbae5a31:0x6a50a18b72facf1e!8m2!3d10.7845622!4d106.6934506","user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T13:33:49.684Z"}	\N	\N
215	260	contact_submissions	4	\N	\N	\N	\N
22	28	directus_users	93696281-13e7-4677-b2cb-d083e9951e20	{"id":"93696281-13e7-4677-b2cb-d083e9951e20","first_name":"PDIP Website","last_name":null,"email":null,"password":null,"location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","token":"**********","last_access":null,"last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"policies":["2e79a50e-4d60-482b-947f-d39a17eb776d"]}	{"token":"**********"}	\N	\N
23	29	directus_permissions	1	{"id":1,"collection":"site_settings","action":"read","permissions":null,"validation":null,"presets":null,"fields":["map_url","address","email","zalo","phone","youtube","linkedin","facebook"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	{"collection":"site_settings","action":"read","permissions":null,"validation":null,"presets":null,"fields":["map_url","address","email","zalo","phone","youtube","linkedin","facebook"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	\N	\N
24	31	directus_fields	12	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"provinces"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"provinces"}	\N	\N
25	32	directus_fields	13	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"provinces"}	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"provinces"}	\N	\N
26	33	directus_fields	14	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"provinces"}	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"provinces"}	\N	\N
27	34	directus_fields	15	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"provinces"}	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"provinces"}	\N	\N
28	35	directus_fields	16	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"provinces"}	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"provinces"}	\N	\N
29	36	directus_collections	provinces	{"singleton":false,"collection":"provinces"}	{"singleton":false,"collection":"provinces"}	\N	\N
30	43	directus_fields	17	{"sort":1,"interface":"input","readonly":false,"hidden":false,"field":"id","collection":"provinces"}	{"sort":1,"interface":"input","readonly":false,"hidden":false,"field":"id","collection":"provinces"}	\N	\N
31	44	directus_fields	18	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"provinces"}	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"provinces"}	\N	\N
32	45	directus_fields	19	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"provinces"}	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"provinces"}	\N	\N
33	46	directus_fields	20	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"provinces"}	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"provinces"}	\N	\N
34	47	directus_fields	21	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"provinces"}	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"provinces"}	\N	\N
35	48	directus_collections	provinces	{"singleton":false,"collection":"provinces"}	{"singleton":false,"collection":"provinces"}	\N	\N
36	49	directus_fields	22	{"sort":6,"interface":"input","special":null,"required":true,"collection":"provinces","field":"name"}	{"sort":6,"interface":"input","special":null,"required":true,"collection":"provinces","field":"name"}	\N	\N
37	50	directus_fields	23	{"sort":7,"interface":"input","special":null,"required":true,"collection":"provinces","field":"name_en"}	{"sort":7,"interface":"input","special":null,"required":true,"collection":"provinces","field":"name_en"}	\N	\N
38	51	provinces	vinh-phuc	{"id":"vinh-phuc","name":"Vĩnh Phúc","name_en":"Vinh Phuc"}	{"id":"vinh-phuc","name":"Vĩnh Phúc","name_en":"Vinh Phuc"}	\N	\N
39	52	directus_fields	24	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"projects"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"projects"}	\N	\N
59	72	directus_fields	41	{"sort":18,"interface":"file-image","special":["file"],"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"image"}	{"sort":18,"interface":"file-image","special":["file"],"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"image"}	\N	\N
60	73	directus_fields	42	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"project_gallery"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"project_gallery"}	\N	\N
40	53	directus_fields	25	{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"projects"}	{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"projects"}	\N	\N
41	54	directus_fields	26	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"projects"}	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"projects"}	\N	\N
42	55	directus_fields	27	{"sort":4,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"projects"}	{"sort":4,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"projects"}	\N	\N
43	56	directus_fields	28	{"sort":5,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"projects"}	{"sort":5,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"projects"}	\N	\N
44	57	directus_fields	29	{"sort":6,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"projects"}	{"sort":6,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"projects"}	\N	\N
45	58	directus_fields	30	{"sort":7,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"projects"}	{"sort":7,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"projects"}	\N	\N
46	59	directus_collections	projects	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"projects"}	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"projects"}	\N	\N
47	60	directus_fields	31	{"sort":8,"interface":"input","special":null,"required":true,"collection":"projects","field":"slug"}	{"sort":8,"interface":"input","special":null,"required":true,"collection":"projects","field":"slug"}	\N	\N
48	61	directus_fields	32	{"sort":9,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"projects","field":"province"}	{"sort":9,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"projects","field":"province"}	\N	\N
49	62	directus_fields	33	{"sort":10,"interface":"input","special":null,"required":true,"collection":"projects","field":"name"}	{"sort":10,"interface":"input","special":null,"required":true,"collection":"projects","field":"name"}	\N	\N
50	63	directus_fields	34	{"sort":11,"interface":"input","special":null,"required":true,"collection":"projects","field":"location"}	{"sort":11,"interface":"input","special":null,"required":true,"collection":"projects","field":"location"}	\N	\N
51	64	directus_fields	35	{"sort":12,"interface":"input","special":null,"required":true,"collection":"projects","field":"location_en"}	{"sort":12,"interface":"input","special":null,"required":true,"collection":"projects","field":"location_en"}	\N	\N
52	65	directus_fields	36	{"sort":13,"interface":"input","special":null,"required":true,"collection":"projects","field":"area"}	{"sort":13,"interface":"input","special":null,"required":true,"collection":"projects","field":"area"}	\N	\N
53	66	directus_fields	37	{"sort":14,"interface":"input","special":null,"required":true,"collection":"projects","field":"type"}	{"sort":14,"interface":"input","special":null,"required":true,"collection":"projects","field":"type"}	\N	\N
54	67	directus_fields	38	{"sort":15,"interface":"input","special":null,"required":true,"collection":"projects","field":"type_en"}	{"sort":15,"interface":"input","special":null,"required":true,"collection":"projects","field":"type_en"}	\N	\N
55	68	directus_fields	39	{"sort":16,"interface":"input-rich-text-html","special":null,"required":true,"collection":"projects","field":"detail"}	{"sort":16,"interface":"input-rich-text-html","special":null,"required":true,"collection":"projects","field":"detail"}	\N	\N
56	69	directus_folders	d49cfbb4-7232-4ad2-8487-6315c94ed1b4	{"name":"projects"}	{"name":"projects"}	\N	\N
57	70	directus_fields	39	{"id":39,"collection":"projects","field":"detail","special":null,"interface":"input-rich-text-html","options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":16,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"projects","field":"detail","options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"}}	\N	\N
58	71	directus_fields	40	{"sort":17,"interface":"input-rich-text-html","special":null,"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"detail_en"}	{"sort":17,"interface":"input-rich-text-html","special":null,"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"detail_en"}	\N	\N
61	74	directus_fields	43	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"project_gallery"}	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"project_gallery"}	\N	\N
62	75	directus_fields	44	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"project_gallery"}	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"project_gallery"}	\N	\N
63	76	directus_fields	45	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"project_gallery"}	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"project_gallery"}	\N	\N
64	77	directus_fields	46	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"project_gallery"}	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"project_gallery"}	\N	\N
65	78	directus_collections	project_gallery	{"singleton":false,"collection":"project_gallery"}	{"singleton":false,"collection":"project_gallery"}	\N	\N
66	79	directus_fields	47	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"template":"{{name}}"},"collection":"project_gallery","field":"project"}	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"template":"{{name}}"},"collection":"project_gallery","field":"project"}	\N	\N
67	80	directus_fields	48	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"project_gallery","field":"file"}	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"project_gallery","field":"file"}	\N	\N
68	81	directus_fields	49	{"sort":19,"interface":"files","special":["files"],"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"gallery"}	{"sort":19,"interface":"files","special":["files"],"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"gallery"}	\N	\N
69	82	directus_fields	50	{"sort":1,"hidden":true,"field":"id","collection":"projects_files"}	{"sort":1,"hidden":true,"field":"id","collection":"projects_files"}	\N	\N
70	83	directus_collections	projects_files	{"hidden":true,"icon":"import_export","collection":"projects_files"}	{"hidden":true,"icon":"import_export","collection":"projects_files"}	\N	\N
71	84	directus_fields	51	{"sort":2,"hidden":true,"collection":"projects_files","field":"projects_id"}	{"sort":2,"hidden":true,"collection":"projects_files","field":"projects_id"}	\N	\N
72	85	directus_fields	52	{"sort":3,"hidden":true,"collection":"projects_files","field":"directus_files_id"}	{"sort":3,"hidden":true,"collection":"projects_files","field":"directus_files_id"}	\N	\N
73	86	directus_files	b211bdcc-e144-432b-95f5-5eeafb7825e2	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Nexus","filename_download":"project_nexus.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Nexus","filename_download":"project_nexus.png","type":"image/png","storage":"local"}	\N	\N
74	87	directus_files	a237bbc2-d65b-4c3c-91f6-96cd241f7a34	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Vina","filename_download":"project_vina.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Vina","filename_download":"project_vina.png","type":"image/png","storage":"local"}	\N	\N
75	88	directus_files	5500af5d-2fff-4cfe-a260-6079cc0f4071	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Terra","filename_download":"project_terra.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Terra","filename_download":"project_terra.png","type":"image/png","storage":"local"}	\N	\N
76	102	directus_fields	53	{"sort":19,"interface":"files","special":["files"],"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"plans"}	{"sort":19,"interface":"files","special":["files"],"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"plans"}	\N	\N
77	103	directus_fields	54	{"sort":1,"hidden":true,"field":"id","collection":"projects_files"}	{"sort":1,"hidden":true,"field":"id","collection":"projects_files"}	\N	\N
78	104	directus_collections	projects_files	{"hidden":true,"icon":"import_export","collection":"projects_files"}	{"hidden":true,"icon":"import_export","collection":"projects_files"}	\N	\N
79	105	directus_fields	55	{"sort":2,"hidden":true,"collection":"projects_files","field":"projects_id"}	{"sort":2,"hidden":true,"collection":"projects_files","field":"projects_id"}	\N	\N
80	106	directus_fields	56	{"sort":3,"hidden":true,"collection":"projects_files","field":"directus_files_id"}	{"sort":3,"hidden":true,"collection":"projects_files","field":"directus_files_id"}	\N	\N
81	107	directus_fields	57	{"sort":20,"interface":"files","special":["files"],"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"gallery"}	{"sort":20,"interface":"files","special":["files"],"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"gallery"}	\N	\N
82	108	directus_fields	58	{"sort":1,"hidden":true,"field":"id","collection":"projects_files_1"}	{"sort":1,"hidden":true,"field":"id","collection":"projects_files_1"}	\N	\N
83	109	directus_collections	projects_files_1	{"hidden":true,"icon":"import_export","collection":"projects_files_1"}	{"hidden":true,"icon":"import_export","collection":"projects_files_1"}	\N	\N
84	110	directus_fields	59	{"sort":2,"hidden":true,"collection":"projects_files_1","field":"projects_id"}	{"sort":2,"hidden":true,"collection":"projects_files_1","field":"projects_id"}	\N	\N
85	111	directus_fields	60	{"sort":3,"hidden":true,"collection":"projects_files_1","field":"directus_files_id"}	{"sort":3,"hidden":true,"collection":"projects_files_1","field":"directus_files_id"}	\N	\N
86	112	directus_fields	61	{"sort":21,"interface":"input","special":null,"collection":"projects","field":"video_url"}	{"sort":21,"interface":"input","special":null,"collection":"projects","field":"video_url"}	\N	\N
87	113	directus_fields	62	{"sort":22,"interface":"input","special":null,"collection":"projects","field":"street_view_url"}	{"sort":22,"interface":"input","special":null,"collection":"projects","field":"street_view_url"}	\N	\N
88	114	directus_fields	63	{"sort":23,"interface":"input","special":null,"required":false,"collection":"projects","field":"connectivity_title"}	{"sort":23,"interface":"input","special":null,"required":false,"collection":"projects","field":"connectivity_title"}	\N	\N
89	115	directus_fields	64	{"sort":24,"interface":"input","special":null,"collection":"projects","field":"connectivity_title_en"}	{"sort":24,"interface":"input","special":null,"collection":"projects","field":"connectivity_title_en"}	\N	\N
90	116	directus_fields	65	{"sort":25,"interface":"input","special":null,"required":true,"collection":"projects","field":"connectivity_description"}	{"sort":25,"interface":"input","special":null,"required":true,"collection":"projects","field":"connectivity_description"}	\N	\N
91	117	directus_fields	66	{"sort":26,"interface":"input","special":null,"required":true,"collection":"projects","field":"connectivity_description_en"}	{"sort":26,"interface":"input","special":null,"required":true,"collection":"projects","field":"connectivity_description_en"}	\N	\N
92	118	directus_fields	67	{"sort":27,"interface":"input","special":null,"required":true,"collection":"projects","field":"leasing_hotline"}	{"sort":27,"interface":"input","special":null,"required":true,"collection":"projects","field":"leasing_hotline"}	\N	\N
93	119	directus_fields	68	{"sort":28,"interface":"input","special":null,"required":true,"collection":"projects","field":"leasing_email"}	{"sort":28,"interface":"input","special":null,"required":true,"collection":"projects","field":"leasing_email"}	\N	\N
95	121	directus_fields	70	{"sort":30,"interface":"boolean","special":["cast-boolean"],"collection":"projects","field":"pin"}	{"sort":30,"interface":"boolean","special":["cast-boolean"],"collection":"projects","field":"pin"}	\N	\N
94	120	directus_fields	69	{"sort":29,"interface":"file","special":["file"],"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"brochure"}	{"sort":29,"interface":"file","special":["file"],"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"brochure"}	\N	\N
96	122	directus_fields	71	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"project_specs"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"project_specs"}	\N	\N
97	123	directus_fields	72	{"sort":2,"interface":"input","hidden":true,"field":"sort","collection":"project_specs"}	{"sort":2,"interface":"input","hidden":true,"field":"sort","collection":"project_specs"}	\N	\N
98	124	directus_fields	73	{"sort":3,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"project_specs"}	{"sort":3,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"project_specs"}	\N	\N
99	125	directus_fields	74	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"project_specs"}	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"project_specs"}	\N	\N
100	126	directus_fields	75	{"sort":5,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"project_specs"}	{"sort":5,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"project_specs"}	\N	\N
101	127	directus_fields	76	{"sort":6,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"project_specs"}	{"sort":6,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"project_specs"}	\N	\N
102	128	directus_collections	project_specs	{"sort_field":"sort","singleton":false,"collection":"project_specs"}	{"sort_field":"sort","singleton":false,"collection":"project_specs"}	\N	\N
103	129	directus_fields	77	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"template":"{{name}}"},"collection":"project_specs","field":"project"}	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"template":"{{name}}"},"collection":"project_specs","field":"project"}	\N	\N
104	130	directus_fields	78	{"sort":8,"interface":"input","special":null,"required":true,"collection":"project_specs","field":"label"}	{"sort":8,"interface":"input","special":null,"required":true,"collection":"project_specs","field":"label"}	\N	\N
105	131	directus_fields	79	{"sort":9,"interface":"input","special":null,"required":true,"collection":"project_specs","field":"label_en"}	{"sort":9,"interface":"input","special":null,"required":true,"collection":"project_specs","field":"label_en"}	\N	\N
106	132	directus_fields	80	{"sort":10,"interface":"input","special":null,"required":true,"collection":"project_specs","field":"value"}	{"sort":10,"interface":"input","special":null,"required":true,"collection":"project_specs","field":"value"}	\N	\N
107	133	directus_fields	81	{"sort":11,"interface":"input","special":null,"required":true,"collection":"project_specs","field":"value_en"}	{"sort":11,"interface":"input","special":null,"required":true,"collection":"project_specs","field":"value_en"}	\N	\N
108	134	directus_fields	82	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"project_connectivity"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"project_connectivity"}	\N	\N
109	135	directus_fields	83	{"sort":2,"interface":"input","hidden":true,"field":"sort","collection":"project_connectivity"}	{"sort":2,"interface":"input","hidden":true,"field":"sort","collection":"project_connectivity"}	\N	\N
110	136	directus_fields	84	{"sort":3,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"project_connectivity"}	{"sort":3,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"project_connectivity"}	\N	\N
111	137	directus_fields	85	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"project_connectivity"}	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"project_connectivity"}	\N	\N
112	138	directus_fields	86	{"sort":5,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"project_connectivity"}	{"sort":5,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"project_connectivity"}	\N	\N
113	139	directus_fields	87	{"sort":6,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"project_connectivity"}	{"sort":6,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"project_connectivity"}	\N	\N
114	140	directus_collections	project_connectivity	{"sort_field":"sort","singleton":false,"collection":"project_connectivity"}	{"sort_field":"sort","singleton":false,"collection":"project_connectivity"}	\N	\N
115	141	directus_fields	88	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"template":"{{name}}"},"collection":"project_connectivity","field":"project"}	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"template":"{{name}}"},"collection":"project_connectivity","field":"project"}	\N	\N
116	142	directus_fields	89	{"sort":8,"interface":"input","special":null,"collection":"project_connectivity","field":"destination"}	{"sort":8,"interface":"input","special":null,"collection":"project_connectivity","field":"destination"}	\N	\N
117	143	directus_fields	90	{"sort":9,"interface":"input","special":null,"required":true,"collection":"project_connectivity","field":"destination_en"}	{"sort":9,"interface":"input","special":null,"required":true,"collection":"project_connectivity","field":"destination_en"}	\N	\N
118	144	directus_fields	89	{"id":89,"collection":"project_connectivity","field":"destination","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"project_connectivity","field":"destination","required":true}	\N	\N
119	145	directus_fields	91	{"sort":10,"interface":"input","special":null,"required":true,"collection":"project_connectivity","field":"distance"}	{"sort":10,"interface":"input","special":null,"required":true,"collection":"project_connectivity","field":"distance"}	\N	\N
120	146	directus_files	4af7065e-102d-4414-8525-a6980fee0939	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Aurora","filename_download":"project_aurora.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Aurora","filename_download":"project_aurora.png","type":"image/png","storage":"local"}	\N	\N
121	147	directus_fields	53	{"id":53,"collection":"projects","field":"plans","special":["files"],"interface":null,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":19,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"projects","field":"plans","interface":null}	\N	\N
122	148	directus_fields	92	{"sort":31,"interface":"files","special":["files"],"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"image_gallery"}	{"sort":31,"interface":"files","special":["files"],"required":true,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"image_gallery"}	\N	\N
123	149	directus_fields	93	{"sort":1,"hidden":true,"field":"id","collection":"projects_files_2"}	{"sort":1,"hidden":true,"field":"id","collection":"projects_files_2"}	\N	\N
124	150	directus_collections	projects_files_2	{"hidden":true,"icon":"import_export","collection":"projects_files_2"}	{"hidden":true,"icon":"import_export","collection":"projects_files_2"}	\N	\N
125	151	directus_fields	94	{"sort":2,"hidden":true,"collection":"projects_files_2","field":"projects_id"}	{"sort":2,"hidden":true,"collection":"projects_files_2","field":"projects_id"}	\N	\N
126	152	directus_fields	95	{"sort":3,"hidden":true,"collection":"projects_files_2","field":"directus_files_id"}	{"sort":3,"hidden":true,"collection":"projects_files_2","field":"directus_files_id"}	\N	\N
127	153	directus_fields	92	{"id":92,"collection":"projects","field":"image_gallery","special":["files"],"interface":"files","options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":31,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"projects","field":"image_gallery","required":false}	\N	\N
128	155	directus_fields	96	{"sort":31,"interface":"files","special":["files"],"required":false,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"image_plans"}	{"sort":31,"interface":"files","special":["files"],"required":false,"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"image_plans"}	\N	\N
129	156	directus_fields	97	{"sort":1,"hidden":true,"field":"id","collection":"projects_files_3"}	{"sort":1,"hidden":true,"field":"id","collection":"projects_files_3"}	\N	\N
130	157	directus_collections	projects_files_3	{"hidden":true,"icon":"import_export","collection":"projects_files_3"}	{"hidden":true,"icon":"import_export","collection":"projects_files_3"}	\N	\N
131	158	directus_fields	98	{"sort":2,"hidden":true,"collection":"projects_files_3","field":"projects_id"}	{"sort":2,"hidden":true,"collection":"projects_files_3","field":"projects_id"}	\N	\N
132	159	directus_fields	99	{"sort":3,"hidden":true,"collection":"projects_files_3","field":"directus_files_id"}	{"sort":3,"hidden":true,"collection":"projects_files_3","field":"directus_files_id"}	\N	\N
133	160	directus_fields	100	{"sort":32,"interface":"files","special":["files"],"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"image_gallery"}	{"sort":32,"interface":"files","special":["files"],"options":{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4"},"collection":"projects","field":"image_gallery"}	\N	\N
134	161	directus_fields	101	{"sort":1,"hidden":true,"field":"id","collection":"projects_files_4"}	{"sort":1,"hidden":true,"field":"id","collection":"projects_files_4"}	\N	\N
135	162	directus_collections	projects_files_4	{"hidden":true,"icon":"import_export","collection":"projects_files_4"}	{"hidden":true,"icon":"import_export","collection":"projects_files_4"}	\N	\N
136	163	directus_fields	102	{"sort":2,"hidden":true,"collection":"projects_files_4","field":"projects_id"}	{"sort":2,"hidden":true,"collection":"projects_files_4","field":"projects_id"}	\N	\N
137	164	directus_fields	103	{"sort":3,"hidden":true,"collection":"projects_files_4","field":"directus_files_id"}	{"sort":3,"hidden":true,"collection":"projects_files_4","field":"directus_files_id"}	\N	\N
138	167	directus_files	787ebd3f-dccb-4ae6-9e2c-1db6343adcf0	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Terra","filename_download":"project_terra.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Terra","filename_download":"project_terra.png","type":"image/png","storage":"local"}	\N	\N
139	168	directus_files	5fbaf40b-b7c2-4e46-8976-c9407b352624	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"News Industrial","filename_download":"news_industrial.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"News Industrial","filename_download":"news_industrial.png","type":"image/png","storage":"local"}	\N	\N
140	169	directus_files	25d246e2-28fe-4a2e-98bc-87b3539b620b	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Vina","filename_download":"project_vina.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Vina","filename_download":"project_vina.png","type":"image/png","storage":"local"}	\N	\N
141	170	directus_files	e668742f-8bd5-4fb9-8fc0-64398abee559	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Terra","filename_download":"project_terra.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Terra","filename_download":"project_terra.png","type":"image/png","storage":"local"}	\N	\N
143	172	directus_files	f32ccce2-b31d-4894-a907-404679617812	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Aurora","filename_download":"project_aurora.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Aurora","filename_download":"project_aurora.png","type":"image/png","storage":"local"}	\N	\N
156	185	projects	1	{"slug":"visiz-industrial-park","province":"vinh-phuc","name":"Visiz Industrial Park","location":"Phúc Yên, Vĩnh Phúc, Việt Nam","location_en":"Phuc Yen, Vinh Phuc, Vietnam","area":"150 ha","type":"Khu công nghiệp xanh","type_en":"Green Industrial Park","detail_en":"<p class=\\"overview-paragraph\\">Visiz eco-industrial smart park is strategically located in Phuc Yen, Vinh Phuc &mdash; the northern gateway connecting directly to Hanoi Capital, Noi Bai International Airport, and key industrial provinces.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Master-planned to international standards with a total area of 150 hectares, Visiz Industrial Park is a next-generation green industrial park integrating renewable energy systems, a centralized wastewater treatment plant with a capacity of 4,500 m3/day, and synchronized technical infrastructure meeting LEED standards.</p>\\n<p class=\\"overview-paragraph secondary\\">The park is divided into distinct functional zones: light industrial manufacturing, logistics and warehousing, utility services, and expert accommodation. Each zone is designed to optimize operational flow and minimize logistics costs for businesses.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz commits to providing high-speed telecommunications infrastructure, internationally-standard fire protection systems, and professional 24/7 operation management services. Investors at the park receive comprehensive support on legal procedures, tax incentives, and access to high-quality labor resources.</p>\\n</blockquote>","detail":"<p class=\\"overview-paragraph\\">Khu c&ocirc;ng nghiệp sinh th&aacute;i th&ocirc;ng minh Visiz tọa lạc tại vị tr&iacute; chiến lược Ph&uacute;c Y&ecirc;n, Vĩnh Ph&uacute;c &mdash; cửa ng&otilde; ph&iacute;a Bắc kết nối trực tiếp với Thủ đ&ocirc; H&agrave; Nội, s&acirc;n bay quốc tế Nội B&agrave;i v&agrave; c&aacute;c tỉnh c&ocirc;ng nghiệp trọng điểm.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Được quy hoạch theo ti&ecirc;u chuẩn quốc tế với tổng diện t&iacute;ch 150 ha, Visiz Industrial Park l&agrave; khu c&ocirc;ng nghiệp xanh thế hệ mới, t&iacute;ch hợp hệ thống năng lượng t&aacute;i tạo, xử l&yacute; nước thải tập trung c&ocirc;ng suất 4.500 m3/ng&agrave;y v&agrave; hạ tầng kỹ thuật đồng bộ đạt chuẩn LEED.</p>\\n<p class=\\"overview-paragraph secondary\\">Khu c&ocirc;ng nghiệp được ph&acirc;n chia th&agrave;nh c&aacute;c ph&acirc;n khu chức năng r&otilde; r&agrave;ng: khu sản xuất c&ocirc;ng nghiệp nhẹ, khu logistics v&agrave; kho vận, khu dịch vụ tiện &iacute;ch v&agrave; khu nh&agrave; ở cho chuy&ecirc;n gia. Mỗi ph&acirc;n khu đều được thiết kế tối ưu h&oacute;a d&ograve;ng chảy vận h&agrave;nh, giảm thiểu chi ph&iacute; logistics cho doanh nghiệp.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz cam kết cung cấp hạ tầng viễn th&ocirc;ng tốc độ cao, hệ thống PCCC đạt chuẩn quốc tế, v&agrave; dịch vụ quản l&yacute; vận h&agrave;nh chuy&ecirc;n nghiệp 24/7. Doanh nghiệp đầu tư tại đ&acirc;y sẽ được hỗ trợ to&agrave;n diện về thủ tục ph&aacute;p l&yacute;, ưu đ&atilde;i thuế v&agrave; kết nối nguồn lao động chất lượng cao.</p>\\n</blockquote>","image":"787ebd3f-dccb-4ae6-9e2c-1db6343adcf0","connectivity_description_en":"Visiz is located in Phuc Yen, Vinh Phuc — the northern gateway, directly connected to the Hanoi–Lao Cai expressway and National Highway 2, helping businesses minimize transportation time to Noi Bai Airport, Hai Phong Port, and northern consumer markets.","connectivity_description":"Visiz tọa lạc tại Phúc Yên, Vĩnh Phúc — cửa ngõ phía Bắc, kết nối trực tiếp với cao tốc Hà Nội – Lào Cai và quốc lộ 2, giúp doanh nghiệp rút ngắn tối đa thời gian vận chuyển hàng hóa đến sân bay Nội Bài, cảng Hải Phòng và thị trường tiêu dùng phía Bắc.","leasing_hotline":"+84 (28) 3995 6868","leasing_email":"leasing@phatdatip.com","brochure":"5fbaf40b-b7c2-4e46-8976-c9407b352624","pin":true,"image_plans":{"create":[{"projects_id":"+","directus_files_id":{"id":"25d246e2-28fe-4a2e-98bc-87b3539b620b"}},{"projects_id":"+","directus_files_id":{"id":"e668742f-8bd5-4fb9-8fc0-64398abee559"}},{"projects_id":"+","directus_files_id":{"id":"71c655cc-a9e5-4c97-9495-95952d0a7f9e"}},{"projects_id":"+","directus_files_id":{"id":"f32ccce2-b31d-4894-a907-404679617812"}},{"projects_id":"+","directus_files_id":{"id":"0d1c7b9b-ebe5-49e1-96cd-a2063cd88e84"}}],"update":[],"delete":[]},"image_gallery":{"create":[{"projects_id":"+","directus_files_id":{"id":"3c2a2598-491f-4fd2-9182-804b3a8e76c0"}},{"projects_id":"+","directus_files_id":{"id":"0101113a-b58d-4cb8-8fc7-dfc8fcef8436"}},{"projects_id":"+","directus_files_id":{"id":"8867ecc0-d8ee-4ddc-92ea-016243960d7b"}}],"update":[],"delete":[]}}	{"slug":"visiz-industrial-park","province":"vinh-phuc","name":"Visiz Industrial Park","location":"Phúc Yên, Vĩnh Phúc, Việt Nam","location_en":"Phuc Yen, Vinh Phuc, Vietnam","area":"150 ha","type":"Khu công nghiệp xanh","type_en":"Green Industrial Park","detail_en":"<p class=\\"overview-paragraph\\">Visiz eco-industrial smart park is strategically located in Phuc Yen, Vinh Phuc &mdash; the northern gateway connecting directly to Hanoi Capital, Noi Bai International Airport, and key industrial provinces.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Master-planned to international standards with a total area of 150 hectares, Visiz Industrial Park is a next-generation green industrial park integrating renewable energy systems, a centralized wastewater treatment plant with a capacity of 4,500 m3/day, and synchronized technical infrastructure meeting LEED standards.</p>\\n<p class=\\"overview-paragraph secondary\\">The park is divided into distinct functional zones: light industrial manufacturing, logistics and warehousing, utility services, and expert accommodation. Each zone is designed to optimize operational flow and minimize logistics costs for businesses.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz commits to providing high-speed telecommunications infrastructure, internationally-standard fire protection systems, and professional 24/7 operation management services. Investors at the park receive comprehensive support on legal procedures, tax incentives, and access to high-quality labor resources.</p>\\n</blockquote>","detail":"<p class=\\"overview-paragraph\\">Khu c&ocirc;ng nghiệp sinh th&aacute;i th&ocirc;ng minh Visiz tọa lạc tại vị tr&iacute; chiến lược Ph&uacute;c Y&ecirc;n, Vĩnh Ph&uacute;c &mdash; cửa ng&otilde; ph&iacute;a Bắc kết nối trực tiếp với Thủ đ&ocirc; H&agrave; Nội, s&acirc;n bay quốc tế Nội B&agrave;i v&agrave; c&aacute;c tỉnh c&ocirc;ng nghiệp trọng điểm.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Được quy hoạch theo ti&ecirc;u chuẩn quốc tế với tổng diện t&iacute;ch 150 ha, Visiz Industrial Park l&agrave; khu c&ocirc;ng nghiệp xanh thế hệ mới, t&iacute;ch hợp hệ thống năng lượng t&aacute;i tạo, xử l&yacute; nước thải tập trung c&ocirc;ng suất 4.500 m3/ng&agrave;y v&agrave; hạ tầng kỹ thuật đồng bộ đạt chuẩn LEED.</p>\\n<p class=\\"overview-paragraph secondary\\">Khu c&ocirc;ng nghiệp được ph&acirc;n chia th&agrave;nh c&aacute;c ph&acirc;n khu chức năng r&otilde; r&agrave;ng: khu sản xuất c&ocirc;ng nghiệp nhẹ, khu logistics v&agrave; kho vận, khu dịch vụ tiện &iacute;ch v&agrave; khu nh&agrave; ở cho chuy&ecirc;n gia. Mỗi ph&acirc;n khu đều được thiết kế tối ưu h&oacute;a d&ograve;ng chảy vận h&agrave;nh, giảm thiểu chi ph&iacute; logistics cho doanh nghiệp.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz cam kết cung cấp hạ tầng viễn th&ocirc;ng tốc độ cao, hệ thống PCCC đạt chuẩn quốc tế, v&agrave; dịch vụ quản l&yacute; vận h&agrave;nh chuy&ecirc;n nghiệp 24/7. Doanh nghiệp đầu tư tại đ&acirc;y sẽ được hỗ trợ to&agrave;n diện về thủ tục ph&aacute;p l&yacute;, ưu đ&atilde;i thuế v&agrave; kết nối nguồn lao động chất lượng cao.</p>\\n</blockquote>","image":"787ebd3f-dccb-4ae6-9e2c-1db6343adcf0","connectivity_description_en":"Visiz is located in Phuc Yen, Vinh Phuc — the northern gateway, directly connected to the Hanoi–Lao Cai expressway and National Highway 2, helping businesses minimize transportation time to Noi Bai Airport, Hai Phong Port, and northern consumer markets.","connectivity_description":"Visiz tọa lạc tại Phúc Yên, Vĩnh Phúc — cửa ngõ phía Bắc, kết nối trực tiếp với cao tốc Hà Nội – Lào Cai và quốc lộ 2, giúp doanh nghiệp rút ngắn tối đa thời gian vận chuyển hàng hóa đến sân bay Nội Bài, cảng Hải Phòng và thị trường tiêu dùng phía Bắc.","leasing_hotline":"+84 (28) 3995 6868","leasing_email":"leasing@phatdatip.com","brochure":"5fbaf40b-b7c2-4e46-8976-c9407b352624","pin":true,"image_plans":{"create":[{"projects_id":"+","directus_files_id":{"id":"25d246e2-28fe-4a2e-98bc-87b3539b620b"}},{"projects_id":"+","directus_files_id":{"id":"e668742f-8bd5-4fb9-8fc0-64398abee559"}},{"projects_id":"+","directus_files_id":{"id":"71c655cc-a9e5-4c97-9495-95952d0a7f9e"}},{"projects_id":"+","directus_files_id":{"id":"f32ccce2-b31d-4894-a907-404679617812"}},{"projects_id":"+","directus_files_id":{"id":"0d1c7b9b-ebe5-49e1-96cd-a2063cd88e84"}}],"update":[],"delete":[]},"image_gallery":{"create":[{"projects_id":"+","directus_files_id":{"id":"3c2a2598-491f-4fd2-9182-804b3a8e76c0"}},{"projects_id":"+","directus_files_id":{"id":"0101113a-b58d-4cb8-8fc7-dfc8fcef8436"}},{"projects_id":"+","directus_files_id":{"id":"8867ecc0-d8ee-4ddc-92ea-016243960d7b"}}],"update":[],"delete":[]}}	\N	\N
148	177	projects_files_4	1	{"projects_id":1,"directus_files_id":{"id":"3c2a2598-491f-4fd2-9182-804b3a8e76c0"}}	{"projects_id":1,"directus_files_id":{"id":"3c2a2598-491f-4fd2-9182-804b3a8e76c0"}}	156	\N
149	178	projects_files_4	2	{"projects_id":1,"directus_files_id":{"id":"0101113a-b58d-4cb8-8fc7-dfc8fcef8436"}}	{"projects_id":1,"directus_files_id":{"id":"0101113a-b58d-4cb8-8fc7-dfc8fcef8436"}}	156	\N
150	179	projects_files_4	3	{"projects_id":1,"directus_files_id":{"id":"8867ecc0-d8ee-4ddc-92ea-016243960d7b"}}	{"projects_id":1,"directus_files_id":{"id":"8867ecc0-d8ee-4ddc-92ea-016243960d7b"}}	156	\N
151	180	projects_files_3	1	{"projects_id":1,"directus_files_id":{"id":"25d246e2-28fe-4a2e-98bc-87b3539b620b"}}	{"projects_id":1,"directus_files_id":{"id":"25d246e2-28fe-4a2e-98bc-87b3539b620b"}}	156	\N
152	181	projects_files_3	2	{"projects_id":1,"directus_files_id":{"id":"e668742f-8bd5-4fb9-8fc0-64398abee559"}}	{"projects_id":1,"directus_files_id":{"id":"e668742f-8bd5-4fb9-8fc0-64398abee559"}}	156	\N
153	182	projects_files_3	3	{"projects_id":1,"directus_files_id":{"id":"71c655cc-a9e5-4c97-9495-95952d0a7f9e"}}	{"projects_id":1,"directus_files_id":{"id":"71c655cc-a9e5-4c97-9495-95952d0a7f9e"}}	156	\N
154	183	projects_files_3	4	{"projects_id":1,"directus_files_id":{"id":"f32ccce2-b31d-4894-a907-404679617812"}}	{"projects_id":1,"directus_files_id":{"id":"f32ccce2-b31d-4894-a907-404679617812"}}	156	\N
155	184	projects_files_3	5	{"projects_id":1,"directus_files_id":{"id":"0d1c7b9b-ebe5-49e1-96cd-a2063cd88e84"}}	{"projects_id":1,"directus_files_id":{"id":"0d1c7b9b-ebe5-49e1-96cd-a2063cd88e84"}}	156	\N
159	188	project_connectivity	1	{"project":1,"destination":"Sân bay Quốc tế Nội Bài","destination_en":"Noi Bai International Airport","distance":"15 km"}	{"project":1,"destination":"Sân bay Quốc tế Nội Bài","destination_en":"Noi Bai International Airport","distance":"15 km"}	\N	\N
142	171	directus_files	71c655cc-a9e5-4c97-9495-95952d0a7f9e	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Nexus","filename_download":"project_nexus.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Project Nexus","filename_download":"project_nexus.png","type":"image/png","storage":"local"}	\N	\N
144	173	directus_files	0d1c7b9b-ebe5-49e1-96cd-a2063cd88e84	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Green Industrial Park","filename_download":"green_industrial_park.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Green Industrial Park","filename_download":"green_industrial_park.png","type":"image/png","storage":"local"}	\N	\N
145	174	directus_files	3c2a2598-491f-4fd2-9182-804b3a8e76c0	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"White Background","filename_download":"White-Background.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"White Background","filename_download":"White-Background.png","type":"image/png","storage":"local"}	\N	\N
146	176	directus_files	0101113a-b58d-4cb8-8fc7-dfc8fcef8436	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Red Background","filename_download":"Red-Background.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Red Background","filename_download":"Red-Background.png","type":"image/png","storage":"local"}	\N	\N
147	175	directus_files	8867ecc0-d8ee-4ddc-92ea-016243960d7b	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Preload Images","filename_download":"preload-images.png","type":"image/png","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Preload Images","filename_download":"preload-images.png","type":"image/png","storage":"local"}	\N	\N
157	186	projects	1	{"id":1,"status":"published","sort":null,"user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_created":"2026-05-28T14:29:44.242Z","user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T14:29:48.622Z","slug":"visiz-industrial-park","province":"vinh-phuc","name":"Visiz Industrial Park","location":"Phúc Yên, Vĩnh Phúc, Việt Nam","location_en":"Phuc Yen, Vinh Phuc, Vietnam","area":"150 ha","type":"Khu công nghiệp xanh","type_en":"Green Industrial Park","detail":"<p class=\\"overview-paragraph\\">Khu c&ocirc;ng nghiệp sinh th&aacute;i th&ocirc;ng minh Visiz tọa lạc tại vị tr&iacute; chiến lược Ph&uacute;c Y&ecirc;n, Vĩnh Ph&uacute;c &mdash; cửa ng&otilde; ph&iacute;a Bắc kết nối trực tiếp với Thủ đ&ocirc; H&agrave; Nội, s&acirc;n bay quốc tế Nội B&agrave;i v&agrave; c&aacute;c tỉnh c&ocirc;ng nghiệp trọng điểm.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Được quy hoạch theo ti&ecirc;u chuẩn quốc tế với tổng diện t&iacute;ch 150 ha, Visiz Industrial Park l&agrave; khu c&ocirc;ng nghiệp xanh thế hệ mới, t&iacute;ch hợp hệ thống năng lượng t&aacute;i tạo, xử l&yacute; nước thải tập trung c&ocirc;ng suất 4.500 m3/ng&agrave;y v&agrave; hạ tầng kỹ thuật đồng bộ đạt chuẩn LEED.</p>\\n<p class=\\"overview-paragraph secondary\\">Khu c&ocirc;ng nghiệp được ph&acirc;n chia th&agrave;nh c&aacute;c ph&acirc;n khu chức năng r&otilde; r&agrave;ng: khu sản xuất c&ocirc;ng nghiệp nhẹ, khu logistics v&agrave; kho vận, khu dịch vụ tiện &iacute;ch v&agrave; khu nh&agrave; ở cho chuy&ecirc;n gia. Mỗi ph&acirc;n khu đều được thiết kế tối ưu h&oacute;a d&ograve;ng chảy vận h&agrave;nh, giảm thiểu chi ph&iacute; logistics cho doanh nghiệp.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz cam kết cung cấp hạ tầng viễn th&ocirc;ng tốc độ cao, hệ thống PCCC đạt chuẩn quốc tế, v&agrave; dịch vụ quản l&yacute; vận h&agrave;nh chuy&ecirc;n nghiệp 24/7. Doanh nghiệp đầu tư tại đ&acirc;y sẽ được hỗ trợ to&agrave;n diện về thủ tục ph&aacute;p l&yacute;, ưu đ&atilde;i thuế v&agrave; kết nối nguồn lao động chất lượng cao.</p>\\n</blockquote>","detail_en":"<p class=\\"overview-paragraph\\">Visiz eco-industrial smart park is strategically located in Phuc Yen, Vinh Phuc &mdash; the northern gateway connecting directly to Hanoi Capital, Noi Bai International Airport, and key industrial provinces.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Master-planned to international standards with a total area of 150 hectares, Visiz Industrial Park is a next-generation green industrial park integrating renewable energy systems, a centralized wastewater treatment plant with a capacity of 4,500 m3/day, and synchronized technical infrastructure meeting LEED standards.</p>\\n<p class=\\"overview-paragraph secondary\\">The park is divided into distinct functional zones: light industrial manufacturing, logistics and warehousing, utility services, and expert accommodation. Each zone is designed to optimize operational flow and minimize logistics costs for businesses.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz commits to providing high-speed telecommunications infrastructure, internationally-standard fire protection systems, and professional 24/7 operation management services. Investors at the park receive comprehensive support on legal procedures, tax incentives, and access to high-quality labor resources.</p>\\n</blockquote>","image":"787ebd3f-dccb-4ae6-9e2c-1db6343adcf0","video_url":null,"street_view_url":null,"connectivity_title":"Vị trí chiến lược, kết nối liên vùng phía Nam","connectivity_title_en":"Strategic location, Southern regional connectivity","connectivity_description":"Visiz tọa lạc tại Phúc Yên, Vĩnh Phúc — cửa ngõ phía Bắc, kết nối trực tiếp với cao tốc Hà Nội – Lào Cai và quốc lộ 2, giúp doanh nghiệp rút ngắn tối đa thời gian vận chuyển hàng hóa đến sân bay Nội Bài, cảng Hải Phòng và thị trường tiêu dùng phía Bắc.","connectivity_description_en":"Visiz is located in Phuc Yen, Vinh Phuc — the northern gateway, directly connected to the Hanoi–Lao Cai expressway and National Highway 2, helping businesses minimize transportation time to Noi Bai Airport, Hai Phong Port, and northern consumer markets.","leasing_hotline":"+84 (28) 3995 6868","leasing_email":"leasing@phatdatip.com","brochure":"5fbaf40b-b7c2-4e46-8976-c9407b352624","pin":true,"image_plans":[1,2,3,4,5],"image_gallery":[1,2,3]}	{"status":"published","user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T14:29:48.622Z"}	\N	\N
158	187	project_specs	1	{"project":1,"label":"Vị trí","label_en":"Location","value":"Phúc Yên, Vĩnh Phúc, Việt Nam","value_en":"Phuc Yen, Vinh Phuc, Vietnam"}	{"project":1,"label":"Vị trí","label_en":"Location","value":"Phúc Yên, Vĩnh Phúc, Việt Nam","value_en":"Phuc Yen, Vinh Phuc, Vietnam"}	\N	\N
160	189	directus_fields	104	{"sort":33,"interface":"list-o2m","special":["o2m"],"collection":"projects","field":"project_specs"}	{"sort":33,"interface":"list-o2m","special":["o2m"],"collection":"projects","field":"project_specs"}	\N	\N
161	190	directus_fields	105	{"sort":34,"interface":"list-o2m","special":["o2m"],"collection":"projects","field":"project_connectivity"}	{"sort":34,"interface":"list-o2m","special":["o2m"],"collection":"projects","field":"project_connectivity"}	\N	\N
162	191	directus_permissions	2	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["status","sort","slug","province","name","location","location_en","area","type","type_en","detail","detail_en","image","video_url","street_view_url","connectivity_title","connectivity_title_en","connectivity_description","connectivity_description_en","leasing_hotline","leasing_email","brochure","pin","image_plans","image_gallery","project_specs","project_connectivity"],"presets":null,"collection":"projects","action":"read"}	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["status","sort","slug","province","name","location","location_en","area","type","type_en","detail","detail_en","image","video_url","street_view_url","connectivity_title","connectivity_title_en","connectivity_description","connectivity_description_en","leasing_hotline","leasing_email","brochure","pin","image_plans","image_gallery","project_specs","project_connectivity"],"presets":null,"collection":"projects","action":"read"}	\N	\N
164	194	projects	1	{"id":1,"status":"published","sort":null,"user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_created":"2026-05-28T14:29:44.242Z","user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T14:40:56.677Z","slug":"visiz-industrial-park","province":"vinh-phuc","name":"Visiz Industrial Park","location":"Phúc Yên, Vĩnh Phúc, Việt Nam","location_en":"Phuc Yen, Vinh Phuc, Vietnam","area":"150 ha","type":"Khu công nghiệp xanh","type_en":"Green Industrial Park","detail":"<p class=\\"overview-paragraph\\">Khu c&ocirc;ng nghiệp sinh th&aacute;i th&ocirc;ng minh Visiz tọa lạc tại vị tr&iacute; chiến lược Ph&uacute;c Y&ecirc;n, Vĩnh Ph&uacute;c &mdash; cửa ng&otilde; ph&iacute;a Bắc kết nối trực tiếp với Thủ đ&ocirc; H&agrave; Nội, s&acirc;n bay quốc tế Nội B&agrave;i v&agrave; c&aacute;c tỉnh c&ocirc;ng nghiệp trọng điểm.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Được quy hoạch theo ti&ecirc;u chuẩn quốc tế với tổng diện t&iacute;ch 150 ha, Visiz Industrial Park l&agrave; khu c&ocirc;ng nghiệp xanh thế hệ mới, t&iacute;ch hợp hệ thống năng lượng t&aacute;i tạo, xử l&yacute; nước thải tập trung c&ocirc;ng suất 4.500 m3/ng&agrave;y v&agrave; hạ tầng kỹ thuật đồng bộ đạt chuẩn LEED.</p>\\n<p class=\\"overview-paragraph secondary\\">Khu c&ocirc;ng nghiệp được ph&acirc;n chia th&agrave;nh c&aacute;c ph&acirc;n khu chức năng r&otilde; r&agrave;ng: khu sản xuất c&ocirc;ng nghiệp nhẹ, khu logistics v&agrave; kho vận, khu dịch vụ tiện &iacute;ch v&agrave; khu nh&agrave; ở cho chuy&ecirc;n gia. Mỗi ph&acirc;n khu đều được thiết kế tối ưu h&oacute;a d&ograve;ng chảy vận h&agrave;nh, giảm thiểu chi ph&iacute; logistics cho doanh nghiệp.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz cam kết cung cấp hạ tầng viễn th&ocirc;ng tốc độ cao, hệ thống PCCC đạt chuẩn quốc tế, v&agrave; dịch vụ quản l&yacute; vận h&agrave;nh chuy&ecirc;n nghiệp 24/7. Doanh nghiệp đầu tư tại đ&acirc;y sẽ được hỗ trợ to&agrave;n diện về thủ tục ph&aacute;p l&yacute;, ưu đ&atilde;i thuế v&agrave; kết nối nguồn lao động chất lượng cao.</p>\\n</blockquote>","detail_en":"<p class=\\"overview-paragraph\\">Visiz eco-industrial smart park is strategically located in Phuc Yen, Vinh Phuc &mdash; the northern gateway connecting directly to Hanoi Capital, Noi Bai International Airport, and key industrial provinces.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Master-planned to international standards with a total area of 150 hectares, Visiz Industrial Park is a next-generation green industrial park integrating renewable energy systems, a centralized wastewater treatment plant with a capacity of 4,500 m3/day, and synchronized technical infrastructure meeting LEED standards.</p>\\n<p class=\\"overview-paragraph secondary\\">The park is divided into distinct functional zones: light industrial manufacturing, logistics and warehousing, utility services, and expert accommodation. Each zone is designed to optimize operational flow and minimize logistics costs for businesses.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz commits to providing high-speed telecommunications infrastructure, internationally-standard fire protection systems, and professional 24/7 operation management services. Investors at the park receive comprehensive support on legal procedures, tax incentives, and access to high-quality labor resources.</p>\\n</blockquote>","image":"787ebd3f-dccb-4ae6-9e2c-1db6343adcf0","video_url":null,"street_view_url":null,"connectivity_title":"Vị trí chiến lược, kết nối liên vùng phía Nam","connectivity_title_en":"Strategic location, Southern regional connectivity","connectivity_description":"Visiz tọa lạc tại Phúc Yên, Vĩnh Phúc — cửa ngõ phía Bắc, kết nối trực tiếp với cao tốc Hà Nội – Lào Cai và quốc lộ 2, giúp doanh nghiệp rút ngắn tối đa thời gian vận chuyển hàng hóa đến sân bay Nội Bài, cảng Hải Phòng và thị trường tiêu dùng phía Bắc.","connectivity_description_en":"Visiz is located in Phuc Yen, Vinh Phuc — the northern gateway, directly connected to the Hanoi–Lao Cai expressway and National Highway 2, helping businesses minimize transportation time to Noi Bai Airport, Hai Phong Port, and northern consumer markets.","leasing_hotline":"+84 (28) 3995 6868","leasing_email":"leasing@phatdatip.com","brochure":"5fbaf40b-b7c2-4e46-8976-c9407b352624","pin":true,"image_plans":[1,2,3,4,5],"image_gallery":[1,2,3],"project_specs":[1,2],"project_connectivity":[1]}	{"user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T14:40:56.677Z"}	\N	\N
163	193	project_specs	2	{"label":"Quy mô","value":"150 ha","label_en":"Total Area","value_en":"150 ha","project":"1"}	{"label":"Quy mô","value":"150 ha","label_en":"Total Area","value_en":"150 ha","project":"1"}	164	\N
165	195	directus_permissions	3	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["project","label","value","value_en","label_en"],"presets":null,"collection":"project_specs","action":"read"}	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["project","label","value","value_en","label_en"],"presets":null,"collection":"project_specs","action":"read"}	\N	\N
166	196	directus_permissions	4	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["project","destination","destination_en","distance"],"presets":null,"collection":"project_connectivity","action":"read"}	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["project","destination","destination_en","distance"],"presets":null,"collection":"project_connectivity","action":"read"}	\N	\N
167	198	directus_permissions	4	{"id":4,"collection":"project_connectivity","action":"read","permissions":null,"validation":null,"presets":null,"fields":["destination","destination_en","distance"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	{"collection":"project_connectivity","action":"read","permissions":null,"validation":null,"presets":null,"fields":["destination","destination_en","distance"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	\N	\N
168	199	directus_permissions	3	{"id":3,"collection":"project_specs","action":"read","permissions":null,"validation":null,"presets":null,"fields":["label","value","value_en","label_en"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	{"collection":"project_specs","action":"read","permissions":null,"validation":null,"presets":null,"fields":["label","value","value_en","label_en"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	\N	\N
169	201	directus_files	8492eaba-6be7-4a0f-9d8b-b06434196074	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Img 8075","filename_download":"IMG_8075.jpeg","type":"image/jpeg","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Img 8075","filename_download":"IMG_8075.jpeg","type":"image/jpeg","storage":"local"}	\N	\N
170	202	projects	1	{"id":1,"status":"published","sort":null,"user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_created":"2026-05-28T14:29:44.242Z","user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T14:55:30.836Z","slug":"visiz-industrial-park","province":"vinh-phuc","name":"Visiz Industrial Park","location":"Phúc Yên, Vĩnh Phúc, Việt Nam","location_en":"Phuc Yen, Vinh Phuc, Vietnam","area":"150 ha","type":"Khu công nghiệp xanh","type_en":"Green Industrial Park","detail":"<p class=\\"overview-paragraph\\">Khu c&ocirc;ng nghiệp sinh th&aacute;i th&ocirc;ng minh Visiz tọa lạc tại vị tr&iacute; chiến lược Ph&uacute;c Y&ecirc;n, Vĩnh Ph&uacute;c &mdash; cửa ng&otilde; ph&iacute;a Bắc kết nối trực tiếp với Thủ đ&ocirc; H&agrave; Nội, s&acirc;n bay quốc tế Nội B&agrave;i v&agrave; c&aacute;c tỉnh c&ocirc;ng nghiệp trọng điểm.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Được quy hoạch theo ti&ecirc;u chuẩn quốc tế với tổng diện t&iacute;ch 150 ha, Visiz Industrial Park l&agrave; khu c&ocirc;ng nghiệp xanh thế hệ mới, t&iacute;ch hợp hệ thống năng lượng t&aacute;i tạo, xử l&yacute; nước thải tập trung c&ocirc;ng suất 4.500 m3/ng&agrave;y v&agrave; hạ tầng kỹ thuật đồng bộ đạt chuẩn LEED.</p>\\n<p class=\\"overview-paragraph secondary\\">Khu c&ocirc;ng nghiệp được ph&acirc;n chia th&agrave;nh c&aacute;c ph&acirc;n khu chức năng r&otilde; r&agrave;ng: khu sản xuất c&ocirc;ng nghiệp nhẹ, khu logistics v&agrave; kho vận, khu dịch vụ tiện &iacute;ch v&agrave; khu nh&agrave; ở cho chuy&ecirc;n gia. Mỗi ph&acirc;n khu đều được thiết kế tối ưu h&oacute;a d&ograve;ng chảy vận h&agrave;nh, giảm thiểu chi ph&iacute; logistics cho doanh nghiệp.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz cam kết cung cấp hạ tầng viễn th&ocirc;ng tốc độ cao, hệ thống PCCC đạt chuẩn quốc tế, v&agrave; dịch vụ quản l&yacute; vận h&agrave;nh chuy&ecirc;n nghiệp 24/7. Doanh nghiệp đầu tư tại đ&acirc;y sẽ được hỗ trợ to&agrave;n diện về thủ tục ph&aacute;p l&yacute;, ưu đ&atilde;i thuế v&agrave; kết nối nguồn lao động chất lượng cao.</p>\\n</blockquote>","detail_en":"<p class=\\"overview-paragraph\\">Visiz eco-industrial smart park is strategically located in Phuc Yen, Vinh Phuc &mdash; the northern gateway connecting directly to Hanoi Capital, Noi Bai International Airport, and key industrial provinces.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Master-planned to international standards with a total area of 150 hectares, Visiz Industrial Park is a next-generation green industrial park integrating renewable energy systems, a centralized wastewater treatment plant with a capacity of 4,500 m3/day, and synchronized technical infrastructure meeting LEED standards.</p>\\n<p class=\\"overview-paragraph secondary\\">The park is divided into distinct functional zones: light industrial manufacturing, logistics and warehousing, utility services, and expert accommodation. Each zone is designed to optimize operational flow and minimize logistics costs for businesses.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz commits to providing high-speed telecommunications infrastructure, internationally-standard fire protection systems, and professional 24/7 operation management services. Investors at the park receive comprehensive support on legal procedures, tax incentives, and access to high-quality labor resources.</p>\\n</blockquote>","image":"8492eaba-6be7-4a0f-9d8b-b06434196074","video_url":null,"street_view_url":null,"connectivity_title":"Vị trí chiến lược, kết nối liên vùng phía Nam","connectivity_title_en":"Strategic location, Southern regional connectivity","connectivity_description":"Visiz tọa lạc tại Phúc Yên, Vĩnh Phúc — cửa ngõ phía Bắc, kết nối trực tiếp với cao tốc Hà Nội – Lào Cai và quốc lộ 2, giúp doanh nghiệp rút ngắn tối đa thời gian vận chuyển hàng hóa đến sân bay Nội Bài, cảng Hải Phòng và thị trường tiêu dùng phía Bắc.","connectivity_description_en":"Visiz is located in Phuc Yen, Vinh Phuc — the northern gateway, directly connected to the Hanoi–Lao Cai expressway and National Highway 2, helping businesses minimize transportation time to Noi Bai Airport, Hai Phong Port, and northern consumer markets.","leasing_hotline":"+84 (28) 3995 6868","leasing_email":"leasing@phatdatip.com","brochure":"5fbaf40b-b7c2-4e46-8976-c9407b352624","pin":true,"image_plans":[1,2,3,4,5],"image_gallery":[1,2,3],"project_specs":[1,2],"project_connectivity":[1]}	{"image":"8492eaba-6be7-4a0f-9d8b-b06434196074","user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T14:55:30.836Z"}	\N	\N
171	203	directus_permissions	5	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	\N	\N
172	207	directus_permissions	6	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":{"_and":[{"folder":{"name":{"_contains":"projects"}}}]},"validation":null,"fields":null,"presets":null,"collection":"directus_files","action":"read"}	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":{"_and":[{"folder":{"name":{"_contains":"projects"}}}]},"validation":null,"fields":null,"presets":null,"collection":"directus_files","action":"read"}	\N	\N
173	209	directus_permissions	7	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":{"_and":[{"folder":{"name":{"_contains":"projects"}}}]},"validation":null,"fields":null,"presets":null,"collection":"directus_files","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":{"_and":[{"folder":{"name":{"_contains":"projects"}}}]},"validation":null,"fields":null,"presets":null,"collection":"directus_files","action":"read"}	\N	\N
174	211	directus_permissions	2	{"id":2,"collection":"projects","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":["status","sort","slug","province","name","location","location_en","area","type","type_en","detail","detail_en","image","video_url","street_view_url","connectivity_title","connectivity_title_en","connectivity_description","connectivity_description_en","leasing_hotline","leasing_email","brochure","pin","image_plans","image_gallery","project_specs","project_connectivity"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	{"collection":"projects","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":["status","sort","slug","province","name","location","location_en","area","type","type_en","detail","detail_en","image","video_url","street_view_url","connectivity_title","connectivity_title_en","connectivity_description","connectivity_description_en","leasing_hotline","leasing_email","brochure","pin","image_plans","image_gallery","project_specs","project_connectivity"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	\N	\N
175	213	directus_permissions	8	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["directus_files_id"],"presets":null,"collection":"projects_files_3","action":"read"}	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["directus_files_id"],"presets":null,"collection":"projects_files_3","action":"read"}	\N	\N
176	214	directus_permissions	9	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["directus_files_id"],"presets":null,"collection":"projects_files_4","action":"read"}	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["directus_files_id"],"presets":null,"collection":"projects_files_4","action":"read"}	\N	\N
177	216	directus_files	0f3b43bb-b324-4a5a-a2a1-1e1e79a6ac18	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Png2pdf","filename_download":"png2pdf.pdf","type":"application/pdf","storage":"local"}	{"folder":"d49cfbb4-7232-4ad2-8487-6315c94ed1b4","title":"Png2pdf","filename_download":"png2pdf.pdf","type":"application/pdf","storage":"local"}	\N	\N
178	217	projects	1	{"id":1,"status":"published","sort":null,"user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_created":"2026-05-28T14:29:44.242Z","user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T15:33:11.150Z","slug":"visiz-industrial-park","province":"vinh-phuc","name":"Visiz Industrial Park","location":"Phúc Yên, Vĩnh Phúc, Việt Nam","location_en":"Phuc Yen, Vinh Phuc, Vietnam","area":"150 ha","type":"Khu công nghiệp xanh","type_en":"Green Industrial Park","detail":"<p class=\\"overview-paragraph\\">Khu c&ocirc;ng nghiệp sinh th&aacute;i th&ocirc;ng minh Visiz tọa lạc tại vị tr&iacute; chiến lược Ph&uacute;c Y&ecirc;n, Vĩnh Ph&uacute;c &mdash; cửa ng&otilde; ph&iacute;a Bắc kết nối trực tiếp với Thủ đ&ocirc; H&agrave; Nội, s&acirc;n bay quốc tế Nội B&agrave;i v&agrave; c&aacute;c tỉnh c&ocirc;ng nghiệp trọng điểm.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Được quy hoạch theo ti&ecirc;u chuẩn quốc tế với tổng diện t&iacute;ch 150 ha, Visiz Industrial Park l&agrave; khu c&ocirc;ng nghiệp xanh thế hệ mới, t&iacute;ch hợp hệ thống năng lượng t&aacute;i tạo, xử l&yacute; nước thải tập trung c&ocirc;ng suất 4.500 m3/ng&agrave;y v&agrave; hạ tầng kỹ thuật đồng bộ đạt chuẩn LEED.</p>\\n<p class=\\"overview-paragraph secondary\\">Khu c&ocirc;ng nghiệp được ph&acirc;n chia th&agrave;nh c&aacute;c ph&acirc;n khu chức năng r&otilde; r&agrave;ng: khu sản xuất c&ocirc;ng nghiệp nhẹ, khu logistics v&agrave; kho vận, khu dịch vụ tiện &iacute;ch v&agrave; khu nh&agrave; ở cho chuy&ecirc;n gia. Mỗi ph&acirc;n khu đều được thiết kế tối ưu h&oacute;a d&ograve;ng chảy vận h&agrave;nh, giảm thiểu chi ph&iacute; logistics cho doanh nghiệp.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz cam kết cung cấp hạ tầng viễn th&ocirc;ng tốc độ cao, hệ thống PCCC đạt chuẩn quốc tế, v&agrave; dịch vụ quản l&yacute; vận h&agrave;nh chuy&ecirc;n nghiệp 24/7. Doanh nghiệp đầu tư tại đ&acirc;y sẽ được hỗ trợ to&agrave;n diện về thủ tục ph&aacute;p l&yacute;, ưu đ&atilde;i thuế v&agrave; kết nối nguồn lao động chất lượng cao.</p>\\n</blockquote>","detail_en":"<p class=\\"overview-paragraph\\">Visiz eco-industrial smart park is strategically located in Phuc Yen, Vinh Phuc &mdash; the northern gateway connecting directly to Hanoi Capital, Noi Bai International Airport, and key industrial provinces.</p>\\n<blockquote>\\n<p class=\\"overview-paragraph secondary\\">Master-planned to international standards with a total area of 150 hectares, Visiz Industrial Park is a next-generation green industrial park integrating renewable energy systems, a centralized wastewater treatment plant with a capacity of 4,500 m3/day, and synchronized technical infrastructure meeting LEED standards.</p>\\n<p class=\\"overview-paragraph secondary\\">The park is divided into distinct functional zones: light industrial manufacturing, logistics and warehousing, utility services, and expert accommodation. Each zone is designed to optimize operational flow and minimize logistics costs for businesses.</p>\\n<p class=\\"overview-paragraph secondary\\">Visiz commits to providing high-speed telecommunications infrastructure, internationally-standard fire protection systems, and professional 24/7 operation management services. Investors at the park receive comprehensive support on legal procedures, tax incentives, and access to high-quality labor resources.</p>\\n</blockquote>","image":"8492eaba-6be7-4a0f-9d8b-b06434196074","video_url":null,"street_view_url":null,"connectivity_title":"Vị trí chiến lược, kết nối liên vùng phía Nam","connectivity_title_en":"Strategic location, Southern regional connectivity","connectivity_description":"Visiz tọa lạc tại Phúc Yên, Vĩnh Phúc — cửa ngõ phía Bắc, kết nối trực tiếp với cao tốc Hà Nội – Lào Cai và quốc lộ 2, giúp doanh nghiệp rút ngắn tối đa thời gian vận chuyển hàng hóa đến sân bay Nội Bài, cảng Hải Phòng và thị trường tiêu dùng phía Bắc.","connectivity_description_en":"Visiz is located in Phuc Yen, Vinh Phuc — the northern gateway, directly connected to the Hanoi–Lao Cai expressway and National Highway 2, helping businesses minimize transportation time to Noi Bai Airport, Hai Phong Port, and northern consumer markets.","leasing_hotline":"+84 (28) 3995 6868","leasing_email":"leasing@phatdatip.com","brochure":"0f3b43bb-b324-4a5a-a2a1-1e1e79a6ac18","pin":true,"image_plans":[1,2,3,4,5],"image_gallery":[1,2,3],"project_specs":[1,2],"project_connectivity":[1]}	{"brochure":"0f3b43bb-b324-4a5a-a2a1-1e1e79a6ac18","user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T15:33:11.150Z"}	\N	\N
179	218	site_settings	1	{"id":1,"user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T15:39:31.444Z","address":"39 Phạm Ngọc Thạch, Phường Xuân Hoà, TP. Hồ Chí Minh","map_url":"https://www.google.com/maps?q=39+Ph%E1%BA%A1m+Ng%E1%BB%8Dc+Th%E1%BA%A1ch,+Ph%C6%B0%E1%BB%9Dng+Xu%C3%A2n+Ho%C3%A0,+TP.+H%E1%BB%93+Ch%C3%AD+Minh","phone":"0988204060","email":"contact@tranminhkhoi.dev","zalo":null,"facebook":"https://www.facebook.com/mktechvn","linkedin":"https://www.google.com/maps/place/39+Ph%E1%BA%A1m+Ng%E1%BB%8Dc+Th%E1%BA%A1ch,+P,+Xu%C3%A2n+H%C3%B2a,+H%E1%BB%93+Ch%C3%AD+Minh,+Vietnam/@10.7845622,106.6908757,17z/data=!3m1!4b1!4m6!3m5!1s0x31752f33fbae5a31:0x6a50a18b72facf1e!8m2!3d10.7845622!4d106.6934506","youtube":null}	{"email":"contact@tranminhkhoi.dev","user_updated":"4adcfb7a-871c-4c08-a7ae-b11e89651916","date_updated":"2026-05-28T15:39:31.444Z"}	\N	\N
180	219	directus_collections	site_settings	{"collection":"site_settings","icon":"settings","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"settings"}	\N	\N
181	220	directus_files	9df5b257-842a-48cd-88fe-13585d4a0b48	{"title":"Logo Only White","filename_download":"logo-only-white.png","type":"image/png","storage":"local"}	{"title":"Logo Only White","filename_download":"logo-only-white.png","type":"image/png","storage":"local"}	\N	\N
182	221	directus_settings	1	{"project_color":"#E35169","project_logo":"9df5b257-842a-48cd-88fe-13585d4a0b48"}	{"project_color":"#E35169","project_logo":"9df5b257-842a-48cd-88fe-13585d4a0b48"}	\N	\N
183	222	directus_settings	1	{"id":1,"project_name":"Phat Dat IP CMS","project_url":null,"project_color":"#E35169","project_logo":"9df5b257-842a-48cd-88fe-13585d4a0b48","public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null}	{"project_name":"Phat Dat IP CMS"}	\N	\N
184	223	directus_fields	106	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"contact_submissions"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"contact_submissions"}	\N	\N
185	224	directus_fields	107	{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"contact_submissions"}	{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"contact_submissions"}	\N	\N
186	225	directus_fields	108	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"contact_submissions"}	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"contact_submissions"}	\N	\N
187	226	directus_fields	109	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"contact_submissions"}	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"contact_submissions"}	\N	\N
188	227	directus_collections	contact_submissions	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"contact_submissions"}	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"contact_submissions"}	\N	\N
189	228	directus_fields	110	{"sort":5,"interface":"input","special":null,"required":true,"collection":"contact_submissions","field":"full_name"}	{"sort":5,"interface":"input","special":null,"required":true,"collection":"contact_submissions","field":"full_name"}	\N	\N
190	229	directus_fields	111	{"sort":6,"interface":"input","special":null,"required":true,"collection":"contact_submissions","field":"email"}	{"sort":6,"interface":"input","special":null,"required":true,"collection":"contact_submissions","field":"email"}	\N	\N
191	230	directus_fields	112	{"sort":7,"interface":"input","special":null,"required":true,"collection":"contact_submissions","field":"phone"}	{"sort":7,"interface":"input","special":null,"required":true,"collection":"contact_submissions","field":"phone"}	\N	\N
192	232	directus_fields	113	{"sort":8,"interface":"input","special":null,"required":true,"collection":"contact_submissions","field":"interest"}	{"sort":8,"interface":"input","special":null,"required":true,"collection":"contact_submissions","field":"interest"}	\N	\N
193	233	directus_fields	114	{"sort":9,"interface":"input-multiline","special":null,"collection":"contact_submissions","field":"message"}	{"sort":9,"interface":"input-multiline","special":null,"collection":"contact_submissions","field":"message"}	\N	\N
194	234	directus_fields	115	{"sort":10,"interface":"input","special":null,"collection":"contact_submissions","field":"ip_address"}	{"sort":10,"interface":"input","special":null,"collection":"contact_submissions","field":"ip_address"}	\N	\N
195	235	directus_fields	116	{"sort":11,"interface":"input-multiline","special":null,"collection":"contact_submissions","field":"user_agent"}	{"sort":11,"interface":"input-multiline","special":null,"collection":"contact_submissions","field":"user_agent"}	\N	\N
196	236	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	{"name":"Send SMTP","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]}}	{"name":"Send SMTP","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]}}	\N	\N
197	237	directus_operations	d48a734a-3a8d-41fd-add0-747b582118e3	{"flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc","position_x":37,"position_y":1,"name":"update data","key":"update_data","type":"item-update","options":{"collection":"contact_submissions","payload":{"ip_address":"{{ $last.ip_address }}","user_agent":"{{ $last.user_agent }}"}}}	{"flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc","position_x":37,"position_y":1,"name":"update data","key":"update_data","type":"item-update","options":{"collection":"contact_submissions","payload":{"ip_address":"{{ $last.ip_address }}","user_agent":"{{ $last.user_agent }}"}}}	198	\N
199	239	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	{"id":"d6d78678-9dea-4d86-9ade-cf82d80112fc","name":"Send SMTP","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]},"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41","date_created":"2026-05-29T01:09:19.380Z","user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916","operations":["d48a734a-3a8d-41fd-add0-747b582118e3","f9b2832a-1600-4ab7-a772-dfac0afaed41"]}	{"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41"}	\N	\N
200	240	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	{"id":"d6d78678-9dea-4d86-9ade-cf82d80112fc","name":"Create Contact Submissions","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]},"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41","date_created":"2026-05-29T01:09:19.380Z","user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916","operations":["d48a734a-3a8d-41fd-add0-747b582118e3","f9b2832a-1600-4ab7-a772-dfac0afaed41"]}	{"name":"Create Contact Submissions","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]}}	\N	\N
205	245	directus_fields	117	{"sort":12,"interface":"input","special":null,"required":true,"collection":"contact_submissions","field":"turnstile_token"}	{"sort":12,"interface":"input","special":null,"required":true,"collection":"contact_submissions","field":"turnstile_token"}	\N	\N
212	256	directus_permissions	10	{"id":10,"collection":"contact_submissions","action":"create","permissions":null,"validation":null,"presets":null,"fields":["full_name","email","phone","interest","message","turnstile_token"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	{"collection":"contact_submissions","action":"create","permissions":null,"validation":null,"presets":null,"fields":["full_name","email","phone","interest","message","turnstile_token"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	\N	\N
214	259	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	{"steps":[{"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41","key":"get_user_agent","status":"reject","options":{"code":"const ip =\\n  $trigger.headers['x-forwarded-for']?.split(',')[0] ||\\n  $trigger.headers['x-real-ip'];\\n\\nconst ua =\\n  $trigger.headers['user-agent'];\\n\\nreturn {\\n  ip_address: ip,\\n  user_agent: ua\\n};"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{},"key":3,"collection":"contact_submissions"},"$last":{"name":"SyntaxError","message":"Illegal return statement [<isolated-vm>:8:1]"},"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"get_user_agent":{"name":"SyntaxError","message":"Illegal return statement [<isolated-vm>:8:1]"}}}	\N	\N	\N
230	278	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{},"key":7,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
198	238	directus_operations	f9b2832a-1600-4ab7-a772-dfac0afaed41	{"flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc","position_x":19,"position_y":1,"name":"get-user-agent","key":"get_user_agent","type":"exec","options":{"code":"const ip =\\n  $trigger.headers['x-forwarded-for']?.split(',')[0] ||\\n  $trigger.headers['x-real-ip'];\\n\\nconst ua =\\n  $trigger.headers['user-agent'];\\n\\nreturn {\\n  ip_address: ip,\\n  user_agent: ua\\n};"},"resolve":{"flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc","position_x":37,"position_y":1,"name":"update data","key":"update_data","type":"item-update","options":{"collection":"contact_submissions","payload":{"ip_address":"{{ $last.ip_address }}","user_agent":"{{ $last.user_agent }}"}}}}	{"flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc","position_x":19,"position_y":1,"name":"get-user-agent","key":"get_user_agent","type":"exec","options":{"code":"const ip =\\n  $trigger.headers['x-forwarded-for']?.split(',')[0] ||\\n  $trigger.headers['x-real-ip'];\\n\\nconst ua =\\n  $trigger.headers['user-agent'];\\n\\nreturn {\\n  ip_address: ip,\\n  user_agent: ua\\n};"},"resolve":{"flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc","position_x":37,"position_y":1,"name":"update data","key":"update_data","type":"item-update","options":{"collection":"contact_submissions","payload":{"ip_address":"{{ $last.ip_address }}","user_agent":"{{ $last.user_agent }}"}}}}	199	\N
201	241	directus_operations	5643b85b-7c38-4500-8f36-d721a7b2683e	{"flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc","position_x":55,"position_y":1,"name":"Send Email","key":"mail_wx0bo","type":"mail","options":{"subject":"[Website Contact] {{$trigger.payload.full_name}}","body":"<h2>Liên hệ mới từ website</h2>\\n\\n<p><b>Họ tên:</b> {{$trigger.payload.full_name}}</p>\\n<p><b>Email:</b> {{$trigger.payload.email}}</p>\\n<p><b>SĐT:</b> {{$trigger.payload.phone}}</p>\\n<p><b>Lĩnh vực:</b> {{$trigger.payload.interest}}</p>\\n<p><b>Tin nhắn:</b></p>\\n<p>{{$trigger.payload.message}}</p>\\n\\n<hr>\\n\\n<p><b>IP:</b> {{$last.ip_address}}</p>\\n<p><b>User Agent:</b> {{$last.user_agent}}</p>"}}	{"flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc","position_x":55,"position_y":1,"name":"Send Email","key":"mail_wx0bo","type":"mail","options":{"subject":"[Website Contact] {{$trigger.payload.full_name}}","body":"<h2>Liên hệ mới từ website</h2>\\n\\n<p><b>Họ tên:</b> {{$trigger.payload.full_name}}</p>\\n<p><b>Email:</b> {{$trigger.payload.email}}</p>\\n<p><b>SĐT:</b> {{$trigger.payload.phone}}</p>\\n<p><b>Lĩnh vực:</b> {{$trigger.payload.interest}}</p>\\n<p><b>Tin nhắn:</b></p>\\n<p>{{$trigger.payload.message}}</p>\\n\\n<hr>\\n\\n<p><b>IP:</b> {{$last.ip_address}}</p>\\n<p><b>User Agent:</b> {{$last.user_agent}}</p>"}}	202	\N
202	242	directus_operations	d48a734a-3a8d-41fd-add0-747b582118e3	{"id":"d48a734a-3a8d-41fd-add0-747b582118e3","name":"update data","key":"update_data","type":"item-update","position_x":37,"position_y":1,"options":{"collection":"contact_submissions","payload":{"ip_address":"{{ $last.ip_address }}","user_agent":"{{ $last.user_agent }}"}},"resolve":"5643b85b-7c38-4500-8f36-d721a7b2683e","reject":null,"flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc","date_created":"2026-05-29T01:15:23.508Z","user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916"}	{"resolve":"5643b85b-7c38-4500-8f36-d721a7b2683e","flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc"}	203	\N
204	244	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	{"id":"d6d78678-9dea-4d86-9ade-cf82d80112fc","name":"Create Contact Submissions","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]},"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41","date_created":"2026-05-29T01:09:19.380Z","user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916","operations":["5643b85b-7c38-4500-8f36-d721a7b2683e","d48a734a-3a8d-41fd-add0-747b582118e3","f9b2832a-1600-4ab7-a772-dfac0afaed41"]}	{"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41"}	\N	\N
203	243	directus_operations	f9b2832a-1600-4ab7-a772-dfac0afaed41	{"id":"f9b2832a-1600-4ab7-a772-dfac0afaed41","name":"get-user-agent","key":"get_user_agent","type":"exec","position_x":19,"position_y":1,"options":{"code":"const ip =\\n  $trigger.headers['x-forwarded-for']?.split(',')[0] ||\\n  $trigger.headers['x-real-ip'];\\n\\nconst ua =\\n  $trigger.headers['user-agent'];\\n\\nreturn {\\n  ip_address: ip,\\n  user_agent: ua\\n};"},"resolve":"d48a734a-3a8d-41fd-add0-747b582118e3","reject":null,"flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc","date_created":"2026-05-29T01:15:23.518Z","user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916"}	{"resolve":"d48a734a-3a8d-41fd-add0-747b582118e3","flow":"d6d78678-9dea-4d86-9ade-cf82d80112fc"}	204	\N
206	246	directus_permissions	10	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["full_name","email","message","interest","phone","ip_address","user_agent","turnstile_token"],"presets":null,"collection":"contact_submissions","action":"create"}	{"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4","permissions":null,"validation":null,"fields":["full_name","email","message","interest","phone","ip_address","user_agent","turnstile_token"],"presets":null,"collection":"contact_submissions","action":"create"}	\N	\N
207	248	contact_submissions	1	\N	\N	\N	\N
208	249	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	{"steps":[{"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41","key":"get_user_agent","status":"reject","options":{"code":"const ip =\\n  $trigger.headers['x-forwarded-for']?.split(',')[0] ||\\n  $trigger.headers['x-real-ip'];\\n\\nconst ua =\\n  $trigger.headers['user-agent'];\\n\\nreturn {\\n  ip_address: ip,\\n  user_agent: ua\\n};"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{},"key":1,"collection":"contact_submissions"},"$last":{"name":"SyntaxError","message":"Illegal return statement [<isolated-vm>:8:1]"},"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"get_user_agent":{"name":"SyntaxError","message":"Illegal return statement [<isolated-vm>:8:1]"}}}	\N	\N	\N
209	250	contact_submissions	2	\N	\N	\N	\N
210	251	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	{"steps":[{"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41","key":"get_user_agent","status":"reject","options":{"code":"const ip =\\n  $trigger.headers['x-forwarded-for']?.split(',')[0] ||\\n  $trigger.headers['x-real-ip'];\\n\\nconst ua =\\n  $trigger.headers['user-agent'];\\n\\nreturn {\\n  ip_address: ip,\\n  user_agent: ua\\n};"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{},"key":2,"collection":"contact_submissions"},"$last":{"name":"SyntaxError","message":"Illegal return statement [<isolated-vm>:8:1]"},"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"get_user_agent":{"name":"SyntaxError","message":"Illegal return statement [<isolated-vm>:8:1]"}}}	\N	\N	\N
211	254	directus_permissions	10	{"id":10,"collection":"contact_submissions","action":"create","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	{"collection":"contact_submissions","action":"create","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	\N	\N
213	258	contact_submissions	3	\N	\N	\N	\N
216	261	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	{"steps":[{"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41","key":"get_user_agent","status":"reject","options":{"code":"const ip =\\n  $trigger.headers['x-forwarded-for']?.split(',')[0] ||\\n  $trigger.headers['x-real-ip'];\\n\\nconst ua =\\n  $trigger.headers['user-agent'];\\n\\nreturn {\\n  ip_address: ip,\\n  user_agent: ua\\n};"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{},"key":4,"collection":"contact_submissions"},"$last":{"name":"SyntaxError","message":"Illegal return statement [<isolated-vm>:8:1]"},"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"get_user_agent":{"name":"SyntaxError","message":"Illegal return statement [<isolated-vm>:8:1]"}}}	\N	\N	\N
217	262	directus_permissions	10	{"id":10,"collection":"contact_submissions","action":"create","permissions":null,"validation":null,"presets":null,"fields":["full_name","email","phone","interest","message","turnstile_token","id","date_created","user_agent","ip_address","status","sort"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	{"collection":"contact_submissions","action":"create","permissions":null,"validation":null,"presets":null,"fields":["full_name","email","phone","interest","message","turnstile_token","id","date_created","user_agent","ip_address","status","sort"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	\N	\N
218	264	contact_submissions	5	\N	\N	\N	\N
219	265	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	{"steps":[{"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41","key":"get_user_agent","status":"reject","options":{"code":"const ip =\\n  $trigger.headers['x-forwarded-for']?.split(',')[0] ||\\n  $trigger.headers['x-real-ip'];\\n\\nconst ua =\\n  $trigger.headers['user-agent'];\\n\\nreturn {\\n  ip_address: ip,\\n  user_agent: ua\\n};"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{},"key":5,"collection":"contact_submissions"},"$last":{"name":"SyntaxError","message":"Illegal return statement [<isolated-vm>:8:1]"},"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"get_user_agent":{"name":"SyntaxError","message":"Illegal return statement [<isolated-vm>:8:1]"}}}	\N	\N	\N
220	266	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	{"id":"d6d78678-9dea-4d86-9ade-cf82d80112fc","name":"Create Contact Submissions","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]},"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41","date_created":"2026-05-29T01:09:19.380Z","user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916","operations":["5643b85b-7c38-4500-8f36-d721a7b2683e","d48a734a-3a8d-41fd-add0-747b582118e3","f9b2832a-1600-4ab7-a772-dfac0afaed41"]}	{"name":"Create Contact Submissions","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]}}	\N	\N
221	267	directus_flows	d6d78678-9dea-4d86-9ade-cf82d80112fc	{"id":"d6d78678-9dea-4d86-9ade-cf82d80112fc","name":"Create Contact Submissions","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]},"operation":"f9b2832a-1600-4ab7-a772-dfac0afaed41","date_created":"2026-05-29T01:09:19.380Z","user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916","operations":["5643b85b-7c38-4500-8f36-d721a7b2683e","d48a734a-3a8d-41fd-add0-747b582118e3","f9b2832a-1600-4ab7-a772-dfac0afaed41"]}	{"name":"Create Contact Submissions","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]}}	\N	\N
222	269	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"name":"Send Email","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]}}	{"name":"Send Email","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]}}	\N	\N
223	270	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"id":"052aff35-edb1-436e-be64-80b0b07c4155","name":"Send Email","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]},"operation":null,"date_created":"2026-05-29T01:37:25.546Z","user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916","operations":[]}	{"name":"Send Email","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]}}	\N	\N
225	272	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"id":"052aff35-edb1-436e-be64-80b0b07c4155","name":"Send Email","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contact_submissions"]},"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","date_created":"2026-05-29T01:37:25.546Z","user_created":"4adcfb7a-871c-4c08-a7ae-b11e89651916","operations":["5dd84a50-19f1-48f1-ab80-ebb3c260540b"]}	{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b"}	\N	\N
224	271	directus_operations	5dd84a50-19f1-48f1-ab80-ebb3c260540b	{"flow":"052aff35-edb1-436e-be64-80b0b07c4155","position_x":19,"position_y":1,"name":"ecitizen@phatdatholdings.com.vn","key":"ecitizen_phatdatholdings_com_vn","type":"mail","options":{"subject":"test","body":"test"}}	{"flow":"052aff35-edb1-436e-be64-80b0b07c4155","position_x":19,"position_y":1,"name":"ecitizen@phatdatholdings.com.vn","key":"ecitizen_phatdatholdings_com_vn","type":"mail","options":{"subject":"test","body":"test"}}	225	\N
226	273	contact_submissions	6	\N	\N	\N	\N
227	274	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{},"key":6,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
228	275	directus_permissions	10	{"id":10,"collection":"contact_submissions","action":"create","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	{"collection":"contact_submissions","action":"create","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"d8282123-159d-4ea1-a12d-3c816ccb39f4"}	\N	\N
229	277	contact_submissions	7	\N	\N	\N	\N
231	279	directus_collections	projects	{"collection":"projects","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":"status","archive_app_filter":true,"archive_value":"archived","unarchive_value":"draft","sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":true}	{"versioning":true}	\N	\N
232	280	directus_collections	project_specs	{"collection":"project_specs","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":true}	{"versioning":true}	\N	\N
233	281	directus_collections	project_connectivity	{"collection":"project_connectivity","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":true}	{"versioning":true}	\N	\N
234	282	directus_collections	contact_submissions	{"collection":"contact_submissions","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":"status","archive_app_filter":true,"archive_value":"archived","unarchive_value":"draft","sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":true}	{"versioning":true}	\N	\N
235	283	directus_collections	contact_submissions	{"collection":"contact_submissions","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":"status","archive_app_filter":true,"archive_value":"archived","unarchive_value":"draft","sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"versioning":false}	\N	\N
236	284	contact_submissions	8	\N	\N	\N	\N
237	285	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{},"key":8,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
238	286	directus_permissions	11	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact_submissions","action":"create"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact_submissions","action":"create"}	\N	\N
239	288	contact_submissions	9	\N	\N	\N	\N
240	289	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{},"key":9,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
241	290	directus_permissions	12	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact_submissions","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact_submissions","action":"read"}	\N	\N
242	291	directus_permissions	13	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact_submissions","action":"update"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact_submissions","action":"update"}	\N	\N
243	292	directus_permissions	14	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact_submissions","action":"delete"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact_submissions","action":"delete"}	\N	\N
244	293	directus_permissions	15	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact_submissions","action":"share"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"contact_submissions","action":"share"}	\N	\N
245	294	directus_permissions	11	{"id":11,"collection":"contact_submissions","action":"create","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	{"collection":"contact_submissions","action":"create","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
246	296	contact_submissions	10	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	\N	\N
247	297	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"},"key":10,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
248	298	contact_submissions	11	\N	\N	\N	\N
249	299	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{},"key":11,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
250	308	contact_submissions	12	\N	\N	\N	\N
251	309	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{},"key":12,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
252	310	contact_submissions	13	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	\N	\N
253	311	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"},"key":13,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
254	322	contact_submissions	14	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	\N	\N
255	323	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"},"key":14,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
256	324	contact_submissions	15	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	\N	\N
257	325	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"},"key":15,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
258	326	contact_submissions	16	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	\N	\N
259	327	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"},"key":16,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
260	328	contact_submissions	17	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	\N	\N
261	329	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"},"key":17,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
262	336	contact_submissions	18	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"}	\N	\N
263	337	directus_flows	052aff35-edb1-436e-be64-80b0b07c4155	{"steps":[{"operation":"5dd84a50-19f1-48f1-ab80-ebb3c260540b","key":"ecitizen_phatdatholdings_com_vn","status":"resolve","options":{"subject":"test","body":"test"}}],"data":{"$trigger":{"event":"contact_submissions.items.create","payload":{"full_name":"Nguyen Van A","email":"a@gmail.com","phone":"0909999999","interest":"Đầu tư","message":"Xin tư vấn","turnstile_token":"TOKEN"},"key":18,"collection":"contact_submissions"},"$last":null,"$accountability":{"role":"89f0d9ce-ec46-46c6-aa43-de555a2173db","user":"93696281-13e7-4677-b2cb-d083e9951e20","roles":["89f0d9ce-ec46-46c6-aa43-de555a2173db"],"admin":false,"app":false,"ip":"172.18.0.1","userAgent":"PostmanRuntime/7.54.0"},"$env":{},"ecitizen_phatdatholdings_com_vn":null}}	\N	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
68f80b85-61f1-494b-813b-77b830a38535	Administrator	verified	$t:admin_description	\N
89f0d9ce-ec46-46c6-aa43-de555a2173db	Phat Dat Industrial Park Website	supervised_user_circle	\N	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
77w5QfTvAEYUzpUKAZLjb1J5u5qetwn_3eV4O2eoWUYgaCi6lBPN0SCK5Fp_ior-	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-06-09 00:42:35.494+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls) FROM stdin;
1	Phat Dat IP CMS	\N	#E35169	9df5b257-842a-48cd-88fe-13585d4a0b48	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N	\N	en-US	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides) FROM stdin;
93696281-13e7-4677-b2cb-d083e9951e20	PDIP Website	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	active	89f0d9ce-ec46-46c6-aa43-de555a2173db	AeMZVtCxw8hPjmqtdSC9-2MQ7A4OvT2w	\N	\N	default	\N	\N	t	\N	\N	\N	\N	\N
4adcfb7a-871c-4c08-a7ae-b11e89651916	Admin	User	citizen@phatdatholdings.com.vn	$argon2id$v=19$m=65536,t=3,p=4$jwDZjgFZfemoOX7W6AA8rQ$EpElh9PBIAhl7uZ+CbJjafDJnPZB/8auVNHsZD0CTiw	\N	\N	\N	\N	\N	\N	\N	active	68f80b85-61f1-494b-813b-77b830a38535	\N	2026-06-02 00:42:35.519+00	/content/contact_submissions/17	default	\N	\N	t	\N	\N	\N	\N	\N
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Data for Name: project_connectivity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.project_connectivity (id, sort, user_created, date_created, user_updated, date_updated, project, destination, destination_en, distance) FROM stdin;
1	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:31:07.443+00	\N	\N	1	Sân bay Quốc tế Nội Bài	Noi Bai International Airport	15 km
\.


--
-- Data for Name: project_specs; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.project_specs (id, sort, user_created, date_created, user_updated, date_updated, project, label, label_en, value, value_en) FROM stdin;
1	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:30:36.389+00	\N	\N	1	Vị trí	Location	Phúc Yên, Vĩnh Phúc, Việt Nam	Phuc Yen, Vinh Phuc, Vietnam
2	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:40:56.68+00	\N	\N	1	Quy mô	Total Area	150 ha	150 ha
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.projects (id, status, sort, user_created, date_created, user_updated, date_updated, slug, province, name, location, location_en, area, type, type_en, detail, detail_en, image, video_url, street_view_url, connectivity_title, connectivity_title_en, connectivity_description, connectivity_description_en, leasing_hotline, leasing_email, brochure, pin) FROM stdin;
1	published	\N	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 14:29:44.242+00	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:33:11.15+00	visiz-industrial-park	vinh-phuc	Visiz Industrial Park	Phúc Yên, Vĩnh Phúc, Việt Nam	Phuc Yen, Vinh Phuc, Vietnam	150 ha	Khu công nghiệp xanh	Green Industrial Park	<p class="overview-paragraph">Khu c&ocirc;ng nghiệp sinh th&aacute;i th&ocirc;ng minh Visiz tọa lạc tại vị tr&iacute; chiến lược Ph&uacute;c Y&ecirc;n, Vĩnh Ph&uacute;c &mdash; cửa ng&otilde; ph&iacute;a Bắc kết nối trực tiếp với Thủ đ&ocirc; H&agrave; Nội, s&acirc;n bay quốc tế Nội B&agrave;i v&agrave; c&aacute;c tỉnh c&ocirc;ng nghiệp trọng điểm.</p>\n<blockquote>\n<p class="overview-paragraph secondary">Được quy hoạch theo ti&ecirc;u chuẩn quốc tế với tổng diện t&iacute;ch 150 ha, Visiz Industrial Park l&agrave; khu c&ocirc;ng nghiệp xanh thế hệ mới, t&iacute;ch hợp hệ thống năng lượng t&aacute;i tạo, xử l&yacute; nước thải tập trung c&ocirc;ng suất 4.500 m3/ng&agrave;y v&agrave; hạ tầng kỹ thuật đồng bộ đạt chuẩn LEED.</p>\n<p class="overview-paragraph secondary">Khu c&ocirc;ng nghiệp được ph&acirc;n chia th&agrave;nh c&aacute;c ph&acirc;n khu chức năng r&otilde; r&agrave;ng: khu sản xuất c&ocirc;ng nghiệp nhẹ, khu logistics v&agrave; kho vận, khu dịch vụ tiện &iacute;ch v&agrave; khu nh&agrave; ở cho chuy&ecirc;n gia. Mỗi ph&acirc;n khu đều được thiết kế tối ưu h&oacute;a d&ograve;ng chảy vận h&agrave;nh, giảm thiểu chi ph&iacute; logistics cho doanh nghiệp.</p>\n<p class="overview-paragraph secondary">Visiz cam kết cung cấp hạ tầng viễn th&ocirc;ng tốc độ cao, hệ thống PCCC đạt chuẩn quốc tế, v&agrave; dịch vụ quản l&yacute; vận h&agrave;nh chuy&ecirc;n nghiệp 24/7. Doanh nghiệp đầu tư tại đ&acirc;y sẽ được hỗ trợ to&agrave;n diện về thủ tục ph&aacute;p l&yacute;, ưu đ&atilde;i thuế v&agrave; kết nối nguồn lao động chất lượng cao.</p>\n</blockquote>	<p class="overview-paragraph">Visiz eco-industrial smart park is strategically located in Phuc Yen, Vinh Phuc &mdash; the northern gateway connecting directly to Hanoi Capital, Noi Bai International Airport, and key industrial provinces.</p>\n<blockquote>\n<p class="overview-paragraph secondary">Master-planned to international standards with a total area of 150 hectares, Visiz Industrial Park is a next-generation green industrial park integrating renewable energy systems, a centralized wastewater treatment plant with a capacity of 4,500 m3/day, and synchronized technical infrastructure meeting LEED standards.</p>\n<p class="overview-paragraph secondary">The park is divided into distinct functional zones: light industrial manufacturing, logistics and warehousing, utility services, and expert accommodation. Each zone is designed to optimize operational flow and minimize logistics costs for businesses.</p>\n<p class="overview-paragraph secondary">Visiz commits to providing high-speed telecommunications infrastructure, internationally-standard fire protection systems, and professional 24/7 operation management services. Investors at the park receive comprehensive support on legal procedures, tax incentives, and access to high-quality labor resources.</p>\n</blockquote>	8492eaba-6be7-4a0f-9d8b-b06434196074	\N	\N	Vị trí chiến lược, kết nối liên vùng phía Nam	Strategic location, Southern regional connectivity	Visiz tọa lạc tại Phúc Yên, Vĩnh Phúc — cửa ngõ phía Bắc, kết nối trực tiếp với cao tốc Hà Nội – Lào Cai và quốc lộ 2, giúp doanh nghiệp rút ngắn tối đa thời gian vận chuyển hàng hóa đến sân bay Nội Bài, cảng Hải Phòng và thị trường tiêu dùng phía Bắc.	Visiz is located in Phuc Yen, Vinh Phuc — the northern gateway, directly connected to the Hanoi–Lao Cai expressway and National Highway 2, helping businesses minimize transportation time to Noi Bai Airport, Hai Phong Port, and northern consumer markets.	+84 (28) 3995 6868	leasing@phatdatip.com	0f3b43bb-b324-4a5a-a2a1-1e1e79a6ac18	t
\.


--
-- Data for Name: projects_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.projects_files (id, projects_id, directus_files_id) FROM stdin;
\.


--
-- Data for Name: projects_files_1; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.projects_files_1 (id, projects_id, directus_files_id) FROM stdin;
\.


--
-- Data for Name: projects_files_2; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.projects_files_2 (id, projects_id, directus_files_id) FROM stdin;
\.


--
-- Data for Name: projects_files_3; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.projects_files_3 (id, projects_id, directus_files_id) FROM stdin;
1	1	25d246e2-28fe-4a2e-98bc-87b3539b620b
2	1	e668742f-8bd5-4fb9-8fc0-64398abee559
3	1	71c655cc-a9e5-4c97-9495-95952d0a7f9e
4	1	f32ccce2-b31d-4894-a907-404679617812
5	1	0d1c7b9b-ebe5-49e1-96cd-a2063cd88e84
\.


--
-- Data for Name: projects_files_4; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.projects_files_4 (id, projects_id, directus_files_id) FROM stdin;
1	1	3c2a2598-491f-4fd2-9182-804b3a8e76c0
2	1	0101113a-b58d-4cb8-8fc7-dfc8fcef8436
3	1	8867ecc0-d8ee-4ddc-92ea-016243960d7b
\.


--
-- Data for Name: provinces; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.provinces (id, user_created, date_created, user_updated, date_updated, name, name_en) FROM stdin;
vinh-phuc	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 13:53:20.251+00	\N	\N	Vĩnh Phúc	Vinh Phuc
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.site_settings (id, user_updated, date_updated, address, map_url, phone, email, zalo, facebook, linkedin, youtube) FROM stdin;
1	4adcfb7a-871c-4c08-a7ae-b11e89651916	2026-05-28 15:39:31.444+00	39 Phạm Ngọc Thạch, Phường Xuân Hoà, TP. Hồ Chí Minh	https://www.google.com/maps?q=39+Ph%E1%BA%A1m+Ng%E1%BB%8Dc+Th%E1%BA%A1ch,+Ph%C6%B0%E1%BB%9Dng+Xu%C3%A2n+Ho%C3%A0,+TP.+H%E1%BB%93+Ch%C3%AD+Minh	0988204060	contact@tranminhkhoi.dev	\N	https://www.facebook.com/mktechvn	https://www.google.com/maps/place/39+Ph%E1%BA%A1m+Ng%E1%BB%8Dc+Th%E1%BA%A1ch,+P,+Xu%C3%A2n+H%C3%B2a,+H%E1%BB%93+Ch%C3%AD+Minh,+Vietnam/@10.7845622,106.6908757,17z/data=!3m1!4b1!4m6!3m5!1s0x31752f33fbae5a31:0x6a50a18b72facf1e!8m2!3d10.7845622!4d106.6934506	\N
\.


--
-- Name: contact_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.contact_submissions_id_seq', 18, true);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 337, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 117, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 15, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 8, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 30, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 263, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: project_connectivity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.project_connectivity_id_seq', 1, true);


--
-- Name: project_specs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.project_specs_id_seq', 2, true);


--
-- Name: projects_files_1_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.projects_files_1_id_seq', 1, false);


--
-- Name: projects_files_2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.projects_files_2_id_seq', 1, false);


--
-- Name: projects_files_3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.projects_files_3_id_seq', 5, true);


--
-- Name: projects_files_4_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.projects_files_4_id_seq', 3, true);


--
-- Name: projects_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.projects_files_id_seq', 1, false);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.projects_id_seq', 1, true);


--
-- Name: site_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.site_settings_id_seq', 1, true);


--
-- Name: contact_submissions contact_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.contact_submissions
    ADD CONSTRAINT contact_submissions_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: project_connectivity project_connectivity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.project_connectivity
    ADD CONSTRAINT project_connectivity_pkey PRIMARY KEY (id);


--
-- Name: project_specs project_specs_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.project_specs
    ADD CONSTRAINT project_specs_pkey PRIMARY KEY (id);


--
-- Name: projects_files_1 projects_files_1_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_1
    ADD CONSTRAINT projects_files_1_pkey PRIMARY KEY (id);


--
-- Name: projects_files_2 projects_files_2_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_2
    ADD CONSTRAINT projects_files_2_pkey PRIMARY KEY (id);


--
-- Name: projects_files_3 projects_files_3_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_3
    ADD CONSTRAINT projects_files_3_pkey PRIMARY KEY (id);


--
-- Name: projects_files_4 projects_files_4_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_4
    ADD CONSTRAINT projects_files_4_pkey PRIMARY KEY (id);


--
-- Name: projects_files projects_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files
    ADD CONSTRAINT projects_files_pkey PRIMARY KEY (id);


--
-- Name: projects projects_name_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_name_unique UNIQUE (name);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: projects projects_slug_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_slug_unique UNIQUE (slug);


--
-- Name: provinces provinces_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_pkey PRIMARY KEY (id);


--
-- Name: site_settings site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: project_connectivity project_connectivity_project_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.project_connectivity
    ADD CONSTRAINT project_connectivity_project_foreign FOREIGN KEY (project) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: project_connectivity project_connectivity_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.project_connectivity
    ADD CONSTRAINT project_connectivity_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: project_connectivity project_connectivity_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.project_connectivity
    ADD CONSTRAINT project_connectivity_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: project_specs project_specs_project_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.project_specs
    ADD CONSTRAINT project_specs_project_foreign FOREIGN KEY (project) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: project_specs project_specs_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.project_specs
    ADD CONSTRAINT project_specs_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: project_specs project_specs_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.project_specs
    ADD CONSTRAINT project_specs_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: projects projects_brochure_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_brochure_foreign FOREIGN KEY (brochure) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: projects_files_1 projects_files_1_directus_files_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_1
    ADD CONSTRAINT projects_files_1_directus_files_id_foreign FOREIGN KEY (directus_files_id) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: projects_files_1 projects_files_1_projects_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_1
    ADD CONSTRAINT projects_files_1_projects_id_foreign FOREIGN KEY (projects_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: projects_files_2 projects_files_2_directus_files_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_2
    ADD CONSTRAINT projects_files_2_directus_files_id_foreign FOREIGN KEY (directus_files_id) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: projects_files_2 projects_files_2_projects_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_2
    ADD CONSTRAINT projects_files_2_projects_id_foreign FOREIGN KEY (projects_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: projects_files_3 projects_files_3_directus_files_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_3
    ADD CONSTRAINT projects_files_3_directus_files_id_foreign FOREIGN KEY (directus_files_id) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: projects_files_3 projects_files_3_projects_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_3
    ADD CONSTRAINT projects_files_3_projects_id_foreign FOREIGN KEY (projects_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: projects_files_4 projects_files_4_directus_files_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_4
    ADD CONSTRAINT projects_files_4_directus_files_id_foreign FOREIGN KEY (directus_files_id) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: projects_files_4 projects_files_4_projects_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects_files_4
    ADD CONSTRAINT projects_files_4_projects_id_foreign FOREIGN KEY (projects_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: projects projects_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: projects projects_province_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_province_foreign FOREIGN KEY (province) REFERENCES public.provinces(id) ON DELETE SET NULL;


--
-- Name: projects projects_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: projects projects_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: provinces provinces_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: provinces provinces_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: site_settings site_settings_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 4zNlkAoPIvyMQazcGxH4fm20fj91M01yqal4oAIaQkN8VxHiyDHSDeXkU5cJTIO

