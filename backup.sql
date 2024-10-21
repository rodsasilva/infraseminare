--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg22.04+2)

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
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: avaliacoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avaliacoes (
    id text NOT NULL,
    data timestamp(3) without time zone NOT NULL,
    "dataCarimbo" timestamp(3) without time zone NOT NULL,
    avaliador text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    "deletedAt" timestamp(3) without time zone,
    nome text,
    cpf text NOT NULL,
    nascimento timestamp(3) without time zone,
    idade integer,
    genero text,
    escolaridade text,
    gmin text,
    "unidadeGm" text,
    "numeroRegistro" text,
    cidade text,
    cargo text,
    "turnoTrabalho" text,
    "setorTrabalho" text,
    "posturaAvaliacao" text,
    "interesseAvaliacao" text,
    "motivoAvaliacao" text,
    "modoComportamento" text,
    "funcoesCognitivas" text,
    "atividadeRisco" boolean,
    "frequenciaRisco" text,
    "riscoAltura" boolean,
    "riscoBrigadista" boolean,
    "riscoEletricistaAltaTensao" boolean,
    "riscoEletricistaBaixaTensao" boolean,
    "riscoEspacoConfinadoVigiasTrabalhadores" boolean,
    "riscoEspacoConfinadoSupervisorEntrada" boolean,
    "riscoPlataformaElevatoria" boolean,
    "riscoPonteRolanteControleRemoto" boolean,
    "riscoPonteRolanteCabine" boolean,
    "riscoTalhaEletrica" boolean,
    "riskoVeiculosIndustriais" boolean,
    "riscoOutros" boolean,
    "riscoOutrosConteudo" text,
    "testesUtilizados" text,
    "produtividadePalo" text,
    "tracoPersonalidade" text,
    nor text,
    "resultadoTesteAtencao" text,
    "resultadoTesteEvent" text,
    "climaOrganizacional" text,
    "pressaoTrabalho" text,
    "infraRotina" text,
    "grauAdaptabilidade" text,
    "nivelAdapatacaoPercebido" text,
    "aptoCargo" text,
    "aptoRisco" text,
    recomendacoes text,
    "geraCarta" boolean,
    "tipoCarta" text,
    "origemInaptidao" text,
    "textoCartaInaptidao" text,
    "nivelRiscoPercebido" text,
    "evolucaoInapto" text,
    observacoes text,
    "observacoesInaptos" text,
    "observacoesRestritas" text,
    "retiradaAtividadeRisco" boolean,
    "nivelSatisfacao" text,
    "opiniaoEmpregado" text,
    "cartaDoc" text,
    "cartaPDF" text,
    "laudoDoc" text,
    "laudoPDF" text
);


ALTER TABLE public.avaliacoes OWNER TO postgres;

