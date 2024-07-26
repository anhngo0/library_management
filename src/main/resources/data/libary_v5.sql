--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-07-26 21:51:01

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
-- TOC entry 218 (class 1259 OID 58767)
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    id bigint NOT NULL,
    password character varying(255),
    username character varying(255),
    profile_id bigint,
    role_id bigint,
    reset_date timestamp(6) with time zone,
    reset_key character varying(36)
);


ALTER TABLE public.account OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 58766)
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.account_id_seq OWNER TO postgres;

--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 217
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_id_seq OWNED BY public.account.id;


--
-- TOC entry 220 (class 1259 OID 58776)
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    id bigint NOT NULL,
    isbnnumber character varying(255),
    alter_name character varying(255),
    author character varying(255),
    book_position character varying(255),
    description character varying(255),
    is_borrowed boolean,
    language character varying(255),
    price double precision,
    publisher character varying(255),
    quantity integer NOT NULL,
    status character varying(255) NOT NULL,
    title_name character varying(255),
    year_of_publication integer,
    category_id bigint,
    number_id bigint,
    liquidation_ticket_id bigint,
    isbn_number character varying(255),
    data oid,
    CONSTRAINT book_status_check CHECK (((status)::text = ANY ((ARRAY['IN_USE_NEW'::character varying, 'IN_USE'::character varying, 'IN_USE_NOMINATED'::character varying, 'INACTIVE'::character varying, 'LIQUIDATED'::character varying])::text[])))
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 58786)
-- Name: book_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_category (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    note character varying(255)
);


ALTER TABLE public.book_category OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 58785)
-- Name: book_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_category_id_seq OWNER TO postgres;

--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 221
-- Name: book_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_category_id_seq OWNED BY public.book_category.id;


--
-- TOC entry 224 (class 1259 OID 58795)
-- Name: book_class_number; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_class_number (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.book_class_number OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 58794)
-- Name: book_class_number_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_class_number_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_class_number_id_seq OWNER TO postgres;

--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 223
-- Name: book_class_number_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_class_number_id_seq OWNED BY public.book_class_number.id;


--
-- TOC entry 219 (class 1259 OID 58775)
-- Name: book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_id_seq OWNER TO postgres;

--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 219
-- Name: book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_id_seq OWNED BY public.book.id;


--
-- TOC entry 225 (class 1259 OID 58801)
-- Name: borrow_book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.borrow_book (
    book_id bigint NOT NULL,
    borrow_ticket_id bigint NOT NULL
);


ALTER TABLE public.borrow_book OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 58807)
-- Name: borrow_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.borrow_ticket (
    id bigint NOT NULL,
    borrowed_date timestamp(6) without time zone,
    note character varying(255),
    returned_date timestamp(6) without time zone,
    status character varying(255),
    librarian_id bigint,
    member_id bigint,
    CONSTRAINT borrow_ticket_status_check CHECK (((status)::text = ANY ((ARRAY['ACCEPT'::character varying, 'PENDING'::character varying, 'REJECT'::character varying])::text[])))
);


ALTER TABLE public.borrow_ticket OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 58806)
-- Name: borrow_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.borrow_ticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.borrow_ticket_id_seq OWNER TO postgres;

--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 226
-- Name: borrow_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.borrow_ticket_id_seq OWNED BY public.borrow_ticket.id;


--
-- TOC entry 229 (class 1259 OID 58817)
-- Name: file_storage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file_storage (
    id bigint NOT NULL,
    associated_entity_id bigint NOT NULL,
    associated_entity_type character varying(255) NOT NULL,
    content_type character varying(255),
    data oid NOT NULL,
    description character varying(255) NOT NULL,
    extension character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    CONSTRAINT file_storage_description_check CHECK (((description)::text = ANY ((ARRAY['IMAGE'::character varying, 'DOCUMENT'::character varying])::text[])))
);


ALTER TABLE public.file_storage OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 58816)
-- Name: file_storage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.file_storage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.file_storage_id_seq OWNER TO postgres;

--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 228
-- Name: file_storage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.file_storage_id_seq OWNED BY public.file_storage.id;


--
-- TOC entry 231 (class 1259 OID 58827)
-- Name: import_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_ticket (
    id bigint NOT NULL,
    approval_date timestamp(6) without time zone,
    approver_note character varying(255),
    created_date timestamp(6) without time zone,
    creator_note character varying(255),
    status character varying(255),
    import_way character varying(255),
    supplier character varying(255),
    total_price double precision,
    total_quantity integer,
    approver_id bigint,
    creator_id bigint,
    CONSTRAINT import_ticket_status_check CHECK (((status)::text = ANY ((ARRAY['ACCEPT'::character varying, 'PENDING'::character varying, 'REJECT'::character varying])::text[])))
);


ALTER TABLE public.import_ticket OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 58826)
-- Name: import_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.import_ticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.import_ticket_id_seq OWNER TO postgres;

--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 230
-- Name: import_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.import_ticket_id_seq OWNED BY public.import_ticket.id;


--
-- TOC entry 233 (class 1259 OID 58837)
-- Name: liquidation_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.liquidation_ticket (
    id bigint NOT NULL,
    approval_date timestamp(6) without time zone,
    approver_note character varying(255),
    created_date timestamp(6) without time zone,
    creator_note character varying(255),
    status character varying(255),
    export_price double precision,
    total_quantity integer NOT NULL,
    approver_id bigint,
    creator_id bigint,
    CONSTRAINT liquidation_ticket_status_check CHECK (((status)::text = ANY ((ARRAY['ACCEPT'::character varying, 'PENDING'::character varying, 'REJECT'::character varying])::text[])))
);


ALTER TABLE public.liquidation_ticket OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 58836)
-- Name: liquidation_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.liquidation_ticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.liquidation_ticket_id_seq OWNER TO postgres;

--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 232
-- Name: liquidation_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.liquidation_ticket_id_seq OWNED BY public.liquidation_ticket.id;


--
-- TOC entry 216 (class 1259 OID 43885)
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id bigint NOT NULL,
    associated_entity_id bigint,
    associated_entity_type character varying(255),
    associated_user_id bigint,
    content character varying(255),
    created_at timestamp(6) with time zone,
    is_read boolean
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 43884)
-- Name: notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_id_seq OWNER TO postgres;

--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 215
-- Name: notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_id_seq OWNED BY public.notification.id;


--
-- TOC entry 235 (class 1259 OID 58847)
-- Name: permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permission (
    id bigint NOT NULL,
    description character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.permission OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 58846)
-- Name: permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permission_id_seq OWNER TO postgres;

--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 234
-- Name: permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permission_id_seq OWNED BY public.permission.id;


--
-- TOC entry 237 (class 1259 OID 58856)
-- Name: profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profile (
    id bigint NOT NULL,
    dob date,
    address character varying(255),
    cccd_id character varying(12) NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    phone character varying(255) NOT NULL,
    user_role character varying(255),
    CONSTRAINT profile_user_role_check CHECK (((user_role)::text = ANY ((ARRAY['MANAGER'::character varying, 'LIBRARIAN'::character varying, 'MEMBER'::character varying])::text[])))
);


ALTER TABLE public.profile OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 58855)
-- Name: profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profile_id_seq OWNER TO postgres;

--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 236
-- Name: profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profile_id_seq OWNED BY public.profile.id;


--
-- TOC entry 239 (class 1259 OID 58866)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id bigint NOT NULL,
    description character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 58874)
-- Name: role_has_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_has_permissions (
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL
);


ALTER TABLE public.role_has_permissions OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 58865)
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_id_seq OWNER TO postgres;

--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 238
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- TOC entry 4738 (class 2604 OID 58965)
-- Name: account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account ALTER COLUMN id SET DEFAULT nextval('public.account_id_seq'::regclass);


--
-- TOC entry 4739 (class 2604 OID 58966)
-- Name: book id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book ALTER COLUMN id SET DEFAULT nextval('public.book_id_seq'::regclass);


--
-- TOC entry 4740 (class 2604 OID 58967)
-- Name: book_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_category ALTER COLUMN id SET DEFAULT nextval('public.book_category_id_seq'::regclass);


--
-- TOC entry 4741 (class 2604 OID 58968)
-- Name: book_class_number id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_class_number ALTER COLUMN id SET DEFAULT nextval('public.book_class_number_id_seq'::regclass);


--
-- TOC entry 4742 (class 2604 OID 58969)
-- Name: borrow_ticket id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_ticket ALTER COLUMN id SET DEFAULT nextval('public.borrow_ticket_id_seq'::regclass);


--
-- TOC entry 4743 (class 2604 OID 58971)
-- Name: file_storage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_storage ALTER COLUMN id SET DEFAULT nextval('public.file_storage_id_seq'::regclass);


--
-- TOC entry 4744 (class 2604 OID 58972)
-- Name: import_ticket id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_ticket ALTER COLUMN id SET DEFAULT nextval('public.import_ticket_id_seq'::regclass);


--
-- TOC entry 4745 (class 2604 OID 58973)
-- Name: liquidation_ticket id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liquidation_ticket ALTER COLUMN id SET DEFAULT nextval('public.liquidation_ticket_id_seq'::regclass);


--
-- TOC entry 4737 (class 2604 OID 58974)
-- Name: notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);


--
-- TOC entry 4746 (class 2604 OID 58975)
-- Name: permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission ALTER COLUMN id SET DEFAULT nextval('public.permission_id_seq'::regclass);


--
-- TOC entry 4747 (class 2604 OID 58976)
-- Name: profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile ALTER COLUMN id SET DEFAULT nextval('public.profile_id_seq'::regclass);


--
-- TOC entry 4748 (class 2604 OID 58977)
-- Name: role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- TOC entry 4958 (class 0 OID 58767)
-- Dependencies: 218
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.account (id, password, username, profile_id, role_id, reset_date, reset_key) VALUES (10, '$2a$10$GmAK.dwdiB8LH5VeBz.mK.7UtvwuzTMkkX49VK2s5ZSo87l39lTDy', 'MaiAnh', 3, 3, NULL, NULL);
INSERT INTO public.account (id, password, username, profile_id, role_id, reset_date, reset_key) VALUES (11, '$2a$10$oVR5DNae29eUhZjmipGXSeWa6qhWiIOQ57.Q7o/5cSl8zpIBSMMoK', 'NhatAn', 2, 2, NULL, NULL);