--
-- Name: avaliacoes_gm; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.avaliacoes_gm AS
 SELECT (("dataCarimbo" AT TIME ZONE 'UTC'::text) AT TIME ZONE 'America/Sao_Paulo'::text) AS "Carimbo de data/hora",
    ((data AT TIME ZONE 'UTC'::text) AT TIME ZONE 'America/Sao_Paulo'::text) AS "DATA DA AVALIAÇÃO",
    avaliador AS "AVALIADOR",
    nome AS "NOME",
    regexp_replace(cpf, '(\d{3})(\d{3})(\d{3})(\d{2})'::text, '\1.\2.\3-\4'::text) AS "CPF",
    idade AS "IDADE",
    genero AS "GENERO",
    escolaridade AS "ESCOLARIDADE",
    gmin AS "GMIN",
    "unidadeGm" AS "UNIDADE GM",
    "numeroRegistro" AS "NUMERO DE REGISTRO",
    cidade AS "CIDADE",
    cargo AS "CARGO/FUNÇÃO",
    "turnoTrabalho" AS "Turno de Trabalho",
    "setorTrabalho" AS "Área/Setor de Trabalho",
    "posturaAvaliacao" AS "POSTURA DURANTE A AVALIAÇÃO",
    "interesseAvaliacao" AS "INTERESSE NA AVALIAÇÃO",
    "motivoAvaliacao" AS "MOTIVO DA AVALIAÇÃO",
    "modoComportamento" AS "COMPORTOU-SE DE MODO",
    "funcoesCognitivas" AS "FUNÇÕES COGNITIVAS",
        CASE
            WHEN "atividadeRisco" THEN 'SIM'::text
            ELSE 'NÃO'::text
        END AS "Este avaliando realiza atividades de risco?",
    "frequenciaRisco" AS "FREQUÊNCIA DE EXPOSIÇÃO AO RISCO",
        CASE
            WHEN "riscoAltura" THEN 'X'::text
            ELSE ''::text
        END AS "[ALTURA]",
        CASE
            WHEN "riscoBrigadista" THEN 'X'::text
            ELSE ''::text
        END AS "[BRIGADISTA]",
        CASE
            WHEN "riscoEletricistaAltaTensao" THEN 'X'::text
            ELSE ''::text
        END AS "[ELETRICISTA DE ALTA TENSÃO]",
        CASE
            WHEN "riscoEletricistaBaixaTensao" THEN 'X'::text
            ELSE ''::text
        END AS "[ELETRICISTA DE BAIXA TENSÃO]",
        CASE
            WHEN "riscoEspacoConfinadoVigiasTrabalhadores" THEN 'X'::text
            ELSE ''::text
        END AS "[ESPAÇO CONFINADO VIGIAS E TRABALHADORES]",
        CASE
            WHEN "riscoEspacoConfinadoSupervisorEntrada" THEN 'X'::text
            ELSE ''::text
        END AS "[ESPAÇO CONFINADO SUPERVISOR DE ENTRADA]",
        CASE
            WHEN "riscoPlataformaElevatoria" THEN 'X'::text
            ELSE ''::text
        END AS "[PLATAFORMA ELEVATÓRIA]",
        CASE
            WHEN "riscoPonteRolanteControleRemoto" THEN 'X'::text
            ELSE ''::text
        END AS "[PONTE ROLANTE COM CONTROLE REMOTO]",
        CASE
            WHEN "riscoPonteRolanteCabine" THEN 'X'::text
            ELSE ''::text
        END AS "[PONTE ROLANTE CABINE]",
        CASE
            WHEN "riscoTalhaEletrica" THEN 'X'::text
            ELSE ''::text
        END AS "[TALHA ELETRICA]",
        CASE
            WHEN "riskoVeiculosIndustriais" THEN 'X'::text
            ELSE ''::text
        END AS "[VEICULOS INDUSTRIAIS]",
        CASE
            WHEN "riscoOutros" THEN 'X'::text
            ELSE ''::text
        END AS "[OUTROS]",
    "riscoOutrosConteudo" AS "CONTEÚDO DE OUTROS",
    "testesUtilizados" AS "TESTE DE ATENÇÃO UTILIZADO",
    "produtividadePalo" AS "PRODUTIVIDADE DO PALO",
    "tracoPersonalidade" AS "TRAÇO DE PERSONALIDADE",
    nor AS "NOR",
    "resultadoTesteAtencao" AS "RESULTADO DO TESTE DE ATENÇÃO",
    "resultadoTesteEvent" AS "RESULTADO GERAL - EVENT",
    "climaOrganizacional" AS "CLIMA E FUNCIONAMENTO ORGANIZACIONAL",
    "pressaoTrabalho" AS "PRESSÃO NO TRABALHO",
    "infraRotina" AS "INFRAESTRUTURA E ROTINA",
    "grauAdaptabilidade" AS "GRAU DE ADAPTABILIDADE",
    "nivelAdapatacaoPercebido" AS "NIVEL DE ADAPTAÇÃO NA PERCEPÇÃO DO PSI",
    "aptoCargo" AS "APTO OU INAPTO PARA O CARGO",
    "aptoRisco" AS "APTO OU INAPTO PARA AS ATIVIDADES DE RISCO",
    recomendacoes AS "RECOMENDAÇÕES",
        CASE
            WHEN "geraCarta" THEN 'SIM'::text
            ELSE 'NÃO'::text
        END AS "GERAR CARTA DE INAPTIDÃO/RECOMENDAÇÃO?",
    "tipoCarta" AS "TIPO DE CARTA",
    "origemInaptidao" AS "ORIGEM DA CONDIÇÃO DE INAPTIDÃO",
    "textoCartaInaptidao" AS "TEXTO DA CARTA DE INAPTIDÃO/RECOMENDAÇÃO",
    "nivelRiscoPercebido" AS "NIVEL DE RISCO NA PERCEPÇÃO DO PSI",
    "evolucaoInapto" AS "EVOLUÇÃO DO INAPTO",
    observacoes AS "OBSERVAÇÕES",
    "observacoesRestritas" AS "OBSERVAÇÕES RESTRITAS",
        CASE
            WHEN "retiradaAtividadeRisco" THEN 'SIM'::text
            ELSE 'NÃO'::text
        END AS "DESEJA INFORMAR RETIRADA DE ATIVIDADE DE RISCO?",
    "nivelSatisfacao" AS "NIVEL DE SATISFAÇÃO DO EMPREGADO",
    "opiniaoEmpregado" AS "OPINIÃO DO EMPREGADO A RESPEITO DA AVALIAÇÃO PSICOSSOCIAL",
    "cartaDoc" AS "CARTA DOC",
    "cartaPDF" AS "CARTA PDF",
    "laudoDoc" AS "LAUDO DOC",
    "laudoPDF" AS "LAUDO PDF"
   FROM public.avaliacoes;