--
-- TOC entry 4960 (class 0 OID 58776)
-- Dependencies: 220
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (909, NULL, NULL, '望月玲子', '120-005', NULL, false, 'Japanese', NULL, '講談社', 12, 'IN_USE', 'タケコさんの恋人', 1991, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (911, NULL, NULL, ' 岩崎 陽子', '120-007', NULL, false, 'Japanese', NULL, ' 秋田書店', 7, 'IN_USE', '王都妖奇譚', 2001, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (913, NULL, NULL, '大和 和紀', '120-009', NULL, false, 'Japanese', NULL, '講談社', 6, 'IN_USE', 'ベビーシッター・ギン!', 1998, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (914, NULL, NULL, '渡瀬 悠宇', '120-010', NULL, false, 'Japanese', NULL, '小学館 ', 15, 'IN_USE', 'ふしぎ遊戯 ', 1992, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (915, NULL, NULL, '吉村 菜由', '120-011', NULL, false, 'Japanese', NULL, ' 白泉社 ', 5, 'IN_USE', '政がゆく', 1988, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (916, NULL, NULL, '一条 ゆかり', '120-012', NULL, false, 'Japanese', NULL, '集英社', 10, 'IN_USE', '有閑倶楽部 ', 2000, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (917, NULL, NULL, '田村 由美', '120-013', NULL, false, 'Japanese', NULL, '小学館 ', 8, 'IN_USE', '巴がゆく!', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (918, NULL, NULL, '水樹 和佳子', '120-014', NULL, false, 'Japanese', NULL, '早川書房', 7, 'IN_USE', 'イティハーサ ', 2000, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (919, NULL, NULL, '萩尾 望都', '120-015', NULL, false, 'Japanese', NULL, '小学館', 5, 'IN_USE', '残酷な神が支配する', 2004, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (920, NULL, NULL, '高河 ゆん', '120-016', NULL, false, 'Japanese', NULL, '新書館', 5, 'IN_USE', '源氏', 1988, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (921, NULL, NULL, '市川 ジュン', '120-017', NULL, false, 'Japanese', NULL, '集英社', 5, 'IN_USE', '陽の末裔', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (922, NULL, NULL, '大和 和紀', '120-018', NULL, false, 'Japanese', NULL, '講談社', 5, 'IN_USE', 'ハイヒールCOP ', 1990, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (923, NULL, NULL, '神坂 智子', '120-019', NULL, false, 'Japanese', NULL, 'ホーム社', 5, 'IN_USE', '蒼のマハラジャ', 2007, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (924, NULL, NULL, '新谷 かおる', '120-020', NULL, false, 'Japanese', NULL, '小学館', 9, 'IN_USE', 'エリア88', 1982, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (925, NULL, NULL, '津寺 里可子', '120-021', NULL, false, 'Japanese', NULL, '秋田書店', 12, 'IN_USE', '月に叢雲花に風', 1993, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (926, NULL, NULL, '紫堂 恭子 ', '120-022', NULL, false, 'Japanese', NULL, '小学館', 3, 'IN_USE', 'エンジェリック・ゲーム', 1993, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (927, '9784063703337', NULL, '大和和紀', '120-023', NULL, false, 'Japanese', NULL, '講談社', 3, 'IN_USE', 'にしむく士', 2006, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (928, '9784840102148', NULL, '佐々木 淳子', '120-024', NULL, false, 'Japanese', NULL, 'メディアファクトリー', 2, 'IN_USE', '那由他', 200, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (931, '4063027341', NULL, '伊藤 ゆう', '120-027', NULL, false, 'Japanese', NULL, '講談社', 3, 'IN_USE', '39℃ショック', 1988, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (932, '9784063257823', NULL, 'あけみ・松苗', '120-028', NULL, false, 'Japanese', NULL, '講談社', 2, 'IN_USE', '結婚よそうよ', 1998, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (933, '9784091913821', NULL, '萩尾望都', '120-029', NULL, false, 'Japanese', NULL, '小学館', 2, 'IN_USE', '海のアリア', 2001, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (934, '4088491998', NULL, 'くらもちふさこ', '120-030', NULL, false, 'Japanese', NULL, '集英社', 3, 'IN_USE', 'アンコールが3回', 1986, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (935, '0', NULL, '槇村さとる', '120-031', NULL, false, 'Japanese', NULL, '集英社', 3, 'IN_USE', 'ダイヤモンド・パラダイス', 1985, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (936, '4253096719', NULL, '津寺里可子', '120-032', NULL, false, 'Japanese', NULL, '秋田書店', 2, 'IN_USE', 'ＳＵＮ－山田浅右衛門', 2002, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (937, '9784048534017', NULL, '紫堂恭子', '120-033', NULL, false, 'Japanese', NULL, '角川書店', 2, 'IN_USE', '姫神町リンク', 2001, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (938, '9784091913104', NULL, '名香智子', '120-034', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'ふんわり狩人(ハンター)', 2002, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (939, '9784091913098', NULL, '名香智子', '120-035', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'レディ・ギネヴィア', 2000, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (941, '9784592887126', NULL, '成田美名子', '120-037', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', '天の神話　地の神話', 2001, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (942, '9784592883265', NULL, '萩尾望都', '120-038', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', 'この娘（こ）うります', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (943, '9784088485416', NULL, '森部みき', '120-039', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'マイ ギャング', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (944, '4088508114', NULL, '有吉京子', '120-040', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', '麗羅からの手紙', 1992, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (946, '4088507681', NULL, '緒形もり', '120-042', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'やせっぽちの梨乃', 1990, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (947, '9784088655659', NULL, '萩岩睦美', '120-043', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'がんこちゃん～峰岸家の伝説～ クイーンズＣ', 2009, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (948, '4088498593', NULL, '宗美智子', '120-044', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'Maji！！　本気', 1992, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (949, '9784088485096', NULL, 'Ｍａｒｉａ', '120-045', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', '紅い糸の恋人 マーガレットＣ', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (951, '9784592120902', NULL, '武藤啓', '120-047', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', '愛っていうのはね', 1997, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (952, '9784592172079', NULL, '河惣益巳 ', '120-048', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', 'メデューサ・リリー', 2001, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (953, '4592125657', NULL, '杜真琴', '120-049', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', 'ダーク・ワンダー ', 1991, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (954, '9784086186865', NULL, '一条 ゆかり', '120-050', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', '9月のポピィ', NULL, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (955, '4061089234', NULL, '大和和紀', '120-051', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '薔薇子爵', 1977, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (956, '4061700995', NULL, '神奈幸子', '120-052', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '夏の迷宮', 1985, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (957, '4061762664', NULL, '大和和紀', '120-053', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', 'なんと王子さま!?', 1990, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (906, NULL, 'Chihayafuru', '末次由紀', '120-002', NULL, false, 'Japanese', NULL, '講談社', 43, 'IN_USE', 'ちはやふる', 2011, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (912, NULL, 'tondemo kishi', '宗 美智子 ', '120-008', NULL, false, 'Japanese', NULL, '集英社', 8, 'IN_USE', 'とんでも騎士', 1987, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (908, NULL, NULL, '惣領 冬実', '120-004', NULL, false, 'Japanese', NULL, ' 小学館', 13, 'IN_USE', '3ーThree', 1988, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (910, NULL, NULL, 'TEAM猫十字社', '120-006', NULL, false, 'Japanese', NULL, '朝日ソノラマ', 11, 'IN_USE', '幻獣の国物語', 2001, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (929, '9784091913234', NULL, '諏訪 緑', '120-025', NULL, false, 'Japanese', NULL, '小学館文庫', 3, 'IN_USE', 'うつほ草紙', 2003, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (945, '9784088485911', NULL, '名取ちずる', '120-041', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'ウサギ', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (958, '9784063031973', NULL, '美咲 さくや', '120-054', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '恋する宝石物語', 2000, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (959, '4063028372', NULL, '真柴ひろみ', '120-055', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '無口なテレパシー', 1991, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (960, '4061702017', NULL, '波間信子', '120-056', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '天使を抱きしめて', 1988, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (961, '9784063030471', NULL, '松本美緒', '120-057', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '獅子たちの夏', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (962, '9784063410136', NULL, '寄田みゆき', '120-058', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '愛と青春の発熱', 1997, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (963, '4061762338', NULL, '成毛 厚子', '120-059', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '魔の風が吹く', 1989, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (964, '406176263-X', NULL, '伊東千江', '120-060', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', 'みつめあえたら素敵', 1991, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (965, '9784061764682', NULL, '日下部拓海 ', '120-061', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', 'はったりアクトレス', 1995, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (966, '9784091322944', NULL, '惣領冬実', '120-062', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'サボテン', 1994, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (967, '9784091324405', NULL, '田村由美', '120-063', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'ボクがゴミを捨てた理由', 1995, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (968, '9784575300260', NULL, 'Shigeru Yokota, Sakie Yokota', '120-064', NULL, false, 'Dual lingual', NULL, 'Headquarters for the Abduction Issue, Government of Japan', 1, 'IN_USE', 'Megumi: Documentary Manga on Abductions by North Korea', 2008, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (969, '425313310-X', NULL, 'あしべゆうほ', '120-066', NULL, false, 'Japanese', NULL, '秋田書店', 1, 'IN_USE', '風の呪歌 射千玉の髪の姫君', 1989, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (970, '4063132900', NULL, '高橋美由紀', '120-067', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '鏡の中の闇', 1992, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (971, '9784592883111', NULL, '川原 泉', '120-068', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', '空の食欲魔人', 1994, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (972, '9784575720808', NULL, '中山星香', '120-069', NULL, false, 'Japanese', NULL, '双葉社', 1, 'IN_USE', 'はいどうぞ', 1997, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (973, '9784575726268', NULL, '名香智子', '120-070', NULL, false, 'Japanese', NULL, '双葉社', 1, 'IN_USE', 'ＤＯＵＢＴ！ ', 2007, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (974, '9784150306618', NULL, '水樹和佳子', '120-071', NULL, false, 'Japanese', NULL, '早川書房', 1, 'IN_USE', '月虹 ', 2001, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (975, '9784150306564', NULL, '水樹和佳子', '120-072', NULL, false, 'Japanese', NULL, '早川書房', 1, 'IN_USE', '樹魔・伝説', 2001, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (976, '4396380232', NULL, '原田 梨花', '120-073', NULL, false, 'Japanese', NULL, '祥伝社 ', 1, 'IN_USE', '天使の分け前', 2004, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (977, '9784168110436', NULL, '山岸凉子', '120-074', NULL, false, 'Japanese', NULL, '文藝春秋 ', 1, 'IN_USE', '月読', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (978, '4091425127', NULL, '穴久保幸作', '120-075', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'ポケットモンスター　', 1997, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (979, '9784840120753', NULL, '大田垣晴子', '120-076', NULL, false, 'Japanese', NULL, 'メディアファク  ', 1, 'IN_USE', 'わたしってどんなヒトですか?', 2007, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (980, '9784592131854', NULL, '川原泉　', '120-077', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', '小人たちが騒ぐので', 1998, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (981, '9784086185028', NULL, '萩岩睦美 ', '120-078', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'アラビアン花ちゃん', 2006, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (982, '9784086174817', NULL, '一条ゆかり ', '120-079', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'ロマンチックください', 1999, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (983, '9784086172578', NULL, '一条ゆかり ', '120-080', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'ティータイム', 1998, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (984, '9784086174824', NULL, '一条ゆかり ', '120-081', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', '日曜日は一緒に', 1999, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (985, '9784086181136', NULL, '一条ゆかり ', '120-082', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'おいしい男の作り方', 2004, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (986, '9784086182669', NULL, '一条ゆかり ', '120-083', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'うそつきな唇　', 2004, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (987, '9784086183932', NULL, '一条ゆかり ', '120-084', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', '麻耶の葬列', 2005, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (988, '9784086181143', NULL, '一条ゆかり ', '120-085', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', '5愛のル-ル', 2003, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (989, '9784253174671', NULL, '花郁悠紀子', '120-086', NULL, false, 'Japanese', NULL, '秋田書店 ', 1, 'IN_USE', '白木蓮抄', 1999, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (991, '9784253174732', NULL, '花郁悠紀子', '120-088', NULL, false, 'Japanese', NULL, '秋田書店 ', 1, 'IN_USE', 'フェネラ', 1999, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (992, '9784253172523', NULL, '萩尾望都', '120-089', NULL, false, 'Japanese', NULL, '秋田書店 ', 1, 'IN_USE', 'モザイク・ラセン', 1998, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (993, '9784592883258', NULL, '川原泉', '120-090', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', '本日のお言葉 ', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (994, '9784575724486', NULL, '望月玲子', '120-091', NULL, false, 'Japanese', NULL, '双葉社', 1, 'IN_USE', 'ヴァルダ 迷宮の貴婦人', 2003, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (995, '9784086175807', NULL, '槇村さとる', '120-092', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'まみあな四重奏団', 2000, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (996, '9784575726275', NULL, '名香智子', '120-093', NULL, false, 'Japanese', NULL, '双葉社', 1, 'IN_USE', 'ころばぬ魔法の杖', 2007, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (997, '4575713279', NULL, '藤臣柊子', '120-094', NULL, false, 'Japanese', NULL, '双葉社', 1, 'IN_USE', '金井家の人々', 2006, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (998, '9784168110320', NULL, '山岸凉子', '120-095', NULL, false, 'Japanese', NULL, '文藝春秋', 1, 'IN_USE', '夜叉御前 自選作品集', 1994, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (999, '4253172466', NULL, '山岸凉子', '120-096', NULL, false, 'Japanese', NULL, '秋田書店', 1, 'IN_USE', '神かくし', 1998, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1041, '9784309275093', 'strawberry war', 'Machiko Kyo', '120-138', NULL, false, 'Japanese', NULL, '河出書房新社', 1, 'IN_USE', 'いちご戦争', 2014, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1042, '9784816708534', NULL, '岡野雄一', '120-139', NULL, false, 'Japanese', NULL, '西日本新聞社', 1, 'IN_USE', 'ペコロスの母に会いに行く', 2014, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1043, NULL, NULL, 'Machiko Kyo', '120-140', NULL, false, 'Japanese', NULL, '大田出版', 3, 'IN_USE', 'センネン画報', 2013, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1044, '9784832232204', 'Chabashira Club', '青木幸子', '120-141', NULL, false, 'Japanese', NULL, '芳文社', 1, 'IN_USE', '茶柱俱乐部', 2011, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1045, '978-4-09-186847-3', NULL, '水木　しげる', '120-142', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', '泉鏡花伝', 2015, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1046, '978-4-09-188671-2', NULL, '島田　虎之介', '120-143', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', '九月十日', 2014, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1047, '978-4-04-726602-5', NULL, '上野　顕太郞', '120-144', NULL, false, 'Japanese', NULL, '[BEAM COMIX]エンターブレイン', 1, 'IN_USE', 'さよならもいわずに', 2010, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1048, '978-4-7783-2143-7', NULL, '佐々木　マキ', '120-145', NULL, false, 'Japanese', NULL, '太田出版', 1, 'IN_USE', 'うみべのまち', 2011, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1049, '978-4-09-179135-1', NULL, '萩尾　望都', '120-146', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'なのはな', 2012, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1050, '978-4-09-185706-4', NULL, '間瀬　元朗', '120-149-1', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'デモクラティア　1', 2013, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1051, '978-4-09-185874-0', NULL, '間瀬　元朗', '120-149-2', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'デモクラティア　2', 2014, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1052, '978-4-09-186602-8', NULL, '間瀬　元朗', '120-149-3', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'デモクラティア　3', 2014, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1053, '978-4-09-186743-8', NULL, '間瀬　元朗', '120-149-4', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'デモクラティア　4', 2015, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1054, '978-4-09-187344-6', NULL, '間瀬　元朗', '120-149-5', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'デモクラティア　5', 2015, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1055, '978-4-09-188630-9', NULL, '野田　彩子', '120-150-1', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'わたしの宇宙 第1巻', 2013, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1056, '978-4-09-188661-3', NULL, '野田　彩子', '120-150-2', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'わたしの宇宙 第2巻', 2013, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1105, NULL, '烈火の炎', 'Nobuyuki Anzai', '210-017', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 33, 'IN_USE', 'Ngọn lửa Recca', 2007, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1057, '978-4-06-388379-4', NULL, '田島　列島', '120-151-1', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', 'こどもはわかってあげない　上', 2014, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1058, '978-4-06-388380-0', NULL, '田島　列島', '120-151-2', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', 'こどもはわかってあげない　下', 2014, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1059, '978-4-06-388041-0', NULL, 'ヤマシタトモコ', '120-152-1', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '花井沢町公民館便り　１', 2015, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1060, '978-4-06-388111-0', NULL, 'ヤマシタトモコ', '120-152-2', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '花井沢町公民館便り　２', 2015, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1061, '978-4-04-726127-3', NULL, 'ヤマザキ　マリ', '120-153-1', NULL, false, 'Japanese', NULL, '[BEAM COMIX]エンターブレイン', 1, 'IN_USE', 'テルマエ・ロマエ　I', 2009, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1062, '978-4-04-726770-1', NULL, 'ヤマザキ　マリ', '120-153-2', NULL, false, 'Japanese', NULL, '[BEAM COMIX]エンターブレイン', 1, 'IN_USE', 'テルマエ・ロマエ　II', 2010, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1063, '978-4-04-727232-3', NULL, 'ヤマザキ　マリ', '120-153-3', NULL, false, 'Japanese', NULL, '[BEAM COMIX]エンターブレイン', 1, 'IN_USE', 'テルマエ・ロマエ　III', 2011, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1064, '978-4-04-727515-7', NULL, 'ヤマザキ　マリ', '120-153-4', NULL, false, 'Japanese', NULL, '[BEAM COMIX]エンターブレイン', 1, 'IN_USE', 'テルマエ・ロマエ　IV', 2011, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1065, '978-4-04-728225-4', NULL, 'ヤマザキ　マリ', '120-153-5', NULL, false, 'Japanese', NULL, '[BEAM COMIX]エンターブレイン', 1, 'IN_USE', 'テルマエ・ロマエ　V', 2012, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1066, '978-4-04-728895-9', NULL, 'ヤマザキ　マリ', '120-153-6', NULL, false, 'Japanese', NULL, '[BEAM COMIX]エンターブレイン', 1, 'IN_USE', 'テルマエ・ロマエ　VI', 2013, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1067, '978-4-09-185429-2', NULL, '村上　もとか', '120-154-1', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'フイチン再見　1', 2013, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1068, '978-4-09-185896-2', NULL, '村上　もとか', '120-154-2', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'フイチン再見　2', 2014, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1069, '978-4-09-186380-5', NULL, '村上　もとか', '120-154-3', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'フイチン再見　3', 2014, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1070, '978-4-09-186760-5', NULL, '村上　もとか', '120-154-4', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'フイチン再見　4', 2015, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1071, '978-4-09-187054-4', NULL, '村上　もとか', '120-154-5', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'フイチン再見　5', 2015, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1072, '978-4-09-187346-0', NULL, '村上　もとか', '120-154-6', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'フイチン再見　6', 2015, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1073, '978-4-09-187524-2', NULL, '村上　もとか', '120-154-7', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'フイチン再見　7', 2016, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1074, '978-4-582-28746-2', NULL, 'こうの　史代', '120-155-1', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', 'ぼおるぺん古事記 1 (天の巻) ', 2012, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1075, '978-4-582-28747-9', NULL, 'こうの　史代', '120-155-2', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', 'ぼおるぺん古事記 2 (地の巻) ', 2012, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1076, '978-4-582-28748-6', NULL, 'こうの　史代', '120-155-3', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', 'ぼおるぺん古事記 3 (海の巻) ', 2012, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1077, '978-4-575-84625-6', NULL, '田亀　源五郎', '120-156', NULL, false, 'Japanese', NULL, '双葉社', 4, 'IN_USE', '弟の夫', 2015, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1078, NULL, NULL, 'くらもちふさこ', '120-157', NULL, false, 'Japanese', NULL, '集英社', 8, 'IN_USE', '花に染む', 2018, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1079, NULL, NULL, 'くらもちふさこ', '120-158', NULL, false, 'Japanese', NULL, '集英社', 2, 'IN_USE', '駅から5分', 2016, 44, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1080, '9784253104906', NULL, '今日マチ子', '120-159', NULL, false, 'Japanese', NULL, '秋田書店', 1, 'IN_USE', 'COCOON', 2016, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1081, NULL, NULL, '今日マチ子', '120-160', NULL, false, 'Japanese', NULL, 'KADOKAWA', 3, 'IN_USE', '吉野北高校図書委員会', 2015, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1082, '9784040683546', NULL, '今日マチ子', '120-161', NULL, false, 'Japanese', NULL, 'KADOKAWA', 1, 'IN_USE', '百人一首ノート', 2016, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1083, '9784103512110', NULL, '矢部太郎', '120-162', NULL, false, 'Japanese', NULL, '新潮社', 1, 'IN_USE', '大家さんと僕', 2018, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1084, '9784088454214', NULL, '安藤ゆき', '120-163', NULL, false, 'Japanese', NULL, '集英社', 7, 'IN_USE', '町田くんの世界', 2016, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1085, '9784816365379', NULL, '鈴木啓子', '120-164', NULL, false, 'Japanese', NULL, 'ナツメ社', 1, 'IN_USE', '日本の文学', 2018, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1086, NULL, NULL, '有間しのぶ', '120-165', NULL, false, 'Japanese', NULL, '小学館', 5, 'IN_USE', 'その女、ジルバ', 2019, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1087, NULL, 'Nyx’s Lantern', '高浜寛', '120-168', NULL, false, 'Japanese', NULL, 'リイド社', 6, 'IN_USE', 'ニュクスの角灯', 2017, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1088, NULL, NULL, '多田かおる', '120-169', NULL, false, 'Japanese', NULL, '集英社', 14, 'IN_USE', 'イタズラなKiss', 2015, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1089, '9784062194761', NULL, 'ふわこういちろう（著）、戸矢学（監修）', '120-170', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '愛と涙と勇気の神様ものがたり　まんが古事記', 2021, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1090, NULL, NULL, NULL, '140-002', NULL, false, 'Japanese', NULL, '集英社', 148, 'IN_USE', 'リボン', NULL, 45, 9, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1091, NULL, 'BAKUMAN', NULL, '210-001', NULL, false, NULL, NULL, NULL, 15, 'IN_USE', 'BAKUMAN', NULL, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1111, NULL, NULL, NULL, '210-023', NULL, false, 'Vietnamese', NULL, NULL, 9, 'IN_USE', 'Nhiệm vụ đặc biệt', NULL, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1112, NULL, NULL, NULL, '210-024', NULL, false, 'Vietnamese', NULL, NULL, 7, 'IN_USE', 'Cơn lốc', NULL, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1113, NULL, NULL, NULL, '210-025', NULL, false, 'Vietnamese', NULL, NULL, 14, 'IN_USE', 'Tôi là Chokkaku ', NULL, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1114, NULL, '結界師', ' Tanabe Yellow', '210-026', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 35, 'IN_USE', 'Kết giới sư', 2009, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1115, NULL, '名探偵コナン', 'Aoyama Gōshō', '210-027', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 101, 'IN_USE', 'Conan', 2009, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1116, NULL, 'かっとび一斗', 'Kadoma Motoki', '210-028', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 47, 'IN_USE', 'Itto Cơn lốc sân cỏ', 2006, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1117, NULL, 'ワンピース', 'Eiichiro Oda', '210-029', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 101, 'IN_USE', 'One Piece', NULL, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1118, NULL, NULL, NULL, '210-030', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 2, 'IN_USE', 'Cageta Dường đua', NULL, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1119, NULL, NULL, 'Takamisaki Ryo', '210-031', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 13, 'IN_USE', 'Rockman - Chiến binh thế giới ảo', 2006, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1120, NULL, NULL, 'Kashimoto Manabu', '210-032', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 14, 'IN_USE', 'Cuộc phiêu lưu của Crocket', 2006, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1121, NULL, NULL, 'CLAMP', '210-033', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 19, 'IN_USE', 'XXXHolic', 2015, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1122, NULL, NULL, 'CLAMP', '210-034', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 28, 'IN_USE', 'Tsubasa Reservoir Chronicle', 2015, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1124, NULL, NULL, 'Hidenori Kusaka', '210-036', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 53, 'IN_USE', 'Pokemon đặc biệt', 2015, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1125, NULL, NULL, 'Morohito Katou', '210-037', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 47, 'IN_USE', 'Q.E.D.', 2015, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1126, NULL, NULL, 'Yumi Tamura', '210-038', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 26, 'IN_USE', 'Basara', 2015, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1127, NULL, NULL, 'Fujiko F. Fujio', '210-039', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 6, 'IN_USE', 'Doraemon Plus', 2015, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1128, NULL, NULL, 'Takeshi Obata - Yumi Hotta', '210-040', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 20, 'IN_USE', 'Hikaru - Kỳ thủ cờ vây', 2016, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1129, NULL, NULL, 'Ogawa Etsushi', '210-041', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 17, 'IN_USE', 'Tiểu đầu bếp cung đình', 2016, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1130, NULL, 'ブリーチ', 'Tite Kubo', '210-042', NULL, false, 'Vietnamese', NULL, 'NXB Đồng Nai', 60, 'IN_USE', 'Bleach', 2015, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1131, NULL, '幽☆遊☆白書', 'Yoshihiro Togashi', '210-043', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 19, 'IN_USE', 'Hành trình u linh giới', 2015, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1132, NULL, '魔法使いの嫁', 'Yamazaki Kore', '210-044', NULL, false, 'Vietnamese', NULL, 'NXB Hồng Đức', 10, 'IN_USE', 'Cô dâu pháp sư', 2016, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1133, NULL, '四月は君の嘘', 'Naoshi Arakawa', '210-045', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 11, 'IN_USE', 'Lời nói dối tháng Tư', 2016, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1134, NULL, NULL, 'Eiichiro Oda', '210-046', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 5, 'IN_USE', 'Hồ sơ One Piece', 2015, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1135, NULL, NULL, 'Eiichiro Oda', '210-047', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 1, 'IN_USE', 'One Piece Strong Words', 2017, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1136, NULL, NULL, 'Eiichiro Oda', '210-048', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 1, 'IN_USE', 'WANTED!', 2015, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1137, NULL, '進撃の巨人', 'Hajime Isayama', '210-049', NULL, false, 'Vietnamese', NULL, 'NXB Hải Phòng', 18, 'IN_USE', 'Đại chiến Titan', 2014, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1138, NULL, 'テガミバチ', 'Hiroyuki Asada', '210-050', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 19, 'IN_USE', 'Ong đưa thư', 2011, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1139, NULL, 'チョッパーマン', 'Hirofumi Takei', '210-051', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 6, 'IN_USE', 'Chopperman', 2016, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1140, NULL, 'クレヨンしんちゃん', 'Yoshito Usui', '210-052', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 50, 'IN_USE', 'Shin - Cậu bé bút chì', 2018, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1142, NULL, 'シャーマンキング', 'Hiroyuki Takei', '210-054', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 32, 'IN_USE', 'Shaman King', 2017, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1143, NULL, 'エスパー魔美', 'Fujiko F. Fujio', '210-055', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 9, 'IN_USE', 'Siêu nhân Mami', 2012, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1144, NULL, '遊☆戯☆王', 'Kazuki Takahashi', '210-056', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 38, 'IN_USE', 'Yu-Gi-Oh!', 2016, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1145, NULL, 'JIN-仁-', 'Motoka Murakami', '210-057', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 19, 'IN_USE', 'Jin', 2019, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1146, NULL, 'ワンパンマン', 'One', '210-058', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 23, 'IN_USE', 'One-Punch Man', 2019, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1147, NULL, '坂本ですが?', 'Sano Nami', '210-059', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 4, 'IN_USE', 'Tôi Là Sakamoto', 2018, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1148, NULL, '暗殺教室', 'Yūsei Matsui', '210-060', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 20, 'IN_USE', 'Assassination Classroom', 2020, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1149, NULL, '金色のガッシュ!!', 'Makoto Raiku', '210-061', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 16, 'IN_USE', 'Gash - Cậu Bé Vàng', 2019, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1150, NULL, 'スケットダンス', 'Kenta Shinohara', '210-062', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 32, 'IN_USE', 'Sket Dance', 2019, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1151, NULL, 'ノラガミ', 'Adachi Toka', '210-063', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 23, 'IN_USE', 'Vị thần lang thang', 2019, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1152, NULL, 'ナルト', 'Masashi Kishimoto', '210-064', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 72, 'IN_USE', 'Naruto', 2018, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1153, NULL, 'コードギアス 反逆のルルーシュ', 'Ichirou Ohkouchi, Goro Taniguchi', '210-065', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 8, 'IN_USE', 'Code Geass', 2018, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1154, NULL, '鬼滅の刃', 'Koyoharu Gotouge', '210-066', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 23, 'IN_USE', 'Thanh gươm diệt quỷ', 2020, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1155, NULL, '妖怪ウォッチ', 'Noriyuki Konishi', '210-067', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 15, 'IN_USE', 'Yo-kai Watch - Đồng Hồ Yêu Quái', 2019, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1156, NULL, '僕のヒーローアカデミア', 'Horikoshi Kohei', '210-068', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 31, 'IN_USE', 'My Hero Academia - Học Viện Siêu Anh Hùng', 2020, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1141, NULL, 'デスノート', 'Tsugumi Oba - Takeshi Obata', '210-053', NULL, false, 'Vietnamese', NULL, 'NXB Hà Nội', 14, 'IN_USE_NOMINATED', 'Death Note', 2018, 6, 10, NULL, NULL, 67239);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1106, NULL, 'デビデビ', 'Miyoshi Yuki', '210-018', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 21, 'IN_USE', 'Thiên thần và ác quỷ', 2004, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1109, NULL, NULL, NULL, '210-021', NULL, false, 'Vietnamese', NULL, NULL, 22, 'IN_USE', 'Đoremon truyện dài', NULL, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1157, NULL, 'ツバサ WoRLD CHRoNiCLE ニライカナイ編', 'CLAMP', '210-069', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 3, 'IN_USE', 'Tsubasa World Chronicle - Thánh Địa Linh Hồn', 2018, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1158, NULL, 'ブラッククローバー', 'Tabata Yuuki', '210-070', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 25, 'IN_USE', 'Black Clover', 2020, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1159, NULL, '鋼の錬金術師', 'Arakawa Hiromu', '210-071', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 17, 'IN_USE', 'Fullmetal Alchemist - Cang Giả Kim Thuật Sư', 2019, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1160, NULL, '犬夜叉', 'Takahashi Rumiko', '210-072', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 22, 'IN_USE', 'Inuyasha', 2020, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1161, NULL, 'らんま½', 'Takahashi Rumiko', '210-073', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 20, 'IN_USE', 'Ranma 1/2', 2020, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1162, NULL, 'YAIBA', 'Aoyama Gōshō', '210-074', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 24, 'IN_USE', 'Yaiba', 2020, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1163, NULL, 'キャプテン翼', 'Takahashi Yoichi', '210-075', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 32, 'IN_USE', 'Tsubasa - Giấc Mơ Sân Cỏ', 2020, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1164, NULL, 'スラムダンク', 'Inoue Takehiko', '210-076', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 11, 'IN_USE', 'SLAM DUNK', 2021, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1165, NULL, '虹色とうがらし?', 'Adachi Mitsuru', '210-077', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 6, 'IN_USE', 'Ớt bảy màu', 2021, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1166, NULL, 'Dr.STONE', 'Inagaki Riichiro, Boichi', '210-078', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 20, 'IN_USE', 'Dr.STONE', 2021, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1167, NULL, 'ブラック・ジャック', 'Tezuka Osamu', '210-079', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 17, 'IN_USE', 'Black Jack', 2021, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1168, NULL, 'おれは鉄兵', 'Chiba Tetsuya', '210-080', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 31, 'IN_USE', 'Siêu quậy Teppei', 2021, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1169, NULL, 'ナイン', 'Adachi Mitsuru', '210-081', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 5, 'IN_USE', 'Nine', 2010, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1170, NULL, 'いつも美空', 'Adachi Mitsuru', '210-082', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 5, 'IN_USE', 'Misora', 2010, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1171, NULL, '侵略!イカ娘', 'Anbe Masahiro', '210-083', NULL, false, 'Vietnamese', NULL, 'NXB Phụ Nữ Việt Nam', 9, 'IN_USE', 'Cuộc Xâm Lăng Của Bé Mực', 2020, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1172, NULL, '聲の形', 'Oima Yoshitoki', '210-084', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 7, 'IN_USE', 'Dáng Hình Thanh Âm', 2021, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1173, NULL, 'ローンナイト', 'Yoshitomi Akihito', '210-085', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 13, 'IN_USE', 'Hiệp Sĩ Ốc Vít', 2002, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1174, NULL, '猫絵十兵衛 御伽草紙', 'Nagao Maru', '210-086', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 19, 'IN_USE', 'Họa sư ma mèo', 2020, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1175, NULL, 'Dr. スランプ', 'Toriyama Akira', '210-087', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 14, 'IN_USE', 'Dr.Slump Ultimate Edition', 2020, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1176, NULL, '極主夫道', 'Oono Kousuke', '210-088', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 7, 'IN_USE', 'Đạo Làm Chồng Đảm', 2022, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1184, NULL, NULL, 'Grolier Incorporated', '010-001-4', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 5 (Burma to Cathay)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1185, NULL, NULL, 'Grolier Incorporated', '010-001-5', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 6 (Cathedrals to Civil war)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1186, NULL, NULL, 'Grolier Incorporated', '010-001-6', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 7 (Civilization to Coronium)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1187, NULL, NULL, 'Grolier Incorporated', '010-001-7', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 8 (Corot to Desdemona)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1188, NULL, NULL, 'Grolier Incorporated', '010-001-8', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 9 (Desert to Egret)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1189, NULL, NULL, 'Grolier Incorporated', '010-001-9', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 10 (Egypt to Falsetto)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1190, NULL, NULL, 'Grolier Incorporated', '010-001-10', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 11 (Falstaff to Francke)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1191, NULL, NULL, 'Grolier Incorporated', '010-001-11', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 12 (Franco to Goethal)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1192, NULL, NULL, 'Grolier Incorporated', '010-001-12', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 13 (Goetheto Hearst)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1193, NULL, NULL, 'Grolier Incorporated', '010-001-13', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 14 (Heart to India)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1194, NULL, NULL, 'Grolier Incorporated', '010-001-14', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 15 (Indian to Jeffer)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1195, NULL, NULL, 'Grolier Incorporated', '010-001-15', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 16 (Jefferson to Latin)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1196, NULL, NULL, 'Grolier Incorporated', '010-001-16', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 17 (Latin America to Lytton)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1197, NULL, NULL, 'Grolier Incorporated', '010-001-17', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 18 (M to Mexico City)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1198, NULL, NULL, 'Grolier Incorporated', '010-001-18', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 19 (Meyer to Nauvoo)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1199, NULL, NULL, 'Grolier Incorporated', '010-001-19', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 20 (Navajo to Opium)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1200, NULL, NULL, 'Grolier Incorporated', '010-001-20', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 21 (Oporto to Photoengraving )', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1201, NULL, NULL, 'Grolier Incorporated', '010-001-21', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 22 (Photography to Pumpkin)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1202, NULL, NULL, 'Grolier Incorporated', '010-001-22', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 23 (Pumps to Russell)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1203, NULL, NULL, 'Grolier Incorporated', '010-001-23', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 24 (Russia to Skimmer)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1204, NULL, NULL, 'Grolier Incorporated', '010-001-24', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 25(Skin to Sumac)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1205, NULL, NULL, 'Grolier Incorporated', '010-001-25', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 26 (Sumatra to Trampoline)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1206, NULL, NULL, 'Grolier Incorporated', '010-001-26', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 27(Trance to Venial Sin)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1207, NULL, NULL, 'Grolier Incorporated', '010-001-27', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 28(Venice to Wilmot, John)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1208, NULL, NULL, 'Grolier Incorporated', '010-001-28', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 29 (Wilmot Proviso to Zygote)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1209, NULL, NULL, 'Grolier Incorporated', '010-001-29', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 30 (Index)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1210, '4-582-02200-6', 'Heibonsha`s world encyclopedia', '平凡社', '010-002-1', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典1', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1211, NULL, 'Heibonsha`s world encyclopedia', '平凡社', '010-002-2', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典2', NULL, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1212, NULL, 'Heibonsha`s world encyclopedia', '平凡社', '010-002-3', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典3', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1213, NULL, 'Heibonsha`s world encyclopedia', '平凡社', '010-002-4', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典4', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1214, NULL, 'Heibonsha`s world encyclopedia 5', '平凡社', '010-002-5', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典5', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1215, NULL, 'Heibonsha`s world encyclopedia 6', '平凡社', '010-002-6', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典6', 1998, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1216, NULL, 'Heibonsha`s World encyclopedia 7', '平凡社', '010-002-7', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典7', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1217, NULL, 'Heibonsha`s world encyclopedia 8', '平凡社', '010-002-8', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典8', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1218, NULL, 'Heibonsha`s world encyclopedia', '平凡社', '010-002-9', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典9', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1219, NULL, 'Heibonsha`s world encyclopedia 10', '平凡社', '010-002-10', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典10', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1220, NULL, 'Heibonsha`sworld encyclopedia 11', '平凡社', '010-002-11', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典11', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1221, NULL, 'Heibonsha`s world encyclopedia 12', '平凡社', '010-002-12', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典12', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1222, NULL, 'Heibonsha`s world encyclopedia 13', '平凡社', '010-002-13', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典13', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1223, NULL, 'Heibonsha`s world encyclopedia', '平凡社', '010-002-14', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典14', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1224, NULL, 'Heibonsha`s world encyclopedia 15', '平凡社', '010-002-15', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典15', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1225, NULL, 'Heibonsha`sworld encyclopedia 16', '平凡社', '010-002-16', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典16', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1226, NULL, 'Heibonsha`sworld encyclopedia 17', '平凡社', '010-002-17', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典17', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1227, NULL, 'Heibonsha`s world encyclopedia 18', '平凡社', '010-002-18', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典18', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1228, NULL, 'Heibonsha`sworld encyclopedia 19', '平凡社', '010-002-19', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典19', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1229, NULL, 'Heibonsha`s world encyclopedia 20', '平凡社', '010-002-20', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典20', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1230, NULL, 'Heibonsha`sworld encyclopedia 21', '平凡社', '010-002-21', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典21', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1231, NULL, 'Heibonsha`s world encyclopedia 21', '平凡社', '010-002-22', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典22', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1232, NULL, 'Heibonsha`s world encyclopedia 22', '平凡社', '010-002-23', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典23', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1233, NULL, 'Heibonsha`sworld Encyclopedia 23', '平凡社', '010-002-24', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典24', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1234, NULL, 'Heibonsha`s world encyclopedia 24', '平凡社', '010-002-25', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典25', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1235, NULL, 'Heibonsha`s world encyclopedia 25', '平凡社', '010-002-26', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典26', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1236, NULL, 'Heibonsha`sworld encyclopedia 26', '平凡社', '010-002-27', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典27', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1237, NULL, 'Heibonsha`sworld encyclopedia 27', '平凡社', '010-002-28', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典28', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1238, NULL, 'Heibonsha`s world encyclopedia', '平凡社', '010-002-29', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典29', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1239, NULL, 'Heibonsha`s world encyclopedia', '平凡社', '010-002-30', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典30', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1240, NULL, 'Heibonsha`s world encyclopedia', '平凡社', '010-002-31', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典31', 1988, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1241, NULL, NULL, '平凡社', '010-002-32', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典・百科年鑑’96', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1242, NULL, NULL, '平凡社', '010-002-33', NULL, false, 'Japanese', NULL, '平凡社', 1, 'IN_USE', '世界大百科事典・百科年鑑’97', 1997, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1243, NULL, NULL, '平凡社', '010-002-34', NULL, false, 'Japanese', NULL, '平凡社', 2, 'IN_USE', '世界大百科事典・日本地図', 1991, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1244, NULL, NULL, '平凡社', '010-002-35', NULL, false, 'Japanese', NULL, '平凡社', 2, 'IN_USE', '世界大百科事典・世界地図', 1991, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1245, NULL, NULL, '平凡社', '010-002-36', NULL, false, 'Japanese', NULL, '平凡社', 2, 'IN_USE', '世界大百科事典・百科使鑑', 1991, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1246, '5638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-1', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 50 No.1', NULL, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1247, '5638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-2', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 50 No.2', 2013, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1248, '5638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-3', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 51 No.1', 2013, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1249, '05638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-4', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 51 No.2', 2014, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1250, '05638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-5', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 52 No.1', NULL, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1251, '05638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-6', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 52 No.2', 2015, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1252, '05638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-7', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 53 No.1', 2015, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1253, '05638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-8', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 53 No.2', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1254, '05638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-9', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 54 No.1', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1255, '05638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-10', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 54 No.2', 2017, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1256, '05638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-11', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 55 No.1', 2017, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1257, '05638682', 'Southest Asian Studies', 'Nhiều tác giả', '020-001-21', NULL, false, 'Japanese', NULL, 'Center for Southest Asian Studies, Kyoto University', 1, 'IN_USE', '東南アジア研究 Vol 60 No.1', NULL, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1258, '21867275', 'CSEAS', 'Various', '020-002-1', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 1 no. 1 2012', 2012, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1259, '21867275', 'CSEAS', 'Various', '020-002-2', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 2 no. 1 2013', 2013, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1260, '21867275', 'CSEAS', 'Various', '020-002-3', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 2 no. 2 2013', 2013, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1261, '21867275', 'CSEAS', 'Various', '020-002-4', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 2 no.3 2013', 2013, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1262, '21867275', 'CSEAS', 'Various', '020-002-5', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 3 no. 1 2014', 2014, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1263, '21867275', 'CSEAS', 'Various', '020-002-6', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 3 no. 2 2014', 2014, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1264, '21867275', 'CSEAS', 'Various', '020-002-7', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 3 no. 3 2014', 2014, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1265, '21867275', 'CSEAS', 'Various', '020-002-8', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 3 supplementary issue 2015', 2015, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1266, '21867275', 'CSEAS', 'Various', '020-002-9', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 4 No. 1 2015', 2015, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1267, '21867275', 'CSEAS', 'Various', '020-002-10', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 4 No. 2 2015', 2015, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1268, '21867275', 'CSEAS', 'Various', '020-002-11', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 4 No. 3 2015', 2015, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1269, '21867275', 'CSEAS', 'Various', '020-002-12', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 5 No. 2 2016', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1270, '21867275', 'CSEAS', 'Various', '020-002-13', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 5 No. 3 2016', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1271, '21867275', 'CSEAS', 'Various', '020-002-14', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 6 No. 1 2017', 2017, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1272, '21867275', 'CSEAS', 'Various', '020-002-15', NULL, false, 'English', NULL, 'CSEAS', 1, 'IN_USE', 'Southeast asian studies vo1. 6 No. 2 2017', 2017, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1273, NULL, NULL, '今井雅晴', '020-003-1', NULL, false, 'Japanese', NULL, '筑波大学第二学群・日本語・日本文化学類', 1, 'IN_USE', 'ニューヨークコロンビア大学の日本研究2000年秋', 2001, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1274, NULL, NULL, '今井雅晴', '020-003-2', NULL, false, 'Japanese', NULL, '筑波大学第二学群・日本語・日本文化学類', 1, 'IN_USE', '中国・大連と日本研究', 2004, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1275, NULL, NULL, '今井雅晴', '020-003-3', NULL, false, 'Japanese', NULL, '筑波大学第二学群・日本語・日本文化学類', 1, 'IN_USE', '中国・大連の筑波大学ー日本語・日本文化学類の出張講義ー世界の中の筑波大学1', 2005, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1276, NULL, NULL, '今井雅晴', '020-003-4', NULL, false, 'Japanese', NULL, '筑波大学第二学群・日本語・日本文化学類', 1, 'IN_USE', '続・日本の宗教と芸能ー戦国時代から安土桃山時代へ', 2005, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1277, NULL, NULL, '今井雅晴', '020-003-5', NULL, false, 'Japanese', NULL, '筑波大学第二学群・日本語・日本文化学類', 1, 'IN_USE', '室町時代人物群像', 2004, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1278, NULL, NULL, '今井雅晴', '020-003-6', NULL, false, 'Japanese', NULL, '筑波大学第二学群・日本語・日本文化学類', 1, 'IN_USE', '鎌倉時代の人物群像', 2003, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1279, NULL, NULL, '今井雅晴', '020-003-7', NULL, false, 'Japanese', NULL, '筑波大学第二学群・日本語・日本文化学類', 1, 'IN_USE', 'イスタンブール・ボアジチ大学の日本語講座', 2002, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1280, NULL, NULL, '今井雅晴', '020-003-8', NULL, false, 'Japanese', NULL, '筑波大学第二学群・日本語・日本文化学類', 1, 'IN_USE', 'スロベニア・リュブリャーナの筑波大学・日本語・日本文化学類の出張講義ー世界の中の筑波大学II', 2006, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1281, '09150900', '日本研究第37集H20/03 月', 'International research center for Japanese Studies', '020-004-1', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.37 March, 2008', 2009, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1282, '09150900', '日本研究第38集H20/09月', 'International research center for Japanese Studies', '020-004-2', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.38 September, 2008', 2008, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1283, '09150900', '日本研究第39集H21/03 月', 'International research center for Japanese Studies', '020-004-3', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.39 March, 2009', 2009, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1284, '09150900', '日本研究第40集H21/11月', 'International research center for Japanese Studies', '020-004-4', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.40 November, 2009', 2009, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1285, '09150900', '日本研究第41集H22/03月', 'International research center for Japanese Studies', '020-004-5', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.41 March, 2010', 2010, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1286, '09150900', '日本研究第49集', 'International research center for Japanese Studies', '020-004-6', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.49 March, 2014', 2014, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1287, '09150900', '日本研究第50集平成26年9月', 'International research center for Japanese Studies', '020-004-7', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.50 September, 2014', 2014, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1288, '09150900', '日本研究第52集', 'International research center for Japanese Studies', '020-004-8', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.52 March, 2016', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1289, '09150900', '日本研究第53集', 'International research center for Japanese Studies', '020-004-9', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.53 June, 2016', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1290, '09150900', '日本研究第54集', 'International research center for Japanese Studies', '020-004-10', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.54 January, 2017', 2017, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1291, '09150900', '日本研究第56集', 'International research center for Japanese Studies', '020-004-11', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.56 October, 2017', 2017, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1292, '09150900', '日本研究第57集', 'International research center for Japanese Studies', '020-004-12', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Nihon-Kenkyu No.57 March, 2018', 2018, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1293, NULL, NULL, 'Nhiều tác giả', '020-005-1', NULL, false, 'English', NULL, 'Sophia university', 1, 'IN_USE', 'Monumenta Nipponica Volume 64-Number 1-Spring 2009', 2009, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1294, '00270741', NULL, NULL, '020-005-2', NULL, false, 'Japanese', NULL, 'Sophia university', 1, 'IN_USE', 'Monumenta Nipponica Volume 64-number 2-Autumn 2009', 2009, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1295, '09150986', NULL, 'International research Center for Japanese Studies', '020-006-1', NULL, false, 'English', NULL, 'Nichibunken', 1, 'IN_USE', 'Nichibunken Japan review-Journal of the international research center for Japanese studies No.20 2008', 2008, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1296, NULL, NULL, 'International research Center for Japanese Studies', '020-006-2', NULL, false, 'English', NULL, 'Nichibunken', 1, 'IN_USE', 'Nichibunken Japan review-Journal of the international research center for Japanese studies No.21 2009', 2009, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1297, '09150986', NULL, 'International research Center for Japanese Studies', '020-006-3', NULL, false, 'English', NULL, 'Nichibunken', 1, 'IN_USE', 'Nichibunken Japan review-Journal of the international research center for Japanese studies No.27 2014', 2014, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1298, '09150986', NULL, 'International research Center for Japanese Studies', '020-006-4', NULL, false, 'English', NULL, 'Nichibunken', 1, 'IN_USE', 'Nichibunken Japan review-Journal of the international research center for Japanese studies No.28 2015', 2015, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1299, '09150986', NULL, 'International research Center for Japanese Studies', '020-006-5', NULL, false, 'English', NULL, 'Nichibunken', 1, 'IN_USE', 'Nichibunken Japan review-Journal of the international research center for Japanese studies No.29 2016', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1300, '09150986', NULL, 'International research Center for Japanese Studies', '020-006-6', NULL, false, 'English', NULL, 'Nichibunken', 1, 'IN_USE', 'Nichibunken Japan review-Journal of the international research center for Japanese studies No.30 2017', 2017, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1301, '09150986', NULL, 'International research Center for Japanese Studies', '020-006-7', NULL, false, 'English', NULL, 'Nichibunken', 1, 'IN_USE', 'Nichibunken Japan review-Journal of the international research center for Japanese studies No.31 2017', 2017, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1302, NULL, 'Proceedings of the second anglo - Japanese Academy, 7-11 January 2006', NULL, '020-007', NULL, false, 'English', NULL, 'International center for comparative Law and Politics, Graduate School of Law and Politics, The University of Tokyo', 1, 'IN_USE', 'Globalisationa regionalisation and national policy Systems', 2006, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1303, '9152822', NULL, 'International research Center for Japanese Studies', '020-008-1', NULL, false, 'Dual lingual', NULL, 'International Research Center for Japanese Studies', 1, 'IN_USE', 'Cairo Conference on Japanese Studies - INTERNATIONAL SYMPOSIUM IN EGYPT 2006', 2006, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1304, '09152822', 'Study of Bureaucracy of Japanese Colonial Empire', 'International research Center for Japanese Studies', '020-008-2', NULL, false, 'Dual lingual', NULL, 'International Research Center for Japanese Studies', 1, 'IN_USE', '日本の朝鮮・台湾支配と植民地官僚', 2007, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1305, '09152822', NULL, 'International research Center for Japanese Studies', '020-008-3', NULL, false, 'English', NULL, 'International Research Center for Japanese Studies', 1, 'IN_USE', 'Interpretations of Japanese Culture　View from Russia and Japan - INTERNATIONAL SYMPOSIUM IN RUSSIA 2007', 2007, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1306, '09152822', '日本・ブラジル文化交流', 'International research Center for Japanese Studies', '020-008-4', NULL, false, 'Dual lingual', NULL, 'International Research Center for Japanese Studies', 1, 'IN_USE', 'Cultural Exchange between Brazil and Japan - INTERNATIONAL SYMPOSIUM IN BRAZIL 2008', 2008, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1307, '09152823', 'Japanese Studies: Past, Present and Future　Breaking New Ground for Research in Japanese Culture', 'International research Center for Japanese Studies', '020-008-5', NULL, false, 'Japanese', NULL, 'International Research Center for Japanese Studies', 1, 'IN_USE', '創立20周年記念国際シンポジウム　日本文化研究の過去・現在・未来―新たな地平を開くために－　', 2007, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1308, '9152822', NULL, 'International research Center for Japanese Studies', '020-008-6', NULL, false, 'Dual lingual', NULL, 'International Research Center for Japanese Studies', 1, 'IN_USE', '「日本研究」再考―北欧の実践から', 2012, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1309, '9152822', 'アジア太平洋地域のおけるグローバリゼイション、ローカリゼイションと日本文化　Volume 1', 'International research Center for Japanese Studies', '020-008-7', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Globalization, Localization, and Japanese Studies in the Asia-Pacific Region　Volume 1 - INTERNATIONAL SYMPOSIUM IN SYDNEY 2003', 2010, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1310, '9152822', 'アジア太平洋地域のおけるグローバリゼイション、ローカリゼイションと日本文化　Volume 2', 'International research Center for Japanese Studies', '020-008-8', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Globalization, Localization, and Japanese Studies in the Asia-Pacific Region　Volume 2 - INTERNATIONAL SYMPOSIUM IN SINGAPORE 2004', 2010, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1311, '9152822', 'アジア太平洋地域のおけるグローバリゼイション、ローカリゼイションと日本文化　Volume 3', 'International research Center for Japanese Studies', '020-008-9', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Globalization, Localization, and Japanese Studies in the Asia-Pacific Region　Volume 3 - INTERNATIONAL SYMPOSIUM IN HONGKONG 2005', 2010, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1463, NULL, NULL, '原 秀則', '110-013', NULL, false, 'Japanese', NULL, '小学館', 9, 'IN_USE', 'さよなら三角', 1983, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1312, '9152822', 'The Reformulation of concepts and Intellectual Systems in Modern East Asia', 'International research Center for Japanese Studies', '020-008-10', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 2, 'IN_USE', '国際シンポジウム35　2008　東アジア近代における概念の再編成', 2010, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1313, '9152822', 'Asian Gender under Construction: Global Reconfiguration of Human Reproduction', 'International research Center for Japanese Studies', '020-008-11', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', '国際シンポジウム36　2009　いま構築されるアジアのジェンダー：人間再生産のグローバルな再編成', 2010, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1314, '09152822', 'The Tradition and Creation of Yōkai Culture: From the Viewpoint of Inside and Outside', 'International research Center for Japanese Studies', '020-008-12', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', '国際シンポジウム45　2013　怪異・妖怪文化の伝統と創造―ウチとソトの視点から', 2015, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1315, '978-4901558853', 'New Vistas: Japanese Studies for the Next Generation - INTERNATIONAL SYMPOSIUM 2014 IN KYOTO', 'International research Center for Japanese Studies', '020-008-13', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', '海外シンポジウム　2014　新領域・次世代の日本研究', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1316, '09152822', 'International Research Symposium Proceedings: "Expo and Human History" - THE 48TH INTERNATIONAL RESEARCH SYMPOSIUM', 'International research Center for Japanese Studies', '020-008-14', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', '国際シンポジウム48　2015　国際研究集会「万国羨博覧会と人間の歴史」報告書', 2015, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1317, '09152822', 'The Philosophy of Mind, Body, and Environment: Reexamination of Traditional East Asian Concepts and Attempts to Universalize Them - THE 49TH INTERNATIONAL RESEARCH SYMPOSIUM', 'International research Center for Japanese Studies', '020-008-15', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', '国際シンポジウム49　「心身／身心」と「環境」の哲学―東アジアの伝統的概念の再検討とその普遍化の試み―', 2018, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1318, '09152822', NULL, 'International research Center for Japanese Studies', '020-008-16', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', '国際シンポジウム50　A Pirate''s View of World History　A Reversed Perception of the Order of Things From a Global Perspective - THE 50TH INTERNATIONAL RESEARCH SYMPOSIUM', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1319, '09152822', '南太平洋から見る日本研究―歴史、政治、文学、芸術―', 'International research Center for Japanese Studies', '020-008-17', NULL, false, 'English', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Japanese Studies Down Under: History, Politics, Literature and Art - OVERSEAS SYMPOSIUM 2016 IN OTAGO', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1320, NULL, NULL, NULL, '020-009', NULL, false, 'Japanese', NULL, '法政大学', 1, 'IN_USE', '国際日本学研究第2号', NULL, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1321, '18838618', NULL, '法政大学国際日本学研究所', '020-010-1', NULL, false, 'Japanese', NULL, NULL, 1, 'IN_USE', '国際日本学研究叢書11異文化としての日本', 2010, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1322, '18838618', NULL, '法政大学国際日本学研究所', '020-010-2', NULL, false, 'Japanese', NULL, NULL, 1, 'IN_USE', '国際日本学研究叢書14転換期日中関係論の最前線', 2010, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1323, '9150889', NULL, '国際日本文化研究センター', '020-011-1', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', '日文研no.41', 2008, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1324, '9150889', NULL, '国際日本文化研究センター', '020-011-2', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', '日文研no.42', 2009, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1325, '9150889', NULL, '国際日本文化研究センター', '020-011-3', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', '日文研no.56', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1326, '9150889', NULL, '国際日本文化研究センター', '020-011-4', NULL, false, 'Japanese', NULL, '国際日本文化研究センター', 1, 'IN_USE', '日文研no.60', 2018, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1327, NULL, NULL, 'Matsuda Toshihiko', '020-012-1', NULL, false, 'English', NULL, '国際日本文化研究センター', 1, 'IN_USE', 'Japanese Studies Around The World 2002　Korea Under Japanese Rule - Past and Current Research Results and Issues for Future Research', 2009, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1328, NULL, 'Japanese Studies Around The World 2008　Scholars of Buddhism in Japan: Buddhist Studies in the 21st Century', 'James Baskind', '020-012-2', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', '世界の日本研究2008　日本の仏学者：21世紀の仏学に向けて', 2009, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1329, '9784901558808', 'Japanese Studies Around The World 2015　Contemplating the Humanities through Japanese Studies', '郭南燕&白石恵理', '020-012-3', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', '世界の日本研究2015　「日本研究」を通じて人文科学を考える', 2016, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1330, '9784901558884', 'Japanese Studies Around The World 2017　Japanese Studies from International Perspectives', '郭南燕', '020-012-4', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', '世界の日本研究2017　国際的視野からの日本研究', 2017, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1331, NULL, NULL, 'Jin, Changsoo', '020-013', NULL, false, 'English', NULL, 'Hanul Academy', 1, 'IN_USE', 'Cuurent state of Japanese Studies in Korea', 2007, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1332, NULL, NULL, '国際日本文化研究センター', '020-014', NULL, false, 'Dual lingual', NULL, '国際日本文化研究センター', 1, 'IN_USE', '国際日本文化研究センター要覧２００９', 2009, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1333, NULL, NULL, 'Nara national research institute for cultural properties', '020-015', NULL, false, 'English', NULL, 'Nara national research institute for cultural properties', 2, 'IN_USE', 'Hamlet survey report Duong Lam Village', 2009, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1334, '4901668196', NULL, 'Center for southeast asian studies', '020-016', NULL, false, 'English', NULL, 'Center for southeast asian studies Kyoto university', 1, 'IN_USE', 'International symposium on area informatics and historical studies in Thang Long - Ha Noi', 2005, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1335, NULL, NULL, 'JSPS', '020-017', NULL, false, 'English', NULL, 'JSPS', 1, 'IN_USE', 'Frontline scientific research projects advanced in Japan', 2008, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1336, '4523237', NULL, '国際文化会館', '020-019', NULL, false, NULL, NULL, '国際文化会館', 1, 'IN_USE', '国際文化会館会報 vo.24, no.2, 2013', 2013, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1337, '2852608', NULL, 'International house of Japan', '020-020', NULL, false, NULL, NULL, 'International house of Japan', 1, 'IN_USE', 'International house of Japan bulletin vo.33, no.2, 2013', 2013, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1338, '4002300013', NULL, '田中彰', '020-021-1', NULL, false, 'Japanese', NULL, '岩波書店', 1, 'IN_USE', '日本近代思想大系・開国', 1991, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1339, '4002300196', NULL, '藤林照信', '020-021-2', NULL, false, 'Japanese', NULL, '岩波書店', 1, 'IN_USE', '日本近代思想大系・都市建築', 1990, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1340, '4002300145', NULL, '飯田賢一', '020-021-3', NULL, false, 'Japanese', NULL, '岩波書店', 1, 'IN_USE', '日本近代思想大系・科学と技術', 1989, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1341, '400230020X', NULL, '海野福寿', '020-021-4', NULL, false, 'Japanese', NULL, '岩波書店', 1, 'IN_USE', '日本近代思想大系・家と村', 1989, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1342, '4002300226', NULL, 'ひろたまさき', '020-021-5', NULL, false, 'Japanese', NULL, '岩波書店', 1, 'IN_USE', '日本近代思想大系・差別の諸相', 1990, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1343, '9784130203098', '20th Century East Asia: A New History', '田中明彦、川島真', '020-022-1', NULL, false, 'Japanese', NULL, '東京大学出版会', 1, 'IN_USE', '20世記の東アジア史　I 国際関係史概論', 2020, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1344, '9784130203098', '20th Century East Asia: A New History', '田中明彦、川島真', '020-022-2', NULL, false, 'Japanese', NULL, '東京大学出版会', 1, 'IN_USE', '20世記の東アジア史　II 各国史[1]東北アジア', 2020, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1345, '9784130203098', '20th Century East Asia: A New History', '田中明彦、川島真', '020-022-3', NULL, false, 'Japanese', NULL, '東京大学出版会', 1, 'IN_USE', '20世記の東アジア史　III 各国史[2] 東南アジア', 2020, 2, 2, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1346, NULL, NULL, '隆杉実夫', '030-001', NULL, false, 'Japanese', NULL, '国際協力出版会', 1, 'IN_USE', '共に歩けば', 2002, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1347, NULL, NULL, 'Statistics Bureau', '030-002', NULL, false, 'English', NULL, 'Ministry of Internal Affair and Communications', 1, 'IN_USE', 'Statistical handbook of Japan 2009 ', 2009, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1348, '9780765600820', NULL, 'Tessa Morris-Suzuki', '030-003', NULL, false, 'English', NULL, 'M.E.Sharpe', 1, 'IN_USE', 'Reinventing Japan Time space nation', 1998, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1349, '9784000237635', NULL, '広島大学', '030-004', NULL, false, 'Japanese', NULL, '岩波書店', 1, 'IN_USE', '大学新入生に薦める101冊の本', 2007, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1363, '4770021666', NULL, '朝日新聞論説委員室・朝日イブニングニュース「訳」', '030-005-8', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', 'ベスト・オブ・天音人語', 2006, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1364, '9784770027276', 'The complete illustrated guide to Japanese systems', '安部直文・テッド・高橋', '030-005-9', NULL, false, 'Dual lingual', NULL, '講談社', 2, 'IN_USE', '日本のしくみ', 2007, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1365, '4022195959', NULL, '河合信和', '030-006-1', NULL, false, 'Dual lingual', NULL, '朝日新聞社', 1, 'IN_USE', 'Japan almanac 1995', 1997, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1366, '4022195983', NULL, '河合信和', '030-006-2', NULL, false, 'Dual lingual', NULL, '朝日新聞社', 1, 'IN_USE', 'Japan almanac 1998', 1997, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1367, '9784022196040', '英和対訳データ年鑑2004', '朝日新聞', '030-006-3', NULL, false, 'Dual lingual', NULL, '朝日新聞社', 1, 'IN_USE', 'Japan Almanac 2004', 2003, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1368, NULL, NULL, 'Statistics Bureau　Ministry of Internal Affair and Communications　Japan', '030-007', NULL, false, 'English', NULL, 'Ministry of Internal Affairs and Communications Japan', 1, 'IN_USE', 'Statiscal Handbook of Japan 2010', 2011, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1369, '4818195146', 'Directory of Scientific Research Institutes of University in Japan', NULL, '030-009', NULL, false, 'Japanese', NULL, NULL, 1, 'IN_USE', '大学研究所要覧(2003年版)', 2003, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1370, NULL, NULL, NULL, '040-001-1', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'The Japan foundation 2004: Annual report', 2004, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1371, NULL, NULL, NULL, '040-001-2', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'The Japan foundation 2005: Annual report', 2005, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1372, NULL, NULL, NULL, '040-001-3', NULL, false, 'Japanese', NULL, NULL, 1, 'IN_USE', '国際交流基金 2005年度年報', NULL, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1373, NULL, NULL, NULL, '040-001-4', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'The Japanfoundation 2006 Anual report', 2007, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1374, NULL, NULL, NULL, '040-001-5', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金2006年度年報', 2006, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1375, NULL, NULL, NULL, '040-001-6', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', 'Japan foundation 2007', 2007, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1376, NULL, NULL, NULL, '040-001-7', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', 'The Japan foundation 2009/2010', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1377, NULL, NULL, 'Japan Foundation', '040-001-8', NULL, false, 'Japanese', NULL, 'Japan Foundation', 2, 'IN_USE', 'The  japan foundation 2010/2011', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1378, NULL, NULL, 'Japan Foundation', '040-001-9', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Fiscal 2011-2012 The Japan Foudation Program Guidelines', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1379, NULL, NULL, 'Japan Foundation', '040-001-10', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'The Japan Foundation 2011/2012 Annual Report', 2013, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1380, NULL, NULL, 'JF　－日本語国際センター', '040-002', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '事業報告　－2004', 2005, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1381, NULL, NULL, '国際交流基金', '040-003-1', NULL, false, NULL, NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金バンコック日本語センター・事業評価報告書（1991～2001年）', 2001, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1464, NULL, NULL, '樹 なつみ', '110-014', NULL, false, 'Japanese', NULL, ' 白泉社 ', 4, 'IN_USE', '獣王星', 2006, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1382, NULL, NULL, '国際交流基金', '040-003-2', NULL, false, NULL, NULL, 'Japan Foundation', 1, 'IN_USE', 'タイ国日本語教育研究会第19回年次セミナー・予稿集', 2005, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1383, NULL, NULL, NULL, '040-004-1', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Migration in Asia and Oceania: Towards a Win-Win and WIN scheme for the Origin -Destination Countries and for the Migrants themselves July17-27,2008', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1384, NULL, NULL, NULL, '040-004-2', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Urban Community Development Inspired by Culture: The Potential of Creative Cities July 29-August 7,2008', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1385, NULL, NULL, NULL, '040-004-3', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Overcoming Poverty through a Social Inclusion Approach: The Status quo of Asia and Ocieania in a Globalized Economy　December 9-December 19, 2008', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1386, NULL, NULL, 'Japan Foundation', '040-004-4', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'jenesys east asia future leaders programme 2009 Envirnment: Symbiosis with nature and a sustainable society', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1387, NULL, NULL, 'The Japan Foundation', '040-004-5', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Comprehensive Piecebuilding initiatives of Young leaders in Asia ans Oceania: The Potentials of Culture and Education　March 2-15 2010', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1388, '9784875401285', NULL, 'The Japan Foundation', '040-004-6', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Re-acknowledging Cultural Diversity: Roles and Possibilities in the Asia and Oceania Region April 1-13 2010', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1389, NULL, NULL, 'The Japan Foundation', '040-004-7', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Jenesys East Asia Future Leaders Programme 2010/ Education for subtainable Development', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1390, NULL, NULL, NULL, '040-004-8', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Climate Change Mesure in Asia: A review of Daily Life and Social/Economic Structure', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1391, NULL, NULL, 'Japan Foundation, JENESYS East Asia Future Leaders Programme', '040-004-9', NULL, false, 'English', NULL, 'Japan Foundation', 2, 'IN_USE', 'Disaster Prevention and People: Working Towards the Creation of a Strong Society  From 20 to 31 January, 2011', 2011, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1392, NULL, NULL, 'Japan Foundation', '040-004-10', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Jenesys east asia future leaders programme 2011/2012', 2012, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1393, '9874875401261', NULL, NULL, '040-005-1', NULL, false, NULL, NULL, '国際交流基金ＣＳＲ連携事業', 1, 'IN_USE', 'ベトナムにおける日系企業の社会貢献活動に関する調査報告書', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1394, '9784875401209', NULL, NULL, '040-005-2', NULL, false, NULL, NULL, '国際交流基金ＣＳＲ連携事業', 1, 'IN_USE', '米国における日系企業社会貢献活動に関する調査報告書', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1395, NULL, NULL, NULL, '040-006', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Unity in diversity', NULL, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1396, NULL, NULL, 'Japan Foundation', '040-007', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', 'An Intellectual Dialogue between Japan and the Middle East: In Search of Shared Experiences', 2007, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1397, NULL, 'Beyond Cross-Cultural Diversity', 'Japan Foundation, Waseda University Institute of Asia-Pacific Studies', '040-008', NULL, false, 'English', NULL, 'Japan Foundation', 2, 'IN_USE', 'Towards an East-Asia Community', 2007, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1398, '9784875401070', NULL, 'Kazuo Ogoura', '040-009', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Japan Culture Diplomacy', 2009, 32, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1399, NULL, NULL, 'Japan Foundation', '040-010-1', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Practical Guide to Publishing in Japanー2008', 2008, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1400, NULL, NULL, 'Japan Foundation', '040-010-2', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Practical Guide to Publishing in Japan　2009', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1401, NULL, NULL, 'Japan Foundation', '040-010-3', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Practical Guide to Publishing in Japan　2010', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1402, NULL, NULL, 'Japan Foundation', '040-011-1', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '文化が創る国際平和', 2008, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1403, NULL, NULL, 'Japan Foundation', '040-011-2', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'The Roles of Cultural Activities in Peacebuilding', 2008, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1404, NULL, 'Cross-Cultural Encounters in the Australia-Japan Relationship', 'Japan Foundation', '040-012-1', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'New Voices vol.1', 2006, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1405, NULL, NULL, 'Japan Foundation', '040-012-2', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'New Voices Vol.2', 2008, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1406, NULL, NULL, 'Japan Foundation', '040-013', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'イスラーム文明と日本文明', 0, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1407, NULL, NULL, 'Japan Foundation', '040-014', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', '中東との対話', 0, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1408, NULL, NULL, 'Japan Foundation', '040-015', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Curator meeting', 0, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1409, NULL, '国際交流基金展覧会記録', 'Japan Foundation', '040-016-1', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'The Japan Foundation Exhibition Report 1972-2012', 2013, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1410, NULL, NULL, 'Japan Foundation', '040-016-2', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金展覧会記録 1972-2012', 2013, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1411, '9784568103793', 'The Japan Foundation Traveling Exhibition', 'Japan Foundation', '040-016-3', NULL, false, 'Dual lingual', NULL, 'Japan Foundation', 1, 'IN_USE', 'Winter garden: The exploration of the Micropop imagination in Contemporary Japanese Art', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1412, NULL, NULL, 'Japan Foundation', '040-016-4', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Lê Hoàng Bích Phượng Thay đổi hình dạng', 2012, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1413, NULL, NULL, 'Japan Foundation', '040-017', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', 'ドー・ホアン・ジュウ短編集', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1414, NULL, 'An Overview of Performing Arts and Artists', 'Các tác giả', '040-018', NULL, false, 'English', NULL, 'Japan Foundation', 2, 'IN_USE', 'Theater in Japan', 2008, 22, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1415, NULL, NULL, '財団法人日本国際教育協会', '040-019-1', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '日本語能力試験の概要　2002年版（2001年度試験結果の分析）', 2002, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1416, NULL, NULL, '財団法人日本国際教育協会', '040-019-2', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '日本語能力試験の概要　2003年版（2002年度試験結果の分析）', 2003, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1417, NULL, '日本語教育機関調査2006', NULL, '040-020', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '海外の日本語教育の現状　2006', 2007, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1418, NULL, NULL, NULL, '040-021', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', 'JF 日本語教育スタンダート「試行版」', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1419, NULL, NULL, NULL, '040-022', NULL, false, 'English', NULL, 'Japan Foundation', 1, 'IN_USE', 'Japanese Studies in south and southeast Asia', 2008, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1420, NULL, 'Japanese Studies in Southeast Asia: The Past, Present and Future', NULL, '040-023', NULL, false, 'Dual lingual', NULL, 'Japan Foundation', 1, 'IN_USE', '東南アジアにおける日本研究－過去・現在・将来', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1421, NULL, 'A report on the International Roundtable on the Establishment of Standards for Japanese-Language Eduacation', NULL, '040-024', NULL, false, 'Dual lingual', NULL, 'Japan Foundation', 1, 'IN_USE', '平成17(2005）日本語教育スタンダードの構築をめざす国際ラウンドテーブル・会議録', 2007, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1422, NULL, NULL, '国際交流基金', '040-026-1', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金・日本語教育紀要第1号2005', 2005, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1423, NULL, NULL, '国際交流基金', '040-026-2', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金・日本語教育紀要第2号 2006', 2006, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1424, NULL, NULL, '国際交流基金', '040-026-3', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金・日本語教育紀要第3号', 2007, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1425, NULL, NULL, '国際交流基金', '040-026-4', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金・日本語教育紀要第4号', 2008, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1426, NULL, NULL, '国際交流基金', '040-026-5', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金・日本語教育紀要第5号', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1427, NULL, NULL, '国際交流基金', '040-026-6', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金・日本語教育紀要第6号', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1428, NULL, NULL, '国際交流基金', '040-026-7', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金・日本語教育紀要第7号', 2011, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1429, '13495658', NULL, '国際交流基金', '040-026-8', NULL, false, 'Japanese', NULL, '国際交流基金', 1, 'IN_USE', '国際交流基金・日本語教育紀要第8号', 2012, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1430, NULL, NULL, '国際交流基金', '040-026-9', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金・日本語教育紀要第9号', 2013, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1431, NULL, NULL, '国際交流基金', '040-026-10', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金・日本語教育紀要第10号', 2014, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1432, '13495658', NULL, '国際交流基金', '040-026-11', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金・日本語教育紀要第11号', 2015, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1433, '13495658', NULL, '国際交流基金', '040-026-13', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '国際交流基金・日本語教育紀要第13号', 2017, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1434, NULL, 'Journal of Japanese Language and Culture Vol.6', '国際交流基金日本語国際センター', '040-027-1', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '日本言語文化研究会論集 ー　第6号', 2010, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1435, '18804918', 'Journal of Japanese Language and Culture Vol.7', '国際交流基金日本語国際センター', '040-027-2', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '日本言語文化研究会論集 ー　第7号', 2011, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1436, '18804918', 'Journal of Japanese Language and Culture Vol.8', '国際交流基金日本語国際センター', '040-027-3', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '日本言語文化研究会論集 ー　第8号', 2012, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1437, NULL, NULL, 'Japan Foundation', '040-028', NULL, false, 'Dual lingual', NULL, 'Japan Foundation', 1, 'IN_USE', '国際シンポジウム2005「アジアのキュビスム」報告書', 2006, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1438, NULL, NULL, '住本財団', '040-029', NULL, false, 'Japanese', NULL, '住本財団', 1, 'IN_USE', '住本財団年次報告書2008', 2008, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1439, NULL, NULL, 'ACCU', '040-030', NULL, false, 'English', NULL, 'ACCU', 1, 'IN_USE', 'Meeting of experts on NFE policy and Programme for the promotion of EFA final report Tokyo 11-12 December 2009', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1440, NULL, NULL, 'ACCU&CWDA', '040-031', NULL, false, 'English', NULL, 'ACCU&CWDA', 1, 'IN_USE', 'Smile Asia project 24-26 june 2009 Phnom Penh Cambodia', 2009, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1441, NULL, NULL, '国際交流基金日本語国際センター教師研修チーム', '040-032', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', '「JF日本語教育スタンダード」準拠コース事例集2015−JF講座における実践', 2016, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1442, NULL, NULL, NULL, '040-033', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', 'ベトナムに対する文化交流使節団', 2005, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1443, NULL, NULL, 'Japan Foundation', '040-035', NULL, false, 'Japanese', NULL, 'Japan Foundation', 1, 'IN_USE', 'アジア・大洋州の日本研究事情　2021年度', 2022, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1444, NULL, 'Weaving Ties with the World for 50 Years and Onward - 50th Anniversary', 'Japan Foundation', '040-036-1', NULL, false, 'Japanese', NULL, 'Japan Foundation', 2, 'IN_USE', '世界との絆を紡いで50年そして未来へ - 50th Anniversary', 2022, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1445, NULL, '世界との絆を紡いで50年そして未来へ - 50th Anniversary', 'Japan Foundation', '040-036-2', NULL, false, 'Japanese', NULL, 'Japan Foundation', 2, 'IN_USE', 'Weaving Ties with the World for 50 Years and Onward - 50th Anniversary', 2022, 3, 4, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1446, '4901617001', NULL, 'Kume Kunitake', '090-001-1', NULL, false, 'English', NULL, 'The Japan Documents', 1, 'IN_USE', 'The Iwakura Embassy 1871-73　I　The United States of America', 2002, 43, 6, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1447, '4901617001', NULL, 'Kume Kunitake', '090-001-2', NULL, false, 'English', NULL, 'The Japan Documents', 1, 'IN_USE', 'The Iwakura Embassy 1871-73　II　Britain', 2002, 43, 6, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1448, '4901617001', NULL, 'Kume Kunitake', '090-001-3', NULL, false, 'English', NULL, 'The Japan Documents', 1, 'IN_USE', 'The Iwakura Embassy 1871-73　III　Continental Europe, 1', 2002, 43, 6, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1449, '4901617001', NULL, 'Kume Kunitake', '090-001-4', NULL, false, 'English', NULL, 'The Japan Documents', 1, 'IN_USE', 'The Iwakura Embassy 1871-73　IV　Continental Europe, 2', 2002, 43, 6, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1450, '4901617001', NULL, 'Kume Kunitake', '090-001-5', NULL, false, 'English', NULL, 'The Japan Documents', 1, 'IN_USE', 'The Iwakura Embassy 1871-73　V　Continental Europe, 3; and the Voyage Home', 2002, 43, 6, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1451, NULL, NULL, NULL, '110-001', NULL, false, 'Japanese', NULL, NULL, 28, 'IN_USE', '犬夜叉', NULL, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1452, NULL, NULL, NULL, '110-002', NULL, false, 'Japanese', NULL, NULL, 15, 'IN_USE', 'テニスの王子様', NULL, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1453, NULL, NULL, '五十嵐大介', '110-003', NULL, false, 'Japanese', NULL, 'IKKICOMIX小学館', 4, 'IN_USE', '海獣の子供', 2009, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1454, NULL, NULL, '手塚治虫', '110-004', NULL, false, 'Japanese', NULL, '講談社', 9, 'IN_USE', '鉄腕アトム', 2010, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1455, NULL, NULL, '松本大洋', '110-005', NULL, false, 'Japanese', NULL, 'IKKICOMIX小学館', 4, 'IN_USE', '吾ナンバーファイブ', 2011, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1456, NULL, NULL, '古谷実', '110-006', NULL, false, 'Japanese', NULL, '講談社', 4, 'IN_USE', 'ヒミズ', 2008, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1457, NULL, NULL, '吉田 聡', '110-007', NULL, false, 'Japanese', NULL, ' 小学館', 9, 'IN_USE', 'ちょっとヨロシク!', 1985, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1458, NULL, NULL, 'あしべ ゆうほ', '110-008', NULL, false, 'Japanese', NULL, '秋田書店', 12, 'IN_USE', 'クリスタル☆ドラゴン', 1982, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1459, NULL, NULL, '秋里 和国', '110-009', NULL, false, 'Japanese', NULL, '小学館 ', 10, 'IN_USE', '空飛ぶペンギン', 1991, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1460, NULL, NULL, '秋里 和国', '110-010', NULL, false, 'Japanese', NULL, '小学館 ', 10, 'IN_USE', 'THE B.B.B. ', 1988, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1461, NULL, NULL, '佐々木 倫子', '110-011', NULL, false, 'Japanese', NULL, '小学館', 5, 'IN_USE', 'おたんこナース', 2002, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1462, NULL, NULL, '潮見 知佳', '110-012', NULL, false, 'Japanese', NULL, '秋田書店', 5, 'IN_USE', '獣たちの夜 ', 1996, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1465, NULL, NULL, '毛利 甚八', '110-015', NULL, false, 'Japanese', NULL, '小学館', 3, 'IN_USE', '家栽の人 ', 1988, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1466, NULL, NULL, '宮崎 駿', '110-016', NULL, false, 'Japanese', NULL, '徳間書店', 4, 'IN_USE', '風の谷のナウシカ ', 1990, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1467, NULL, NULL, '宮崎 駿', '110-017', NULL, false, 'Japanese', NULL, '徳間書店', 4, 'IN_USE', 'もののけ姫', 2000, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1468, '9784091233721', NULL, '青山 剛昌　', '110-018', NULL, false, 'Japanese', NULL, '小学館', 10, 'IN_USE', '名探偵コナン', 1994, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1469, '9784063127416', NULL, '綾峰欄人/ 青樹佑夜', '110-019', NULL, false, 'Japanese', NULL, '講談社', 6, 'IN_USE', 'Get　Backers〜奪還屋〜', 2003, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1470, '9784253171281', NULL, '木原敏江', '110-020', NULL, false, 'Japanese', NULL, '秋田文庫', 3, 'IN_USE', 'アンジェリク', 1995, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1471, '9784091883735', NULL, '西島大介', '110-021', NULL, false, 'Japanese', NULL, '小学館', 12, 'IN_USE', 'ディエンビエンフー', 2007, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1472, NULL, NULL, 'あだち 充', '110-022', NULL, false, 'Japanese', NULL, '小学館', 20, 'IN_USE', 'H2', 2000, 4, 7, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1123, NULL, NULL, 'Seimaru Amagi - Yozaburo Kanari', '210-035', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 34, 'IN_USE', 'Thám tử Kindaichi', 2015, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1350, '9784770020819', 'The tales of Miyazawa Kenji', '宮沢賢治・John Bester 「訳」', '030-005-1', NULL, false, 'Dual lingual', NULL, '講談社', 2, 'IN_USE', '英語で話す宮沢賢治短編集', 2008, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1177, NULL, '呪術廻戦', 'Akutami Gege', '210-089', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 10, 'IN_USE', 'Chú Thuật Hồi Chiến', 2022, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1178, NULL, '家庭教師ヒットマンREBORN!', 'Amano Akira', '210-090', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 42, 'IN_USE', 'Gia Sư Hitman Reborn!', 2014, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1179, NULL, 'ドラゴンクエスト列伝 ロトの紋章', 'Fujiwara Kamui & Kawamata Chiaki', '210-091', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 14, 'IN_USE', 'Dragon Quest - Dấu ấn Roto', 2021, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1180, NULL, '地縛少年花子くん', 'Aida Iro', '210-094', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 16, 'IN_USE', '"Cậu" ma nhà xí Hanako', 2022, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1181, NULL, NULL, 'Grolier Incorporated', '010-001-1', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 1 (A to Anjou)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1182, NULL, NULL, 'Grolier Incorporated', '010-001-2', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 2 (Ankara to Azusa)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1183, NULL, NULL, 'Grolier Incorporated', '010-001-3', NULL, false, 'English', NULL, 'Grolier Incorporated', 1, 'IN_USE', 'Encyclopedia Americana 3 (B to Birling)', 1996, 1, 1, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1092, NULL, 'RUROUNI  KENSHIN', NULL, '210-002', NULL, false, NULL, NULL, NULL, 28, 'IN_USE', 'Kiếm khách Kenshin', NULL, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1093, NULL, NULL, NULL, '210-005', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 8, 'IN_USE', 'Sắc lệnh ánh trăng', NULL, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1094, NULL, 'イフリート [断罪の炎人]', 'YOSHIDA Masanori ', '210-006', NULL, false, 'vietnamese', NULL, 'NXB Kim Đồng', 6, 'IN_USE', 'Ifrit - Người Lửa', 2008, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1095, NULL, NULL, 'Adachi Mitsuru', '210-007', NULL, false, 'Japanese', NULL, NULL, 34, 'IN_USE', 'H2', NULL, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1096, NULL, 'Marceau - Jidai Yori Atsuku', 'Yamada Takatoshi', '210-008', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 9, 'IN_USE', 'Mush', 2010, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1097, NULL, 'ドラゴンボール', 'Toriyama Akira', '210-009', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 42, 'IN_USE', 'Dragonball', 2008, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1098, NULL, 'ドラえもん', 'Fujiko F. Fujio', '210-010', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 44, 'IN_USE', 'Đôrêmon', 2008, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1099, NULL, '– サイレン– ', 'Toshiaki Iwashiro', '210-011', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 16, 'IN_USE', 'Psyren', 2009, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1101, NULL, 'キングスウヰーツ 甜品王', 'Hiroto Oishi', '210-013', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 5, 'IN_USE', 'Vua bánh ngọt', 2008, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1102, NULL, 'ワイルドライフ', 'Fujisaki Masato', '210-014', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 27, 'IN_USE', 'Cuộc sống hoang dã', 2006, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1107, NULL, 'タッチ', 'Adachi Mitsuru', '210-019', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 26, 'IN_USE', 'Touch', 2007, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1108, NULL, 'H2', 'Adachi Mitsuru', '210-020', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 34, 'IN_USE', 'H2', 2008, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1110, NULL, '名探偵コナン', NULL, '210-022', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 25, 'IN_USE', 'Conan bộ đặc biệt', NULL, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1037, '9784770040398', 'The tale of Genji', '大和和紀', '120-134', NULL, false, 'English', NULL, '講談社インターナショナル', 1, 'IN_USE', 'あさきゆめみし　星の章　源氏物語', 2013, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1038, '9784063030327', NULL, '桑木砂織', '120-135', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '運命の恋人', 1997, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1039, '9781606993774', NULL, 'Moto Hagio', '120-136', NULL, false, 'English', NULL, 'Fantagraphics', 1, 'IN_USE', 'A Drunken Dream and Other Stories', 2010, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1040, '9784082400552', NULL, '谷口由美子', '120-137', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'マリア・フォン・トラップ　愛と歌声で世界を感動させた家族合唱団の母', 2012, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1100, NULL, '    ', 'Hiroyuki Eto', '210-012', NULL, false, 'Vietnamese', NULL, 'NXB Kim Đồng', 2, 'IN_USE', 'Gadget ', 2010, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1351, '9784770040183', 'Japanese History', NULL, '030-005-10', NULL, false, 'Dual lingual', NULL, '講談社', 2, 'IN_USE', '英語で読む日本史', 2009, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1352, '9784770028815', 'Once Upon a Time in jolly Japan', 'Sayumi Kawauchi, Ralph F. McCarthy', '030-005-11', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', 'まんが日本昔ばなし愉快なお話', 2006, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1353, '9784770023476', 'Once Upon a Time in Ghostly Japan', 'Sayumi Kawauchi, Ralph F. McCarthy', '030-005-12', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', 'まんが日本昔話妖しお話', 2006, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1354, '9784770028419', 'Japan at a glance Updated', NULL, '030-005-13', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', 'イラスト日本まるごと事典', 2006, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1355, '4770021429', 'Discover Japan: Words, Customs and Concepts', '日本文化研究所', '030-005-14', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', 'ニッポン不思議発見！　日本文化を英語で語る50の名エッセイ集', 1997, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1356, '9784770026071', 'The Complete Guide to Traditional Japanese Performing Arts', '日本文化研究所', '030-005-15', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', '英語で話す「日本の伝統芸能」', 2008, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1357, '9784770024022', 'Bushido', '新渡戸稲造・須地徳平「訳」', '030-005-2', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', '英語で話す武士道', 2007, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1358, '9784770021618', 'Talking about Buddhism', '高田佳人・James M.Vardaman「訳」', '030-005-3', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', '英語で話す仏教Q&A', 2008, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1359, '9784770021977', 'Japan as I See it', 'NHK国際局文化プロジェクト・Don Kenny 「訳」', '030-005-4', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', '英語で話す日本の文化', 2007, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1360, '4770028814', 'Once Upon a Time in Japan', 'Sayumi Kawauchi, Ralph F. McCarthy', '030-005-5', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', 'まんが日本昔ばなし', 2006, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1361, '9784770023797', 'The book of tea', '岡倉天心・千宗室・浅野晃「訳」', '030-005-6', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', '茶の本', 2008, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1362, '4770020821', 'Keys to the Japanese Heart and Soul', '英文日本大辞典', '030-005-7', NULL, false, 'Dual lingual', NULL, '講談社', 1, 'IN_USE', '英語で話す日本の心・和英辞典では引けないキーワード197', 2006, 2, 3, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1103, NULL, '焼きたて!! ジャぱん', 'Takashi Hashiguchi', '210-015', NULL, false, 'Vietnamese', NULL, 'NXB Trẻ', 26, 'IN_USE', 'Vua bánh mỳ', 2005, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1104, NULL, 'プラス アニマ', 'Natsumi Mukai', '210-016', NULL, false, 'Vietnamese', NULL, 'NXB Thông tân', 10, 'IN_USE', 'Anima 10+', 2007, 6, 10, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (905, NULL, NULL, '萩尾望都', '120-001', NULL, false, 'Japanese', NULL, '白泉社', 3, 'IN_USE', ' メッシュ', 1994, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (907, NULL, NULL, '西村ミツル・かわすみひろし', '120-003', NULL, false, 'Japanese', NULL, '講談社', 6, 'IN_USE', '大使閣下の料理人', 2005, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (930, '9784062602440', NULL, '坂口尚', '120-026', NULL, false, 'Japanese', NULL, '講談社', 5, 'IN_USE', '石の花', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (940, '9784041851104', NULL, '手塚治虫', '120-036', NULL, false, 'Japanese', NULL, '角川文庫 ', 1, 'IN_USE', '火の鳥  ', NULL, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (950, '9784592177166', NULL, '立野真琴', '120-046', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', '月に吠えろ', 1999, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (990, '9784253174718', NULL, '花郁悠紀子', '120-087', NULL, false, 'Japanese', NULL, '秋田書店 ', 1, 'IN_USE', '四季つづり', 1999, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1000, '404924294-X', NULL, '木原敏江', '120-097', NULL, false, 'Japanese', NULL, '角川書店', 1, 'IN_USE', 'わたしが嫌いなお姐様', 1992, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1001, '9784889912180', NULL, 'けら えいこ', '120-098', NULL, false, 'Japanese', NULL, 'メディアファクトリー', 1, 'IN_USE', 'セキララ結婚生活', 1991, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1002, '9784344014510', NULL, '益田ミリ', '120-099', NULL, false, 'Japanese', NULL, '幻冬舎', 1, 'IN_USE', '結婚しなくていいですか。 ', 2008, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1003, '9784334901684', NULL, '谷口 ジロー', '120-100', NULL, false, 'Japanese', NULL, '光文社', 2, 'IN_USE', '『 歩くひと PLUS 』 THE DIRECTOR’S CUT ', 2010, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1004, NULL, NULL, '大和和紀', '120-101', NULL, false, 'Japanese', NULL, '講談社', 1, 'IN_USE', '月光樹', 1980, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1005, NULL, NULL, '萩尾望都', '120-102', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', '11人いる', 1994, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1006, NULL, NULL, '萩尾望都', '120-103', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'スター・レッド', 1995, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1007, NULL, NULL, '萩尾望都', '120-104', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', '訪問者', 1995, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1008, NULL, NULL, '萩尾望都', '120-105', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'ゴールデンライラック', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1009, NULL, NULL, '萩尾望都', '120-106', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', '怒るべき子どもたち', 1997, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1010, NULL, NULL, '萩尾望都', '120-107', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'フラワー・フェスティバル', 2000, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1011, NULL, NULL, '萩尾望都', '120-108', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', '感謝知らずの男', 2000, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1012, NULL, NULL, '萩尾望都', '120-109', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'ローマへの道', 2000, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1013, NULL, NULL, '萩尾望都', '120-110', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', '完全犯罪フェアリー', 2000, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1015, NULL, NULL, '槇村さとる', '120-112', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', '華のなまえ', 1993, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1016, NULL, NULL, '槇村さとる', '120-113', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'NGダンディー・OKレディ', 1988, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1017, NULL, NULL, '槇村さとる', '120-114', NULL, false, 'Japanese', NULL, '集英社', 2, 'IN_USE', 'ピーナッツ戦線', 2000, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1018, NULL, NULL, '槇村さとる', '120-115', NULL, false, 'Japanese', NULL, '集英社', 2, 'IN_USE', 'コクーン荘1ｘ1', 2002, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1019, NULL, NULL, '槇村さとる', '120-116', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'シンパシー―失われたささやき', 2001, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1020, NULL, NULL, '槇村さとる', '120-117', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'ラブ・ストーリー19XX', 1991, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1021, NULL, NULL, 'さいきなおこ', '120-118', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'レイ二ー・アイズ', 1996, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1022, NULL, NULL, 'さいきなおこ', '120-119', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', '葵学園プレイタイム', 1988, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1023, NULL, NULL, 'さいきなおこ', '120-120', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', '葵学園スノータイム', 1989, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1024, NULL, NULL, 'さいきなおこ', '120-121', NULL, false, 'Japanese', NULL, '集英社', 1, 'IN_USE', 'フラワープロジェクト', 1990, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1025, NULL, NULL, '神坂智子', '120-122', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', 'シルクロード永遠を見る娘', 1990, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1026, NULL, NULL, '神坂智子', '120-123', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', 'シルクロード雪の朝―ホワイトカングリー', 1988, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1027, NULL, NULL, '神坂智子', '120-124', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', 'シルクロードヘディンの手帳', 1987, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1028, NULL, NULL, '神坂智子', '120-125', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', 'シルクロード巻毛のカムシン', 1986, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1029, NULL, NULL, '神坂智子', '120-126', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', 'シルクロード砂漠幻想', 1986, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1030, NULL, NULL, '神坂智子', '120-127', NULL, false, 'Japanese', NULL, '白泉社', 1, 'IN_USE', 'シルクロードゾマの祭り', 1985, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1031, NULL, NULL, '鈴木 由美子', '120-128', NULL, false, 'Japanese', NULL, '講談社', 7, 'IN_USE', '白鳥麗子でございます! ', 1988, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1032, NULL, NULL, '清原なつの', '120-129', NULL, false, 'Japanese', NULL, '集英社', 4, 'IN_USE', '花図鑑', NULL, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1033, '9784091910172', NULL, '萩尾望都', '120-130', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', '半神', 2006, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1034, '9784091910202', NULL, '萩尾望都', '120-131', NULL, false, 'Japanese', NULL, '小学館', 1, 'IN_USE', 'ウは宇宙船のウ', 1997, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1035, '9784770040732', 'Nodame Cantabile', '二ノ宮知子，玉置百合子', '120-132', NULL, false, 'English', NULL, '講談社', 3, 'IN_USE', 'のだめカンタービレ', 2010, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1036, '9784770040404', 'The tale of Genji', '大和和紀', '120-133', NULL, false, 'English', NULL, '講談社インターナショナル', 1, 'IN_USE', 'あさきゆめみし　花の章　源氏物語', 2008, 5, 8, NULL, NULL, NULL);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1473, '9784575515039', ' Chuộc tội', '湊かなえ', '610-501', '双葉文庫によると：
15年前、静かな田舎町でひとりの女児が殺害された。直前まで一緒に遊んでいた四人の女の子は、犯人と思われる男と言葉を交わしていたものの、なぜか顔が思い出せず、事件は迷宮入りとなる。娘を喪った母親は彼女たちに言った──あなたたちを絶対に許さない。必ず犯人を見つけなさい。それができないのなら、わたしが納得できる償いをしなさい、と。十字架を背負わされたまま成長した四人に降りかかる、悲劇の連鎖の結末は!?
黒沢清監督インタビューを特別収録。', false, 'Japanese', NULL, '双葉文庫', 1, 'IN_USE_NOMINATED', '贖罪 ', NULL, 38, 33, NULL, NULL, 67244);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1475, '9786043253269', '', 'Konishi Takashi & Ishikawa Eriko', '320-093', '“”Nè, bố ơi,
Mẹ, mẹ yêu con bố nhỉ?
Hí hí hí
Mẹ rất, rất, rất yêu con bố nhỉ?
Con cũng rất, rất, rất yêu mẹ.
Con thực sự, thực sự, thực sự rất yêu mẹ!””
– Trích trong Lại bị giận rồi!', false, 'Vietnamese', NULL, NULL, 2, 'IN_USE_NOMINATED', 'Lại bị giận rồi!', NULL, 46, 14, NULL, NULL, 59050);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1477, NULL, '', 'Grolier Incorporated', '050-321', '', false, 'Vietnamese', 100000, 'Nhà xuất bản kim đồng', 1, 'IN_USE_NOMINATED', 'Những Đứa Trẻ Bị Mắc Kẹt', NULL, 6, 5, NULL, '878372731371', 67238);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1474, '9786043253245', '', 'Kusunoki Akiko & Ishii Tsutomu', '320-094', '', false, 'Vietnamese', NULL, NULL, 2, 'IN_USE_NOMINATED', 'Bà ơi, không sao đâu!', NULL, 46, 14, NULL, NULL, 67241);
INSERT INTO public.book (id, isbnnumber, alter_name, author, book_position, description, is_borrowed, language, price, publisher, quantity, status, title_name, year_of_publication, category_id, number_id, liquidation_ticket_id, isbn_number, data) VALUES (1478, NULL, '', 'Minato Kanae', '860-498', 'Thi thể nữ nhân viên xinh đẹp của công ty mĩ phẩm nổi tiếng được tìm thấy trong tình trạng cháy đen. Phóng viên tự do Akahoshi bắt đầu lần theo các manh mối, tự mình điều tra để lên bài cho một tuần san.', false, 'Vietnamese', NULL, 'NXB Kim Đồng', 0, 'IN_USE_NOMINATED', 'Án mạng Bạch Tuyết', NULL, 38, 45, NULL, '9786042218672', 67242);


--
-- TOC entry 4962 (class 0 OID 58786)
-- Dependencies: 222
-- Data for Name: book_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.book_category (id, name, note) VALUES (1, 'Bách khoa toàn thư', 'sách từ điển');
INSERT INTO public.book_category (id, name, note) VALUES (2, 'Tổng hợp chung', '');
INSERT INTO public.book_category (id, name, note) VALUES (3, 'Japanese foundation', 'sách giới thiệu vềvề japan foundation');
INSERT INTO public.book_category (id, name, note) VALUES (4, '少年マンガ', 'truyện tranh cho con trai lứa tuổi nhỏ');
INSERT INTO public.book_category (id, name, note) VALUES (5, '少女マンガ', 'truyện tranh cho con gái (lứa tuổi nhỏ), thiếu nữ');
INSERT INTO public.book_category (id, name, note) VALUES (6, 'Truyện tranh nam', '');
INSERT INTO public.book_category (id, name, note) VALUES (7, ' Truyện tranh nữ', '');
INSERT INTO public.book_category (id, name, note) VALUES (8, '青年漫画', 'truyện tranh hướng đến lứa tuổi trưởng thành');
INSERT INTO public.book_category (id, name, note) VALUES (9, 'Sách tranh minh họa tiếng Nhật', '');
INSERT INTO public.book_category (id, name, note) VALUES (10, 'Sách làm cha mẹ', '');
INSERT INTO public.book_category (id, name, note) VALUES (11, 'Trẻ em', '');
INSERT INTO public.book_category (id, name, note) VALUES (12, 'Văn học thiếu nhi (có hình minh họa)', '');
INSERT INTO public.book_category (id, name, note) VALUES (13, 'Ký sự', '');
INSERT INTO public.book_category (id, name, note) VALUES (14, 'Truyện cổ tích', '');
INSERT INTO public.book_category (id, name, note) VALUES (15, 'Truyện thần thoại', '');
INSERT INTO public.book_category (id, name, note) VALUES (16, 'Khác', '');
INSERT INTO public.book_category (id, name, note) VALUES (17, 'Nghệ thuật・Mỹ thuật・Thủ công nghiệp', '');
INSERT INTO public.book_category (id, name, note) VALUES (18, 'Manga - Anime', '');
INSERT INTO public.book_category (id, name, note) VALUES (19, 'Nhiếp ảnh・Thiết kế', '');
INSERT INTO public.book_category (id, name, note) VALUES (20, 'Xây dựng, kiến trúc', '');
INSERT INTO public.book_category (id, name, note) VALUES (21, 'Điện Ảnh', '');
INSERT INTO public.book_category (id, name, note) VALUES (22, 'Sân khấu', '');
INSERT INTO public.book_category (id, name, note) VALUES (23, 'Ẩm thực', '');
INSERT INTO public.book_category (id, name, note) VALUES (24, 'Nghệ thuật Nhật Bản', '');
INSERT INTO public.book_category (id, name, note) VALUES (25, 'Origami', 'Nghệ thuật gấp giấy Nhật Bản');
INSERT INTO public.book_category (id, name, note) VALUES (26, 'Trà đạo', '');
INSERT INTO public.book_category (id, name, note) VALUES (27, 'Phục trang', '');
INSERT INTO public.book_category (id, name, note) VALUES (28, 'Thể thao', '');
INSERT INTO public.book_category (id, name, note) VALUES (29, 'Triết học・Tôn giáo', '');
INSERT INTO public.book_category (id, name, note) VALUES (30, 'Văn hóa・Xã hội', '');
INSERT INTO public.book_category (id, name, note) VALUES (31, 'Lịch sử・Địa lý', '');
INSERT INTO public.book_category (id, name, note) VALUES (32, 'Văn hóa', '');
INSERT INTO public.book_category (id, name, note) VALUES (33, 'Xã hội', '');
INSERT INTO public.book_category (id, name, note) VALUES (34, 'Chính trị・Quan hệ quốc tế', '');
INSERT INTO public.book_category (id, name, note) VALUES (35, 'Kinh tế', '');
INSERT INTO public.book_category (id, name, note) VALUES (36, 'Tiểu luận', '');
INSERT INTO public.book_category (id, name, note) VALUES (37, 'Bài phê bình', '');
INSERT INTO public.book_category (id, name, note) VALUES (38, 'Văn học - tiểu thuyết, truyện ngắn', '');
INSERT INTO public.book_category (id, name, note) VALUES (39, 'Văn học - thơ', '');
INSERT INTO public.book_category (id, name, note) VALUES (40, 'Nghiên cứu văn học', '');
INSERT INTO public.book_category (id, name, note) VALUES (41, 'Ngôn ngữ', '');
INSERT INTO public.book_category (id, name, note) VALUES (42, 'Giáo dục tiếng Nhật', '');
INSERT INTO public.book_category (id, name, note) VALUES (43, 'The Japan Documents', NULL);
INSERT INTO public.book_category (id, name, note) VALUES (44, 'くらもちふさこ', NULL);
INSERT INTO public.book_category (id, name, note) VALUES (45, '少女雑誌', NULL);
INSERT INTO public.book_category (id, name, note) VALUES (46, 'sách minh họa tiếng việt', '');


--
-- TOC entry 4964 (class 0 OID 58795)
-- Dependencies: 224
-- Data for Name: book_class_number; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.book_class_number (id, name) VALUES (1, '010');
INSERT INTO public.book_class_number (id, name) VALUES (2, '020');
INSERT INTO public.book_class_number (id, name) VALUES (3, '030');
INSERT INTO public.book_class_number (id, name) VALUES (4, '040');
INSERT INTO public.book_class_number (id, name) VALUES (5, '050');
INSERT INTO public.book_class_number (id, name) VALUES (6, '090');
INSERT INTO public.book_class_number (id, name) VALUES (7, '110');
INSERT INTO public.book_class_number (id, name) VALUES (8, '120');
INSERT INTO public.book_class_number (id, name) VALUES (9, '140');
INSERT INTO public.book_class_number (id, name) VALUES (10, '210');
INSERT INTO public.book_class_number (id, name) VALUES (11, '220');
INSERT INTO public.book_class_number (id, name) VALUES (12, '290');
INSERT INTO public.book_class_number (id, name) VALUES (13, '310');
INSERT INTO public.book_class_number (id, name) VALUES (14, '320');
INSERT INTO public.book_class_number (id, name) VALUES (15, '330');
INSERT INTO public.book_class_number (id, name) VALUES (16, '340');
INSERT INTO public.book_class_number (id, name) VALUES (17, '360');
INSERT INTO public.book_class_number (id, name) VALUES (18, '370');
INSERT INTO public.book_class_number (id, name) VALUES (19, '390');
INSERT INTO public.book_class_number (id, name) VALUES (20, '410');
INSERT INTO public.book_class_number (id, name) VALUES (21, '420');
INSERT INTO public.book_class_number (id, name) VALUES (22, '430');
INSERT INTO public.book_class_number (id, name) VALUES (23, '450');
INSERT INTO public.book_class_number (id, name) VALUES (24, '470');
INSERT INTO public.book_class_number (id, name) VALUES (25, '480');
INSERT INTO public.book_class_number (id, name) VALUES (26, '490');
INSERT INTO public.book_class_number (id, name) VALUES (27, '510');
INSERT INTO public.book_class_number (id, name) VALUES (28, '520');
INSERT INTO public.book_class_number (id, name) VALUES (29, '530');
INSERT INTO public.book_class_number (id, name) VALUES (30, '540');
INSERT INTO public.book_class_number (id, name) VALUES (31, '550');
INSERT INTO public.book_class_number (id, name) VALUES (32, '590');
INSERT INTO public.book_class_number (id, name) VALUES (33, '610');
INSERT INTO public.book_class_number (id, name) VALUES (34, '620');
INSERT INTO public.book_class_number (id, name) VALUES (35, '690');
INSERT INTO public.book_class_number (id, name) VALUES (36, '710');
INSERT INTO public.book_class_number (id, name) VALUES (37, '720');
INSERT INTO public.book_class_number (id, name) VALUES (38, '730');
INSERT INTO public.book_class_number (id, name) VALUES (39, '740');
INSERT INTO public.book_class_number (id, name) VALUES (40, '790');
INSERT INTO public.book_class_number (id, name) VALUES (41, '810');
INSERT INTO public.book_class_number (id, name) VALUES (42, '820');
INSERT INTO public.book_class_number (id, name) VALUES (43, '830');
INSERT INTO public.book_class_number (id, name) VALUES (44, '850');
INSERT INTO public.book_class_number (id, name) VALUES (45, '860');


--
-- TOC entry 4965 (class 0 OID 58801)
-- Dependencies: 225
-- Data for Name: borrow_book; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4967 (class 0 OID 58807)
-- Dependencies: 227
-- Data for Name: borrow_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4969 (class 0 OID 58817)
-- Dependencies: 229
-- Data for Name: file_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.file_storage (id, associated_entity_id, associated_entity_type, content_type, data, description, extension, name) VALUES (18, 12, 'ImportTicket', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 59045, 'DOCUMENT', 'xlsx', 'Book2');
INSERT INTO public.file_storage (id, associated_entity_id, associated_entity_type, content_type, data, description, extension, name) VALUES (21, 13, 'ImportTicket', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 59048, 'DOCUMENT', 'xlsx', 'Book2');


--
-- TOC entry 4971 (class 0 OID 58827)
-- Dependencies: 231
-- Data for Name: import_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.import_ticket (id, approval_date, approver_note, created_date, creator_note, status, import_way, supplier, total_price, total_quantity, approver_id, creator_id) VALUES (12, '2024-07-11 00:25:35.297655', NULL, '2024-07-11 00:25:35.296655', '', 'ACCEPT', 'mua ', 'fahasa', 400000, 6, 2, 2);
INSERT INTO public.import_ticket (id, approval_date, approver_note, created_date, creator_note, status, import_way, supplier, total_price, total_quantity, approver_id, creator_id) VALUES (13, NULL, NULL, '2024-07-11 07:43:57.089595', '', 'PENDING', 'mua', 'fahasa', 123000, 2, NULL, 3);


--
-- TOC entry 4973 (class 0 OID 58837)
-- Dependencies: 233
-- Data for Name: liquidation_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4956 (class 0 OID 43885)
-- Dependencies: 216
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.notification (id, associated_entity_id, associated_entity_type, associated_user_id, content, created_at, is_read) VALUES (3, 14, 'ImportTicket', 9, 'An import ticket has created. Need to respond', '2024-05-21 18:10:21.009215+07', true);
INSERT INTO public.notification (id, associated_entity_id, associated_entity_type, associated_user_id, content, created_at, is_read) VALUES (4, NULL, 'ImportTicket', 9, 'An import ticket has created. Need to respond', '2024-05-21 21:17:56.72577+07', false);
INSERT INTO public.notification (id, associated_entity_id, associated_entity_type, associated_user_id, content, created_at, is_read) VALUES (1, 13, 'ImportTicket', 11, 'An import ticket has created. Need to respond', '2024-07-11 07:43:57.366119+07', false);


--
-- TOC entry 4975 (class 0 OID 58847)
-- Dependencies: 235
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.permission (id, description, name) VALUES (1, NULL, 'PROFILE.UPDATE');
INSERT INTO public.permission (id, description, name) VALUES (2, NULL, 'ACCOUNT.UPDATE');
INSERT INTO public.permission (id, description, name) VALUES (3, NULL, 'LIQUID.READ');
INSERT INTO public.permission (id, description, name) VALUES (4, NULL, 'BORROW.DELETE');
INSERT INTO public.permission (id, description, name) VALUES (5, NULL, 'ROLE.UPDATE');
INSERT INTO public.permission (id, description, name) VALUES (6, NULL, 'PROFILE.CREATE');
INSERT INTO public.permission (id, description, name) VALUES (7, NULL, 'IMPORT.READ');
INSERT INTO public.permission (id, description, name) VALUES (8, NULL, 'ACCOUNT.CREATE');
INSERT INTO public.permission (id, description, name) VALUES (9, NULL, 'LIQUID.UPDATE');
INSERT INTO public.permission (id, description, name) VALUES (10, NULL, 'BOOK.READ');
INSERT INTO public.permission (id, description, name) VALUES (11, NULL, 'LIQUID.ACCEPT');
INSERT INTO public.permission (id, description, name) VALUES (12, NULL, 'ROLE.CREATE');
INSERT INTO public.permission (id, description, name) VALUES (13, NULL, 'PROFILE.DELETE');
INSERT INTO public.permission (id, description, name) VALUES (14, NULL, 'IMPORT.UPDATE');
INSERT INTO public.permission (id, description, name) VALUES (15, NULL, 'IMPORT.ACCEPT');
INSERT INTO public.permission (id, description, name) VALUES (16, NULL, 'LIQUID.CREATE');
INSERT INTO public.permission (id, description, name) VALUES (17, NULL, 'BORROW.READ');
INSERT INTO public.permission (id, description, name) VALUES (18, NULL, 'BOOK.UPDATE');
INSERT INTO public.permission (id, description, name) VALUES (19, NULL, 'ACCOUNT.DELETE');
INSERT INTO public.permission (id, description, name) VALUES (20, NULL, 'IMPORT.CREATE');
INSERT INTO public.permission (id, description, name) VALUES (21, NULL, 'ROLE.DELETE');
INSERT INTO public.permission (id, description, name) VALUES (22, NULL, 'BORROW.ACCEPT');
INSERT INTO public.permission (id, description, name) VALUES (23, NULL, 'BORROW.UPDATE');
INSERT INTO public.permission (id, description, name) VALUES (24, NULL, 'BOOK.CREATE');
INSERT INTO public.permission (id, description, name) VALUES (25, NULL, 'LIQUID.DELETE');
INSERT INTO public.permission (id, description, name) VALUES (26, NULL, 'BOOK.CHANGE_STATUS');
INSERT INTO public.permission (id, description, name) VALUES (27, NULL, 'PROFILE.READ');
INSERT INTO public.permission (id, description, name) VALUES (28, NULL, 'ACCOUNT.READ');
INSERT INTO public.permission (id, description, name) VALUES (29, NULL, 'BORROW.CREATE');
INSERT INTO public.permission (id, description, name) VALUES (30, NULL, 'IMPORT.DELETE');
INSERT INTO public.permission (id, description, name) VALUES (31, NULL, 'BOOK.DELETE');
INSERT INTO public.permission (id, description, name) VALUES (32, NULL, 'ROLE.READ');


--
-- TOC entry 4977 (class 0 OID 58856)
-- Dependencies: 237
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (3, NULL, 'Bạch mai,Hai Bà Trưng, Ha Noi', '543276548765', 'anh.nn210073@sis.hust.edu.vn', 'Dao Mai Anh', '0983456234', 'LIBRARIAN');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (139, '1994-06-15', '68 Spohn Avenue', '375808866035', 'kgraeme3r@exblog.jp', 'Kitti Graeme', '110-328-8923', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (4, '2004-02-22', '4241 Northwestern Lane', '081683646355', 'wketteringham0@msn.com', 'Wesley Ketteringham', '336-993-7945', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (5, '1992-12-09', '8 Darwin Pass', '940524994032', 'mefford1@themeforest.net', 'Mellisent Efford', '544-200-8118', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (6, '1996-11-04', '50416 North Circle', '373691186733', 'kextal2@nature.com', 'Kyle Extal', '466-566-9519', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (7, '2002-09-23', '9 Ohio Park', '083144120999', 'ssalliss3@cisco.com', 'Silvia Salliss', '910-941-5231', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (8, '1997-01-23', '356 Alpine Road', '215549507608', 'mgolborn4@europa.eu', 'Maxie Golborn', '109-163-3071', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (9, '1994-06-10', '3116 Blaine Hill', '808864099306', 'bgigg5@lycos.com', 'Barbee Gigg', '689-221-3448', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (10, '2002-05-07', '13 Hudson Center', '624217283523', 'agoodricke6@sun.com', 'Alvira Goodricke', '445-557-0470', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (11, '2000-02-23', '3 Mcguire Junction', '309027848828', 'asurgood7@walmart.com', 'Arv Surgood', '489-161-1623', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (12, '1991-08-03', '3 Ridgeview Alley', '399720607373', 'ekittles8@privacy.gov.au', 'Eda Kittles', '363-694-0967', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (13, '1991-06-21', '2 Toban Center', '582487306516', 'cmacghee9@indiatimes.com', 'Chauncey MacGhee', '590-754-1755', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (14, '1997-01-27', '3155 Karstens Place', '044872423885', 'kmacvaugha@mediafire.com', 'Kellen MacVaugh', '588-181-6121', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (15, '1995-06-19', '0 David Junction', '008963737966', 'rsabinb@prlog.org', 'Russ Sabin', '989-353-3514', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (16, '1992-09-13', '3 Debra Hill', '435197807272', 'hsherbournec@lycos.com', 'Happy Sherbourne', '818-165-8668', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (17, '2000-10-04', '93 Hanson Alley', '883707703276', 'psaynord@dell.com', 'Pierson Saynor', '474-419-0415', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (18, '1992-04-06', '16 Aberg Pass', '100099455700', 'bboarde@flavors.me', 'Bob Board', '278-473-0371', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (19, '1997-12-26', '70 Village Park', '127505365436', 'sgrumbridgef@miibeian.gov.cn', 'Susann Grumbridge', '899-922-5404', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (20, '1990-12-22', '99 Anhalt Circle', '757069261165', 'rbycraftg@loc.gov', 'Rhody Bycraft', '564-359-4564', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (21, '1999-09-22', '09626 Sycamore Park', '789124223703', 'ahuntlyh@com.com', 'Angelo Huntly', '754-612-0804', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (22, '1997-10-19', '4740 8th Alley', '789033399990', 'gfeakei@adobe.com', 'Grace Feake', '632-193-8205', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (23, '1990-05-09', '36 Laurel Place', '536389019545', 'esomerfieldj@posterous.com', 'Evered Somerfield', '343-920-5724', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (24, '1991-06-08', '855 Hansons Junction', '690417327727', 'bpavlikk@com.com', 'Basilio Pavlik', '249-143-1559', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (25, '2000-10-20', '18251 Nobel Circle', '223871543796', 'scestardl@hibu.com', 'Stuart Cestard', '760-234-4234', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (26, '1991-07-16', '51273 Caliangt Junction', '188574558277', 'vscothornm@jiathis.com', 'Valentin Scothorn', '860-956-4649', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (27, '2000-01-12', '0121 Pine View Crossing', '624951414646', 'kcausleyn@oracle.com', 'Krysta Causley', '836-202-5675', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (28, '1999-04-18', '08937 Toban Point', '926027638426', 'cabbeso@dmoz.org', 'Consuela Abbes', '257-411-8542', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (29, '2005-08-22', '01 Lotheville Way', '063642558434', 'iwoodgatep@vk.com', 'Ileana Woodgate', '951-248-9573', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (30, '1995-07-06', '95 Bultman Point', '621735030088', 'mronaldq@gmpg.org', 'Mahalia Ronald', '378-933-1666', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (31, '1997-12-10', '210 Tomscot Lane', '066433476877', 'bmatzaitisr@cnbc.com', 'Bartlet Matzaitis', '496-205-0479', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (32, '1999-12-09', '52 Duke Way', '724106821115', 'cdes@dropbox.com', 'Charlotta De Ruggiero', '791-689-2067', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (33, '2001-07-10', '79706 Rockefeller Place', '507798314010', 'chenlont@php.net', 'Creight Henlon', '670-996-3287', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (34, '1997-09-25', '39549 Pleasure Terrace', '819852637606', 'mdroghanu@google.nl', 'Myrtia Droghan', '771-408-0873', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (35, '1996-02-13', '70035 Browning Lane', '009051352169', 'bcannawayv@bravesites.com', 'Bliss Cannaway', '549-870-5779', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (36, '1991-12-05', '6495 Stang Lane', '446307729809', 'trogersonw@twitpic.com', 'Tiffanie Rogerson', '217-439-2695', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (37, '2002-10-12', '8503 Havey Point', '501534682757', 'rnapperx@theatlantic.com', 'Rubia Napper', '939-550-1098', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (38, '2005-12-09', '11 Riverside Trail', '104212280917', 'rflippiniy@shinystat.com', 'Rodge Flippini', '685-315-9969', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (39, '2000-06-06', '3 Norway Maple Terrace', '240575784444', 'jaskenz@drupal.org', 'Joyce Asken', '642-141-7559', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (40, '2005-07-27', '143 Northfield Circle', '192433765261', 'bbeddoe10@uol.com.br', 'Barnaby Beddoe', '186-908-4198', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (41, '2002-09-07', '0035 Tennessee Park', '238577672672', 'mbaudi11@stanford.edu', 'Marguerite Baudi', '156-653-2962', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (42, '1991-10-06', '724 Roth Way', '087743102904', 'hcreelman12@sitemeter.com', 'Hi Creelman', '580-415-8319', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (43, '1995-05-21', '067 Burrows Plaza', '893125230369', 'alynd13@cafepress.com', 'Adorne Lynd', '570-694-5222', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (44, '2004-11-11', '79258 Northfield Street', '321681212987', 'mwrey14@java.com', 'Milli Wrey', '453-143-1504', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (45, '2005-05-10', '6 Boyd Court', '906549951575', 'mgillani15@xing.com', 'Mariquilla Gillani', '264-508-9033', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (46, '1994-02-22', '23652 Main Drive', '859326689186', 'afarlamb16@google.cn', 'Ave Farlamb', '170-623-1781', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (47, '2004-03-31', '0604 Hoepker Junction', '192354363555', 'jchilderhouse17@gravatar.com', 'Janot Childerhouse', '970-142-6720', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (48, '1991-10-15', '47024 Sullivan Crossing', '020228438064', 'abrooks18@businessweek.com', 'Aeriel Brooks', '654-541-1253', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (49, '1993-02-14', '2383 Mayfield Parkway', '987025014802', 'tmaciak19@army.mil', 'Theressa Maciak', '344-272-7937', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (50, '1995-01-03', '7550 Boyd Terrace', '926907529037', 'vkilsby1a@ftc.gov', 'Verena Kilsby', '251-222-1380', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (51, '2005-11-09', '61 Golf Drive', '787658465340', 'hgeaveny1b@elpais.com', 'Helena Geaveny', '204-752-7002', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (52, '1992-02-27', '838 Tennyson Park', '322951163182', 'jstirrip1c@github.com', 'Jania Stirrip', '958-170-0693', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (53, '2002-02-11', '1513 Packers Crossing', '989652303100', 'jshowalter1d@devhub.com', 'Jessi Showalter', '943-876-1254', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (54, '2001-10-13', '5 Mccormick Trail', '475090762608', 'etrencher1e@dell.com', 'Eddy Trencher', '476-200-0517', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (55, '1994-07-11', '1 Moose Road', '290894087139', 'hnorthover1f@china.com.cn', 'Hewitt Northover', '666-229-9347', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (56, '1991-07-30', '273 Vernon Avenue', '816716360697', 'mmela1g@mail.ru', 'Miof mela Andreia', '433-109-4607', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (57, '2004-08-12', '9996 Crest Line Alley', '254214447850', 'ktussaine1h@comsenz.com', 'Kirby Tussaine', '184-694-4376', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (58, '2000-02-24', '0397 Northwestern Alley', '973768375603', 'arounce1i@123-reg.co.uk', 'Appolonia Rounce', '256-298-5527', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (59, '1991-03-08', '550 Prentice Hill', '245180941994', 'ddowding1j@hibu.com', 'Darryl Dowding', '679-317-0343', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (60, '1998-11-20', '36 Bultman Way', '185352756053', 'dsimek1k@bloglovin.com', 'Dinnie Simek', '234-751-3781', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (61, '1999-08-17', '1048 Vidon Way', '349559132329', 'omacnalley1l@blogs.com', 'Oren MacNalley', '641-368-8622', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (62, '1999-05-18', '692 Jenna Circle', '970927873672', 'pchalice1m@wsj.com', 'Pamelina Chalice', '686-600-7195', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (63, '1996-08-11', '56 Northridge Road', '473536099562', 'sathelstan1n@house.gov', 'Sydney Athelstan', '910-748-6189', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (64, '1997-03-06', '500 Montana Way', '315015176033', 'wpargent1o@salon.com', 'West Pargent', '478-546-3849', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (65, '2002-05-25', '6704 Corben Parkway', '358253082512', 'lpetera1p@slashdot.org', 'Luca Petera', '779-541-9929', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (66, '1996-07-25', '0783 Mitchell Street', '174234818156', 'ctimothy1q@ehow.com', 'Carlin Timothy', '992-512-4179', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (67, '2002-09-18', '61 Pleasure Hill', '417341096297', 'aold1r@sogou.com', 'Ade Old', '154-436-7846', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (68, '2005-01-07', '12 Helena Plaza', '807826019206', 'djoannic1s@aboutads.info', 'Dre Joannic', '126-516-2299', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (69, '1992-07-29', '85845 Lindbergh Crossing', '806267031160', 'sgainsborough1t@geocities.jp', 'Sydel Gainsborough', '774-395-9749', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (70, '1995-07-17', '4 Prentice Way', '132212082110', 'ltindle1u@foxnews.com', 'Lenette Tindle', '424-766-1529', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (71, '2003-05-24', '019 Muir Point', '624497483180', 'bfilyakov1v@nymag.com', 'Belicia Filyakov', '921-481-1045', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (72, '1992-07-23', '95 Lillian Place', '330390774107', 'tjarry1w@shutterfly.com', 'Tate Jarry', '180-626-8841', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (73, '1997-01-09', '90831 Harbort Trail', '160143676386', 'cglauber1x@paypal.com', 'Cirilo Glauber', '646-124-2072', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (74, '1993-10-12', '4 Carey Trail', '485350922269', 'educkerin1y@dion.ne.jp', 'Engelbert Duckerin', '336-133-9967', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (75, '1998-02-14', '039 3rd Terrace', '306612953911', 'hcasazza1z@eepurl.com', 'Helen-elizabeth Casazza', '446-311-1389', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (76, '1997-04-25', '586 4th Parkway', '671187183480', 'rnorcop20@ed.gov', 'Renelle Norcop', '795-348-5736', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (77, '2003-04-06', '82 Fulton Street', '770261055193', 'coldcote21@cmu.edu', 'Cecile Oldcote', '551-341-3407', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (78, '1990-05-06', '91 Mcguire Circle', '666380265825', 'idonovan22@washington.edu', 'Irma Donovan', '730-746-1739', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (79, '2001-11-17', '3 Colorado Pass', '520748663725', 'saldie23@si.edu', 'Staford Aldie', '497-158-2334', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (80, '1994-04-25', '34487 Cody Center', '321755855000', 'pyellowlea24@addthis.com', 'Patrice Yellowlea', '806-795-8367', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (81, '1998-01-31', '73 Riverside Avenue', '352482412449', 'egaltone25@pbs.org', 'Elane Galtone', '879-318-9080', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (82, '2002-09-16', '826 Coolidge Center', '609735740901', 'mpotts26@cloudflare.com', 'Mariele Potts', '356-955-6021', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (83, '1999-08-31', '3108 La Follette Parkway', '954180119705', 'gtrenear27@vk.com', 'Gilligan Trenear', '243-413-8790', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (84, '1995-12-29', '0 Londonderry Lane', '437254326727', 'sblakeslee28@imageshack.us', 'Sanderson Blakeslee', '941-455-1446', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (85, '2000-09-14', '4 Hovde Point', '859665494524', 'tabramzon29@tamu.edu', 'Terrye Abramzon', '441-316-8326', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (86, '1998-03-14', '7257 Leroy Trail', '781549732571', 'bmacdonogh2a@etsy.com', 'Briney MacDonogh', '258-998-9994', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (87, '1996-12-28', '88 Lindbergh Drive', '901169044632', 'cdybell2b@zimbio.com', 'Conchita Dybell', '520-181-4763', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (88, '2000-01-02', '62 Morrow Alley', '327625220182', 'jechalie2c@pagesperso-orange.fr', 'Joice Echalie', '650-851-6742', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (89, '2005-03-04', '4884 Westridge Alley', '081202849796', 'tgullen2d@amazonaws.com', 'Thorsten Gullen', '957-931-6327', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (90, '1992-03-10', '98644 Melody Trail', '643546274880', 'ljedraszek2e@state.tx.us', 'Lorain Jedraszek', '934-966-1625', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (91, '2001-10-26', '17 Lien Lane', '707965352207', 'mfriedlos2f@hud.gov', 'Mead Friedlos', '613-902-4742', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (92, '1992-02-11', '439 Homewood Parkway', '046426591412', 'odilgarno2g@webeden.co.uk', 'Oswald Dilgarno', '437-529-9487', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (93, '1996-07-28', '4 Transport Alley', '248574297470', 'fhazeman2h@craigslist.org', 'Fern Hazeman', '168-416-9997', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (94, '1990-04-23', '56125 Continental Hill', '464003241115', 'dmews2i@state.gov', 'Dennison Mews', '656-425-4671', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (95, '1996-07-11', '197 American Place', '122872207547', 'scatherine2j@census.gov', 'Shelby Catherine', '897-288-6552', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (96, '2000-11-23', '895 Old Shore Point', '578892823231', 'achapellow2k@cnbc.com', 'Ardath Chapellow', '876-901-7976', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (97, '1990-02-15', '1 Bowman Court', '674271702954', 'rcayle2l@dion.ne.jp', 'Rourke Cayle', '269-989-2223', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (98, '1996-07-04', '94489 Susan Terrace', '202284644687', 'djendrich2m@princeton.edu', 'Dierdre Jendrich', '100-942-4553', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (99, '1994-01-11', '233 Anthes Center', '652825635929', 'cbier2n@princeton.edu', 'Conny Bier', '776-348-6259', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (100, '1998-10-09', '932 Burrows Trail', '500642251834', 'gbridgeman2o@spiegel.de', 'Gennie Bridgeman', '292-232-4211', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (101, '1998-03-03', '8853 Maple Hill', '714820728904', 'rjowitt2p@1688.com', 'Rodrick Jowitt', '408-366-5860', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (102, '1998-11-30', '079 Troy Lane', '099767506579', 'ewoolerton2q@wired.com', 'Elsa Woolerton', '947-536-2559', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (103, '1990-04-28', '52 Rockefeller Court', '763912600938', 'thearley2r@microsoft.com', 'Tamqrah Hearley', '423-797-0462', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (104, '1996-08-30', '046 Northport Lane', '187232312423', 'idorro2s@wisc.edu', 'Isadora Dorro', '693-262-5223', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (105, '1997-01-10', '5 Montana Plaza', '986191629535', 'nhegges2t@fema.gov', 'Natasha Hegges', '529-410-0619', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (106, '2002-08-29', '86 Karstens Circle', '627830542223', 'jivie2u@sina.com.cn', 'Joellen Ivie', '285-230-8775', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (107, '1998-11-10', '2309 South Way', '337638658039', 'cdjakovic2v@stumbleupon.com', 'Chico Djakovic', '465-707-7703', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (108, '1992-12-04', '572 Maywood Street', '679332837158', 'ospeechley2w@imdb.com', 'Orland Speechley', '290-859-1393', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (109, '2004-12-01', '7 4th Alley', '580611179637', 'asearjeant2x@g.co', 'Alis Searjeant', '609-264-3868', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (110, '1999-07-26', '81 Schiller Trail', '276375957296', 'frevel2y@cafepress.com', 'Farr Revel', '997-319-1328', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (111, '1992-07-17', '26 Manitowish Street', '050264024076', 'abronger2z@histats.com', 'Alexis Bronger', '772-626-0313', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (112, '1995-07-13', '2208 Hauk Place', '018927178142', 'fcamillo30@dedecms.com', 'Felicity Camillo', '250-446-2039', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (113, '1996-02-24', '16004 Onsgard Road', '989935524287', 'scovill31@acquirethisname.com', 'Salvatore Covill', '840-465-1231', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (114, '1996-11-27', '37 Erie Lane', '535300270946', 'racaster32@wisc.edu', 'Rriocard Acaster', '453-309-0959', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (115, '1992-11-29', '27359 Upham Crossing', '921481516165', 'mvarcoe33@taobao.com', 'Mano Varcoe', '904-696-0876', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (116, '1992-09-11', '925 Barby Lane', '547743128734', 'nnudde34@latimes.com', 'Nanine Nudde', '330-236-2634', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (117, '1990-11-03', '257 Farmco Drive', '481632003527', 'bblowin35@google.de', 'Brina Blowin', '363-235-6219', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (118, '2001-03-17', '6032 Arkansas Road', '550912795189', 'mchristensen36@usa.gov', 'Matthias Christensen', '201-214-9362', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (119, '1991-04-25', '0794 Golf Lane', '475802630239', 'layce37@state.tx.us', 'Lorne Ayce', '111-701-0833', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (120, '1998-04-27', '8 Scofield Point', '014526641704', 'mcorrington38@facebook.com', 'Marje Corrington', '365-145-1000', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (121, '1998-05-25', '47 Milwaukee Lane', '358785159191', 'bsexten39@statcounter.com', 'Britney Sexten', '880-378-1567', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (122, '1993-01-01', '926 Village Trail', '865637951468', 'lsmidmor3a@usgs.gov', 'Lilith Smidmor', '631-138-6977', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (123, '2001-11-11', '72388 Prairie Rose Center', '477481912450', 'shaysey3b@moonfruit.com', 'Sawyere Haysey', '835-645-0576', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (124, '1998-06-18', '259 Shelley Terrace', '565293282826', 'gshields3c@huffingtonpost.com', 'Gabbie Shields', '192-723-5199', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (125, '2001-06-08', '22445 Southridge Lane', '487286044399', 'tdarko3d@123-reg.co.uk', 'Tami Darko', '935-403-9648', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (126, '2005-05-21', '03 American Circle', '446869302594', 'blainton3e@nationalgeographic.com', 'Berri Lainton', '783-964-6303', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (127, '1990-11-24', '221 Cascade Avenue', '473155912863', 'akilty3f@godaddy.com', 'Allyson Kilty', '473-691-9539', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (128, '2002-11-13', '49465 Thierer Junction', '396846739105', 'mseear3g@reference.com', 'Marcelle Seear', '667-614-6145', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (129, '1993-08-19', '13903 Kropf Park', '897155391408', 'mgiamo3h@virginia.edu', 'Mord Giamo', '160-118-0004', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (130, '1993-01-26', '27544 Blue Bill Park Plaza', '015909341283', 'lpeatman3i@wiley.com', 'Leilah Peatman', '309-113-7797', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (131, '1992-09-05', '4252 Daystar Road', '845527917570', 'cgilfether3j@spiegel.de', 'Cosimo Gilfether', '446-474-8407', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (132, '2004-01-15', '13595 Bayside Drive', '171104845811', 'wettles3k@wikimedia.org', 'Weider Ettles', '609-974-2028', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (133, '1997-07-08', '4100 Moland Junction', '409584056439', 'cblannin3l@liveinternet.ru', 'Cati Blannin', '995-132-5155', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (134, '1995-06-26', '28021 North Junction', '382150370593', 'kgaliford3m@xing.com', 'Kaila Galiford', '900-464-6999', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (135, '1990-10-21', '283 Eagle Crest Alley', '245938335761', 'rtrask3n@techcrunch.com', 'Reynard Trask', '124-712-9245', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (136, '1999-10-21', '3203 Knutson Pass', '991176973052', 'abrunnstein3o@dyndns.org', 'Althea Brunnstein', '667-737-7840', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (137, '2000-12-10', '4 Huxley Plaza', '157860894290', 'jdriscoll3p@dailymotion.com', 'Jaquenetta Driscoll', '659-137-1022', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (138, '1997-09-28', '676 Ridge Oak Place', '049104380638', 'avasilevich3q@google.com.br', 'Addia Vasilevich', '780-793-5363', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (140, '1995-05-30', '1 Basil Avenue', '268529383145', 'chayes3s@com.com', 'Caryl Hayes', '705-741-6790', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (141, '1998-10-23', '03511 Springview Way', '029678230361', 'bsandys3t@mac.com', 'Blondell Sandys', '563-522-2658', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (142, '1992-11-05', '64 Killdeer Point', '106783332422', 'egeroldini3u@auda.org.au', 'Emalee Geroldini', '892-366-8820', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (143, '1991-02-02', '0 Bunting Terrace', '121908655634', 'tgarlinge3v@house.gov', 'Tabina Garlinge', '948-764-1717', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (144, '1993-01-15', '65758 Dorton Trail', '481376188942', 'bstobbes3w@wufoo.com', 'Barrett Stobbes', '943-548-8672', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (145, '2005-12-16', '1 Graedel Court', '759553866559', 'dmquhan3x@usnews.com', 'Dareen M''Quhan', '808-887-9942', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (146, '1991-07-21', '0931 Chive Alley', '900639164644', 'hvirgo3y@virginia.edu', 'Helen-elizabeth Virgo', '454-188-2206', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (147, '1994-06-08', '0045 Westend Hill', '969412907006', 'apotticary3z@mozilla.org', 'Alisander Potticary', '833-977-6149', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (148, '1999-07-24', '730 Sullivan Point', '456562619223', 'lfernley40@plala.or.jp', 'Lockwood Fernley', '224-507-9385', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (149, '2005-11-17', '6 Mesta Parkway', '300190024133', 'sbostick41@github.com', 'Sunny Bostick', '299-454-0534', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (150, '1994-01-29', '6 Merry Court', '734347756171', 'hmacillrick42@ning.com', 'Henrie MacIllrick', '300-253-2689', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (151, '2000-09-29', '5365 Vernon Way', '065772220220', 'tbruggen43@home.pl', 'Teresita Bruggen', '928-660-6249', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (152, '2002-08-17', '815 Ridgeview Pass', '450306373339', 'pmostin44@gizmodo.com', 'Petronia Mostin', '356-152-7360', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (153, '2000-05-03', '7831 Crescent Oaks Trail', '567332747642', 'gchesterton45@wired.com', 'Gael Chesterton', '120-583-8396', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (154, '1994-04-24', '98344 Walton Park', '262034173422', 'vchildes46@earthlink.net', 'Val Childes', '185-165-3044', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (155, '1998-09-16', '965 Schurz Lane', '897446593950', 'vdionisi47@merriam-webster.com', 'Vern Dionisi', '718-312-6348', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (156, '1998-08-14', '132 Bay Place', '886231077125', 'lproven48@un.org', 'Lowrance Proven', '288-355-4337', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (157, '1991-11-29', '1 Pennsylvania Point', '809689532012', 'cmcnab49@usa.gov', 'Cori McNab', '876-606-9982', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (158, '2000-10-21', '485 Clove Plaza', '620039151756', 'arablen4a@cargocollective.com', 'Amabel Rablen', '189-988-2314', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (159, '2004-12-07', '54 Oxford Street', '264973277608', 'rluxton4b@marketwatch.com', 'Rosanne Luxton', '310-210-8432', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (160, '1991-02-15', '1 Amoth Parkway', '253240685643', 'mjovasevic4c@exblog.jp', 'Maureen Jovasevic', '426-763-5585', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (161, '1991-09-03', '8 6th Court', '315188781392', 'tfishenden4d@ox.ac.uk', 'Tonye Fishenden', '442-284-6318', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (162, '1992-09-28', '517 Colorado Center', '561371730875', 'asawden4e@phpbb.com', 'Audi Sawden', '885-171-6475', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (163, '1995-08-28', '0 Waxwing Trail', '906854622553', 'msowray4f@huffingtonpost.com', 'Mikey Sowray', '305-484-3846', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (164, '1993-12-30', '09248 Orin Lane', '691988473351', 'dferguson4g@etsy.com', 'Diann Ferguson', '702-670-1328', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (165, '2001-12-22', '24602 Melrose Parkway', '589844127410', 'hblaschek4h@diigo.com', 'Hortensia Blaschek', '748-806-6723', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (166, '1990-08-06', '2942 Lien Terrace', '585006690853', 'ikonzelmann4i@wikipedia.org', 'Irene Konzelmann', '971-240-4994', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (167, '1997-04-27', '9 Lerdahl Crossing', '887671658683', 'fbruckshaw4j@symantec.com', 'Freddy Bruckshaw', '301-287-6684', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (168, '1992-10-08', '390 Troy Center', '671526494888', 'rdoghartie4k@nifty.com', 'Redford Doghartie', '623-867-0416', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (169, '1994-12-15', '94 Dorton Junction', '107345035007', 'cbumpas4l@ucla.edu', 'Chandra Bumpas', '380-544-3609', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (170, '1997-01-13', '08 Haas Way', '221982790748', 'kallwell4m@senate.gov', 'Keith Allwell', '728-983-4562', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (171, '1996-07-01', '94 Northwestern Pass', '791230785886', 'ko4n@bbc.co.uk', 'Kerwinn O'' Mara', '916-225-8602', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (172, '1991-11-27', '7105 Duke Court', '507677436240', 'ipentecost4o@deliciousdays.com', 'Isak Pentecost', '485-805-2794', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (173, '1999-09-01', '799 Rusk Parkway', '793904799975', 'ahanselmann4p@multiply.com', 'Almeria Hanselmann', '647-601-3836', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (174, '2000-07-09', '34835 Barby Lane', '631752216435', 'glongwood4q@bing.com', 'Greg Longwood', '121-822-3043', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (175, '2001-05-13', '36 Anzinger Junction', '015178791308', 'hsavile4r@lycos.com', 'Hubey Savile', '622-902-3561', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (176, '1996-09-06', '669 Dunning Crossing', '445834231867', 'agoligly4s@about.me', 'Alethea Goligly', '573-547-0507', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (177, '1999-05-05', '16 Kings Hill', '884633651441', 'ode4t@google.com.br', 'Olav De Benedictis', '717-734-2529', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (178, '1999-06-13', '7 Oakridge Alley', '746769041554', 'dedgeson4u@xing.com', 'Dev Edgeson', '940-472-7691', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (179, '2003-03-05', '48 Maple Wood Circle', '479653398858', 'zvan4v@wix.com', 'Zeke Van Schafflaer', '214-191-4676', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (180, '2004-04-30', '9512 Mockingbird Pass', '088896254861', 'tsommerled4w@g.co', 'Tiler Sommerled', '665-137-7322', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (181, '1993-01-02', '1 Lerdahl Terrace', '930407477475', 'sturle4x@rakuten.co.jp', 'Shaina Turle', '565-463-1371', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (182, '1995-01-25', '27 Express Point', '846146573947', 'gpebworth4y@simplemachines.org', 'Godwin Pebworth', '344-189-7118', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (183, '1991-06-17', '60503 Blue Bill Park Circle', '776268956530', 'eipsly4z@goo.ne.jp', 'Ewart Ipsly', '288-971-9133', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (184, '2005-12-25', '908 Manitowish Avenue', '406026298801', 'smilstead50@princeton.edu', 'Sadye Milstead', '271-426-7685', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (185, '2003-07-08', '2 Kenwood Court', '258419431757', 'aschole51@nyu.edu', 'Alfons Schole', '788-731-0553', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (186, '1994-11-15', '4435 Chinook Way', '325048378522', 'gwinscomb52@ucoz.com', 'Gipsy Winscomb', '128-401-8158', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (187, '1992-07-15', '5 Continental Crossing', '886659270968', 'helt53@archive.org', 'Hersch Elt', '220-913-6189', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (188, '1992-07-30', '8944 Starling Terrace', '296893817782', 'ewesley54@example.com', 'Elbert Wesley', '846-211-1474', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (189, '2001-07-30', '93788 Loftsgordon Court', '177843463249', 'elehrer55@seesaa.net', 'Erinn Lehrer', '725-553-4629', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (190, '1994-05-13', '91 Maywood Court', '766918741857', 'mloudiane56@japanpost.jp', 'Merle Loudiane', '409-147-9034', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (191, '2003-03-11', '46 Troy Way', '648916505069', 'kpumfrey57@fc2.com', 'Katerina Pumfrey', '452-342-2537', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (192, '1999-11-23', '39 Namekagon Way', '856253736840', 'jskyrm58@mashable.com', 'Jillian Skyrm', '635-215-0432', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (193, '2001-11-04', '4106 Macpherson Plaza', '558305721559', 'mdoak59@cargocollective.com', 'Margery Doak', '884-863-0737', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (194, '2001-08-05', '19530 Little Fleur Crossing', '169383286388', 'ngibbins5a@cbc.ca', 'Nick Gibbins', '759-588-1536', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (195, '1994-10-26', '690 Holy Cross Center', '560073495039', 'dnaldrett5b@tmall.com', 'Darn Naldrett', '811-578-1295', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (196, '1999-01-27', '686 Arkansas Junction', '936520433762', 'sbeszant5c@dailymotion.com', 'Selestina Beszant', '790-164-4253', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (197, '1996-12-03', '939 Charing Cross Circle', '079068233848', 'hwooderson5d@slideshare.net', 'Hakeem Wooderson', '555-269-2227', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (198, '1996-04-02', '901 Buena Vista Lane', '059610688936', 'rbuncombe5e@nsw.gov.au', 'Rosalie Buncombe', '287-388-3664', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (199, '2001-09-16', '440 Mallory Circle', '945015712349', 'mbraffington5f@icq.com', 'Martino Braffington', '500-180-0078', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (200, '2005-08-28', '129 Cardinal Parkway', '365506760800', 'sballintime5g@apache.org', 'Seline Ballintime', '107-409-4099', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (201, '1998-03-07', '01467 Columbus Avenue', '227876103855', 'rflorentine5h@nature.com', 'Reuben Florentine', '620-331-8725', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (202, '1991-09-22', '41367 Carpenter Circle', '435755820079', 'ssamways5i@unc.edu', 'Samaria Samways', '335-809-4151', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (203, '2000-06-19', '9690 Gale Center', '293866488342', 'dsego5j@angelfire.com', 'Demetris Sego', '651-981-0792', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (204, '2005-02-27', '80894 Manitowish Street', '140602616825', 'atidbold5k@indiegogo.com', 'Anthiathia Tidbold', '613-674-9305', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (205, '1993-09-11', '484 Gerald Point', '479800135596', 'jscurrey5l@youtu.be', 'Joan Scurrey', '969-645-1897', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (206, '1994-01-02', '041 Badeau Plaza', '379324671080', 'pmoffet5m@marriott.com', 'Paten Moffet', '939-850-5940', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (207, '1991-11-30', '04 Clyde Gallagher Circle', '236601050529', 'dbatcock5n@de.vu', 'Davey Batcock', '568-358-6835', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (208, '1994-10-08', '87 West Parkway', '615975735324', 'gkulas5o@tamu.edu', 'Goldia Kulas', '535-209-1599', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (209, '1998-12-18', '0085 Hollow Ridge Street', '311461442741', 'jfranzen5p@booking.com', 'Jason Franzen', '402-961-1690', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (210, '2004-05-10', '24649 Novick Court', '351224637930', 'kkedie5q@google.ru', 'Kaspar Kedie', '411-990-5977', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (211, '1999-01-30', '81782 Judy Hill', '444618823897', 'mcarren5r@bravesites.com', 'Mil Carren', '394-990-6911', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (212, '1997-08-16', '630 Welch Way', '737846804638', 'fkleine5s@blogger.com', 'Flossy Kleine', '455-275-2589', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (213, '1996-12-09', '466 Jackson Court', '345564215820', 'gpatzelt5t@yellowpages.com', 'Garfield Patzelt', '294-745-5663', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (214, '1992-06-27', '53710 Waywood Court', '265279938987', 'kfallowes5u@bluehost.com', 'Kynthia Fallowes', '989-890-7308', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (215, '1990-11-19', '711 Center Court', '826450352732', 'nheffernon5v@icio.us', 'Nerita Heffernon', '820-557-5468', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (216, '1993-10-25', '9 Moulton Way', '179113505470', 'thartlebury5w@ebay.co.uk', 'Thane Hartlebury', '610-619-1888', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (217, '2003-09-19', '388 Everett Alley', '777370059437', 'dkeneforde5x@wikipedia.org', 'Desmund Keneforde', '990-558-8320', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (218, '2000-05-15', '59 Golf View Way', '101979321645', 'wrobben5y@businessweek.com', 'Wyatan Robben', '281-951-1504', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (219, '2005-05-03', '8 Golf View Way', '016720676968', 'dsoles5z@slideshare.net', 'Devland Soles', '683-923-9141', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (220, '2003-04-24', '92 Texas Terrace', '903240627421', 'estood60@github.com', 'Elfreda Stood', '144-497-6228', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (221, '1993-05-06', '0 Johnson Way', '307073678319', 'fszwandt61@chronoengine.com', 'Feodor Szwandt', '230-896-4375', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (222, '2003-06-22', '1 Emmet Way', '331134169711', 'abiasioni62@usnews.com', 'Amalea Biasioni', '307-953-5850', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (223, '1993-07-19', '666 Main Alley', '014282872915', 'steesdale63@reverbnation.com', 'Sonnie Teesdale', '577-845-8248', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (224, '2002-08-20', '4 Manley Terrace', '442860393113', 'gburry64@nytimes.com', 'Garwin Burry', '259-218-5123', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (225, '1993-12-25', '8 Garrison Pass', '809550609352', 'tprestland65@cornell.edu', 'Tremain Prestland', '312-822-0368', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (226, '1998-06-07', '4852 Mcguire Hill', '937534207651', 'zslayford66@topsy.com', 'Zorine Slayford', '764-183-2424', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (227, '1994-04-03', '9265 Bobwhite Center', '568423192996', 'celliman67@twitpic.com', 'Constantino Elliman', '272-553-2544', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (228, '1991-08-15', '2 Kipling Drive', '805711593251', 'slenox68@yellowbook.com', 'Sheri Lenox', '479-720-4724', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (229, '1999-10-21', '1 Eastlawn Crossing', '519085081865', 'hmattaus69@i2i.jp', 'Hakim Mattaus', '588-760-5504', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (230, '1990-02-05', '1544 Chinook Place', '261968939634', 'aandriesse6a@oaic.gov.au', 'Ada Andriesse', '872-410-1348', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (231, '1993-12-29', '94 Talisman Parkway', '196288056963', 'kgraver6b@admin.ch', 'Karlik Graver', '147-845-2464', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (232, '1991-04-20', '675 Canary Parkway', '884524261901', 'apalmby6c@nationalgeographic.com', 'Alexine Palmby', '188-772-5941', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (233, '2005-10-28', '48 Commercial Junction', '720595129788', 'rprene6d@state.gov', 'Rudolph Prene', '519-518-6258', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (234, '1995-08-05', '4 Hovde Road', '734495421472', 'tventum6e@diigo.com', 'Tammy Ventum', '270-454-4029', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (235, '2003-02-27', '0787 Washington Drive', '886284193242', 'lbeasley6f@cbslocal.com', 'Luciana Beasley', '214-920-5493', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (236, '2000-07-03', '7712 Rieder Drive', '582679199996', 'nmarkson6g@miibeian.gov.cn', 'Nannette Markson', '189-322-3183', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (237, '2003-03-03', '2672 Granby Place', '836512857630', 'pberthelmot6h@trellian.com', 'Prescott Berthelmot', '854-925-9071', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (238, '2003-09-05', '652 School Junction', '764170269482', 'drootes6i@delicious.com', 'Danny Rootes', '255-563-2409', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (239, '1991-12-31', '718 Beilfuss Plaza', '035847007560', 'amccafferky6j@mlb.com', 'Alisander McCafferky', '201-447-0798', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (240, '1990-09-17', '9098 Karstens Circle', '691327324907', 'bmccarrison6k@sourceforge.net', 'Brook McCarrison', '950-755-2833', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (241, '2002-05-17', '0060 Warbler Terrace', '139881254244', 'cbleasdale6l@marketwatch.com', 'Cristiano Bleasdale', '249-960-8791', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (242, '1996-06-10', '51 Londonderry Circle', '626035802398', 'psommerly6m@geocities.jp', 'Price Sommerly', '982-982-6496', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (243, '2004-11-27', '778 Walton Avenue', '108009812666', 'kmcimmie6n@infoseek.co.jp', 'Kathe Mcimmie', '324-119-7857', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (244, '1998-10-10', '66 Rowland Terrace', '224890238442', 'cstorkes6o@i2i.jp', 'Camile Storkes', '536-937-0356', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (245, '1991-12-16', '5 Moulton Road', '036161500616', 'tclarkin6p@bizjournals.com', 'Tabbie Clarkin', '121-949-0895', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (246, '1991-07-06', '5 Anthes Crossing', '114241265581', 'erisso6q@ted.com', 'Emlynne Risso', '303-147-1000', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (247, '1991-05-11', '4263 Coleman Circle', '785645573269', 'gmoret6r@delicious.com', 'Glen Moret', '408-138-5980', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (248, '1992-02-11', '4 Shoshone Trail', '506769078370', 'ylardier6s@blog.com', 'Yolanthe Lardier', '486-273-5281', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (249, '1993-05-11', '15 Anzinger Park', '046077048188', 'jinnis6t@cisco.com', 'Joyan Innis', '220-163-2883', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (250, '2002-07-06', '205 Moulton Place', '661912910841', 'cjeffels6u@yale.edu', 'Cleveland Jeffels', '859-735-7399', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (251, '2002-05-23', '705 Dunning Trail', '180287108927', 'tmixworthy6v@domainmarket.com', 'Torrie Mixworthy', '975-406-1022', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (252, '1991-01-11', '6812 Grasskamp Way', '312994834962', 'kpaulitschke6w@nyu.edu', 'Karoline Paulitschke', '336-371-6778', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (253, '1995-09-05', '896 Lakeland Alley', '789575806276', 'bgeldard6x@friendfeed.com', 'Briana Geldard', '538-851-3578', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (254, '1994-08-18', '7459 Maple Lane', '555460708137', 'ltry6y@europa.eu', 'Lorna Try', '371-165-9749', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (255, '2003-11-26', '8408 Welch Way', '141859567234', 'amyring6z@shinystat.com', 'Ailyn Myring', '538-744-2253', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (256, '1990-12-06', '1 Tony Terrace', '645368704574', 'wclemitt70@weebly.com', 'Wren Clemitt', '998-782-3905', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (257, '1990-08-27', '249 Elgar Alley', '069078594454', 'gbellon71@w3.org', 'Godiva Bellon', '190-819-2480', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (258, '1993-01-12', '35491 Buhler Crossing', '952715474634', 'mbicker72@unesco.org', 'Mauricio Bicker', '242-268-2541', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (259, '1997-11-12', '97317 Muir Plaza', '600100128720', 'cbanat73@apple.com', 'Carl Banat', '183-246-5463', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (260, '1993-07-21', '8805 Melrose Avenue', '724606657955', 'lbelvard74@huffingtonpost.com', 'Lennard Belvard', '345-416-0008', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (261, '1991-03-09', '5 Farwell Junction', '238388355616', 'sskouling75@privacy.gov.au', 'Sophi Skouling', '716-349-0653', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (262, '1998-12-04', '15304 Mosinee Lane', '672292612906', 'irubenovic76@shinystat.com', 'Iggy Rubenovic', '709-908-6046', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (263, '1991-11-05', '63284 Little Fleur Junction', '864104831800', 'alisciandro77@google.de', 'Anderson Lisciandro', '131-757-3057', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (264, '1999-05-31', '27 Grover Terrace', '741203994597', 'wkeeping78@360.cn', 'Wood Keeping', '931-533-3429', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (265, '1993-12-28', '3 Mendota Hill', '073335742564', 'rrawsthorne79@marriott.com', 'Reinwald Rawsthorne', '531-678-4330', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (266, '1998-10-02', '531 Carpenter Center', '120378577286', 'nwoloschinski7a@opensource.org', 'Normy Woloschinski', '282-503-4159', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (267, '2004-03-14', '301 Gerald Junction', '609690457162', 'tfreckelton7b@ebay.com', 'Tabor Freckelton', '303-843-2215', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (268, '1991-09-15', '331 Derek Terrace', '157402964691', 'rmamwell7c@businesswire.com', 'Randy Mamwell', '980-947-9847', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (269, '1999-11-06', '751 Del Mar Avenue', '643400971602', 'spalffy7d@jugem.jp', 'Sylvia Palffy', '529-289-7542', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (270, '1992-05-09', '646 Oakridge Place', '237182249388', 'ckops7e@cnbc.com', 'Clerissa Kops', '316-857-5014', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (271, '1998-01-05', '096 Sunnyside Pass', '485801774371', 'pcalendar7f@angelfire.com', 'Paddie Calendar', '857-466-3992', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (272, '2005-02-26', '4972 North Parkway', '928856017715', 'dbocken7g@arstechnica.com', 'Dara Bocken', '878-155-3337', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (273, '1991-05-20', '542 Macpherson Plaza', '769511051120', 'gbennike7h@telegraph.co.uk', 'Ginelle Bennike', '267-840-6339', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (274, '1992-06-19', '704 Bluejay Crossing', '694260851429', 'churne7i@businessweek.com', 'Cullin Hurne', '915-271-1910', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (275, '2005-01-14', '987 Old Shore Crossing', '671487346214', 'rlohan7j@nydailynews.com', 'Robbie Lohan', '902-599-4717', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (276, '2003-03-17', '137 Cordelia Alley', '961091423481', 'cliggett7k@creativecommons.org', 'Carny Liggett', '891-549-6566', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (277, '1990-03-19', '56 Ramsey Street', '826924450351', 'bgovan7l@vimeo.com', 'Bethanne Govan', '176-946-2984', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (278, '1991-08-03', '2595 4th Street', '825068618617', 'bfeaver7m@dmoz.org', 'Bordie Feaver', '866-438-9739', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (279, '1997-01-25', '0 Canary Court', '021043428857', 'tfaraday7n@usgs.gov', 'Tony Faraday', '546-639-8968', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (280, '1990-12-25', '6827 Iowa Junction', '656609720265', 'jdenisard7o@ebay.co.uk', 'Jamie Denisard', '810-473-2243', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (281, '1992-11-18', '89 Fisk Way', '506098572260', 'lboast7p@boston.com', 'Lu Boast', '840-818-2556', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (282, '2004-03-26', '07 Rowland Road', '025266843507', 'kroose7q@aboutads.info', 'Kylynn Roose', '869-122-9262', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (283, '1999-11-10', '68 Magdeline Point', '108187122474', 'aexeter7r@pcworld.com', 'Artemus Exeter', '217-237-8615', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (284, '1995-04-18', '89 Grayhawk Terrace', '642130813633', 'mbellham7s@google.co.jp', 'Malva Bellham', '240-589-2474', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (285, '1996-06-08', '82420 Kipling Plaza', '678370070236', 'mamaya7t@hatena.ne.jp', 'Mindy Amaya', '782-128-9612', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (286, '1993-12-20', '15753 Village Green Hill', '413280441468', 'jwitcomb7u@about.me', 'Jobyna Witcomb', '373-194-7949', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (287, '1996-09-03', '2 Mccormick Drive', '045292288039', 'krego7v@e-recht24.de', 'Karolina Rego', '524-517-8869', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (288, '1996-07-30', '5988 Truax Alley', '046700504930', 'csmalecombe7w@drupal.org', 'Cathi Smalecombe', '772-415-3096', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (289, '1990-11-02', '278 Sunnyside Park', '286364943045', 'roddie7x@usa.gov', 'Reinwald Oddie', '412-567-6167', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (290, '2004-07-01', '58852 Kinsman Street', '912680876329', 'dschiesterl7y@unesco.org', 'Dolf Schiesterl', '882-835-3473', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (291, '1998-12-01', '271 Golf View Junction', '334842707147', 'thylands7z@devhub.com', 'Trisha Hylands', '611-602-6015', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (292, '1998-12-19', '46 Leroy Point', '796708236955', 'ophysick80@surveymonkey.com', 'Odette Physick', '140-255-3282', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (293, '2002-01-04', '1 Lerdahl Parkway', '352325617583', 'rfelmingham81@deviantart.com', 'Roanne Felmingham', '366-333-7365', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (294, '1995-05-02', '7215 Sunfield Court', '435417710532', 'deckersley82@xing.com', 'Dorelia Eckersley', '241-457-4801', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (295, '1990-03-15', '62516 Lakewood Street', '400590165442', 'wtabbernor83@ocn.ne.jp', 'Wes Tabbernor', '498-653-0849', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (296, '2005-01-29', '63818 Northridge Pass', '712876562555', 'cmandell84@state.gov', 'Carline Mandell', '997-177-3735', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (297, '1998-12-06', '8 Lukken Trail', '172988713975', 'gkesteven85@dot.gov', 'Gabie Kesteven', '539-792-4590', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (298, '1991-11-05', '0 Esker Plaza', '680009241815', 'bprettejohns86@xrea.com', 'Brinn Prettejohns', '707-775-9316', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (299, '2006-02-04', '8522 Oriole Pass', '657776018463', 'lolander87@fda.gov', 'Lynnelle Olander', '581-821-5892', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (300, '2005-03-26', '790 Glacier Hill Avenue', '392813534378', 'hdanels88@comsenz.com', 'Hamid Danels', '360-485-9580', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (301, '1995-05-12', '4103 Eastlawn Trail', '144370253719', 'xdeason89@theatlantic.com', 'Xenos Deason', '579-284-6493', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (302, '1990-05-05', '4025 Corry Place', '591470975035', 'sdulling8a@github.com', 'Stanford Dulling', '510-872-6449', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (303, '1991-12-17', '75 Mariners Cove Terrace', '052365027000', 'tdannehl8b@mail.ru', 'Tony Dannehl', '303-148-1613', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (304, '1995-06-21', '7 Gale Drive', '219472737524', 'gbambrugh8c@hhs.gov', 'Gerrilee Bambrugh', '302-851-2220', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (305, '1992-01-02', '90837 Corscot Plaza', '603396030952', 'aspoerl8d@ox.ac.uk', 'Ardelia Spoerl', '407-109-3278', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (306, '2006-01-31', '00 Forest Run Park', '206265111746', 'mbrogini8e@buzzfeed.com', 'Marylou Brogini', '793-846-4700', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (307, '1993-06-11', '58467 Debs Park', '599637292256', 'mmela8f@whitehouse.gov', 'Miof mela De Meyer', '308-235-9307', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (308, '1990-09-26', '2131 Tennyson Drive', '416509634905', 'kcracknall8g@cbc.ca', 'Katinka Cracknall', '485-954-1922', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (309, '1997-05-23', '42056 Hudson Alley', '575262658677', 'dwase8h@ovh.net', 'Devan Wase', '135-384-9159', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (310, '2000-11-17', '857 Daystar Road', '920629862094', 'aedbrooke8i@hp.com', 'Aprilette Edbrooke', '560-714-6194', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (311, '1990-02-06', '044 Reinke Crossing', '827503084394', 'rdadamo8j@shutterfly.com', 'Rasla D''Adamo', '361-375-8680', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (312, '1997-03-22', '09726 Sauthoff Drive', '469909524450', 'rtorbett8k@xing.com', 'Rivi Torbett', '967-303-3909', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (313, '1994-04-13', '95196 Prentice Drive', '407901790653', 'umidson8l@google.co.jp', 'Una Midson', '998-758-1616', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (314, '1999-02-24', '166 Logan Parkway', '134766302993', 'molyonov8m@columbia.edu', 'Mattias Olyonov', '456-789-7813', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (315, '2006-01-19', '5 Straubel Lane', '142504466422', 'rkelmere8n@about.com', 'Ronna Kelmere', '556-471-9842', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (316, '1998-02-10', '42825 Crownhardt Road', '804775486061', 'shucker8o@wisc.edu', 'See Hucker', '929-184-0651', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (317, '1996-01-10', '1 Weeping Birch Alley', '805899633033', 'fpile8p@reuters.com', 'Franky Pile', '967-945-4122', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (318, '1991-08-12', '5987 Fordem Parkway', '567106683881', 'rtrudgeon8q@surveymonkey.com', 'Raquel Trudgeon', '112-340-2053', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (319, '1994-03-24', '00265 Huxley Terrace', '123746329259', 'calesi8r@cnet.com', 'Cyril Alesi', '860-897-8970', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (320, '1996-02-08', '9 Parkside Pass', '429245419480', 'fgallyon8s@craigslist.org', 'Franny Gallyon', '995-533-5646', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (321, '2002-12-03', '5745 Sutherland Place', '013156839913', 'slucian8t@dailymotion.com', 'Stewart Lucian', '724-482-4741', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (322, '1992-12-05', '9522 Hanover Street', '172527978907', 'iandrys8u@moonfruit.com', 'Irvine Andrys', '571-517-6977', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (323, '1991-03-08', '917 Bluestem Pass', '664529543184', 'ebrowse8v@hibu.com', 'Erin Browse', '513-491-6484', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (324, '2001-10-04', '9 Laurel Center', '542980719251', 'akorlat8w@reuters.com', 'Andonis Korlat', '576-315-6174', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (325, '1992-12-18', '352 Cascade Alley', '430676180909', 'ckuhndel8x@google.nl', 'Ciel Kuhndel', '374-628-5888', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (326, '1995-03-20', '9362 Leroy Trail', '569409624280', 'jelfitt8y@youku.com', 'Janela Elfitt', '365-114-8282', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (327, '2004-05-30', '96471 Hoffman Drive', '229415587983', 'pkirke8z@wikimedia.org', 'Patric Kirke', '680-687-9208', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (328, '2000-02-28', '63 Victoria Park', '083573694434', 'kchasney90@furl.net', 'Kev Chasney', '414-901-9710', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (329, '1995-11-20', '49 Iowa Way', '138375170247', 'hdenisevich91@discovery.com', 'Hort Denisevich', '290-905-5094', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (330, '1997-11-07', '509 David Street', '776667169258', 'fleuren92@cmu.edu', 'Freddie Leuren', '102-919-2335', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (331, '2005-05-23', '630 Arrowood Street', '600998108233', 'tmedeway93@typepad.com', 'Tyne Medeway', '790-323-4441', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (332, '1995-02-11', '6 David Circle', '730903873260', 'bbouller94@icio.us', 'Brit Bouller', '230-309-0858', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (333, '1997-05-21', '57 Morningstar Point', '395123035734', 'cgilchriest95@narod.ru', 'Carlynn Gilchriest', '652-612-4970', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (334, '1991-04-10', '732 Lakewood Gardens Road', '881713116232', 'smeak96@google.com.au', 'Shelbi Meak', '127-315-4679', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (335, '1997-08-22', '98935 Mayfield Center', '534479896986', 'aeger97@dailymail.co.uk', 'Alla Eger', '366-444-9626', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (336, '1998-12-09', '43713 Packers Road', '892689905490', 'morrick98@i2i.jp', 'Malinda Orrick', '864-727-4905', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (337, '1996-09-20', '636 Morning Terrace', '399137545257', 'aricardot99@reddit.com', 'Abbe Ricardot', '489-755-5740', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (338, '1993-01-02', '65 Nelson Park', '401308383619', 'bpickles9a@flickr.com', 'Bernie Pickles', '872-691-8284', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (339, '1993-04-28', '71 Sachtjen Crossing', '734898970374', 'jdoni9b@google.fr', 'Jae Doni', '828-888-6694', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (340, '1996-11-28', '764 Annamark Park', '627228819022', 'odownie9c@usatoday.com', 'Olga Downie', '334-241-3214', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (341, '1997-06-10', '10084 Mockingbird Pass', '299005204842', 'mdudbridge9d@whitehouse.gov', 'Mannie Dudbridge', '900-510-6144', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (342, '2001-03-28', '370 Crownhardt Hill', '425141027231', 'bsiehard9e@seattletimes.com', 'Brooke Siehard', '714-144-4012', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (343, '2004-07-28', '9 Redwing Point', '403040607875', 'khercock9f@digg.com', 'Kiley Hercock', '952-130-8361', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (344, '2001-04-15', '78 Truax Way', '436865098733', 'mjager9g@mtv.com', 'Melany Jager', '681-740-5075', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (345, '2003-03-04', '70343 Hoepker Terrace', '364541437674', 'apetti9h@msu.edu', 'Artur Petti', '315-393-5054', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (346, '1990-01-21', '9 Granby Hill', '157012151327', 'wgwyther9i@aboutads.info', 'Wald Gwyther', '647-491-7167', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (347, '2005-07-31', '4555 Marquette Court', '336734255683', 'kmolan9j@mayoclinic.com', 'Kelbee Molan', '958-675-2520', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (348, '1997-02-11', '0791 Del Mar Circle', '069551328370', 'atrundell9k@shinystat.com', 'Athena Trundell', '985-524-6624', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (349, '2004-05-05', '7824 Hermina Drive', '986284507358', 'bfinker9l@hubpages.com', 'Bendix Finker', '695-802-6458', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (350, '2000-02-07', '9667 Dovetail Road', '407200887014', 'bskurray9m@time.com', 'Bernie Skurray', '972-169-8937', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (351, '1995-01-26', '89 Bluestem Alley', '039877285970', 'emongain9n@bloglovin.com', 'Ernestus Mongain', '771-512-6896', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (352, '1994-12-26', '95326 Stone Corner Circle', '670814337340', 'ntadman9o@tinypic.com', 'Nickolas Tadman', '316-140-6456', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (353, '1997-12-12', '0 Forest Run Park', '727237442997', 'cwyss9p@bloglovin.com', 'Caldwell Wyss', '493-406-2703', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (354, '2001-04-19', '83066 Loeprich Terrace', '280784375101', 'mradnage9q@ow.ly', 'Missie Radnage', '824-635-7250', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (355, '1999-09-26', '641 Loomis Court', '281356234382', 'myoell9r@spiegel.de', 'Merell Yoell', '463-876-2232', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (356, '2002-10-31', '88 Dottie Center', '186823641481', 'bthowes9s@wikia.com', 'Balduin Thowes', '666-532-2346', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (357, '2003-04-03', '4226 Hazelcrest Alley', '798729325241', 'mdashwood9t@craigslist.org', 'Melli Dashwood', '681-690-1537', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (358, '2004-06-26', '25 Dayton Park', '421064442581', 'mcossar9u@tumblr.com', 'Margalit Cossar', '359-370-9917', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (359, '1994-05-15', '52 Ludington Plaza', '729392610901', 'acolton9v@who.int', 'Ardelle Colton', '838-359-5387', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (360, '1999-10-04', '93400 Claremont Plaza', '591394134502', 'jtolotti9w@google.es', 'Jenifer Tolotti', '389-244-7224', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (361, '1990-04-16', '06929 Maple Wood Court', '642160321672', 'gmcsperron9x@netscape.com', 'Gregoire McSperron', '173-207-7571', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (362, '2002-02-11', '54 Scofield Lane', '853716929417', 'nlerner9y@imageshack.us', 'Noe Lerner', '156-608-6435', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (363, '2005-07-03', '1340 Haas Avenue', '618271465956', 'ajaine9z@nydailynews.com', 'Anallise Jaine', '869-364-1468', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (364, '1991-09-12', '4396 Forster Center', '098034761071', 'vlosseljonga0@usnews.com', 'Virgilio Losseljong', '617-551-9629', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (365, '1999-03-05', '8 Erie Hill', '289559855031', 'smetsona1@hostgator.com', 'Sig Metson', '314-197-5791', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (366, '2000-03-02', '37 Hoepker Place', '389028774471', 'rjellymana2@bizjournals.com', 'Reba Jellyman', '727-861-2432', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (367, '2001-01-13', '2432 Bellgrove Avenue', '618164327442', 'mkingshotta3@baidu.com', 'Mollie Kingshott', '228-947-3794', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (368, '2005-12-30', '489 Kinsman Court', '610361242982', 'ntatlowea4@nps.gov', 'Nara Tatlowe', '891-938-9188', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (369, '2002-02-25', '7893 Milwaukee Point', '156805623673', 'mpaffetta5@blinklist.com', 'Molli Paffett', '503-800-3952', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (370, '1992-04-10', '23 School Pass', '229758119170', 'csainta6@hugedomains.com', 'Chadwick Saint', '115-650-1708', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (371, '1995-04-04', '91 Evergreen Parkway', '858366903177', 'eippletta7@apache.org', 'Erinn Ipplett', '202-498-0867', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (372, '1992-06-28', '3491 Pawling Center', '535635945714', 'ajanikowskia8@51.la', 'Ashlie Janikowski', '863-126-1711', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (373, '2005-08-16', '8614 Debs Street', '545523965843', 'rnelanea9@a8.net', 'Rufus Nelane', '708-427-2395', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (374, '1994-09-21', '41629 Arapahoe Hill', '575861894048', 'bgerhtsaa@myspace.com', 'Brock Gerhts', '757-897-2397', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (375, '2002-06-26', '512 Florence Park', '632534139345', 'rspilisyab@nsw.gov.au', 'Russ Spilisy', '863-584-1986', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (376, '1996-12-01', '258 Manitowish Trail', '687879502427', 'jtuffellac@dailymotion.com', 'Joane Tuffell', '272-797-6930', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (377, '1996-07-21', '8 Blue Bill Park Junction', '211645615999', 'rgorgenad@squarespace.com', 'Reynard Gorgen', '955-779-8196', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (378, '2000-11-12', '11 4th Center', '246348893203', 'dbartelsae@biblegateway.com', 'Deerdre Bartels', '636-124-3984', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (379, '1993-01-13', '4 Charing Cross Terrace', '619462208418', 'rbrozssetaf@epa.gov', 'Rosie Brozsset', '305-876-7347', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (380, '2001-03-27', '2 3rd Crossing', '861902901513', 'lmorrantag@wiley.com', 'Leland Morrant', '914-584-6082', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (381, '1995-10-02', '9967 Transport Court', '264933624916', 'spageah@reverbnation.com', 'Shayne Page', '952-259-0980', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (382, '2002-09-15', '14 Hayes Parkway', '327670279254', 'acrathernai@devhub.com', 'Andrus Crathern', '442-165-1655', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (383, '2000-08-02', '0752 Esch Parkway', '210703727595', 'anockoldsaj@sourceforge.net', 'Ashia Nockolds', '912-770-7590', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (384, '2002-04-12', '3 Lotheville Court', '261141199330', 'zrubinekak@omniture.com', 'Zak Rubinek', '759-356-4478', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (385, '1994-05-30', '9 Aberg Alley', '056497818119', 'awarrenderal@t-online.de', 'Abbi Warrender', '954-381-5939', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (386, '2000-04-27', '0326 Stoughton Alley', '504494504179', 'trastallam@time.com', 'Teddy Rastall', '213-282-8252', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (387, '1996-03-03', '91790 Logan Alley', '870375979337', 'gwinterburnan@theglobeandmail.com', 'Gustavo Winterburn', '999-606-3608', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (388, '1996-10-24', '9 Waywood Trail', '249178189584', 'oivanchikovao@dot.gov', 'Osborne Ivanchikov', '319-308-0958', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (389, '1993-01-09', '30 Melrose Crossing', '606928333425', 'lovingtonap@theguardian.com', 'Langston Ovington', '849-184-6466', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (390, '1990-09-03', '76155 Lerdahl Way', '923531660780', 'tashaq@paginegialle.it', 'Thorpe Ash', '438-683-7760', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (391, '2001-08-19', '3 Mallard Street', '817895347396', 'ccrudgear@hhs.gov', 'Clarette Crudge', '841-872-9455', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (392, '2002-09-04', '90476 Rowland Court', '501240082325', 'mhabberjamas@51.la', 'Mendel Habberjam', '993-241-4538', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (393, '1992-04-06', '5658 6th Pass', '484966836697', 'mpettisat@army.mil', 'Marleah Pettis', '641-848-1501', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (394, '1996-12-06', '14408 Talmadge Court', '087573671325', 'atatteshallau@sakura.ne.jp', 'Adam Tatteshall', '649-301-8776', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (395, '1997-09-25', '551 Montana Parkway', '280242303659', 'tbeckwithav@discuz.net', 'Trina Beckwith', '669-646-9169', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (396, '1994-12-11', '76136 Waubesa Street', '673918041630', 'sadamoliaw@usatoday.com', 'Sandro Adamoli', '478-956-2223', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (397, '2003-09-03', '0244 Shelley Plaza', '631582850294', 'tgowenlockax@squidoo.com', 'Tammie Gowenlock', '787-211-4625', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (398, '1998-10-13', '50 Superior Terrace', '431298017921', 'nmiguetay@diigo.com', 'Nealy Miguet', '732-721-4921', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (399, '1996-06-16', '820 Tony Way', '030138545973', 'gsuggettaz@qq.com', 'Gardener Suggett', '462-734-8116', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (400, '2003-02-10', '895 International Junction', '791134933101', 'gwiltsherb0@ow.ly', 'Genevra Wiltsher', '211-569-3777', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (401, '2002-10-25', '43107 Eagle Crest Way', '577631656025', 'mygoub1@free.fr', 'Mahmoud Ygou', '361-352-2021', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (402, '1991-05-22', '1203 Beilfuss Hill', '704939102079', 'cashtonhurstb2@fotki.com', 'Carri Ashtonhurst', '675-868-6573', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (403, '1999-10-02', '748 Parkside Point', '066931408131', 'tpeddarb3@devhub.com', 'Tomasina Peddar', '295-122-8023', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (404, '2002-08-05', '8178 Union Street', '839826421315', 'hallflattb4@senate.gov', 'Hanna Allflatt', '463-835-2373', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (405, '1990-01-22', '9179 Linden Trail', '083623836065', 'rfoggob5@cisco.com', 'Redd Foggo', '321-200-5173', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (406, '1995-10-25', '59 Onsgard Park', '154555324551', 'jmitieb6@gravatar.com', 'Jeremiah Mitie', '902-489-2132', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (407, '1995-07-23', '3651 Spohn Road', '693223195027', 'btoftb7@ted.com', 'Bernadene Toft', '320-311-6645', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (408, '1994-09-10', '6 Maple Parkway', '730524171520', 'maynscombeb8@cpanel.net', 'Malissia Aynscombe', '143-808-1045', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (409, '1992-06-25', '63 Kings Hill', '975925818637', 'aolivellib9@seesaa.net', 'Alic Olivelli', '980-134-9398', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (410, '1992-05-24', '5410 Coolidge Avenue', '310373733320', 'sfairmanba@nsw.gov.au', 'Sutton Fairman', '121-608-4197', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (411, '1995-12-23', '25 Glacier Hill Way', '612256218178', 'ddelanybb@arizona.edu', 'Devon Delany', '653-722-6550', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (412, '1993-06-19', '37052 Riverside Park', '892602329138', 'cbaswallbc@mapy.cz', 'Charlotte Baswall', '966-294-9462', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (413, '1990-06-05', '57814 1st Parkway', '213318054658', 'tsinclairebd@scribd.com', 'Thomasina Sinclaire', '768-141-4516', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (414, '1998-02-24', '7409 Corben Plaza', '697094616996', 'gnouchbe@guardian.co.uk', 'Gabriel Nouch', '525-377-6010', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (415, '2005-08-06', '8 Forest Dale Hill', '691568652627', 'bsemensbf@slashdot.org', 'Blair Semens', '263-760-1626', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (416, '1995-07-09', '1 Helena Parkway', '449703922522', 'swroughtonbg@blog.com', 'Sybille Wroughton', '568-807-6003', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (417, '2003-09-29', '9 Jenna Road', '422122824009', 'thirschmannbh@scientificamerican.com', 'Travers Hirschmann', '643-468-6523', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (418, '1996-12-01', '20337 8th Junction', '215414331510', 'hfiddimanbi@quantcast.com', 'Hanny Fiddiman', '151-566-5021', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (419, '2005-11-29', '7 Onsgard Center', '405616345582', 'lhowsanbj@elegantthemes.com', 'Laure Howsan', '725-581-9613', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (420, '1996-01-01', '61 Monterey Place', '888860481839', 'gburdekinbk@github.io', 'Gerrard Burdekin', '864-207-8213', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (421, '1992-12-09', '93038 Bowman Way', '147426552052', 'secobbl@smh.com.au', 'Sallee Ecob', '231-173-4138', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (422, '1993-09-02', '633 Corscot Center', '608206327549', 'fbeardshallbm@cloudflare.com', 'Fae Beardshall', '361-962-5742', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (423, '1992-01-30', '9563 Florence Place', '125945575669', 'ccleveleybn@mediafire.com', 'Cris Cleveley', '689-189-5837', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (424, '2003-01-05', '690 Anhalt Crossing', '126900201033', 'jshevlinbo@forbes.com', 'Josie Shevlin', '725-961-5210', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (425, '2002-09-08', '11 Merry Plaza', '366480881501', 'sfieldsbp@kickstarter.com', 'Shannen Fields', '666-492-0617', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (426, '1994-07-26', '861 Green Ridge Parkway', '281740384408', 'hdingleybq@facebook.com', 'Hobart Dingley', '254-862-1465', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (427, '1997-12-21', '499 Basil Park', '100369343386', 'mpeekevoutbr@etsy.com', 'Morry Peeke-Vout', '558-980-9741', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (428, '2003-07-24', '2 Dorton Circle', '411444333699', 'bmatthiesenbs@techcrunch.com', 'Bibi Matthiesen', '338-208-1953', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (429, '1998-08-29', '36 Melrose Trail', '350539305076', 'njessettbt@topsy.com', 'Nicholle Jessett', '497-562-9030', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (430, '1990-12-13', '22591 Nevada Trail', '949088030467', 'fmattinglybu@wix.com', 'Flossi Mattingly', '140-979-3897', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (431, '2002-12-13', '66 Elmside Lane', '893992112748', 'simlackebv@narod.ru', 'Stirling Imlacke', '398-876-5282', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (432, '1993-10-28', '5 Johnson Junction', '638832457785', 'vgillbanksbw@umich.edu', 'Val Gillbanks', '198-722-2615', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (433, '1992-06-26', '62401 Colorado Center', '561211180463', 'obrounsellbx@blogs.com', 'Olympia Brounsell', '942-325-6422', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (434, '1990-11-13', '587 Arapahoe Street', '871814622981', 'dkunkelby@google.com.hk', 'Dominica Kunkel', '841-284-5988', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (435, '1996-05-31', '518 Oriole Circle', '917488439936', 'ppendreighbz@businessinsider.com', 'Paulita Pendreigh', '390-184-4997', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (436, '1999-02-20', '7 Pennsylvania Trail', '308082380513', 'jmaccolec0@jigsy.com', 'Jon MacCole', '222-287-5453', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (437, '1999-08-05', '7996 Rigney Street', '014988207436', 'cpierrepointc1@unesco.org', 'Costa Pierrepoint', '478-483-6648', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (438, '2001-03-06', '0 Graceland Court', '524375079286', 'cwegenerc2@constantcontact.com', 'Clarey Wegener', '720-609-1766', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (439, '2003-05-28', '4 Eagle Crest Alley', '204543740378', 'ltomaschkec3@time.com', 'Leeanne Tomaschke', '281-717-0088', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (440, '2005-11-22', '2 1st Hill', '778296661860', 'fmaynardc4@reuters.com', 'Faye Maynard', '851-537-9935', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (441, '2001-08-30', '10 Bartelt Pass', '225041017815', 'mnieselc5@nbcnews.com', 'Meg Niesel', '437-563-7309', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (442, '2004-10-18', '4 Karstens Park', '920821089557', 'mspaffordc6@google.nl', 'Murial Spafford', '318-868-2310', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (443, '1991-02-08', '71 Bellgrove Way', '689788147054', 'wkainec7@go.com', 'Walt Kaine', '898-601-0224', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (444, '2001-10-27', '59 Clyde Gallagher Circle', '640097482245', 'rfarensc8@last.fm', 'Ravi Farens', '402-783-7650', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (445, '1999-10-23', '6 Evergreen Junction', '706237207701', 'rspearmanc9@nba.com', 'Renado Spearman', '629-932-7680', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (446, '1990-04-05', '51019 Eliot Circle', '473979692823', 'nsoigneca@photobucket.com', 'Norah Soigne', '927-596-2101', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (447, '1993-05-17', '46 Northport Hill', '566636691693', 'carnotcb@rambler.ru', 'Christiane Arnot', '411-359-0575', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (448, '2000-03-27', '0 Morrow Plaza', '952241243477', 'dstanelandcc@bbb.org', 'Delmar Staneland', '616-539-8985', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (449, '1991-07-05', '32 Old Gate Terrace', '312576128174', 'agreiswoodcd@cnn.com', 'Adriaens Greiswood', '595-172-4526', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (450, '1998-05-18', '3299 Sage Plaza', '455938834443', 'aragglesce@deliciousdays.com', 'Aubrey Raggles', '540-271-2652', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (451, '2001-10-03', '77 Golden Leaf Drive', '300868708956', 'rlyecf@china.com.cn', 'Randy Lye', '729-660-0868', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (452, '1995-09-19', '42 Dayton Way', '457054185049', 'oklimentyonokcg@eepurl.com', 'Ogdon Klimentyonok', '756-163-0398', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (453, '1996-04-16', '95234 Victoria Alley', '312164952052', 'ajonathonch@chronoengine.com', 'Agnese Jonathon', '538-801-6702', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (454, '1991-02-16', '9134 Ludington Pass', '188082789103', 'jrydingsci@nature.com', 'Jdavie Rydings', '380-545-0880', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (455, '1994-01-02', '39546 Mallard Place', '937771573553', 'ichristoflecj@linkedin.com', 'Ivory Christofle', '599-483-9306', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (456, '1996-10-29', '18 Sloan Avenue', '285678422792', 'gmottonck@ask.com', 'Gaven Motton', '959-259-4753', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (457, '1997-01-03', '151 Summerview Lane', '333093394914', 'eevecl@pcworld.com', 'Eddi Eve', '608-826-3618', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (458, '2002-12-29', '13522 Walton Terrace', '003678494047', 'cmatteaccicm@gravatar.com', 'Crissie Matteacci', '854-234-7953', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (459, '2000-05-08', '074 Thackeray Junction', '112953657852', 'cbellocn@delicious.com', 'Chet Bello', '887-122-8850', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (460, '1998-11-03', '72807 Green Plaza', '040337981097', 'ebernhardtco@storify.com', 'Edita Bernhardt', '530-870-4270', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (461, '2004-03-29', '504 Union Pass', '116440401288', 'bsallowayecp@sohu.com', 'Bobine Sallowaye', '167-410-0381', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (462, '1995-12-18', '7 Dakota Crossing', '259185316231', 'twoodwardcq@blogs.com', 'Thorvald Woodward', '928-384-8136', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (463, '2005-03-11', '976 Meadow Valley Place', '437101205012', 'jabrahamscr@simplemachines.org', 'Judi Abrahams', '360-959-2526', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (464, '1994-08-30', '27870 Chive Avenue', '351677253281', 'mlandacs@illinois.edu', 'Maud Landa', '754-328-6524', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (465, '1993-05-12', '9951 Burning Wood Point', '366411606239', 'ocleaverct@ftc.gov', 'Ofella Cleaver', '739-473-1601', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (466, '2005-10-04', '5 Vidon Crossing', '548296813210', 'hmoulandcu@earthlink.net', 'Hannis Mouland', '502-829-0174', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (467, '1997-04-23', '8829 Dennis Way', '717428872090', 'sisakssoncv@oracle.com', 'Sande Isaksson', '229-548-0093', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (468, '1991-06-12', '460 La Follette Pass', '941015996439', 'tabbottscw@wordpress.com', 'Thorpe Abbotts', '857-381-2264', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (469, '1993-11-02', '7692 Randy Crossing', '832169632768', 'wyezafovichcx@mysql.com', 'Wandis Yezafovich', '123-840-2016', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (470, '1997-10-22', '7 Thackeray Alley', '884920467046', 'aseverncy@intel.com', 'Amery Severn', '866-420-9578', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (471, '1999-02-10', '586 Holy Cross Center', '739090447019', 'kantonomoliicz@abc.net.au', 'Koren Antonomolii', '446-413-0635', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (472, '2002-12-22', '603 Evergreen Terrace', '457167711515', 'ghaggletond0@reference.com', 'Gae Haggleton', '119-339-3734', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (473, '1990-10-13', '01960 International Alley', '677363854471', 'lpavlatad1@1688.com', 'Leda Pavlata', '660-568-3360', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (474, '1994-03-22', '8236 Victoria Point', '762952799146', 'ddorred2@examiner.com', 'Davidson Dorre', '668-712-3809', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (475, '1997-05-13', '261 Buhler Circle', '468637695110', 'kmaccheyned3@patch.com', 'Katine MacCheyne', '607-455-6496', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (476, '2003-03-23', '42 Pierstorff Court', '113365521002', 'mcosted4@facebook.com', 'Mord Coste', '670-522-2707', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (477, '1992-09-24', '186 Fieldstone Circle', '010076959762', 'rferensd5@mtv.com', 'Rosaleen Ferens', '201-674-2747', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (478, '1999-11-22', '3995 Monument Alley', '567524234596', 'amanketelld6@hibu.com', 'Ailene Manketell', '348-592-1312', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (479, '2004-06-20', '000 Becker Point', '177788376336', 'tded7@furl.net', 'Thaddeus De Bruin', '210-993-9573', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (480, '2004-05-06', '14780 Jenna Pass', '495786215026', 'dcastanod8@digg.com', 'Danna Castano', '972-758-4816', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (481, '2002-10-13', '6 Thompson Court', '129224927297', 'cmenid9@nationalgeographic.com', 'Caria Meni', '510-177-4885', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (482, '1995-11-17', '636 Waxwing Pass', '912720703479', 'alawlorda@wp.com', 'Aluin Lawlor', '926-425-2979', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (483, '2000-11-03', '03015 Holy Cross Drive', '547297721305', 'jdimblebeedb@google.ru', 'Jamima Dimblebee', '827-791-5854', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (484, '2000-09-08', '3197 Anzinger Parkway', '738702522550', 'wpinndc@tripadvisor.com', 'Warde Pinn', '158-946-9902', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (485, '2005-10-13', '9 Scoville Pass', '133770865871', 'efletcherdd@reverbnation.com', 'Eachelle Fletcher', '428-879-2955', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (486, '2003-06-21', '05 Arizona Court', '520312740000', 'wkumaarde@amazon.com', 'Walden Kumaar', '702-604-4295', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (487, '1998-10-24', '790 Lakeland Point', '329773696451', 'apinchbackdf@squidoo.com', 'Astrid Pinchback', '125-104-9364', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (488, '2002-09-16', '95569 Fairfield Park', '929009165670', 'jfulcherdg@craigslist.org', 'Jocelyn Fulcher', '151-971-9979', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (489, '1990-03-10', '5 Shasta Crossing', '457435961993', 'aopferdh@intel.com', 'Alden Opfer', '916-956-8821', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (490, '2005-03-19', '3 Waywood Drive', '289566647870', 'ggetleydi@gizmodo.com', 'Guilbert Getley', '991-980-9380', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (491, '1992-01-06', '8 Merry Court', '770707255346', 'bshatliffedj@vimeo.com', 'Bobbie Shatliffe', '114-484-1957', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (492, '1993-01-20', '53349 Oak Circle', '834839649210', 'lcorkelldk@mapy.cz', 'Luciano Corkell', '127-115-9706', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (493, '1994-03-26', '48425 Bunting Park', '218958866433', 'kwilmutdl@alexa.com', 'Kara-lynn Wilmut', '851-512-5994', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (494, '1992-06-21', '6 Anniversary Center', '620978341180', 'plackintondm@multiply.com', 'Padgett Lackinton', '442-365-1910', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (495, '2004-05-01', '3 Golf Drive', '770938583268', 'agoulleedn@gravatar.com', 'Amabelle Goullee', '960-504-5591', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (496, '2005-01-18', '59257 Manitowish Hill', '117803460886', 'fburchalldo@live.com', 'Filip Burchall', '832-326-3829', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (497, '1995-08-16', '3644 Lawn Trail', '705154970800', 'churringdp@loc.gov', 'Clark Hurring', '448-844-7813', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (498, '1994-10-13', '5094 Sage Trail', '724032645903', 'ryashnovdq@time.com', 'Raeann Yashnov', '197-626-5499', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (499, '1992-11-06', '0468 Thierer Trail', '670814026183', 'jwarnerdr@nasa.gov', 'Judas Warner', '481-263-0088', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (500, '2003-10-23', '586 High Crossing Road', '789371348136', 'messameds@gnu.org', 'Matias Essame', '691-539-6084', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (501, '1998-11-16', '39774 Gale Plaza', '691106107777', 'dsurplicedt@domainmarket.com', 'Donielle Surplice', '120-857-8387', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (502, '1998-06-04', '33398 Sundown Circle', '789023832709', 'iferbrachedu@state.tx.us', 'Ilysa Ferbrache', '766-371-0511', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (503, '1995-09-15', '5 Ruskin Crossing', '277622414526', 'bbrambelldv@fda.gov', 'Barbabra Brambell', '921-196-1240', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (504, '2003-07-06', '017 Thompson Plaza', '256671905870', 'jlappinedw@ebay.com', 'Jonathon Lappine', '863-506-1692', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (505, '1991-12-27', '3 Leroy Alley', '021971485490', 'bmittendx@alibaba.com', 'Brenn Mitten', '811-606-2065', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (506, '1996-04-04', '647 2nd Lane', '096374670787', 'faldingtondy@craigslist.org', 'Flem Aldington', '184-151-2481', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (507, '1994-05-07', '2636 Merry Circle', '242866920098', 'jcogledz@hugedomains.com', 'Janaye Cogle', '627-158-7742', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (508, '1992-06-01', '19682 Comanche Terrace', '480841175568', 'khanscombee0@mtv.com', 'Kirstyn Hanscombe', '669-763-7300', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (509, '2004-10-02', '20157 Hooker Avenue', '136849507224', 'twhiteheade1@hud.gov', 'Tamara Whitehead', '629-503-9112', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (510, '2000-01-02', '022 Manley Park', '686929672063', 'rfinnigane2@freewebs.com', 'Rockwell Finnigan', '750-536-2605', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (511, '2001-07-28', '0101 Nova Junction', '822587041491', 'hmateose3@angelfire.com', 'Harley Mateos', '138-373-5275', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (512, '2001-02-24', '48973 Colorado Center', '919406661364', 'vmcgluee4@ehow.com', 'Vitoria McGlue', '205-227-6709', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (513, '2006-01-20', '62 Bellgrove Place', '269864532221', 'acamouse5@1und1.de', 'Allix Camous', '101-420-0642', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (514, '2005-02-23', '335 Sutteridge Avenue', '018103525278', 'epoonee6@mac.com', 'Etienne Poone', '526-216-7089', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (515, '2005-09-19', '03787 Vera Lane', '160196732012', 'amelhuishe7@google.com.br', 'Arlene Melhuish', '644-586-8796', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (516, '1997-09-04', '82 Service Circle', '527256963949', 'brenzinie8@epa.gov', 'Betti Renzini', '304-465-9989', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (517, '1995-02-12', '801 Longview Circle', '322192622079', 'hcasarie9@uiuc.edu', 'Hersh Casari', '928-882-0353', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (518, '2005-07-22', '206 Bellgrove Trail', '595575605314', 'kdillingerea@deviantart.com', 'Kyle Dillinger', '841-151-0883', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (519, '2004-05-31', '35 Hansons Hill', '353113131952', 'lhephereb@google.co.jp', 'Letitia Hepher', '735-344-2331', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (520, '1996-09-07', '6 Wayridge Way', '748490031941', 'jlakerec@jigsy.com', 'Jennie Laker', '919-125-2066', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (521, '1990-11-13', '7 Muir Pass', '483499303530', 'gvondrysed@dailymotion.com', 'Gabbie Vondrys', '123-581-7976', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (522, '1993-07-25', '9 Lunder Center', '570420267622', 'tantonoyevee@fotki.com', 'Tildi Antonoyev', '266-774-3544', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (523, '1990-08-03', '2 Arkansas Crossing', '497544519603', 'tmillikenef@eepurl.com', 'Torrance Milliken', '380-842-3298', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (524, '1998-08-16', '4 Westport Trail', '198637676219', 'arichfieldeg@de.vu', 'Ansell Richfield', '376-387-3051', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (525, '1990-10-01', '69948 Nelson Point', '566840791454', 'wsilversmidteh@wikipedia.org', 'Woodman Silversmidt', '992-566-5012', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (526, '1992-02-22', '26767 6th Crossing', '412933171241', 'dashbyei@a8.net', 'Denver Ashby', '212-245-3417', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (527, '1991-12-20', '3911 Westport Place', '103432757337', 'mpunchardej@vkontakte.ru', 'Mortimer Punchard', '997-526-0810', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (528, '2003-05-11', '8067 Crescent Oaks Avenue', '494930120522', 'fferrettinoek@guardian.co.uk', 'Farrell Ferrettino', '913-224-3981', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (529, '1991-01-28', '89 American Ash Pass', '265649011268', 'ashurrocksel@epa.gov', 'Adrian Shurrocks', '583-120-5372', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (530, '2003-04-08', '47 Helena Plaza', '558767230853', 'ssquelchem@cmu.edu', 'Shermie Squelch', '738-371-7521', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (531, '2004-01-16', '424 Macpherson Lane', '359756454929', 'dcausbeyen@usa.gov', 'Dane Causbey', '130-108-0889', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (532, '1995-09-05', '52230 David Drive', '668407886733', 'isowdeneo@usda.gov', 'Idalia Sowden', '455-680-5379', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (533, '2003-06-07', '4510 Gina Pass', '193648909614', 'mbarkesep@flickr.com', 'Maximo Barkes', '774-816-0949', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (534, '2002-01-25', '84766 Buell Circle', '357482418256', 'edebrickeq@cmu.edu', 'Eydie Debrick', '646-419-1536', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (535, '1992-12-31', '4 Butterfield Park', '102429840348', 'nfilinkover@uol.com.br', 'Nanon Filinkov', '638-590-5981', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (536, '2001-07-20', '4 Cardinal Pass', '704158134498', 'djadoses@ebay.com', 'Dix Jados', '390-715-9649', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (537, '2003-05-21', '352 Duke Place', '394989699604', 'abaggarleyet@woothemes.com', 'Artie Baggarley', '928-695-7305', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (538, '1993-10-26', '71 Brickson Park Road', '105179202579', 'sbiswelleu@cnet.com', 'Steffie Biswell', '902-648-2178', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (539, '1990-10-20', '335 Ronald Regan Court', '958653111873', 'cleggonev@themeforest.net', 'Clerkclaude Leggon', '816-175-5501', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (540, '1997-12-09', '666 Myrtle Terrace', '015097669116', 'mbiersew@psu.edu', 'Madison Biers', '145-478-3644', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (541, '1998-08-10', '31 Nevada Crossing', '752990318221', 'rapfelmannex@cafepress.com', 'Rochell Apfelmann', '530-903-0402', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (542, '2005-03-05', '1792 Muir Park', '089689036463', 'mmacneilleyey@cocolog-nifty.com', 'Megan MacNeilley', '725-979-2004', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (543, '1991-10-19', '64012 Spohn Avenue', '011634490607', 'wmerricksez@reverbnation.com', 'Walther Merricks', '786-950-5301', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (544, '2000-05-01', '9 Fremont Circle', '574110199578', 'dgyrgorcewicxf0@arstechnica.com', 'Dacy Gyrgorcewicx', '888-223-1034', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (545, '1996-04-24', '62 Forest Run Terrace', '846719745937', 'gtearnyf1@homestead.com', 'Gay Tearny', '849-296-4430', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (546, '1990-07-19', '210 Katie Lane', '549293034663', 'aalfonzof2@eventbrite.com', 'Averyl Alfonzo', '579-749-4132', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (547, '1995-09-06', '666 Di Loreto Way', '142496169577', 'bkorpalf3@unc.edu', 'Blake Korpal', '646-747-4383', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (548, '2000-10-03', '93292 Rigney Pass', '377661610733', 'fabdeyf4@tumblr.com', 'Felizio Abdey', '835-143-2567', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (549, '2004-10-30', '387 Swallow Lane', '856742118867', 'jscroxtonf5@lulu.com', 'Jephthah Scroxton', '395-763-4085', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (550, '2001-06-07', '7 Wayridge Avenue', '201368170984', 'ccarillof6@skyrock.com', 'Chryste Carillo', '600-332-6558', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (551, '1993-07-12', '84 Bay Parkway', '143429854701', 'jbedberryf7@cisco.com', 'Jacklyn Bedberry', '153-549-2353', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (552, '1996-03-27', '5 Lunder Center', '111416784185', 'gphilipeauxf8@cornell.edu', 'Godfree Philipeaux', '317-951-0271', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (553, '1997-01-09', '75963 Goodland Lane', '779742700308', 'mclampettf9@cbslocal.com', 'Milo Clampett', '402-814-9167', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (554, '2001-09-15', '930 Birchwood Trail', '100150116469', 'qmacterrellyfa@techcrunch.com', 'Quintana MacTerrelly', '909-728-1341', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (555, '1993-02-14', '4 Westport Trail', '190603934011', 'jpatriefb@fc2.com', 'Jodee Patrie', '539-753-8399', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (556, '1991-01-26', '51831 Aberg Junction', '435569440043', 'babreheartfc@sourceforge.net', 'Basil Abreheart', '783-215-5561', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (557, '1992-11-06', '6246 Mariners Cove Park', '875887807757', 'gpopplewellfd@wunderground.com', 'Gale Popplewell', '198-397-0810', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (558, '2003-09-29', '9977 Victoria Junction', '562435900183', 'hodoneganfe@tripod.com', 'Heall O''Donegan', '438-926-7414', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (559, '1999-11-13', '07962 Becker Drive', '122884155300', 'mflaggff@reuters.com', 'Maggee Flagg', '458-506-7252', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (560, '2003-07-23', '891 Vermont Trail', '351783812006', 'mdimmickfg@amazonaws.com', 'Mario Dimmick', '102-738-1731', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (561, '2005-06-12', '4 Arrowood Drive', '533017915660', 'vmcsheafh@harvard.edu', 'Valida McShea', '588-788-0026', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (562, '1999-07-06', '46 Green Road', '291987676709', 'eeneferfi@nature.com', 'Elsy Enefer', '315-699-5152', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (563, '2004-04-10', '7 Bellgrove Terrace', '530107947361', 'fabbeyfj@cnet.com', 'Finn Abbey', '951-890-9176', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (564, '1994-10-03', '4 Scofield Terrace', '030658336443', 'swemmfk@ocn.ne.jp', 'Spenser Wemm', '715-955-5064', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (565, '1999-05-01', '9 Little Fleur Avenue', '297932293228', 'fmacpeakefl@spiegel.de', 'Fonsie MacPeake', '566-763-1079', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (566, '1992-09-24', '67 Randy Court', '571934982470', 'asilsonfm@creativecommons.org', 'Aharon Silson', '619-476-4880', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (567, '1993-03-02', '6442 Badeau Drive', '466829362830', 'gaikettfn@kickstarter.com', 'Gina Aikett', '327-787-8460', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (568, '1998-01-25', '0 Bay Trail', '562551792261', 'rleestutfo@reverbnation.com', 'Ramona LeEstut', '263-757-3554', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (569, '2000-05-12', '571 Anhalt Drive', '246700494589', 'skilliamfp@si.edu', 'Sandye Killiam', '759-890-6715', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (570, '2002-04-04', '1 Schlimgen Drive', '105392296473', 'asarfattifq@google.com.hk', 'Ashton Sarfatti', '236-181-4750', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (571, '1992-08-21', '790 South Terrace', '803833241932', 'ntrewfr@csmonitor.com', 'Noelyn Trew', '529-649-9587', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (572, '2003-08-05', '258 Briar Crest Circle', '138055652690', 'cbaudouxfs@cornell.edu', 'Chelsie Baudoux', '677-972-7724', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (573, '2001-03-17', '3174 Crowley Street', '444192898196', 'crathkeft@over-blog.com', 'Cilka Rathke', '234-759-0934', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (574, '1992-09-28', '27 Welch Place', '514777517744', 'bsatterfittfu@seattletimes.com', 'Bonny Satterfitt', '992-620-2096', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (575, '1999-03-29', '7724 Walton Court', '127105679026', 'aaffusofv@ucoz.ru', 'Anne-marie Affuso', '901-756-5290', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (576, '1997-11-04', '767 Talmadge Pass', '537722343726', 'eliggensfw@independent.co.uk', 'Evangelia Liggens', '203-637-7751', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (577, '2005-08-07', '82 Duke Road', '541060846592', 'nkocherfx@ucoz.com', 'Normand Kocher', '137-130-8218', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (578, '1999-10-22', '002 Shelley Alley', '846415368197', 'sovesenfy@nhs.uk', 'Sandro Ovesen', '821-306-0188', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (579, '2004-08-16', '82365 Mosinee Place', '000503998035', 'fperonefz@columbia.edu', 'Felipa Perone', '102-427-4287', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (580, '2004-04-09', '12 Steensland Trail', '191509431038', 'hkristofferseng0@imgur.com', 'Huberto Kristoffersen', '111-199-8919', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (581, '1995-11-06', '346 Mayer Crossing', '418313378838', 'snegrog1@slate.com', 'Salvatore Negro', '718-681-7339', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (582, '1991-05-08', '962 Elka Junction', '875395935437', 'gkemeryg2@ebay.com', 'Gilbert Kemery', '967-351-0713', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (583, '2005-07-23', '51267 Fisk Drive', '265183719392', 'ljentong3@ucsd.edu', 'Lorine Jenton', '809-655-4500', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (584, '2005-01-04', '9 Evergreen Hill', '981501206037', 'ofearnleyg4@alibaba.com', 'Ogdon Fearnley', '453-893-9879', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (585, '1991-12-14', '3 Village Alley', '741090999569', 'gmcguireg5@wunderground.com', 'Gisella McGuire', '555-845-3175', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (586, '2001-12-25', '5 Scoville Court', '755491813276', 'slazerg6@cbc.ca', 'Sherwin Lazer', '217-864-0272', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (587, '1994-03-03', '4 Dryden Street', '278301891474', 'cgrindleyg7@twitter.com', 'Cordell Grindley', '109-121-7166', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (588, '1995-05-21', '52 Laurel Hill', '567854504636', 'lscorahg8@opensource.org', 'Lynnea Scorah', '474-756-1213', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (589, '1996-04-09', '804 Autumn Leaf Lane', '373912607389', 'hlansdaleg9@ucsd.edu', 'Haskel Lansdale', '993-305-2788', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (590, '2004-07-23', '381 Grasskamp Junction', '762384239611', 'ecastagnaroga@mail.ru', 'Ethelred Castagnaro', '206-794-6050', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (591, '1994-09-03', '42 Rutledge Lane', '533472727168', 'otoffalonigb@plala.or.jp', 'Orin Toffaloni', '873-487-9135', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (592, '2003-05-19', '70140 Lerdahl Alley', '563894603920', 'doquingc@craigslist.org', 'Dan O''Quin', '494-674-9668', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (593, '2002-10-29', '54915 Rowland Circle', '988795031576', 'mfoulchergd@cocolog-nifty.com', 'Montgomery Foulcher', '223-631-5419', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (594, '1990-11-15', '72 Arapahoe Plaza', '708509792392', 'gmeringtonge@cnet.com', 'Giustina Merington', '369-470-6891', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (595, '2000-05-01', '8 Delaware Way', '585622065371', 'lcrocketgf@wiley.com', 'Lacee Crocket', '893-178-3567', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (596, '1991-04-24', '00 Pierstorff Parkway', '456021114884', 'wbernardinogg@wunderground.com', 'Wendi Bernardino', '659-769-0561', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (597, '1992-03-06', '43 Mcbride Avenue', '404411093271', 'fparrengh@addthis.com', 'Felicle Parren', '467-529-4216', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (598, '1995-07-02', '8540 Forest Run Trail', '755129525571', 'vmconiegi@google.pl', 'Vilhelmina McOnie', '146-716-4093', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (599, '2004-05-10', '242 Judy Trail', '862569903452', 'kroylancegj@ow.ly', 'Kit Roylance', '679-123-8066', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (600, '1993-05-21', '5 Jay Drive', '156114036400', 'nmathewsgk@cdc.gov', 'Nerita Mathews', '923-783-6751', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (601, '1996-10-02', '025 Jenna Trail', '079539588278', 'ggaitskillgl@typepad.com', 'Gan Gaitskill', '718-710-4276', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (602, '2001-11-14', '905 Pierstorff Avenue', '918163719452', 'gbodhamgm@pagesperso-orange.fr', 'Goldi Bodham', '426-574-2231', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (603, '1994-04-06', '11451 Mcguire Hill', '273318643656', 'ssessergn@squarespace.com', 'Simone Sesser', '575-621-8866', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (604, '2000-09-23', '751 Sunnyside Pass', '334817141306', 'bstakergo@hao123.com', 'Bree Staker', '302-719-1287', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (605, '1991-03-04', '079 Express Point', '466249927897', 'ngibbongp@patch.com', 'Noach Gibbon', '960-878-6715', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (606, '1998-07-15', '1969 Trailsway Lane', '901542777752', 'mpilgrimgq@jigsy.com', 'Marnie Pilgrim', '296-909-6532', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (607, '2000-07-27', '4916 Stuart Junction', '285909586480', 'oastgr@walmart.com', 'Oates Ast', '476-785-0258', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (608, '1999-05-11', '7036 Hayes Street', '220856621737', 'ksnoxillgs@ning.com', 'Kin Snoxill', '148-545-6821', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (609, '1990-05-31', '5 Carioca Parkway', '207811106034', 'fmerrickgt@phoca.cz', 'Ferdy Merrick', '399-993-6950', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (610, '1999-03-04', '5432 Bonner Point', '542714797755', 'dkarpychevgu@whitehouse.gov', 'Diana Karpychev', '563-697-6707', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (611, '2002-04-19', '400 Sunfield Point', '426323593572', 'glubertigv@seattletimes.com', 'Goldia Luberti', '361-217-1537', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (612, '2000-08-14', '478 Memorial Circle', '978837195308', 'klaleveegw@about.me', 'Kenyon Lalevee', '992-471-8530', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (613, '1999-09-25', '122 Delladonna Park', '759607880691', 'gcoffingx@google.fr', 'Gannon Coffin', '767-145-3968', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (614, '1998-05-09', '75741 Calypso Pass', '200174443059', 'hfugegy@blogger.com', 'Hartley Fuge', '305-294-2867', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (615, '2006-01-26', '79 Jana Crossing', '410702355581', 'lmcdunlevygz@netvibes.com', 'Leshia McDunlevy', '256-785-1043', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (616, '1990-08-19', '7928 Kedzie Plaza', '021248518859', 'pkimberlyh0@yahoo.co.jp', 'Patrizio Kimberly', '933-335-1009', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (617, '2002-04-21', '5124 Coleman Crossing', '689250891869', 'gratterh1@apache.org', 'Garrett Ratter', '367-584-7832', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (618, '1998-03-29', '7727 Farwell Drive', '854485368523', 'agawthorph2@wufoo.com', 'Austen Gawthorp', '109-703-8225', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (619, '1998-06-19', '7 Gina Center', '498652434032', 'tmauchlenh3@netvibes.com', 'Thedrick Mauchlen', '838-660-3309', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (620, '1994-04-30', '813 Packers Plaza', '446687631267', 'dtraylenh4@hugedomains.com', 'Dru Traylen', '147-448-0809', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (621, '1998-10-21', '940 Burrows Park', '659165315680', 'tgioanih5@microsoft.com', 'Tabb Gioani', '187-136-9791', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (622, '2000-02-28', '6 Delaware Street', '044766865466', 'rrobbekeh6@ustream.tv', 'Riobard Robbeke', '387-142-5956', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (623, '1991-06-11', '8 Bluejay Hill', '011435463754', 'elanonh7@spiegel.de', 'Elihu Lanon', '958-274-9070', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (624, '1999-04-26', '42 Truax Crossing', '731761805103', 'kanthonsenh8@google.fr', 'Karia Anthonsen', '771-288-7541', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (625, '1999-07-01', '197 Vernon Street', '441764496576', 'mscolah9@economist.com', 'Miguel Scola', '898-365-9989', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (626, '1999-11-19', '46 Del Sol Circle', '319162207832', 'nmeeganha@reddit.com', 'Nealon Meegan', '678-952-5425', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (627, '1993-03-24', '3279 Mitchell Street', '360875874243', 'zfilasovhb@opensource.org', 'Zaneta Filasov', '817-566-0247', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (628, '2000-09-11', '99 Manley Place', '823992111973', 'edobererhc@dedecms.com', 'Edouard Doberer', '606-805-5752', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (629, '1993-12-30', '01524 David Way', '381134208137', 'ischirokhd@sun.com', 'Ibrahim Schirok', '894-536-9841', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (630, '1999-07-06', '50 Killdeer Terrace', '240403407354', 'acalfhe@mysql.com', 'Audie Calf', '644-608-0392', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (631, '1990-02-12', '574 Bonner Circle', '787894065035', 'cscroytonhf@cpanel.net', 'Christian Scroyton', '147-812-0150', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (632, '1991-07-28', '0674 Little Fleur Street', '302592669177', 'krandlesomehg@mysql.com', 'Kenneth Randlesome', '764-881-3453', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (633, '1997-04-15', '57 Bonner Drive', '087766705246', 'wdevenporthh@irs.gov', 'Waite Devenport', '175-172-4821', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (634, '1996-12-10', '9 Corry Road', '085085413402', 'pballintimehi@mtv.com', 'Page Ballintime', '763-817-4356', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (635, '2000-10-31', '231 Talmadge Pass', '139177747511', 'bbeavingtonhj@yolasite.com', 'Baron Beavington', '508-625-5473', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (636, '2003-10-31', '6 Garrison Alley', '571825720929', 'rdeverehk@fda.gov', 'Rona De''Vere - Hunt', '261-515-8383', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (637, '1997-03-24', '4438 Delladonna Way', '068399374714', 'cbourchierhl@gov.uk', 'Constantin Bourchier', '252-114-5650', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (638, '2005-06-14', '17 Morningstar Court', '450394178906', 'fmacmillanhm@who.int', 'Felipe MacMillan', '217-676-3551', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (639, '1991-07-03', '34 Autumn Leaf Terrace', '193407112425', 'rmorganhn@youku.com', 'Randy Morgan', '157-576-0703', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (640, '2002-11-20', '486 Southridge Way', '158318633465', 'cjoisceho@wired.com', 'Courtnay Joisce', '849-161-5072', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (641, '1996-12-14', '4 Cottonwood Circle', '670266458144', 'ndealyhp@npr.org', 'Nadean Dealy', '512-921-1842', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (642, '2001-12-21', '82449 Kedzie Crossing', '893338070352', 'csetteringtonhq@tiny.cc', 'Cecilia Setterington', '405-892-7931', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (643, '1995-01-01', '358 Corben Lane', '670671884123', 'aspiershr@bbc.co.uk', 'Alexi Spiers', '301-385-4317', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (644, '1998-02-15', '93462 Di Loreto Avenue', '389567321438', 'brouths@ning.com', 'Babbette Rout', '237-774-9472', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (645, '2003-01-19', '02762 Arapahoe Road', '291245689457', 'rcookht@constantcontact.com', 'Rutger Cook', '442-983-5630', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (646, '1993-03-04', '50 Longview Lane', '543735334054', 'mrollingshu@twitpic.com', 'Margalo Rollings', '218-479-3699', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (647, '1995-10-30', '487 Dunning Trail', '897909835154', 'zbacherhv@sohu.com', 'Zebadiah Bacher', '520-219-0950', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (648, '2005-01-27', '9902 Forest Dale Alley', '697701011825', 'pglendzahw@kickstarter.com', 'Phebe Glendza', '288-432-7225', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (649, '2004-05-25', '900 Sherman Drive', '901024325621', 'tdehx@hugedomains.com', 'Taddeo de Glanville', '833-329-1250', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (650, '1993-01-31', '054 Nova Avenue', '204078766131', 'tnewvillhy@gravatar.com', 'Thoma Newvill', '517-230-8586', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (651, '1995-12-03', '34 Coleman Hill', '318495035666', 'okemballhz@hp.com', 'Odille Kemball', '766-455-8451', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (652, '1999-12-06', '5923 Del Sol Plaza', '128133216242', 'dtanderi0@t.co', 'Darbie Tander', '593-719-7416', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (653, '1995-06-10', '3 Spenser Court', '508460900250', 'rmorcombi1@blinklist.com', 'Rem Morcomb', '675-218-7924', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (654, '1996-11-30', '988 Dayton Parkway', '614205311727', 'tmorriartyi2@marketwatch.com', 'Toby Morriarty', '184-370-3991', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (655, '1994-05-20', '553 Sloan Point', '312215690064', 'azimai3@scientificamerican.com', 'Aubrie Zima', '834-896-2194', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (656, '1994-01-21', '986 Independence Trail', '320268517625', 'cpeeveri4@pagesperso-orange.fr', 'Christa Peever', '580-100-0428', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (657, '1996-12-27', '77 1st Park', '153705378972', 'aweedenburgi5@wikia.com', 'Ami Weedenburg', '591-984-2472', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (658, '2001-09-11', '25129 Daystar Street', '874720900117', 'mbracknelli6@pen.io', 'Merrick Bracknell', '337-445-1703', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (659, '2005-09-18', '3 Coolidge Lane', '025032466825', 'sgassoni7@bandcamp.com', 'Skipton Gasson', '253-501-6616', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (660, '1999-04-08', '326 Knutson Crossing', '947936623871', 'ehabbijami8@bravesites.com', 'Ellary Habbijam', '758-412-9391', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (661, '2002-03-15', '01836 Havey Lane', '543195666262', 'ltorresii9@amazon.co.jp', 'Lilyan Torresi', '919-761-3129', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (662, '1998-10-04', '34994 Cherokee Alley', '747369987396', 'sstephensonia@mediafire.com', 'Sigfried Stephenson', '588-214-4774', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (663, '1992-10-22', '9 Hagan Crossing', '851268870921', 'gmcveeib@domainmarket.com', 'Gwendolin McVee', '821-348-5268', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (664, '2004-02-02', '4 Anhalt Junction', '993186003362', 'mminchiic@php.net', 'Mattias Minchi', '911-684-7958', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (665, '1995-09-16', '903 Esch Way', '629111931913', 'clammerdingid@hao123.com', 'Constantia Lammerding', '625-437-2793', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (666, '1999-03-22', '09 Grayhawk Court', '995487361485', 'cgullefordie@shop-pro.jp', 'Coleen Gulleford', '207-431-2175', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (667, '2000-07-26', '03 Debs Pass', '101820397142', 'abezleyif@quantcast.com', 'Anatol Bezley', '886-928-1047', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (668, '2004-02-07', '8788 Eastwood Circle', '770249667834', 'rmcwhinnieig@telegraph.co.uk', 'Rees Mcwhinnie', '787-416-3037', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (669, '1995-02-05', '627 Haas Place', '966482469448', 'fivanyushkinih@slideshare.net', 'Frazier Ivanyushkin', '929-995-7356', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (670, '1994-11-17', '3 Straubel Plaza', '612645700562', 'vtiplingii@unblog.fr', 'Vonny Tipling', '275-786-8915', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (671, '2004-04-04', '0063 Lyons Hill', '674336206824', 'wsterlingij@woothemes.com', 'Woodrow Sterling', '910-574-0345', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (672, '1996-03-19', '009 Jenna Avenue', '442538899218', 'umcgavinik@google.es', 'Ulrich McGavin', '187-954-8772', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (673, '1995-03-03', '02 Killdeer Way', '022725444694', 'cwhitlawil@hostgator.com', 'Chelsae Whitlaw', '619-722-1041', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (674, '1990-11-17', '32528 Coleman Avenue', '121371486051', 'njemmettim@ca.gov', 'Nicola Jemmett', '609-503-6420', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (675, '1996-12-27', '926 Hovde Plaza', '510907179626', 'dreemanin@squarespace.com', 'Dionis Reeman', '855-222-1358', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (676, '2005-09-17', '3414 Crescent Oaks Park', '385333455800', 'bbanbrickio@phoca.cz', 'Birgit Banbrick', '682-861-2042', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (677, '1995-05-14', '641 Straubel Trail', '891480436596', 'ppuddicombeip@csmonitor.com', 'Phyllys Puddicombe', '428-895-9547', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (678, '2004-06-09', '94 Saint Paul Pass', '451072234162', 'mtophamiq@nsw.gov.au', 'Marcella Topham', '262-548-5080', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (679, '1991-03-11', '7015 Lindbergh Street', '627725487726', 'wtwigginsir@hexun.com', 'Wolfie Twiggins', '427-929-2644', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (680, '1998-04-30', '44 Clarendon Trail', '766854761632', 'rshreeveis@seattletimes.com', 'Rosemaria Shreeve', '634-524-6928', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (681, '2002-08-15', '51607 Lighthouse Bay Circle', '620669275040', 'ajikyllsit@unesco.org', 'Alvan Jikylls', '283-668-9397', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (682, '1994-01-08', '988 Manufacturers Terrace', '166330859090', 'nguariniu@loc.gov', 'Nick Guarin', '257-325-7175', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (683, '1995-07-25', '19 Barnett Parkway', '739655318583', 'aadolphineiv@moonfruit.com', 'Aube Adolphine', '263-687-7418', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (684, '1992-08-26', '33 Mifflin Terrace', '370283494773', 'mpoytherasiw@posterous.com', 'Mabelle Poytheras', '957-414-5626', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (685, '2002-03-21', '4 Cordelia Court', '531038969244', 'iheersemaix@jugem.jp', 'Inessa Heersema', '987-329-7827', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (686, '1998-09-30', '132 Loeprich Court', '139368971744', 'lmaccaulliy@pen.io', 'Lenette MacCaull', '520-863-0849', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (687, '1991-03-16', '69 Talisman Point', '008233929297', 'ltampioniz@sfgate.com', 'Leta Tampion', '239-477-8044', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (688, '1998-12-11', '0 Sullivan Alley', '707040216207', 'kmcmeylerj0@army.mil', 'Karel McMeyler', '835-926-3950', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (689, '2005-10-22', '6 Drewry Alley', '326001587704', 'hmenhcij1@tumblr.com', 'Harry Menhci', '985-363-0029', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (690, '2002-03-24', '9986 Basil Way', '829448683935', 'lwitcombj2@umn.edu', 'Leisha Witcomb', '283-482-2784', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (691, '1995-11-27', '5260 Randy Center', '934655225782', 'acopinj3@home.pl', 'Akim Copin', '606-447-7526', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (692, '2004-08-25', '3666 Autumn Leaf Pass', '150977083998', 'lbeardsworthj4@purevolume.com', 'Lyndy Beardsworth', '774-197-1328', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (693, '1998-06-13', '080 Kenwood Crossing', '666098313630', 'nshonej5@gmpg.org', 'Noelle Shone', '286-161-1151', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (694, '2004-04-13', '30 Clyde Gallagher Lane', '347336751041', 'nmahedyj6@studiopress.com', 'Neely Mahedy', '348-992-1397', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (695, '1992-02-01', '676 Hazelcrest Pass', '095063183163', 'bmaynej7@shinystat.com', 'Bernarr Mayne', '953-836-4542', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (696, '1998-02-23', '2909 Arapahoe Parkway', '931908245392', 'bdennertj8@google.nl', 'Bryce Dennert', '138-895-2847', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (697, '1998-02-05', '7226 Sycamore Place', '551175892916', 'irubkej9@businesswire.com', 'Ingaborg Rubke', '683-377-7758', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (698, '1991-08-02', '47 Morningstar Hill', '968641987561', 'jdutchburnja@archive.org', 'Jacquenette Dutchburn', '662-544-0268', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (699, '1993-12-15', '90034 Cardinal Plaza', '326850721283', 'aalexisjb@vkontakte.ru', 'Alanah Alexis', '315-301-0138', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (700, '1990-03-27', '346 East Junction', '678122490039', 'dlambertsjc@eepurl.com', 'Debbi Lamberts', '299-263-3711', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (701, '1992-08-01', '2 Kropf Alley', '868650700932', 'mquilterjd@blogs.com', 'Mikael Quilter', '710-892-0014', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (702, '1995-11-05', '7 Continental Street', '766503403036', 'hlazellje@va.gov', 'Hesther Lazell', '602-547-1429', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (703, '1996-10-13', '7 Lunder Drive', '846719869271', 'vrichardeaujf@bravesites.com', 'Victoria Richardeau', '774-652-3095', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (704, '1996-06-29', '21 Rowland Terrace', '873031446679', 'gleyninyejg@cyberchimps.com', 'Griz Leyninye', '811-138-7033', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (705, '1993-03-03', '40 Doe Crossing Street', '838903455872', 'tcurraojh@homestead.com', 'Tally Currao', '927-998-6542', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (706, '1994-10-23', '08351 Mayer Avenue', '699989303032', 'cdetloffji@myspace.com', 'Corry Detloff', '408-486-5555', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (707, '2003-12-10', '48074 Kensington Court', '782792645399', 'fwogdonjj@51.la', 'Fred Wogdon', '453-603-5290', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (708, '1996-11-30', '3 Continental Park', '243054729152', 'eeagarjk@ustream.tv', 'Eirena Eagar', '126-956-0133', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (709, '1992-11-12', '4 8th Point', '660520954594', 'aitzaksonjl@rakuten.co.jp', 'Anna-maria Itzakson', '669-710-2781', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (710, '2004-08-10', '5 Packers Place', '660449439869', 'ebassilashvilijm@cisco.com', 'Elaina Bassilashvili', '648-960-8487', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (711, '1996-12-03', '162 Banding Center', '834363911379', 'tabryjn@ted.com', 'Tabatha Abry', '712-534-7839', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (712, '1999-07-16', '9703 Jana Hill', '426627188396', 'bpratijo@fema.gov', 'Banky Prati', '568-648-8078', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (713, '2003-10-24', '253 Cambridge Trail', '211877335866', 'rmcboylejp@biblegateway.com', 'Reynard McBoyle', '116-387-1153', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (714, '2005-08-17', '8787 Bultman Lane', '070317223297', 'ejosskovizjq@theguardian.com', 'Elita Josskoviz', '345-510-2245', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (715, '1995-02-25', '48 Sommers Park', '219897085475', 'eohmsjr@sakura.ne.jp', 'Effie Ohms', '282-595-8958', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (716, '2001-01-13', '0 Boyd Road', '328835781299', 'rbascombejs@qq.com', 'Reinold Bascombe', '749-901-8636', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (717, '2004-04-09', '09456 Kipling Center', '603416181815', 'dludwikiewiczjt@msn.com', 'Dino Ludwikiewicz', '780-680-6506', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (718, '2002-01-15', '4361 Prairieview Trail', '274173265086', 'dpedroju@nih.gov', 'Di Pedro', '870-149-7470', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (719, '1993-04-17', '57571 Forest Run Terrace', '389533410469', 'backermanjv@sogou.com', 'Bernetta Ackerman', '255-291-9410', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (720, '1999-04-15', '82 Kingsford Way', '394647848341', 'cbiggarjw@un.org', 'Casey Biggar', '427-297-8791', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (721, '1999-02-28', '010 Bellgrove Parkway', '489650748886', 'epawlynjx@google.es', 'Eric Pawlyn', '538-304-4972', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (722, '1994-02-07', '60 Golf Court', '867309309862', 'gsorojy@geocities.com', 'Grady Soro', '912-216-5408', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (723, '2003-09-12', '6 Jenna Way', '144546631135', 'tchirmjz@telegraph.co.uk', 'Tuckie Chirm', '907-745-9172', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (724, '2002-08-12', '03888 Nova Terrace', '094551441845', 'bdubblek0@bbc.co.uk', 'Briano Dubble', '150-825-7639', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (725, '2004-07-01', '0996 Messerschmidt Center', '914540519418', 'mmarlonk1@cdbaby.com', 'Marlin Marlon', '953-433-4701', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (726, '1997-06-13', '3900 Briar Crest Lane', '305482613994', 'gchambersk2@behance.net', 'Gery Chambers', '789-211-6919', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (727, '2001-01-14', '121 Rockefeller Drive', '377765015685', 'jdarbishirek3@studiopress.com', 'Jannelle Darbishire', '720-654-7898', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (728, '2005-03-19', '17 Pankratz Lane', '432597383703', 'nosgoodk4@barnesandnoble.com', 'Nancy Osgood', '237-682-3185', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (729, '1999-05-02', '23 Jenna Terrace', '067673830107', 'gstanexk5@amazon.com', 'Gillie Stanex', '500-554-4883', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (730, '1990-06-29', '97 Dovetail Road', '528254227789', 'bgarmonsk6@reference.com', 'Byrom Garmons', '761-736-1401', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (731, '1990-07-24', '26896 Clove Point', '741962367826', 'cmundiek7@amazonaws.com', 'Clayton Mundie', '692-756-4749', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (732, '1996-06-10', '72958 Burrows Crossing', '041775892852', 'hkibbyk8@tinypic.com', 'Hobie Kibby', '327-111-4417', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (733, '1997-02-10', '71321 Northview Street', '080637803776', 'rpettik9@msu.edu', 'Rosalia Petti', '373-910-8466', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (734, '1998-10-14', '143 Straubel Trail', '731812520169', 'kdobsonska@toplist.cz', 'Kattie Dobsons', '419-436-7512', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (735, '1998-12-07', '9 Bobwhite Avenue', '774191796652', 'imcfallkb@paypal.com', 'Ilse McFall', '246-726-3347', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (736, '1995-07-14', '2991 Banding Pass', '840834480969', 'bshovellkc@livejournal.com', 'Byrom Shovell', '704-570-6549', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (737, '1998-06-03', '07134 Magdeline Street', '295800717965', 'dpoundfordkd@newyorker.com', 'Daveta Poundford', '306-408-1720', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (738, '2004-09-04', '80 Maple Parkway', '558147115085', 'sbarnbyke@thetimes.co.uk', 'Sheree Barnby', '849-452-0075', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (739, '2004-05-29', '45 Dixon Junction', '749421240532', 'bfountainekf@facebook.com', 'Bryn Fountaine', '595-478-2109', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (740, '1996-11-13', '996 Anzinger Crossing', '748599776323', 'sbeereskg@addtoany.com', 'Skip Beeres', '863-816-0434', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (741, '2002-09-11', '53 Jay Plaza', '192153230858', 'cmynerkh@nyu.edu', 'Carroll Myner', '342-540-6961', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (742, '1994-05-25', '05187 Donald Plaza', '077289388696', 'gtrumperki@instagram.com', 'Geoffrey Trumper', '366-279-4940', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (743, '2001-06-05', '01 Meadow Vale Trail', '559227745934', 'csitchkj@freewebs.com', 'Care Sitch', '989-627-6609', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (744, '2002-07-11', '8357 Heath Drive', '829674091055', 'fstanyonkk@bandcamp.com', 'Field Stanyon', '504-540-3937', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (745, '1997-01-16', '9 Delladonna Place', '601564124588', 'bmcgavigankl@t.co', 'Bryanty McGavigan', '934-676-6791', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (746, '2000-06-30', '7111 Grim Terrace', '206676597476', 'clepickkm@is.gd', 'Colleen Lepick', '316-992-0661', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (747, '2001-05-16', '89403 Westend Street', '204869463668', 'edikn@imageshack.us', 'Elsie Di Biasio', '237-959-2834', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (748, '1992-11-19', '140 Karstens Court', '502911811688', 'lbrodheadko@mlb.com', 'Leia Brodhead', '759-549-0608', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (749, '1994-05-26', '57003 Hanover Place', '248830283649', 'gaugiekp@google.de', 'Genny Augie', '624-549-9797', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (750, '2002-04-01', '5594 Basil Center', '988044953321', 'dschirachkq@a8.net', 'Dalenna Schirach', '695-252-1725', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (751, '1996-02-02', '1 Banding Lane', '689917705822', 'amurtellkr@macromedia.com', 'Anatole Murtell', '620-799-7017', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (752, '2004-01-25', '7 Shoshone Way', '381432652487', 'avasichevks@google.it', 'Archer Vasichev', '488-355-4502', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (753, '1995-03-08', '37 Kim Junction', '557884188618', 'efrankelkt@hibu.com', 'Elonore Frankel', '135-143-1847', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (754, '2005-01-18', '9 Hazelcrest Parkway', '954864439356', 'cmcmurrayaku@about.com', 'Cherish McMurraya', '873-162-9795', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (755, '1993-10-22', '305 Granby Way', '393818046639', 'oflawskv@bbb.org', 'Odetta Flaws', '421-311-9658', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (756, '1990-10-01', '6338 Debra Junction', '954941642180', 'erobelinkw@cornell.edu', 'Elane Robelin', '906-936-1876', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (757, '1998-09-02', '8838 Spenser Circle', '015113582172', 'tshevelinkx@gnu.org', 'Tobi Shevelin', '824-239-8715', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (758, '2003-04-02', '5969 Steensland Point', '583988338940', 'jmcmychemky@flickr.com', 'Jojo McMychem', '779-557-3475', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (759, '1996-05-09', '173 Meadow Ridge Avenue', '766050990255', 'hdekz@stumbleupon.com', 'Hamid De Blasio', '877-216-3931', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (760, '2005-04-14', '80 Michigan Plaza', '589703315258', 'eblydenl0@miitbeian.gov.cn', 'Ewen Blyden', '741-813-0389', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (761, '1990-11-27', '23 Esch Road', '210768552623', 'tadcockl1@webmd.com', 'Trudie Adcock', '854-535-0291', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (762, '1993-11-28', '4 Toban Terrace', '916181450988', 'mpouckl2@surveymonkey.com', 'Merralee Pouck', '257-940-5115', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (763, '1997-03-18', '6825 Spohn Terrace', '941373029234', 'finkinl3@blogspot.com', 'Frances Inkin', '429-816-5959', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (764, '1998-08-30', '990 Lakewood Plaza', '064019374581', 'gbeveridgel4@t-online.de', 'Gonzales Beveridge', '136-119-1691', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (765, '2003-01-08', '8147 Manley Crossing', '971129178500', 'dkorbmakerl5@amazon.com', 'Devin Korbmaker', '913-947-1176', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (766, '1990-10-02', '0934 Marcy Road', '246366254116', 'jcampol6@bing.com', 'Janella Campo', '422-119-7189', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (767, '1997-04-30', '46469 Fallview Crossing', '396245105746', 'ameeusl7@latimes.com', 'Arte Meeus', '827-529-3193', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (768, '2001-06-12', '9167 Chinook Crossing', '578922329297', 'ebenianl8@geocities.com', 'Ely Benian', '119-141-8316', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (769, '1998-03-13', '603 Grasskamp Crossing', '841923618528', 'tbeaufoyl9@list-manage.com', 'Timothea Beaufoy', '652-700-4143', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (770, '2001-04-15', '35125 Forest Crossing', '402328108082', 'rmalzardla@simplemachines.org', 'Rip Malzard', '727-908-4862', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (771, '2002-12-22', '04 Prairieview Place', '605629724803', 'dbevarlb@patch.com', 'Diannne Bevar', '523-225-1707', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (772, '2004-09-15', '6 Muir Point', '361034308208', 'gorvisslc@oakley.com', 'Gordon Orviss', '680-978-4268', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (773, '1990-07-08', '7416 Fulton Terrace', '678145664972', 'wmougeotld@mapy.cz', 'Webb Mougeot', '757-848-7341', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (774, '2003-07-13', '694 Bunker Hill Park', '171053441435', 'cattersollle@berkeley.edu', 'Cherise Attersoll', '218-804-6378', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (775, '2001-03-13', '732 Sutherland Junction', '207937894968', 'pmaultlf@scientificamerican.com', 'Peg Mault', '720-815-1926', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (776, '1994-05-21', '43368 Mallory Road', '477981379791', 'ewoolertonlg@kickstarter.com', 'Edouard Woolerton', '660-388-3501', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (777, '1996-11-19', '0248 Kedzie Way', '391661422989', 'smaddicklh@smugmug.com', 'Skye Maddick', '626-906-8421', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (778, '2002-11-12', '0 Butternut Plaza', '260595100491', 'sstowgillli@samsung.com', 'Sigismondo Stowgill', '905-722-6237', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (779, '2002-01-30', '4094 Dennis Park', '916111907432', 'kfockeslj@webs.com', 'Kimbell Fockes', '958-858-3833', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (780, '1994-11-14', '7 Schurz Terrace', '538342764978', 'cstubbelk@cmu.edu', 'Cirstoforo Stubbe', '691-726-0988', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (781, '1991-04-06', '53 Iowa Lane', '288772654871', 'hsangwinell@uiuc.edu', 'Hastings Sangwine', '743-206-0597', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (782, '1995-01-20', '70 Ridgeway Hill', '756457952794', 'isomertonlm@columbia.edu', 'Ian Somerton', '663-756-1424', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (783, '2001-07-05', '60456 Judy Parkway', '292639291433', 'wcattrellln@tiny.cc', 'Westleigh Cattrell', '916-897-8818', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (784, '2004-08-13', '960 North Drive', '417238144388', 'asagglo@tiny.cc', 'Alvin Sagg', '477-815-1888', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (785, '1994-05-16', '04 Hazelcrest Street', '215276967944', 'eknevettlp@example.com', 'Evangelina Knevett', '481-784-6207', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (786, '1990-07-13', '27233 Havey Pass', '115716273082', 'smulliganlq@behance.net', 'Selia Mulligan', '247-372-4968', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (787, '1999-04-23', '74992 Buell Circle', '189216496787', 'rbroughtonlr@cbc.ca', 'Romy Broughton', '544-688-4320', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (788, '1990-09-02', '9 Loftsgordon Avenue', '108733808028', 'wgartonls@clickbank.net', 'Willey Garton', '763-670-2539', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (789, '1992-08-30', '4 Canary Circle', '459132624023', 'chalfacrelt@weibo.com', 'Chandra Halfacre', '786-418-6998', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (790, '1993-03-26', '4 Porter Place', '603404873957', 'tlefeuvrelu@privacy.gov.au', 'Traver Lefeuvre', '918-783-6114', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (791, '2005-07-16', '1 Scofield Place', '412433602946', 'kwoofendenlv@webmd.com', 'Klemens Woofenden', '319-499-8630', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (792, '1995-12-19', '813 Lyons Place', '299053193560', 'jnewshamlw@si.edu', 'Jacquelyn Newsham', '389-831-8793', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (793, '1991-09-18', '16 Brown Street', '000615808618', 'bpaddonlx@ameblo.jp', 'Betteann Paddon', '667-674-7028', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (794, '1997-03-15', '6 Gulseth Center', '452491515206', 'lkieranly@bigcartel.com', 'Lolly Kieran', '312-389-5445', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (795, '1994-11-18', '6798 Pine View Road', '953429816061', 'ddrewelllz@mtv.com', 'Darleen Drewell', '418-528-6066', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (796, '1994-07-12', '872 Morrow Road', '780826483797', 'sbalharrym0@fema.gov', 'Sebastian Balharry', '277-490-7352', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (797, '2003-10-24', '884 Bowman Way', '463959144871', 'naloshikinm1@google.co.jp', 'Newton Aloshikin', '368-680-1988', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (798, '2000-10-25', '3 Troy Way', '099142147961', 'dflackm2@smugmug.com', 'Dallis Flack', '878-869-8462', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (799, '1990-07-18', '86309 Graceland Crossing', '451371122187', 'jsollasm3@mashable.com', 'Jermaine Sollas', '279-531-6900', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (800, '1996-04-19', '6 Marquette Terrace', '692464739129', 'dfloyedm4@1und1.de', 'Del Floyed', '793-948-9672', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (801, '1993-08-12', '70 Northland Center', '805763218149', 'mwikeym5@wordpress.com', 'Melloney Wikey', '290-498-0144', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (802, '1997-04-10', '854 Westend Way', '936053027686', 'hfalkm6@toplist.cz', 'Horace Falk', '877-493-9590', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (803, '2005-12-14', '8 Roxbury Junction', '984485486408', 'jpersehousem7@wordpress.org', 'Jan Persehouse', '420-734-8448', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (804, '1993-12-02', '072 Leroy Center', '355261726886', 'jkinclam8@mapquest.com', 'Justen Kincla', '627-141-6978', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (805, '1995-08-08', '408 Dorton Avenue', '299263247716', 'wmagorm9@aboutads.info', 'Will Magor', '404-116-9331', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (806, '1990-09-26', '30 Golden Leaf Lane', '701217020324', 'ascardifeildma@businesswire.com', 'Ashleigh Scardifeild', '931-983-3449', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (807, '1997-07-28', '6145 Annamark Crossing', '142006115401', 'itenchmb@cyberchimps.com', 'Isaac Tench', '530-142-8436', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (808, '2004-08-03', '51 Loomis Circle', '533243069646', 'jmonerymc@ask.com', 'Jock Monery', '458-166-6002', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (809, '2002-01-24', '75551 Jay Circle', '513259714145', 'rdjokicmd@cdbaby.com', 'Reina Djokic', '970-730-4701', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (810, '1995-01-13', '0006 Parkside Road', '031509468000', 'kspekeme@nationalgeographic.com', 'Kally Speke', '302-470-3641', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (811, '2003-11-06', '19 Ramsey Junction', '605027299852', 'owalcarmf@nasa.gov', 'Odella Walcar', '623-665-8390', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (812, '1992-06-11', '5176 Annamark Court', '646931375749', 'sellerbymg@wikipedia.org', 'Sharon Ellerby', '609-196-3927', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (813, '1999-10-31', '41575 Holmberg Crossing', '046984799817', 'bzarfatmh@go.com', 'Bella Zarfat', '145-997-6836', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (814, '1993-12-25', '699 Porter Place', '436830148411', 'athreadgillmi@themeforest.net', 'Anissa Threadgill', '599-995-9453', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (815, '1994-03-12', '4364 Milwaukee Drive', '832545900697', 'jcaldronmj@cam.ac.uk', 'Jobi Caldron', '353-907-8396', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (816, '1994-01-09', '5 Maple Court', '536448360724', 'kingraymk@usda.gov', 'Kearney Ingray', '522-670-7811', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (817, '1995-11-12', '902 Mayfield Street', '018382026018', 'ystigersml@reverbnation.com', 'Yvette Stigers', '277-180-0930', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (818, '1995-12-03', '2 Morningstar Junction', '820171935136', 'mleetmm@mtv.com', 'Maudie Leet', '918-116-6143', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (819, '2003-04-09', '95 Duke Pass', '929176560614', 'emcgurganmn@bravesites.com', 'Ebenezer McGurgan', '884-451-4569', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (820, '1994-06-22', '01701 Moulton Alley', '138861429859', 'alutmanmo@opensource.org', 'Alexio Lutman', '641-650-7589', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (821, '2004-10-22', '89406 Darwin Court', '577454708612', 'lscroytonmp@businesswire.com', 'Leena Scroyton', '898-217-4949', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (822, '2005-10-11', '21365 Eastwood Center', '462446028567', 'cthackeraymq@topsy.com', 'Cosetta Thackeray', '797-903-6348', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (823, '1999-03-26', '0644 Ohio Alley', '382272583609', 'rcopemanmr@shareasale.com', 'Remy Copeman', '969-870-4087', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (824, '1994-05-16', '4 Carioca Plaza', '007060729808', 'barchellms@ning.com', 'Bail Archell', '407-453-0302', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (825, '2004-02-08', '81501 Lindbergh Drive', '451928076927', 'hkingcottmt@acquirethisname.com', 'Harlin Kingcott', '844-223-6823', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (826, '2003-05-09', '9051 Lake View Park', '962953493784', 'mschooleymu@digg.com', 'Miriam Schooley', '258-795-1445', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (827, '2004-11-01', '26415 Monterey Junction', '609076129589', 'spitchfordmv@disqus.com', 'Schuyler Pitchford', '409-735-5958', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (828, '1999-12-17', '21637 Anzinger Court', '635712264682', 'fvoelkermw@reference.com', 'Fifine Voelker', '714-947-7305', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (829, '1991-11-18', '43157 Hermina Park', '042880981811', 'nsnuggmx@redcross.org', 'Nefen Snugg', '823-949-3179', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (830, '1997-12-28', '3742 Petterle Way', '205137656462', 'bgilpinmy@gov.uk', 'Blondie Gilpin', '547-550-0125', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (831, '1994-03-18', '06 Summer Ridge Park', '663952079490', 'clantmz@typepad.com', 'Cathleen Lant', '975-934-3437', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (832, '2000-04-02', '3330 Troy Parkway', '252010391593', 'btrowsdalln0@oracle.com', 'Brodie Trowsdall', '777-270-2424', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (833, '2002-11-30', '90452 Caliangt Crossing', '127783700627', 'balgaten1@com.com', 'Benedicto Algate', '495-191-8090', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (834, '2004-09-11', '82 Warner Circle', '164626534823', 'dlatusn2@storify.com', 'Deeanne Latus', '537-902-4038', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (835, '1993-06-22', '4438 Longview Circle', '377672869024', 'lcorneliussenn3@altervista.org', 'Lovell Corneliussen', '346-315-6771', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (836, '1990-02-22', '5 Fairfield Place', '389197594147', 'areadien4@washington.edu', 'Ashli Readie', '735-149-4468', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (837, '1998-05-09', '38877 Mitchell Drive', '557061746214', 'gattriden5@npr.org', 'Gaspard Attride', '647-416-1546', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (838, '1995-01-06', '403 Delladonna Crossing', '116988973127', 'bhaughann6@symantec.com', 'Billie Haughan', '491-382-5240', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (839, '1990-04-22', '82838 Hintze Circle', '596137655214', 'bbeddoesn7@mediafire.com', 'Beau Beddoes', '137-526-9826', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (840, '1998-02-03', '644 Pepper Wood Trail', '436912869897', 'mmaccullochn8@umn.edu', 'Merry MacCulloch', '674-349-4688', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (841, '1990-04-21', '1106 Dorton Way', '732641835416', 'akilmartinn9@sogou.com', 'Anetta Kilmartin', '421-132-6574', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (842, '1995-03-17', '645 5th Terrace', '532766732513', 'rolivettina@e-recht24.de', 'Roda Olivetti', '519-313-8063', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (843, '2001-08-07', '11 Elmside Terrace', '371967960731', 'rcanonb@cargocollective.com', 'Randolph Cano', '245-821-0292', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (844, '2003-11-10', '6791 Novick Court', '514674837077', 'groddannc@webeden.co.uk', 'Grady Roddan', '906-270-2139', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (845, '1993-12-16', '064 Vera Avenue', '395887348464', 'fschachternd@google.ca', 'Fiorenze Schachter', '169-557-2654', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (846, '1999-01-20', '0 Shelley Street', '177075048439', 'jdulinne@wikimedia.org', 'Jayne Dulin', '884-476-0172', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (847, '1994-12-28', '74 Pearson Junction', '424797390513', 'bliddingtonnf@omniture.com', 'Briny Liddington', '840-515-8700', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (848, '1998-09-03', '8971 Dunning Park', '944551374249', 'blurrimanng@unc.edu', 'Brandon Lurriman', '943-731-3104', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (849, '2004-05-27', '28 Oneill Street', '937735200271', 'lhaugnh@a8.net', 'Lizzy Haug', '884-614-6214', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (850, '2001-07-11', '9101 Mariners Cove Road', '846283794344', 'jburnsydeni@microsoft.com', 'Jermaine Burnsyde', '480-888-3723', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (851, '1990-05-23', '802 Corry Avenue', '590652750932', 'spatemorenj@qq.com', 'Sissy Patemore', '150-676-7954', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (852, '1997-12-31', '3133 7th Hill', '851192719487', 'aclowsernk@thetimes.co.uk', 'Arlee Clowser', '288-891-5964', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (853, '2002-05-12', '117 Park Meadow Junction', '383033563839', 'grivallandnl@apache.org', 'Guenna Rivalland', '291-494-0195', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (854, '2002-01-15', '342 Heffernan Trail', '984116084682', 'mmassynm@eventbrite.com', 'Malia Massy', '315-348-7662', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (855, '2003-11-20', '9968 Dayton Center', '334422346525', 'dstammersnn@nps.gov', 'Donica Stammers', '311-903-9243', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (856, '2006-01-26', '414 Forest Run Plaza', '576569539537', 'jhaniganno@exblog.jp', 'Jess Hanigan', '338-429-5148', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (857, '2003-08-07', '531 Del Mar Hill', '574324822032', 'bnorcuttnp@amazon.de', 'Bogart Norcutt', '119-950-3347', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (858, '2001-04-14', '0625 Transport Way', '212123997040', 'imucklownq@vinaora.com', 'Ines Mucklow', '171-129-2870', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (859, '1995-06-16', '4407 Portage Hill', '452507139660', 'rwastallnr@mtv.com', 'Regine Wastall', '315-956-6746', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (860, '1997-06-26', '74392 Pine View Park', '737803371215', 'ccristouns@alibaba.com', 'Christina Cristou', '108-572-0256', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (861, '2001-10-04', '277 Mesta Avenue', '149363447016', 'lhellisnt@aboutads.info', 'Lindy Hellis', '849-386-1923', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (862, '1995-10-23', '045 Miller Lane', '914961768269', 'jsignorinu@example.com', 'Jordanna Signori', '931-903-1129', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (863, '1991-05-17', '78379 Merchant Avenue', '462905491402', 'ksonnenscheinnv@goodreads.com', 'Kimble Sonnenschein', '549-506-2713', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (864, '1990-09-22', '82 Fair Oaks Court', '226939877124', 'lbullmannw@ed.gov', 'Laraine Bullman', '106-310-9017', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (865, '1990-06-06', '0425 Meadow Valley Crossing', '188115944621', 'nbewshirenx@deviantart.com', 'Noby Bewshire', '158-302-0900', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (866, '2005-12-03', '8 Holmberg Lane', '794818461664', 'qvasiljevicny@a8.net', 'Quincy Vasiljevic', '480-822-8949', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (867, '1996-07-29', '6 Troy Trail', '475228938649', 'kjanotanz@ibm.com', 'Keith Janota', '871-656-6129', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (868, '1995-05-27', '8 Green Ridge Circle', '935789764481', 'pdowtryo0@webeden.co.uk', 'Patrizius Dowtry', '381-269-9833', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (869, '2001-02-21', '872 Gale Circle', '045208383746', 'choyeso1@netvibes.com', 'Cordy Hoyes', '151-683-2280', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (870, '1994-03-26', '55 Esch Plaza', '814986695492', 'gwillstropo2@netlog.com', 'Gordan Willstrop', '142-373-2734', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (871, '2003-06-27', '84299 Packers Point', '661404589871', 'okniftono3@taobao.com', 'Othelia Knifton', '842-240-9370', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (872, '1994-03-14', '1 Mifflin Park', '419041903229', 'lblindero4@sourceforge.net', 'Lyndy Blinder', '518-296-7153', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (873, '2000-07-02', '44 Upham Way', '893716811648', 'ogallono5@army.mil', 'Odo Gallon', '637-734-9462', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (874, '1998-12-31', '105 Meadow Valley Place', '961121332803', 'pcattelo6@moonfruit.com', 'Priscella Cattel', '796-658-5199', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (875, '1993-02-11', '2276 Towne Hill', '294173434766', 'sfletchero7@ca.gov', 'Salvador Fletcher', '558-802-7105', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (876, '1994-02-28', '0623 Arizona Park', '669424564976', 'abatero8@studiopress.com', 'Aggie Bater', '439-111-0890', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (877, '2002-10-28', '083 Reinke Center', '206465428861', 'cspeereo9@stumbleupon.com', 'Clerkclaude Speere', '346-868-4148', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (878, '1999-06-08', '5912 Stoughton Drive', '325443446149', 'rblewmenoa@cisco.com', 'Reginald Blewmen', '104-269-2955', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (879, '1992-06-26', '42028 Sommers Road', '437923644520', 'fogreadyob@ning.com', 'Federico O''Gready', '542-197-9370', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (880, '1991-09-30', '0 Iowa Center', '890087242584', 'mjeskinoc@taobao.com', 'Maryrose Jeskin', '357-955-3411', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (881, '1996-06-27', '539 Lakewood Trail', '888584274082', 'aloomisod@typepad.com', 'Annnora Loomis', '340-607-7390', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (882, '2002-05-04', '82 Colorado Drive', '071788260113', 'athomenoe@rambler.ru', 'Ashil Thomen', '242-189-5175', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (883, '2005-12-06', '70 Veith Drive', '040864130621', 'nriversof@indiatimes.com', 'Nesta Rivers', '276-189-4244', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (884, '2000-08-21', '05334 Summer Ridge Road', '785666865365', 'lchartog@wunderground.com', 'Lindon Chart', '774-150-2634', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (885, '1991-05-18', '3100 Parkside Avenue', '004294412152', 'amiddleweekoh@cbslocal.com', 'Aristotle Middleweek', '194-893-1619', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (886, '1994-01-14', '890 Melby Center', '779259251781', 'drubeloi@chronoengine.com', 'Davis Rubel', '695-649-7927', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (887, '2003-11-09', '67 Union Circle', '620561063397', 'ncloneyoj@paginegialle.it', 'Nicolette Cloney', '600-785-0958', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (888, '2003-08-28', '83649 Saint Paul Circle', '953824225380', 'mbartkiewiczok@youtube.com', 'Mona Bartkiewicz', '230-432-1450', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (889, '1994-05-30', '207 Northfield Pass', '633971518395', 'colenechanol@state.tx.us', 'Colline O''Lenechan', '907-102-2354', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (890, '1998-10-23', '2 Debs Pass', '606631064504', 'blocklessom@ovh.net', 'Berry Lockless', '686-871-0017', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (891, '1999-07-08', '1821 International Hill', '040453600286', 'goakeon@reuters.com', 'Gideon Oake', '563-108-0588', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (892, '1997-10-03', '5 Stephen Road', '926924160637', 'aguppieoo@washington.edu', 'Alic Guppie', '705-423-0084', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (893, '2001-05-19', '9038 Surrey Parkway', '724036957789', 'cdoyop@xrea.com', 'Chan Doy', '278-987-6262', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (894, '1997-08-22', '16124 David Court', '234363584468', 'emuccinooq@eepurl.com', 'Erna Muccino', '409-395-7299', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (895, '1990-08-12', '2625 Crowley Plaza', '307506843858', 'asondonor@unesco.org', 'Alicea Sondon', '122-699-5731', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (896, '2000-02-12', '9 Graedel Pass', '758513487607', 'rliddallos@simplemachines.org', 'Rabi Liddall', '504-484-8203', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (897, '1995-07-01', '72 Londonderry Junction', '810612693406', 'fclausnerot@oaic.gov.au', 'Flo Clausner', '308-136-0304', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (898, '2004-03-27', '88 Lakeland Lane', '015549280581', 'cwelbeckou@examiner.com', 'Cyrillus Welbeck', '834-408-0326', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (899, '1995-04-01', '03248 Graedel Alley', '087819974476', 'delsomov@blogs.com', 'Dukie Elsom', '890-744-9568', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (900, '1999-05-23', '6 Maywood Point', '842672300686', 'klangmanow@dot.gov', 'Karlis Langman', '379-843-9570', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (901, '2001-10-28', '36216 Chive Point', '384517305054', 'bdumphryox@odnoklassniki.ru', 'Bridget Dumphry', '335-309-3807', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (902, '1992-11-15', '8 Victoria Crossing', '080374224067', 'kbrittanoy@engadget.com', 'Karly Brittan', '883-488-0015', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (903, '2002-02-23', '6614 Kennedy Road', '297183563793', 'chemmsoz@tuttocitta.it', 'Christos Hemms', '785-752-1360', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (904, '2002-09-17', '06860 Fordem Street', '169568573973', 'kstenhousep0@prweb.com', 'Kylie Stenhouse', '756-936-6940', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (905, '1994-09-29', '2950 Del Sol Avenue', '753016916838', 'fbullierp1@usda.gov', 'Franny Bullier', '499-572-2500', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (906, '1996-06-16', '9400 Amoth Hill', '420990448281', 'mgrassp2@moonfruit.com', 'Maiga Grass', '137-448-7831', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (907, '1997-11-17', '34445 Cordelia Court', '253521840531', 'ccruickshankp3@time.com', 'Care Cruickshank', '689-764-4410', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (908, '1996-08-23', '2 Old Shore Hill', '923748619315', 'bwraxallp4@furl.net', 'Brennen Wraxall', '718-738-1373', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (909, '1997-12-04', '9628 Sommers Circle', '518268839196', 'rbentermanp5@multiply.com', 'Rudolfo Benterman', '161-890-6055', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (910, '1991-04-30', '0 Comanche Drive', '425097446871', 'sfisbeyp6@rediff.com', 'Shay Fisbey', '955-593-6089', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (911, '1997-05-27', '861 Artisan Trail', '397585450898', 'aaustinp7@google.com', 'Ashli Austin', '475-168-2333', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (912, '2006-01-25', '152 Carey Court', '383174455163', 'qmarfellp8@usnews.com', 'Quinta Marfell', '277-213-6009', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (913, '2003-10-06', '8795 School Crossing', '143281228348', 'bmeighp9@angelfire.com', 'Baryram Meigh', '138-150-8244', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (914, '1996-08-01', '8459 Maple Plaza', '559794334408', 'ahedlingpa@fema.gov', 'Ashil Hedling', '149-417-5868', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (915, '1996-09-04', '848 Fairview Park', '045450618432', 'nmanifouldpb@naver.com', 'Niel Manifould', '921-900-3457', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (916, '2005-01-05', '4910 Prairieview Street', '600042358041', 'pyarrantonpc@clickbank.net', 'Philippe Yarranton', '198-122-3496', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (917, '1994-02-05', '23 Melvin Center', '873148219391', 'dfarryanpd@is.gd', 'Dalia Farryan', '825-515-6853', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (918, '1995-06-05', '11383 Oakridge Alley', '933213125771', 'gshorbrookpe@fotki.com', 'Guntar Shorbrook', '129-755-8683', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (919, '2000-05-21', '23 Troy Terrace', '751066207621', 'ddraysonpf@netlog.com', 'Des Drayson', '462-702-4565', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (920, '2005-12-13', '94 Darwin Hill', '179124940951', 'misittpg@photobucket.com', 'Martha Isitt', '807-644-8928', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (921, '1997-02-09', '50 Clove Trail', '698060033773', 'ewalczakph@un.org', 'Elnore Walczak', '435-563-0899', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (922, '1999-12-04', '61920 Ruskin Place', '057941060143', 'chansedpi@chronoengine.com', 'Chilton Hansed', '260-385-1610', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (923, '2001-06-09', '174 Cherokee Hill', '199489445199', 'vzannutopj@gmpg.org', 'Vassily Zannuto', '831-868-0780', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (924, '1993-03-29', '752 Pearson Circle', '497677871728', 'agulvinpk@google.cn', 'Ashbey Gulvin', '647-493-7023', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (925, '1997-04-29', '2 Jenna Place', '537197768399', 'caverypl@1688.com', 'Coleen Avery', '950-136-5871', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (926, '1990-05-04', '3 Red Cloud Way', '319733529169', 'mgritlandpm@unblog.fr', 'Mara Gritland', '103-752-7872', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (927, '2003-02-08', '4 Nobel Center', '531484761764', 'usiberrypn@patch.com', 'Uriel Siberry', '449-503-9461', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (928, '2001-02-18', '55 Pearson Pass', '009901006460', 'uescalepo@hugedomains.com', 'Umberto Escale', '678-692-2355', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (929, '2000-01-12', '07103 Becker Way', '409877290949', 'vmcveighpp@ezinearticles.com', 'Verge McVeigh', '970-616-6747', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (930, '1994-02-04', '8211 Oak Valley Circle', '876054025823', 'cmahoodpq@cisco.com', 'Cymbre Mahood', '751-267-5087', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (931, '2005-08-28', '26 Prairieview Pass', '571979643157', 'ttwedepr@skyrock.com', 'Tracy Twede', '514-538-0583', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (932, '1996-05-19', '90844 Hansons Terrace', '351857467896', 'bvanps@blogspot.com', 'Bird Van den Velde', '772-654-9054', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (933, '1990-07-04', '7 Fulton Way', '633183583378', 'gvedikhovpt@nhs.uk', 'Gerry Vedikhov', '733-407-3958', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (934, '1995-12-08', '69 Golf Course Lane', '964245494509', 'krangellpu@shutterfly.com', 'Krystyna Rangell', '257-264-8313', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (935, '2002-07-23', '50 Karstens Center', '171672891857', 'acoepv@bloglines.com', 'Amalle Coe', '832-884-3785', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (936, '2002-08-05', '0983 Mifflin Road', '275470073185', 'gjaggspw@quantcast.com', 'Giffard Jaggs', '628-577-5732', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (937, '1990-09-18', '9 Sunfield Way', '943259243053', 'mspreullpx@europa.eu', 'Marlin Spreull', '378-775-5916', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (938, '1990-02-05', '7799 Commercial Court', '129613350100', 'dmacfaulpy@meetup.com', 'Dennison MacFaul', '172-218-8756', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (939, '1995-07-10', '5783 Crest Line Park', '992833221218', 'uburrispz@ycombinator.com', 'Ulberto Burris', '283-300-0760', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (940, '1995-05-26', '273 Cottonwood Crossing', '844882038165', 'kpatkinq0@over-blog.com', 'Kameko Patkin', '972-744-1378', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (941, '1996-03-27', '43 Roxbury Park', '004654502960', 'sbrownhillq1@mayoclinic.com', 'Sholom Brownhill', '397-809-9739', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (942, '1994-08-18', '082 Buhler Plaza', '568401428692', 'jcurnessq2@examiner.com', 'Jacquelyn Curness', '281-674-0969', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (943, '2000-09-02', '314 Montana Street', '210283381841', 'eglandersq3@fastcompany.com', 'Elden Glanders', '828-322-1217', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (944, '2003-02-04', '8031 Badeau Center', '859619587570', 'gkalinskyq4@taobao.com', 'Golda Kalinsky', '447-541-6203', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (945, '1994-11-06', '7 Blaine Plaza', '893742650504', 'apennazziq5@nih.gov', 'Alonzo Pennazzi', '408-923-4431', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (946, '1999-01-25', '8640 Mendota Way', '698345254308', 'cfenlonq6@dailymotion.com', 'Christoph Fenlon', '828-452-5414', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (947, '2002-06-11', '61 Homewood Lane', '165587359279', 'lstifeq7@howstuffworks.com', 'Lion Stife', '137-386-2740', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (948, '1992-04-21', '64408 Tomscot Street', '477145678669', 'kclapstonq8@acquirethisname.com', 'Kimberlyn Clapston', '380-773-4709', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (949, '2004-07-02', '09 Killdeer Hill', '454232515779', 'bkybertq9@delicious.com', 'Bibi Kybert', '315-777-4534', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (950, '1990-12-31', '462 Corscot Park', '250396530896', 'blawlingsqa@hud.gov', 'Broderic Lawlings', '658-905-4600', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (951, '1996-01-29', '1569 Columbus Terrace', '451551242585', 'bhenrietqb@sphinn.com', 'Bibbie Henriet', '958-816-9332', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (952, '2004-08-02', '107 Kipling Center', '770807052816', 'ayakoboviczqc@huffingtonpost.com', 'Ambrosius Yakobovicz', '875-296-6816', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (953, '2003-11-11', '1 Mayer Plaza', '529742799794', 'ssecrettqd@globo.com', 'Simonne Secrett', '869-711-2942', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (954, '1997-01-24', '270 Gateway Point', '544030451664', 'eiddonsqe@unblog.fr', 'Emanuel Iddons', '733-726-0558', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (955, '2003-09-15', '274 Dunning Hill', '344210621163', 'klarozeqf@guardian.co.uk', 'Katuscha Laroze', '175-585-8622', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (956, '1997-08-06', '6 Claremont Place', '355659353363', 'rtweddleqg@livejournal.com', 'Roanne Tweddle', '414-135-1234', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (957, '1997-01-17', '7 Vidon Park', '420027572785', 'lverneqh@booking.com', 'La verne Ivashinnikov', '247-722-4282', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (958, '2001-08-07', '3 Stoughton Hill', '291914969325', 'creicharzqi@prweb.com', 'Chane Reicharz', '374-666-1087', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (959, '2000-05-11', '7019 Anniversary Terrace', '486415465748', 'cwhetherqj@ebay.com', 'Chucho Whether', '942-625-4814', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (960, '2003-03-12', '796 Old Shore Alley', '064405522692', 'lmandersonqk@merriam-webster.com', 'Lucias Manderson', '223-471-7030', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (961, '1998-03-20', '2 Meadow Ridge Crossing', '205515435707', 'reffauntql@discuz.net', 'Robert Effaunt', '852-818-8274', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (962, '1994-11-01', '3 Vahlen Road', '584757124981', 'dkitmanqm@yolasite.com', 'Danna Kitman', '721-497-4322', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (963, '1995-10-18', '5123 Kipling Plaza', '378114285385', 'fcoweuppeqn@slideshare.net', 'Filberte Coweuppe', '908-396-7014', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (964, '1995-08-12', '6930 Northland Avenue', '618094086645', 'sperriqo@digg.com', 'Shannan Perri', '487-231-3857', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (965, '1990-12-13', '00 Veith Trail', '324613031188', 'rbardellqp@meetup.com', 'Ronna Bardell', '659-113-4558', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (966, '1997-06-09', '95 Katie Way', '776277135230', 'dboxqq@goo.ne.jp', 'Domingo Box', '410-874-8968', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (967, '2003-02-08', '4218 Banding Plaza', '810859442494', 'nrenisonqr@cbslocal.com', 'Natala Renison', '943-462-5348', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (968, '1991-03-13', '378 Service Court', '825823798471', 'xkearleyqs@google.ru', 'Xever Kearley', '956-563-7878', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (969, '2005-08-15', '85431 Monterey Street', '581543885681', 'bhixsonqt@elegantthemes.com', 'Berthe Hixson', '901-224-0013', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (970, '2000-07-29', '953 Glendale Junction', '570813174980', 'wmatteoliqu@github.com', 'Waiter Matteoli', '372-886-9385', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (971, '2001-12-18', '535 Sunfield Circle', '070206229693', 'tmccroaryqv@list-manage.com', 'Terrijo McCroary', '624-735-8085', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (972, '2002-09-24', '0582 Chinook Lane', '763548269396', 'kroxbroughqw@boston.com', 'Kahaleel Roxbrough', '394-992-1692', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (973, '2000-06-19', '17947 Parkside Center', '338065897821', 'abevansqx@uiuc.edu', 'Ashley Bevans', '698-731-9928', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (974, '2002-09-16', '522 Burrows Parkway', '673814492927', 'faldenqy@usa.gov', 'Flem Alden', '252-980-9682', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (975, '2003-04-08', '77120 Cambridge Hill', '570151800888', 'ldorkingqz@mlb.com', 'Ludovika Dorking', '190-485-1422', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (976, '2000-03-08', '74 Londonderry Street', '067834008719', 'sbackhouser0@github.com', 'Sauncho Backhouse', '391-727-4181', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (977, '1992-07-09', '2 Vahlen Hill', '543132564910', 'rprendeguestr1@taobao.com', 'Roana Prendeguest', '512-531-2128', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (978, '1998-01-14', '53755 Logan Crossing', '864953980005', 'jluggarr2@list-manage.com', 'Jennica Luggar', '690-806-3193', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (979, '1997-04-06', '5105 Holmberg Avenue', '867341844885', 'cwoodroughr3@abc.net.au', 'Consalve Woodrough', '128-429-4301', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (980, '2003-07-10', '2911 Weeping Birch Pass', '377701796081', 'tcollocottr4@hubpages.com', 'Tallie Collocott', '134-547-5283', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (981, '1999-09-10', '6 Crowley Avenue', '103289184537', 'lwhiskerr5@baidu.com', 'Layne Whisker', '560-534-7029', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (982, '1993-12-07', '6441 Lillian Crossing', '145790329156', 'nruddochr6@europa.eu', 'Nina Ruddoch', '629-515-1459', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (983, '1990-09-27', '9667 Huxley Lane', '793586138001', 'nscrimshawr7@woothemes.com', 'Nefen Scrimshaw', '151-598-0259', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (984, '2005-04-11', '71 South Hill', '950444644064', 'mdawesr8@drupal.org', 'Melania Dawes', '584-730-8382', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (985, '1999-01-09', '764 Sunbrook Center', '383116335842', 'hacremanr9@jiathis.com', 'Harmon Acreman', '424-189-5747', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (986, '2002-12-21', '612 Havey Crossing', '778984081872', 'aaskerra@nydailynews.com', 'Adriaens Asker', '988-743-7753', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (987, '1993-04-26', '17 Cherokee Parkway', '486363935626', 'geberleinrb@google.co.jp', 'Gisele Eberlein', '674-474-7839', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (988, '1999-04-24', '62 Kropf Pass', '011529570120', 'hcuddehayrc@cnn.com', 'Holly Cuddehay', '754-345-4973', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (989, '1993-07-22', '65 Springview Road', '421240086330', 'wkepperd@discovery.com', 'Wallas Keppe', '929-774-5092', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (990, '1994-06-29', '53 Linden Drive', '440388716614', 'wdrinkalere@ezinearticles.com', 'Westley Drinkale', '652-400-7926', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (991, '2001-05-05', '80622 Coolidge Place', '940006735573', 'blambournerf@jugem.jp', 'Barbabra Lambourne', '436-246-1352', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (992, '1999-04-08', '0 Manufacturers Point', '070096210961', 'tiglesiazrg@addthis.com', 'Toby Iglesiaz', '466-428-0853', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (993, '1995-11-21', '63038 Kim Place', '710278851591', 'lcutsforthrh@blogs.com', 'Laurence Cutsforth', '134-788-5369', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (994, '2000-06-07', '8 Burrows Hill', '424177570164', 'kzienkiewiczri@domainmarket.com', 'Kiersten Zienkiewicz', '285-118-6917', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (995, '1990-06-17', '99 Corscot Hill', '608265853412', 'hruprichrj@google.de', 'Hephzibah Ruprich', '804-166-0163', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (996, '2001-08-03', '81 Kenwood Court', '539022486128', 'yabethellrk@livejournal.com', 'Yvon Abethell', '920-862-6122', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (997, '2000-06-30', '7 Kim Avenue', '038649218388', 'mmartinerl@seattletimes.com', 'Massimo Martine', '348-850-3396', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (998, '2002-04-08', '810 Victoria Pass', '043816602597', 'bpeakmanrm@ustream.tv', 'Bevvy Peakman', '228-469-7453', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (999, '2003-05-18', '48327 Crowley Plaza', '388812877003', 'slungern@behance.net', 'Sharla Lunge', '246-478-6289', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1000, '2000-04-26', '022 Iowa Terrace', '252231576337', 'ccorthesro@sciencedirect.com', 'Charyl Corthes', '554-262-9817', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1001, '1999-07-02', '625 Jana Center', '734590053109', 'bwylemanrp@yahoo.co.jp', 'Brigham Wyleman', '764-223-9992', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1002, '1990-02-12', '3 Sachs Trail', '383377728239', 'yriggollrq@latimes.com', 'Yorker Riggoll', '848-442-7272', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1003, '1999-07-10', '62206 Sunbrook Hill', '686832796938', 'zsimonsenrr@lulu.com', 'Zsazsa Simonsen', '612-106-0851', 'MEMBER');
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1006, '2023-01-09', '4899 Bluejay Junction', '123456678111', 'esuffe0@angelfire.com', 'Evangelia', '2567119510', NULL);
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1007, '2024-02-04', '56152 Derek Hill', '123456678112', 'wpauls1@chronoengine.com', 'Wyn', '8984963723', NULL);
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1008, '2024-02-03', '87897 Melby Avenue', '123456678131', 'ncorkitt2@miibeian.gov.cn', 'Nonah', '8184765441', NULL);
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1009, '2024-02-03', '8 Harper Center', '123456678114', 'rdace3@mozilla.org', 'Roselle', '4698362722', NULL);
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1010, '2024-01-03', '228 Lakewood Center', '123456678115', 'mlippini4@google.ca', 'Margi', '7603146057', NULL);
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1011, '2023-01-10', '7 Warbler Court', '126456678111', 'rsteaning5@timesonline.co.uk', 'Rorke', '5014711483', NULL);
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1012, '2023-09-03', '44 Schiller Park', '123456678711', 'sshirley6@rambler.ru', 'Sonnie', '9325495948', NULL);
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1013, '2024-10-01', '61 Rowland Parkway', '123456678211', 'bfoy7@soundcloud.com', 'Babita', '7667657641', NULL);
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1014, '2024-10-01', '268 Springview Parkway', '143456678111', 'taldcorne8@deliciousdays.com', 'Theressa', '1472945175', NULL);
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (1015, '2024-04-01', '5 John Wall Avenue', '123456678911', 'pneeson9@bluehost.com', 'Patrice', '1035351482', NULL);
INSERT INTO public.profile (id, dob, address, cccd_id, email, name, phone, user_role) VALUES (2, NULL, 'Minh Khai, Hai Ba Trung, Ha Noi', '098754321324', 'anhn@gmail.com', 'Ngô Nhất An', '0982736162', 'MANAGER');


--
-- TOC entry 4979 (class 0 OID 58866)
-- Dependencies: 239
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.role (id, description, name) VALUES (1, 'thành viên đăng kí sử dụng dịch vụ mượn trả sách của thư viện', 'member');
INSERT INTO public.role (id, description, name) VALUES (2, 'Quản lí chung sách, phiếu nhập, phiếu thanh lí, phiếu mượn, đọc hồ sơ nhân viên , tài khoản, vai trò và quyền', 'manager');
INSERT INTO public.role (id, description, name) VALUES (3, 'Thủ thư có thể quản lí sách, phiếu nhập, phiếu xuất, tạo và chấp nhận phiếu mượn, cập nhập thông tin cá nhân', 'librarian');


--
-- TOC entry 4980 (class 0 OID 58874)
-- Dependencies: 240
-- Data for Name: role_has_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 1);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 2);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 3);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 4);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 5);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 6);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 7);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 8);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 9);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 10);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 11);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 12);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 13);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 14);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 15);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 16);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 17);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 18);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 19);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 20);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 21);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 22);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 23);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 24);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 25);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 26);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 27);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 28);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 29);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 30);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 31);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (2, 32);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 1);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 3);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 4);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 7);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 9);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 10);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 14);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 16);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 17);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 18);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 20);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 22);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 23);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 24);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 25);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 26);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 27);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 29);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 30);
INSERT INTO public.role_has_permissions (role_id, permission_id) VALUES (3, 31);


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 217
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_id_seq', 11, true);


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 221
-- Name: book_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_category_id_seq', 46, true);


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 223
-- Name: book_class_number_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_class_number_id_seq', 46, true);


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 219
-- Name: book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_id_seq', 1478, true);


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 226
-- Name: borrow_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.borrow_ticket_id_seq', 1, false);


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 228
-- Name: file_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.file_storage_id_seq', 21, true);


--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 230
-- Name: import_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.import_ticket_id_seq', 13, true);


--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 232
-- Name: liquidation_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.liquidation_ticket_id_seq', 1, false);


--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 215
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_id_seq', 1, true);


--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 234
-- Name: permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permission_id_seq', 32, true);


--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 236
-- Name: profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profile_id_seq', 1015, true);


--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 238
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_seq', 3, true);


--
-- TOC entry 4758 (class 2606 OID 58774)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 4760 (class 2606 OID 58979)
-- Name: account account_profile_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_profile_id_key UNIQUE (profile_id);


--
-- TOC entry 4762 (class 2606 OID 58981)
-- Name: account account_role_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_role_id_key UNIQUE (role_id);


--
-- TOC entry 4772 (class 2606 OID 58793)
-- Name: book_category book_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_category
    ADD CONSTRAINT book_category_pkey PRIMARY KEY (id);


--
-- TOC entry 4774 (class 2606 OID 58800)
-- Name: book_class_number book_class_number_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_class_number
    ADD CONSTRAINT book_class_number_pkey PRIMARY KEY (id);


--
-- TOC entry 4770 (class 2606 OID 58784)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);


--
-- TOC entry 4776 (class 2606 OID 58805)
-- Name: borrow_book borrow_book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_book
    ADD CONSTRAINT borrow_book_pkey PRIMARY KEY (book_id, borrow_ticket_id);


--
-- TOC entry 4778 (class 2606 OID 58815)
-- Name: borrow_ticket borrow_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_ticket
    ADD CONSTRAINT borrow_ticket_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 58888)
-- Name: profile cccd_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT cccd_id UNIQUE (cccd_id);


--
-- TOC entry 4780 (class 2606 OID 58825)
-- Name: file_storage file_storage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_storage
    ADD CONSTRAINT file_storage_pkey PRIMARY KEY (id);


--
-- TOC entry 4782 (class 2606 OID 58835)
-- Name: import_ticket import_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_ticket
    ADD CONSTRAINT import_ticket_pkey PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 58845)
-- Name: liquidation_ticket liquidation_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liquidation_ticket
    ADD CONSTRAINT liquidation_ticket_pkey PRIMARY KEY (id);


--
-- TOC entry 4786 (class 2606 OID 58886)
-- Name: permission name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT name UNIQUE (name);


--
-- TOC entry 4756 (class 2606 OID 43892)
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- TOC entry 4764 (class 2606 OID 58880)
-- Name: account password; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT password UNIQUE (password);


--
-- TOC entry 4788 (class 2606 OID 58854)
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id);


--
-- TOC entry 4792 (class 2606 OID 58864)
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (id);


--
-- TOC entry 4796 (class 2606 OID 58878)
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- TOC entry 4794 (class 2606 OID 58873)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 4766 (class 2606 OID 58884)
-- Name: account uk_5e7ep7h84faaq5axp3t2exkis; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT uk_5e7ep7h84faaq5axp3t2exkis UNIQUE (role_id);


--
-- TOC entry 4768 (class 2606 OID 58882)
-- Name: account uk_lx5o8xa39akufx3vih7fto4gj; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT uk_lx5o8xa39akufx3vih7fto4gj UNIQUE (profile_id);


--
-- TOC entry 4804 (class 2606 OID 58929)
-- Name: borrow_ticket fk5jeyed2y8cfuge39fqmvrl1dd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_ticket
    ADD CONSTRAINT fk5jeyed2y8cfuge39fqmvrl1dd FOREIGN KEY (member_id) REFERENCES public.profile(id);


--
-- TOC entry 4799 (class 2606 OID 58899)
-- Name: book fk5jgwecmfn1vyn9jtld3o64v4x; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT fk5jgwecmfn1vyn9jtld3o64v4x FOREIGN KEY (category_id) REFERENCES public.book_category(id);


--
-- TOC entry 4806 (class 2606 OID 58934)
-- Name: import_ticket fk7c3gfdr4pbedlnxwrr13nadf4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_ticket
    ADD CONSTRAINT fk7c3gfdr4pbedlnxwrr13nadf4 FOREIGN KEY (approver_id) REFERENCES public.profile(id);


--
-- TOC entry 4802 (class 2606 OID 58914)
-- Name: borrow_book fk8c6sb7c2jaa4gnrdmhj638hvb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_book
    ADD CONSTRAINT fk8c6sb7c2jaa4gnrdmhj638hvb FOREIGN KEY (borrow_ticket_id) REFERENCES public.book(id);


--
-- TOC entry 4803 (class 2606 OID 58919)
-- Name: borrow_book fk9acatl35gx33rewsmk7uotuvv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_book
    ADD CONSTRAINT fk9acatl35gx33rewsmk7uotuvv FOREIGN KEY (book_id) REFERENCES public.borrow_ticket(id);


--
-- TOC entry 4797 (class 2606 OID 58894)
-- Name: account fkd4vb66o896tay3yy52oqxr9w0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT fkd4vb66o896tay3yy52oqxr9w0 FOREIGN KEY (role_id) REFERENCES public.role(id);


--
-- TOC entry 4805 (class 2606 OID 58924)
-- Name: borrow_ticket fkg7rln0oiwtktv5igx5q0pkelp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_ticket
    ADD CONSTRAINT fkg7rln0oiwtktv5igx5q0pkelp FOREIGN KEY (librarian_id) REFERENCES public.profile(id);


--
-- TOC entry 4810 (class 2606 OID 58954)
-- Name: role_has_permissions fki6o5mxxguk2r0wigg2oer2jqj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT fki6o5mxxguk2r0wigg2oer2jqj FOREIGN KEY (permission_id) REFERENCES public.permission(id);


--
-- TOC entry 4798 (class 2606 OID 58889)
-- Name: account fklelt1dhpyk7dqxdco3x3cd5ub; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT fklelt1dhpyk7dqxdco3x3cd5ub FOREIGN KEY (profile_id) REFERENCES public.profile(id);


--
-- TOC entry 4808 (class 2606 OID 58949)
-- Name: liquidation_ticket fkmks0efoyrobcdnphqpp8bne9m; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liquidation_ticket
    ADD CONSTRAINT fkmks0efoyrobcdnphqpp8bne9m FOREIGN KEY (creator_id) REFERENCES public.profile(id);


--
-- TOC entry 4800 (class 2606 OID 58904)
-- Name: book fknu4jk7l32o46t949ge715323v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT fknu4jk7l32o46t949ge715323v FOREIGN KEY (number_id) REFERENCES public.book_class_number(id);


--
-- TOC entry 4801 (class 2606 OID 58909)
-- Name: book fkp0iq3pxev8n0at8hkxx2u36cy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT fkp0iq3pxev8n0at8hkxx2u36cy FOREIGN KEY (liquidation_ticket_id) REFERENCES public.liquidation_ticket(id);


--
-- TOC entry 4811 (class 2606 OID 58959)
-- Name: role_has_permissions fkqn0h8eumwirhbm7ibv3jus36; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT fkqn0h8eumwirhbm7ibv3jus36 FOREIGN KEY (role_id) REFERENCES public.role(id);


--
-- TOC entry 4809 (class 2606 OID 58944)
-- Name: liquidation_ticket fkrqb4144bmmooxgyw8mmo2tfo5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liquidation_ticket
    ADD CONSTRAINT fkrqb4144bmmooxgyw8mmo2tfo5 FOREIGN KEY (approver_id) REFERENCES public.profile(id);


--
-- TOC entry 4807 (class 2606 OID 58939)
-- Name: import_ticket fktbjyc54ffmdv8uxm5j0klhvml; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_ticket
    ADD CONSTRAINT fktbjyc54ffmdv8uxm5j0klhvml FOREIGN KEY (creator_id) REFERENCES public.profile(id);


-- Completed on 2024-07-26 21:51:01

--
-- PostgreSQL database dump complete
--