ALTER VIEW public.avaliacoes_gm OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id text NOT NULL,
    "importId" text,
    name text,
    email text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    "googleId" text,
    "avatarUrl" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    "deletedAt" timestamp(3) without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
7302887d-fe71-401e-b2fc-ccb873b01522	6b63b65429a8c84bae2cfbca48081b215ef09ac6f018939be5f5e2da87ab6034	2024-10-21 14:08:18.55929+00	20241018024148_init	\N	\N	2024-10-21 14:08:17.636009+00	1
\.


--
-- Data for Name: avaliacoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.avaliacoes (id, data, "dataCarimbo", avaliador, "createdAt", "updatedAt", "deletedAt", nome, cpf, nascimento, idade, genero, escolaridade, gmin, "unidadeGm", "numeroRegistro", cidade, cargo, "turnoTrabalho", "setorTrabalho", "posturaAvaliacao", "interesseAvaliacao", "motivoAvaliacao", "modoComportamento", "funcoesCognitivas", "atividadeRisco", "frequenciaRisco", "riscoAltura", "riscoBrigadista", "riscoEletricistaAltaTensao", "riscoEletricistaBaixaTensao", "riscoEspacoConfinadoVigiasTrabalhadores", "riscoEspacoConfinadoSupervisorEntrada", "riscoPlataformaElevatoria", "riscoPonteRolanteControleRemoto", "riscoPonteRolanteCabine", "riscoTalhaEletrica", "riskoVeiculosIndustriais", "riscoOutros", "riscoOutrosConteudo", "testesUtilizados", "produtividadePalo", "tracoPersonalidade", nor, "resultadoTesteAtencao", "resultadoTesteEvent", "climaOrganizacional", "pressaoTrabalho", "infraRotina", "grauAdaptabilidade", "nivelAdapatacaoPercebido", "aptoCargo", "aptoRisco", recomendacoes, "geraCarta", "tipoCarta", "origemInaptidao", "textoCartaInaptidao", "nivelRiscoPercebido", "evolucaoInapto", observacoes, "observacoesInaptos", "observacoesRestritas", "retiradaAtividadeRisco", "nivelSatisfacao", "opiniaoEmpregado", "cartaDoc", "cartaPDF", "laudoDoc", "laudoPDF") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, "importId", name, email, active, "googleId", "avatarUrl", "createdAt", "updatedAt", "deletedAt") FROM stdin;
cm2j3dtc400003h1yn7dvni11	\N	Paulo Cruz	cruzpaulo@gmail.com	t	\N	\N	2024-10-21 14:08:35.525	2024-10-21 14:08:35.525	\N
cm2j3due500023h1yjz5s3yv7	\N	Diogo Herminio	dafsonic@gmail.com	t	\N	\N	2024-10-21 14:08:35.525	2024-10-21 14:08:35.525	\N
cm2j547v00000d0567eujrh8h	10	Seminare Psicologia	seminarepsicologia@gmail.com	t	\N	\N	2024-10-21 14:57:07.019	2024-10-21 14:57:07.019	\N
\.


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: avaliacoes avaliacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacoes
    ADD CONSTRAINT avaliacoes_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- PostgreSQL database dump complete
--

