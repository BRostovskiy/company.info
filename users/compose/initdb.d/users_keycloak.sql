--
-- PostgreSQL database dump
--

-- Dumped from database version 11.20
-- Dumped by pg_dump version 11.20

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

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


--
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: component; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


--
-- Name: component_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- Name: credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer,
    version integer DEFAULT 0
);


--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL,
    description character varying(255)
);


--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


--
-- Name: org; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: realm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: server_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
13f3ce9e-501e-4b41-bc12-f7fd7579604f	9b84021b-be9b-495f-996b-d5b46e71d552
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
6d549f7c-cbbd-4a5d-8c28-6a0d2805616c	\N	auth-cookie	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	f4e10254-e06b-49a2-afb1-578c8955ef81	2	10	f	\N	\N
fb9ca20b-cdec-44f1-bd71-938040936c1d	\N	auth-spnego	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	f4e10254-e06b-49a2-afb1-578c8955ef81	3	20	f	\N	\N
7867556c-4510-482a-8a6d-0131027a3a69	\N	identity-provider-redirector	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	f4e10254-e06b-49a2-afb1-578c8955ef81	2	25	f	\N	\N
b46f8214-3d8a-45f8-80be-10a5293ce43b	\N	\N	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	f4e10254-e06b-49a2-afb1-578c8955ef81	2	30	t	65b0a85e-4fa2-4133-849a-dfe04f202057	\N
5489cdbf-0612-4eaa-b5bf-03e5c2fd7555	\N	auth-username-password-form	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	65b0a85e-4fa2-4133-849a-dfe04f202057	0	10	f	\N	\N
1f13842d-b850-4804-a324-9f4014126849	\N	\N	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	65b0a85e-4fa2-4133-849a-dfe04f202057	1	20	t	38b93d3a-842f-4e75-885a-fd25011db1be	\N
2313bde0-c029-4d12-ad4e-1264ce04f47c	\N	conditional-user-configured	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	38b93d3a-842f-4e75-885a-fd25011db1be	0	10	f	\N	\N
bfbc1c8e-a067-4758-a11a-5fe5816a2882	\N	auth-otp-form	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	38b93d3a-842f-4e75-885a-fd25011db1be	2	20	f	\N	\N
03c9ab7b-b78c-4c53-a6dc-5d4d1fcd25c5	\N	webauthn-authenticator	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	38b93d3a-842f-4e75-885a-fd25011db1be	3	30	f	\N	\N
f24dcb8d-0ab7-473d-b533-0f98c04f7dcb	\N	auth-recovery-authn-code-form	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	38b93d3a-842f-4e75-885a-fd25011db1be	3	40	f	\N	\N
490d7678-530d-4e32-bc9a-ba71759e3815	\N	direct-grant-validate-username	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	0445f87f-73e8-428a-b92b-036ee35b7859	0	10	f	\N	\N
7371904b-e4a1-4247-9662-ba04e24793f3	\N	direct-grant-validate-password	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	0445f87f-73e8-428a-b92b-036ee35b7859	0	20	f	\N	\N
b0dfcb3e-ba01-4dc2-acd1-cddd9d2b9986	\N	\N	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	0445f87f-73e8-428a-b92b-036ee35b7859	1	30	t	81c293ad-e1c0-4886-a9fc-189b531513eb	\N
913c4c3a-a3a6-4056-ad85-352b1f0bc0b5	\N	conditional-user-configured	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	81c293ad-e1c0-4886-a9fc-189b531513eb	0	10	f	\N	\N
1ca928f3-8279-4f5f-858a-f57510c8a67f	\N	direct-grant-validate-otp	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	81c293ad-e1c0-4886-a9fc-189b531513eb	0	20	f	\N	\N
f2f3b13e-a2c0-4f37-b923-4f5e0ea066fd	\N	registration-page-form	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	c3a7f5aa-7a02-490b-b02c-2ad8df936350	0	10	t	97558fbf-a2cc-4f61-8d3e-0b9ef045519b	\N
331d69ee-2352-4840-9315-a31ba5c1fdb9	\N	registration-user-creation	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	97558fbf-a2cc-4f61-8d3e-0b9ef045519b	0	20	f	\N	\N
33f78b5e-aca2-4cda-990b-3a3179061917	\N	registration-password-action	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	97558fbf-a2cc-4f61-8d3e-0b9ef045519b	0	50	f	\N	\N
9e1827ac-a849-46a4-8f72-9cd862a67353	\N	registration-recaptcha-action	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	97558fbf-a2cc-4f61-8d3e-0b9ef045519b	3	60	f	\N	\N
4983730e-80b9-4757-b9a4-06b06c1ef6d8	\N	registration-terms-and-conditions	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	97558fbf-a2cc-4f61-8d3e-0b9ef045519b	3	70	f	\N	\N
7300021b-e0e0-4a4a-9c13-5219ded35d32	\N	reset-credentials-choose-user	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	e0ba9c72-75e8-45e7-b949-2cf004810e6b	0	10	f	\N	\N
ec10f77d-c572-4820-be75-27348754437d	\N	reset-credential-email	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	e0ba9c72-75e8-45e7-b949-2cf004810e6b	0	20	f	\N	\N
4387a62f-4d05-4998-9f81-743ff33f7816	\N	reset-password	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	e0ba9c72-75e8-45e7-b949-2cf004810e6b	0	30	f	\N	\N
5498d069-87b9-4d40-b53a-e09ec8fe5bac	\N	\N	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	e0ba9c72-75e8-45e7-b949-2cf004810e6b	1	40	t	ea1ba730-ca72-44fe-ab33-4735375b838c	\N
19087d1f-1af7-4975-8cd3-3fcee456f4be	\N	conditional-user-configured	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	ea1ba730-ca72-44fe-ab33-4735375b838c	0	10	f	\N	\N
808f4d60-11ef-44d8-bb93-00429f33c58a	\N	reset-otp	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	ea1ba730-ca72-44fe-ab33-4735375b838c	0	20	f	\N	\N
b471c339-1ddb-403b-826f-a0855afb8e05	\N	client-secret	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	fd1b36d1-1760-4981-9db3-c76774617ac9	2	10	f	\N	\N
9a7c8d87-7942-4362-b75c-914018913e36	\N	client-jwt	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	fd1b36d1-1760-4981-9db3-c76774617ac9	2	20	f	\N	\N
09b5df22-6075-4644-a1ec-0af1b289727d	\N	client-secret-jwt	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	fd1b36d1-1760-4981-9db3-c76774617ac9	2	30	f	\N	\N
dd5f7b46-ab3a-4f57-ab51-6cb559bdd6df	\N	client-x509	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	fd1b36d1-1760-4981-9db3-c76774617ac9	2	40	f	\N	\N
506747f9-0c09-49d7-a08f-450925e9aee9	\N	idp-review-profile	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	5634af62-d1bd-411b-89c2-e7f96dd40ac3	0	10	f	\N	45cb4623-e846-47b3-a29c-b0425d447280
5baced20-d086-4156-bdfc-48ee0c17e0b2	\N	\N	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	5634af62-d1bd-411b-89c2-e7f96dd40ac3	0	20	t	e50e3b9e-8cf0-4498-ad06-e937e22d75e7	\N
83605eca-4ccb-4752-8abf-f2ba4e15db13	\N	idp-create-user-if-unique	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	e50e3b9e-8cf0-4498-ad06-e937e22d75e7	2	10	f	\N	1d1e09f9-cca4-4a89-9093-d1bde0dc5b40
6ca5277d-bcf9-4f2a-9bf2-fc17a1191b6a	\N	\N	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	e50e3b9e-8cf0-4498-ad06-e937e22d75e7	2	20	t	a09ebb54-26dc-4e5b-93c1-1489751079ad	\N
019dd366-851c-462b-8924-99658ea0de27	\N	idp-confirm-link	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a09ebb54-26dc-4e5b-93c1-1489751079ad	0	10	f	\N	\N
30f62091-3f14-488b-af17-a853a8e1c7ed	\N	\N	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a09ebb54-26dc-4e5b-93c1-1489751079ad	0	20	t	6082a0b8-c335-44fc-bab6-ae6253052f6c	\N
7945c929-05b4-4185-9e75-d8cdfc07ea56	\N	idp-email-verification	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	6082a0b8-c335-44fc-bab6-ae6253052f6c	2	10	f	\N	\N
679fe018-4e6c-403b-8d1c-295a4c494cff	\N	\N	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	6082a0b8-c335-44fc-bab6-ae6253052f6c	2	20	t	8ce5d53c-dd6d-4f54-aea5-bda806983b78	\N
a703b421-421c-4d9b-93da-1b18e5014e0c	\N	idp-username-password-form	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	8ce5d53c-dd6d-4f54-aea5-bda806983b78	0	10	f	\N	\N
bad926a6-9efc-47f4-881f-a26f50d92489	\N	\N	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	8ce5d53c-dd6d-4f54-aea5-bda806983b78	1	20	t	349baa8a-ccb7-4925-b361-e8484c081976	\N
bc7657b3-cff0-4322-a3b2-f1327ea199cc	\N	conditional-user-configured	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	349baa8a-ccb7-4925-b361-e8484c081976	0	10	f	\N	\N
4ddf3b60-3387-4902-854f-3832432267ab	\N	auth-otp-form	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	349baa8a-ccb7-4925-b361-e8484c081976	2	20	f	\N	\N
9255e151-20ad-4aaf-939a-74f09cae4ba7	\N	webauthn-authenticator	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	349baa8a-ccb7-4925-b361-e8484c081976	3	30	f	\N	\N
c54e882e-811c-490a-b885-7253fbc0215a	\N	auth-recovery-authn-code-form	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	349baa8a-ccb7-4925-b361-e8484c081976	3	40	f	\N	\N
135abe8b-8e70-4ea0-809d-328b1fc3294f	\N	http-basic-authenticator	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	74a21a4b-5ee9-47ad-9ec9-25871bc8736e	0	10	f	\N	\N
89a01958-a1ad-4ecf-a743-1c42d5f0b847	\N	docker-http-basic-authenticator	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	b4a11079-de7d-411a-84d4-d3de38d3086f	0	10	f	\N	\N
78bce6f4-5a0e-4d3e-ae8f-9facdbb26b36	\N	auth-cookie	8d35e8a2-755c-44b9-84e1-cd723f651bbc	1ca7dd80-1e3b-4e96-80b0-355a8557693f	2	10	f	\N	\N
810e6cff-c931-429d-bcc6-736fe746dd11	\N	auth-spnego	8d35e8a2-755c-44b9-84e1-cd723f651bbc	1ca7dd80-1e3b-4e96-80b0-355a8557693f	3	20	f	\N	\N
d8cfaccc-a24d-4f10-a056-ae8598e76f51	\N	identity-provider-redirector	8d35e8a2-755c-44b9-84e1-cd723f651bbc	1ca7dd80-1e3b-4e96-80b0-355a8557693f	2	25	f	\N	\N
33d3d39f-6db1-408c-b732-494e2a036ce9	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	1ca7dd80-1e3b-4e96-80b0-355a8557693f	2	30	t	a37df4f9-ebbf-4657-9bcc-f42e060a15f3	\N
e57501e0-b9fc-4193-9c9b-9762997fce1a	\N	auth-username-password-form	8d35e8a2-755c-44b9-84e1-cd723f651bbc	a37df4f9-ebbf-4657-9bcc-f42e060a15f3	0	10	f	\N	\N
45c190e4-88b8-4241-b7e8-d4f3b60ce053	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	a37df4f9-ebbf-4657-9bcc-f42e060a15f3	1	20	t	647f3c82-7eae-4319-b1d7-cb93f0683350	\N
2707e02b-8734-4b52-a1d9-a23e1b460061	\N	conditional-user-configured	8d35e8a2-755c-44b9-84e1-cd723f651bbc	647f3c82-7eae-4319-b1d7-cb93f0683350	0	10	f	\N	\N
891ce53d-9a25-4952-a72c-e6e3146c391b	\N	auth-otp-form	8d35e8a2-755c-44b9-84e1-cd723f651bbc	647f3c82-7eae-4319-b1d7-cb93f0683350	2	20	f	\N	\N
cd9ea587-ece9-44d7-b364-cfa800ff4243	\N	webauthn-authenticator	8d35e8a2-755c-44b9-84e1-cd723f651bbc	647f3c82-7eae-4319-b1d7-cb93f0683350	3	30	f	\N	\N
b780e719-ee26-4d7b-b81f-d251bb420ca0	\N	auth-recovery-authn-code-form	8d35e8a2-755c-44b9-84e1-cd723f651bbc	647f3c82-7eae-4319-b1d7-cb93f0683350	3	40	f	\N	\N
a3185b55-ae93-437c-a68b-522779ce6bd3	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	1ca7dd80-1e3b-4e96-80b0-355a8557693f	2	26	t	cb9a333b-6a9b-43a1-a18f-b32d20eec416	\N
edfed64d-6370-479b-b63a-719d40f4f231	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	cb9a333b-6a9b-43a1-a18f-b32d20eec416	1	10	t	80840e83-65ee-41f4-b273-6e468dd2852f	\N
786b93be-839e-4810-bd32-4a9bb87cedb1	\N	conditional-user-configured	8d35e8a2-755c-44b9-84e1-cd723f651bbc	80840e83-65ee-41f4-b273-6e468dd2852f	0	10	f	\N	\N
2c4ce6a2-bb69-4ae1-8a5b-00f84adf495d	\N	organization	8d35e8a2-755c-44b9-84e1-cd723f651bbc	80840e83-65ee-41f4-b273-6e468dd2852f	2	20	f	\N	\N
d2f5c5d8-7936-4056-a92b-db7fcb55dd5d	\N	direct-grant-validate-username	8d35e8a2-755c-44b9-84e1-cd723f651bbc	68f86973-4dff-4573-b6a2-688a7115369b	0	10	f	\N	\N
06d0bfe2-1fb4-4502-b6b1-193eaa015b88	\N	direct-grant-validate-password	8d35e8a2-755c-44b9-84e1-cd723f651bbc	68f86973-4dff-4573-b6a2-688a7115369b	0	20	f	\N	\N
07e2b3c9-85b8-4386-8a3e-38292dcae7aa	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	68f86973-4dff-4573-b6a2-688a7115369b	1	30	t	501e6cba-212a-457a-9d9b-bf907ac73985	\N
d8f64641-220e-4ca7-836e-16111fd356bb	\N	conditional-user-configured	8d35e8a2-755c-44b9-84e1-cd723f651bbc	501e6cba-212a-457a-9d9b-bf907ac73985	0	10	f	\N	\N
c2e4e6c2-a8c9-4066-b9f9-22f503e9cb7e	\N	direct-grant-validate-otp	8d35e8a2-755c-44b9-84e1-cd723f651bbc	501e6cba-212a-457a-9d9b-bf907ac73985	0	20	f	\N	\N
e30fca84-daf8-4e99-9bf2-7c8c73356c74	\N	registration-page-form	8d35e8a2-755c-44b9-84e1-cd723f651bbc	05ad9daa-38c2-4b51-8afb-8e679173329b	0	10	t	a6b2aca2-8539-4405-aef8-6b5f282df999	\N
1402097b-3764-4082-acc1-257c627b6c67	\N	registration-user-creation	8d35e8a2-755c-44b9-84e1-cd723f651bbc	a6b2aca2-8539-4405-aef8-6b5f282df999	0	20	f	\N	\N
6ee7d325-d127-4365-bb6c-b457ab7029de	\N	registration-password-action	8d35e8a2-755c-44b9-84e1-cd723f651bbc	a6b2aca2-8539-4405-aef8-6b5f282df999	0	50	f	\N	\N
ed8246b1-ccdf-44c9-a6d9-daf5d99e65c9	\N	registration-recaptcha-action	8d35e8a2-755c-44b9-84e1-cd723f651bbc	a6b2aca2-8539-4405-aef8-6b5f282df999	3	60	f	\N	\N
7deeb948-f635-407a-8271-efd9909a635c	\N	registration-terms-and-conditions	8d35e8a2-755c-44b9-84e1-cd723f651bbc	a6b2aca2-8539-4405-aef8-6b5f282df999	3	70	f	\N	\N
262b1b72-d87f-4826-8b95-ce3a1a0d4c9a	\N	reset-credentials-choose-user	8d35e8a2-755c-44b9-84e1-cd723f651bbc	10e25710-6342-4830-ab2c-cc2189c688b4	0	10	f	\N	\N
310827e0-4984-46be-8702-2c1938e2d353	\N	reset-credential-email	8d35e8a2-755c-44b9-84e1-cd723f651bbc	10e25710-6342-4830-ab2c-cc2189c688b4	0	20	f	\N	\N
efaeb8d2-6851-4f12-9704-8df15a68eb37	\N	reset-password	8d35e8a2-755c-44b9-84e1-cd723f651bbc	10e25710-6342-4830-ab2c-cc2189c688b4	0	30	f	\N	\N
041bbbe8-f66f-44a1-8ed6-404c2e57004d	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	10e25710-6342-4830-ab2c-cc2189c688b4	1	40	t	2be2eb4b-9a98-4657-9451-7ef34ca6e088	\N
932f3e1d-17b1-49df-a4a4-beb3faea29fd	\N	conditional-user-configured	8d35e8a2-755c-44b9-84e1-cd723f651bbc	2be2eb4b-9a98-4657-9451-7ef34ca6e088	0	10	f	\N	\N
3d07e542-8505-45fe-b030-70b41cd09ecf	\N	reset-otp	8d35e8a2-755c-44b9-84e1-cd723f651bbc	2be2eb4b-9a98-4657-9451-7ef34ca6e088	0	20	f	\N	\N
bf9f6f9f-ab47-4d1b-9335-1a4c0e44aff4	\N	client-secret	8d35e8a2-755c-44b9-84e1-cd723f651bbc	43c1624d-d333-4908-be14-e8d504e7e492	2	10	f	\N	\N
ccc1c1ab-0997-48af-aae0-5b0c40797541	\N	client-jwt	8d35e8a2-755c-44b9-84e1-cd723f651bbc	43c1624d-d333-4908-be14-e8d504e7e492	2	20	f	\N	\N
30050b6f-cd83-461e-9bc5-f35ef7228b1e	\N	client-secret-jwt	8d35e8a2-755c-44b9-84e1-cd723f651bbc	43c1624d-d333-4908-be14-e8d504e7e492	2	30	f	\N	\N
79131de1-74b9-4bb4-a1f5-73fa6894ec26	\N	client-x509	8d35e8a2-755c-44b9-84e1-cd723f651bbc	43c1624d-d333-4908-be14-e8d504e7e492	2	40	f	\N	\N
197f0bb0-a936-41b7-be25-a37cac870626	\N	idp-review-profile	8d35e8a2-755c-44b9-84e1-cd723f651bbc	0a5685ff-3190-4507-82a6-6219f9d3f227	0	10	f	\N	f0788442-d0c1-42a5-8890-15afaa0741be
f7bdc1b6-c8e9-478c-a3b7-8034efa8e50e	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	0a5685ff-3190-4507-82a6-6219f9d3f227	0	20	t	aa620f26-285f-4988-96a5-42687491cfd4	\N
36104549-93ad-40d0-9336-9475c1ad89c5	\N	idp-create-user-if-unique	8d35e8a2-755c-44b9-84e1-cd723f651bbc	aa620f26-285f-4988-96a5-42687491cfd4	2	10	f	\N	83f9eac4-3c9c-474c-bcc7-2f800a54969b
a81edb03-d0e9-4643-a158-5025c927cbfe	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	aa620f26-285f-4988-96a5-42687491cfd4	2	20	t	db3e3c64-3e2b-4b68-bd99-c7256bb6bae2	\N
06a194ba-a20c-426f-937e-d3524a660dd1	\N	idp-confirm-link	8d35e8a2-755c-44b9-84e1-cd723f651bbc	db3e3c64-3e2b-4b68-bd99-c7256bb6bae2	0	10	f	\N	\N
c816d4e3-3a7a-45f6-9445-7816f10250c1	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	db3e3c64-3e2b-4b68-bd99-c7256bb6bae2	0	20	t	0e8e05fe-d193-49dc-bd2a-247accaf3965	\N
461a6e60-317c-4c43-97f3-f7815333eee4	\N	idp-email-verification	8d35e8a2-755c-44b9-84e1-cd723f651bbc	0e8e05fe-d193-49dc-bd2a-247accaf3965	2	10	f	\N	\N
8fa4c54b-c807-4cf5-8a87-7e0cb5849d9f	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	0e8e05fe-d193-49dc-bd2a-247accaf3965	2	20	t	7db6f454-498b-4d03-bf68-d96f149e421c	\N
82fdb83f-55e2-491f-8707-2db84a96e41c	\N	idp-username-password-form	8d35e8a2-755c-44b9-84e1-cd723f651bbc	7db6f454-498b-4d03-bf68-d96f149e421c	0	10	f	\N	\N
d54ab761-6dbf-4805-a2f6-2a7999c1e8b5	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	7db6f454-498b-4d03-bf68-d96f149e421c	1	20	t	e10f39ad-9063-4e09-a3eb-cfa651367c3e	\N
5a065446-73b1-4ca3-a78e-4d3fd0697d21	\N	conditional-user-configured	8d35e8a2-755c-44b9-84e1-cd723f651bbc	e10f39ad-9063-4e09-a3eb-cfa651367c3e	0	10	f	\N	\N
87fdd22a-433f-4567-a71d-668173a34d0d	\N	auth-otp-form	8d35e8a2-755c-44b9-84e1-cd723f651bbc	e10f39ad-9063-4e09-a3eb-cfa651367c3e	2	20	f	\N	\N
2105520b-98b6-4787-bdf5-1d5d5bd72dde	\N	webauthn-authenticator	8d35e8a2-755c-44b9-84e1-cd723f651bbc	e10f39ad-9063-4e09-a3eb-cfa651367c3e	3	30	f	\N	\N
f4f753c6-e461-4c34-9c7f-10c4d83ad52f	\N	auth-recovery-authn-code-form	8d35e8a2-755c-44b9-84e1-cd723f651bbc	e10f39ad-9063-4e09-a3eb-cfa651367c3e	3	40	f	\N	\N
19758703-7b53-447a-a0bd-2f13c9bf1f0f	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	0a5685ff-3190-4507-82a6-6219f9d3f227	1	50	t	abe89c45-69cd-406a-8eba-35797580511e	\N
e4d4517a-d92c-4960-9517-e1718fc375b2	\N	conditional-user-configured	8d35e8a2-755c-44b9-84e1-cd723f651bbc	abe89c45-69cd-406a-8eba-35797580511e	0	10	f	\N	\N
9254232d-93b3-4723-acdb-34bae1e7ac9f	\N	idp-add-organization-member	8d35e8a2-755c-44b9-84e1-cd723f651bbc	abe89c45-69cd-406a-8eba-35797580511e	0	20	f	\N	\N
66e34757-5b0c-4ef2-ab90-cff7bedd1de4	\N	http-basic-authenticator	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f913477e-6e57-405e-a483-956264ebc3d8	0	10	f	\N	\N
58d01b2b-3535-4d1e-ade4-c0e5e9873444	\N	docker-http-basic-authenticator	8d35e8a2-755c-44b9-84e1-cd723f651bbc	4f03d95c-1922-4a94-b23e-4aab0b7ca8e8	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
f4e10254-e06b-49a2-afb1-578c8955ef81	browser	Browser based authentication	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	t	t
65b0a85e-4fa2-4133-849a-dfe04f202057	forms	Username, password, otp and other auth forms.	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	f	t
38b93d3a-842f-4e75-885a-fd25011db1be	Browser - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	f	t
0445f87f-73e8-428a-b92b-036ee35b7859	direct grant	OpenID Connect Resource Owner Grant	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	t	t
81c293ad-e1c0-4886-a9fc-189b531513eb	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	f	t
c3a7f5aa-7a02-490b-b02c-2ad8df936350	registration	Registration flow	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	t	t
97558fbf-a2cc-4f61-8d3e-0b9ef045519b	registration form	Registration form	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	form-flow	f	t
e0ba9c72-75e8-45e7-b949-2cf004810e6b	reset credentials	Reset credentials for a user if they forgot their password or something	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	t	t
ea1ba730-ca72-44fe-ab33-4735375b838c	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	f	t
fd1b36d1-1760-4981-9db3-c76774617ac9	clients	Base authentication for clients	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	client-flow	t	t
5634af62-d1bd-411b-89c2-e7f96dd40ac3	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	t	t
e50e3b9e-8cf0-4498-ad06-e937e22d75e7	User creation or linking	Flow for the existing/non-existing user alternatives	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	f	t
a09ebb54-26dc-4e5b-93c1-1489751079ad	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	f	t
6082a0b8-c335-44fc-bab6-ae6253052f6c	Account verification options	Method with which to verity the existing account	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	f	t
8ce5d53c-dd6d-4f54-aea5-bda806983b78	Verify Existing Account by Re-authentication	Reauthentication of existing account	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	f	t
349baa8a-ccb7-4925-b361-e8484c081976	First broker login - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	f	t
74a21a4b-5ee9-47ad-9ec9-25871bc8736e	saml ecp	SAML ECP Profile Authentication Flow	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	t	t
b4a11079-de7d-411a-84d4-d3de38d3086f	docker auth	Used by Docker clients to authenticate against the IDP	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	basic-flow	t	t
1ca7dd80-1e3b-4e96-80b0-355a8557693f	browser	Browser based authentication	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	t	t
a37df4f9-ebbf-4657-9bcc-f42e060a15f3	forms	Username, password, otp and other auth forms.	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
647f3c82-7eae-4319-b1d7-cb93f0683350	Browser - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
cb9a333b-6a9b-43a1-a18f-b32d20eec416	Organization	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
80840e83-65ee-41f4-b273-6e468dd2852f	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
68f86973-4dff-4573-b6a2-688a7115369b	direct grant	OpenID Connect Resource Owner Grant	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	t	t
501e6cba-212a-457a-9d9b-bf907ac73985	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
05ad9daa-38c2-4b51-8afb-8e679173329b	registration	Registration flow	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	t	t
a6b2aca2-8539-4405-aef8-6b5f282df999	registration form	Registration form	8d35e8a2-755c-44b9-84e1-cd723f651bbc	form-flow	f	t
10e25710-6342-4830-ab2c-cc2189c688b4	reset credentials	Reset credentials for a user if they forgot their password or something	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	t	t
2be2eb4b-9a98-4657-9451-7ef34ca6e088	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
43c1624d-d333-4908-be14-e8d504e7e492	clients	Base authentication for clients	8d35e8a2-755c-44b9-84e1-cd723f651bbc	client-flow	t	t
0a5685ff-3190-4507-82a6-6219f9d3f227	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	t	t
aa620f26-285f-4988-96a5-42687491cfd4	User creation or linking	Flow for the existing/non-existing user alternatives	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
db3e3c64-3e2b-4b68-bd99-c7256bb6bae2	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
0e8e05fe-d193-49dc-bd2a-247accaf3965	Account verification options	Method with which to verity the existing account	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
7db6f454-498b-4d03-bf68-d96f149e421c	Verify Existing Account by Re-authentication	Reauthentication of existing account	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
e10f39ad-9063-4e09-a3eb-cfa651367c3e	First broker login - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
abe89c45-69cd-406a-8eba-35797580511e	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	f	t
f913477e-6e57-405e-a483-956264ebc3d8	saml ecp	SAML ECP Profile Authentication Flow	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	t	t
4f03d95c-1922-4a94-b23e-4aab0b7ca8e8	docker auth	Used by Docker clients to authenticate against the IDP	8d35e8a2-755c-44b9-84e1-cd723f651bbc	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
45cb4623-e846-47b3-a29c-b0425d447280	review profile config	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d
1d1e09f9-cca4-4a89-9093-d1bde0dc5b40	create unique user config	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d
f0788442-d0c1-42a5-8890-15afaa0741be	review profile config	8d35e8a2-755c-44b9-84e1-cd723f651bbc
83f9eac4-3c9c-474c-bcc7-2f800a54969b	create unique user config	8d35e8a2-755c-44b9-84e1-cd723f651bbc
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
1d1e09f9-cca4-4a89-9093-d1bde0dc5b40	false	require.password.update.after.registration
45cb4623-e846-47b3-a29c-b0425d447280	missing	update.profile.on.first.login
83f9eac4-3c9c-474c-bcc7-2f800a54969b	false	require.password.update.after.registration
f0788442-d0c1-42a5-8890-15afaa0741be	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	f	master-realm	0	f	\N	\N	t	\N	f	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
3b574bb8-433e-48a7-8c9e-90414d96dcaa	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2caa34fc-3296-4d55-a66c-5443a2901355	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
0682d93d-69b3-444b-94a8-d5528a967f03	t	f	broker	0	f	\N	\N	t	\N	f	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
c504fbfb-db56-470f-923a-796d489a7796	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	t	t	admin-cli	0	t	\N	\N	f	\N	f	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
a551b881-6778-494f-86bb-c3c5ffb52a46	t	f	companyinfo-realm	0	f	\N	\N	t	\N	f	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N	0	f	f	companyinfo Realm	f	client-secret	\N	\N	\N	t	f	f	f
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	f	realm-management	0	f	\N	\N	t	\N	f	8d35e8a2-755c-44b9-84e1-cd723f651bbc	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
bad31dd0-85e6-4111-834d-3d78a8eb119d	t	f	account	0	t	\N	/realms/companyinfo/account/	f	\N	f	8d35e8a2-755c-44b9-84e1-cd723f651bbc	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	t	f	account-console	0	t	\N	/realms/companyinfo/account/	f	\N	f	8d35e8a2-755c-44b9-84e1-cd723f651bbc	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
c06163ae-71c6-43e1-aeac-1152d0a27717	t	f	broker	0	f	\N	\N	t	\N	f	8d35e8a2-755c-44b9-84e1-cd723f651bbc	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d59e569d-28d9-4895-8e91-d4fe13d285e6	t	t	security-admin-console	0	t	\N	/admin/companyinfo/console/	f	\N	f	8d35e8a2-755c-44b9-84e1-cd723f651bbc	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	t	t	admin-cli	0	t	\N	\N	f	\N	f	8d35e8a2-755c-44b9-84e1-cd723f651bbc	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
c185c938-d7ab-4c5e-947a-a0668898148a	t	t	ciadmin	0	f	cuWORnXCgcGCPETKZQXlbyKCc3F4JMC3		f		f	8d35e8a2-755c-44b9-84e1-cd723f651bbc	openid-connect	-1	t	f		t	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
3b574bb8-433e-48a7-8c9e-90414d96dcaa	post.logout.redirect.uris	+
2caa34fc-3296-4d55-a66c-5443a2901355	post.logout.redirect.uris	+
2caa34fc-3296-4d55-a66c-5443a2901355	pkce.code.challenge.method	S256
c504fbfb-db56-470f-923a-796d489a7796	post.logout.redirect.uris	+
c504fbfb-db56-470f-923a-796d489a7796	pkce.code.challenge.method	S256
c504fbfb-db56-470f-923a-796d489a7796	client.use.lightweight.access.token.enabled	true
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	client.use.lightweight.access.token.enabled	true
bad31dd0-85e6-4111-834d-3d78a8eb119d	post.logout.redirect.uris	+
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	post.logout.redirect.uris	+
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	pkce.code.challenge.method	S256
d59e569d-28d9-4895-8e91-d4fe13d285e6	post.logout.redirect.uris	+
d59e569d-28d9-4895-8e91-d4fe13d285e6	pkce.code.challenge.method	S256
d59e569d-28d9-4895-8e91-d4fe13d285e6	client.use.lightweight.access.token.enabled	true
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	client.use.lightweight.access.token.enabled	true
c185c938-d7ab-4c5e-947a-a0668898148a	client.secret.creation.time	1755788582
c185c938-d7ab-4c5e-947a-a0668898148a	standard.token.exchange.enabled	false
c185c938-d7ab-4c5e-947a-a0668898148a	oauth2.device.authorization.grant.enabled	false
c185c938-d7ab-4c5e-947a-a0668898148a	oidc.ciba.grant.enabled	false
c185c938-d7ab-4c5e-947a-a0668898148a	backchannel.logout.session.required	true
c185c938-d7ab-4c5e-947a-a0668898148a	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
c956c9b4-d05a-4254-9229-7b5b6776f7ef	offline_access	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	OpenID Connect built-in scope: offline_access	openid-connect
c0063e58-2ce8-4bba-87e4-12d6ff5d0052	role_list	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	SAML role list	saml
d0527f9d-7a01-45eb-bb25-6dcbaef658ed	saml_organization	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	Organization Membership	saml
e566570a-0e0b-41b0-a0a9-515bb1f523ef	profile	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	OpenID Connect built-in scope: profile	openid-connect
8b2151ab-8ec8-4269-93d7-65746ab24ee2	email	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	OpenID Connect built-in scope: email	openid-connect
bdf76a7a-3e05-40d1-a927-46efba92421f	address	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	OpenID Connect built-in scope: address	openid-connect
646bc4aa-0d50-4562-810e-1ca06dd18a1e	phone	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	OpenID Connect built-in scope: phone	openid-connect
dc2d0890-826b-4e3f-a6ee-d2a0e502aeee	roles	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	OpenID Connect scope for add user roles to the access token	openid-connect
432d630c-d18d-4630-a3d7-0e1159801c76	web-origins	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	OpenID Connect scope for add allowed web origins to the access token	openid-connect
e2d8c194-521f-4ceb-93d7-2aadd62ddfd7	microprofile-jwt	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	Microprofile - JWT built-in scope	openid-connect
b936e873-7a92-493b-aa12-cc1a14da53c5	acr	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
95aa00d2-ec89-4f8c-9997-31616a1967f1	basic	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	OpenID Connect scope for add all basic claims to the token	openid-connect
cd8df6ed-f413-43a3-9a16-5700d41f746c	service_account	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	Specific scope for a client enabled for service accounts	openid-connect
61d442bc-bf7a-47a9-83b1-0ced83287aac	organization	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	Additional claims about the organization a subject belongs to	openid-connect
009b393e-ae51-4606-ab28-99881e00119c	offline_access	8d35e8a2-755c-44b9-84e1-cd723f651bbc	OpenID Connect built-in scope: offline_access	openid-connect
4f10e3bc-236d-4bef-b332-7c12bd47283c	role_list	8d35e8a2-755c-44b9-84e1-cd723f651bbc	SAML role list	saml
5acc3b80-a66a-47d6-8220-431d8a2e61e9	saml_organization	8d35e8a2-755c-44b9-84e1-cd723f651bbc	Organization Membership	saml
8f54d702-7771-4261-a630-3187a6406bcc	profile	8d35e8a2-755c-44b9-84e1-cd723f651bbc	OpenID Connect built-in scope: profile	openid-connect
dbd836c2-479e-4c21-9a99-afd38ede0a5a	email	8d35e8a2-755c-44b9-84e1-cd723f651bbc	OpenID Connect built-in scope: email	openid-connect
9da5abc2-306d-4431-9c1a-4d22aeac41ce	address	8d35e8a2-755c-44b9-84e1-cd723f651bbc	OpenID Connect built-in scope: address	openid-connect
77ca655c-161b-4a25-863b-10d4ad41b966	phone	8d35e8a2-755c-44b9-84e1-cd723f651bbc	OpenID Connect built-in scope: phone	openid-connect
57b8203b-eb98-4316-979f-87b3b8f42484	roles	8d35e8a2-755c-44b9-84e1-cd723f651bbc	OpenID Connect scope for add user roles to the access token	openid-connect
9c034611-01be-497b-b007-a7c7b717d26f	web-origins	8d35e8a2-755c-44b9-84e1-cd723f651bbc	OpenID Connect scope for add allowed web origins to the access token	openid-connect
38055269-5a63-4111-a5a4-80436d1f1d7c	microprofile-jwt	8d35e8a2-755c-44b9-84e1-cd723f651bbc	Microprofile - JWT built-in scope	openid-connect
76ff392c-7bb0-47c5-9255-f361c431b6ad	acr	8d35e8a2-755c-44b9-84e1-cd723f651bbc	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
ecddf396-4842-46e2-a9dc-fc8ae2ab1994	basic	8d35e8a2-755c-44b9-84e1-cd723f651bbc	OpenID Connect scope for add all basic claims to the token	openid-connect
f6f6b0b7-c739-4b96-a1ed-ec3ad6aaeacc	service_account	8d35e8a2-755c-44b9-84e1-cd723f651bbc	Specific scope for a client enabled for service accounts	openid-connect
9ffe61f0-fffb-41c0-995a-6a1ebefd1807	organization	8d35e8a2-755c-44b9-84e1-cd723f651bbc	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
c956c9b4-d05a-4254-9229-7b5b6776f7ef	true	display.on.consent.screen
c956c9b4-d05a-4254-9229-7b5b6776f7ef	${offlineAccessScopeConsentText}	consent.screen.text
c0063e58-2ce8-4bba-87e4-12d6ff5d0052	true	display.on.consent.screen
c0063e58-2ce8-4bba-87e4-12d6ff5d0052	${samlRoleListScopeConsentText}	consent.screen.text
d0527f9d-7a01-45eb-bb25-6dcbaef658ed	false	display.on.consent.screen
e566570a-0e0b-41b0-a0a9-515bb1f523ef	true	display.on.consent.screen
e566570a-0e0b-41b0-a0a9-515bb1f523ef	${profileScopeConsentText}	consent.screen.text
e566570a-0e0b-41b0-a0a9-515bb1f523ef	true	include.in.token.scope
8b2151ab-8ec8-4269-93d7-65746ab24ee2	true	display.on.consent.screen
8b2151ab-8ec8-4269-93d7-65746ab24ee2	${emailScopeConsentText}	consent.screen.text
8b2151ab-8ec8-4269-93d7-65746ab24ee2	true	include.in.token.scope
bdf76a7a-3e05-40d1-a927-46efba92421f	true	display.on.consent.screen
bdf76a7a-3e05-40d1-a927-46efba92421f	${addressScopeConsentText}	consent.screen.text
bdf76a7a-3e05-40d1-a927-46efba92421f	true	include.in.token.scope
646bc4aa-0d50-4562-810e-1ca06dd18a1e	true	display.on.consent.screen
646bc4aa-0d50-4562-810e-1ca06dd18a1e	${phoneScopeConsentText}	consent.screen.text
646bc4aa-0d50-4562-810e-1ca06dd18a1e	true	include.in.token.scope
dc2d0890-826b-4e3f-a6ee-d2a0e502aeee	true	display.on.consent.screen
dc2d0890-826b-4e3f-a6ee-d2a0e502aeee	${rolesScopeConsentText}	consent.screen.text
dc2d0890-826b-4e3f-a6ee-d2a0e502aeee	false	include.in.token.scope
432d630c-d18d-4630-a3d7-0e1159801c76	false	display.on.consent.screen
432d630c-d18d-4630-a3d7-0e1159801c76		consent.screen.text
432d630c-d18d-4630-a3d7-0e1159801c76	false	include.in.token.scope
e2d8c194-521f-4ceb-93d7-2aadd62ddfd7	false	display.on.consent.screen
e2d8c194-521f-4ceb-93d7-2aadd62ddfd7	true	include.in.token.scope
b936e873-7a92-493b-aa12-cc1a14da53c5	false	display.on.consent.screen
b936e873-7a92-493b-aa12-cc1a14da53c5	false	include.in.token.scope
95aa00d2-ec89-4f8c-9997-31616a1967f1	false	display.on.consent.screen
95aa00d2-ec89-4f8c-9997-31616a1967f1	false	include.in.token.scope
cd8df6ed-f413-43a3-9a16-5700d41f746c	false	display.on.consent.screen
cd8df6ed-f413-43a3-9a16-5700d41f746c	false	include.in.token.scope
61d442bc-bf7a-47a9-83b1-0ced83287aac	true	display.on.consent.screen
61d442bc-bf7a-47a9-83b1-0ced83287aac	${organizationScopeConsentText}	consent.screen.text
61d442bc-bf7a-47a9-83b1-0ced83287aac	true	include.in.token.scope
009b393e-ae51-4606-ab28-99881e00119c	true	display.on.consent.screen
009b393e-ae51-4606-ab28-99881e00119c	${offlineAccessScopeConsentText}	consent.screen.text
4f10e3bc-236d-4bef-b332-7c12bd47283c	true	display.on.consent.screen
4f10e3bc-236d-4bef-b332-7c12bd47283c	${samlRoleListScopeConsentText}	consent.screen.text
5acc3b80-a66a-47d6-8220-431d8a2e61e9	false	display.on.consent.screen
8f54d702-7771-4261-a630-3187a6406bcc	true	display.on.consent.screen
8f54d702-7771-4261-a630-3187a6406bcc	${profileScopeConsentText}	consent.screen.text
8f54d702-7771-4261-a630-3187a6406bcc	true	include.in.token.scope
dbd836c2-479e-4c21-9a99-afd38ede0a5a	true	display.on.consent.screen
dbd836c2-479e-4c21-9a99-afd38ede0a5a	${emailScopeConsentText}	consent.screen.text
dbd836c2-479e-4c21-9a99-afd38ede0a5a	true	include.in.token.scope
9da5abc2-306d-4431-9c1a-4d22aeac41ce	true	display.on.consent.screen
9da5abc2-306d-4431-9c1a-4d22aeac41ce	${addressScopeConsentText}	consent.screen.text
9da5abc2-306d-4431-9c1a-4d22aeac41ce	true	include.in.token.scope
77ca655c-161b-4a25-863b-10d4ad41b966	true	display.on.consent.screen
77ca655c-161b-4a25-863b-10d4ad41b966	${phoneScopeConsentText}	consent.screen.text
77ca655c-161b-4a25-863b-10d4ad41b966	true	include.in.token.scope
57b8203b-eb98-4316-979f-87b3b8f42484	true	display.on.consent.screen
57b8203b-eb98-4316-979f-87b3b8f42484	${rolesScopeConsentText}	consent.screen.text
57b8203b-eb98-4316-979f-87b3b8f42484	false	include.in.token.scope
9c034611-01be-497b-b007-a7c7b717d26f	false	display.on.consent.screen
9c034611-01be-497b-b007-a7c7b717d26f		consent.screen.text
9c034611-01be-497b-b007-a7c7b717d26f	false	include.in.token.scope
38055269-5a63-4111-a5a4-80436d1f1d7c	false	display.on.consent.screen
38055269-5a63-4111-a5a4-80436d1f1d7c	true	include.in.token.scope
76ff392c-7bb0-47c5-9255-f361c431b6ad	false	display.on.consent.screen
76ff392c-7bb0-47c5-9255-f361c431b6ad	false	include.in.token.scope
ecddf396-4842-46e2-a9dc-fc8ae2ab1994	false	display.on.consent.screen
ecddf396-4842-46e2-a9dc-fc8ae2ab1994	false	include.in.token.scope
f6f6b0b7-c739-4b96-a1ed-ec3ad6aaeacc	false	display.on.consent.screen
f6f6b0b7-c739-4b96-a1ed-ec3ad6aaeacc	false	include.in.token.scope
9ffe61f0-fffb-41c0-995a-6a1ebefd1807	true	display.on.consent.screen
9ffe61f0-fffb-41c0-995a-6a1ebefd1807	${organizationScopeConsentText}	consent.screen.text
9ffe61f0-fffb-41c0-995a-6a1ebefd1807	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
3b574bb8-433e-48a7-8c9e-90414d96dcaa	b936e873-7a92-493b-aa12-cc1a14da53c5	t
3b574bb8-433e-48a7-8c9e-90414d96dcaa	e566570a-0e0b-41b0-a0a9-515bb1f523ef	t
3b574bb8-433e-48a7-8c9e-90414d96dcaa	8b2151ab-8ec8-4269-93d7-65746ab24ee2	t
3b574bb8-433e-48a7-8c9e-90414d96dcaa	95aa00d2-ec89-4f8c-9997-31616a1967f1	t
3b574bb8-433e-48a7-8c9e-90414d96dcaa	432d630c-d18d-4630-a3d7-0e1159801c76	t
3b574bb8-433e-48a7-8c9e-90414d96dcaa	dc2d0890-826b-4e3f-a6ee-d2a0e502aeee	t
3b574bb8-433e-48a7-8c9e-90414d96dcaa	bdf76a7a-3e05-40d1-a927-46efba92421f	f
3b574bb8-433e-48a7-8c9e-90414d96dcaa	e2d8c194-521f-4ceb-93d7-2aadd62ddfd7	f
3b574bb8-433e-48a7-8c9e-90414d96dcaa	c956c9b4-d05a-4254-9229-7b5b6776f7ef	f
3b574bb8-433e-48a7-8c9e-90414d96dcaa	646bc4aa-0d50-4562-810e-1ca06dd18a1e	f
3b574bb8-433e-48a7-8c9e-90414d96dcaa	61d442bc-bf7a-47a9-83b1-0ced83287aac	f
2caa34fc-3296-4d55-a66c-5443a2901355	b936e873-7a92-493b-aa12-cc1a14da53c5	t
2caa34fc-3296-4d55-a66c-5443a2901355	e566570a-0e0b-41b0-a0a9-515bb1f523ef	t
2caa34fc-3296-4d55-a66c-5443a2901355	8b2151ab-8ec8-4269-93d7-65746ab24ee2	t
2caa34fc-3296-4d55-a66c-5443a2901355	95aa00d2-ec89-4f8c-9997-31616a1967f1	t
2caa34fc-3296-4d55-a66c-5443a2901355	432d630c-d18d-4630-a3d7-0e1159801c76	t
2caa34fc-3296-4d55-a66c-5443a2901355	dc2d0890-826b-4e3f-a6ee-d2a0e502aeee	t
2caa34fc-3296-4d55-a66c-5443a2901355	bdf76a7a-3e05-40d1-a927-46efba92421f	f
2caa34fc-3296-4d55-a66c-5443a2901355	e2d8c194-521f-4ceb-93d7-2aadd62ddfd7	f
2caa34fc-3296-4d55-a66c-5443a2901355	c956c9b4-d05a-4254-9229-7b5b6776f7ef	f
2caa34fc-3296-4d55-a66c-5443a2901355	646bc4aa-0d50-4562-810e-1ca06dd18a1e	f
2caa34fc-3296-4d55-a66c-5443a2901355	61d442bc-bf7a-47a9-83b1-0ced83287aac	f
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	b936e873-7a92-493b-aa12-cc1a14da53c5	t
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	e566570a-0e0b-41b0-a0a9-515bb1f523ef	t
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	8b2151ab-8ec8-4269-93d7-65746ab24ee2	t
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	95aa00d2-ec89-4f8c-9997-31616a1967f1	t
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	432d630c-d18d-4630-a3d7-0e1159801c76	t
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	dc2d0890-826b-4e3f-a6ee-d2a0e502aeee	t
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	bdf76a7a-3e05-40d1-a927-46efba92421f	f
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	e2d8c194-521f-4ceb-93d7-2aadd62ddfd7	f
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	c956c9b4-d05a-4254-9229-7b5b6776f7ef	f
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	646bc4aa-0d50-4562-810e-1ca06dd18a1e	f
e01d8bfe-cffd-4e9e-b95c-a0cb8cd6e233	61d442bc-bf7a-47a9-83b1-0ced83287aac	f
0682d93d-69b3-444b-94a8-d5528a967f03	b936e873-7a92-493b-aa12-cc1a14da53c5	t
0682d93d-69b3-444b-94a8-d5528a967f03	e566570a-0e0b-41b0-a0a9-515bb1f523ef	t
0682d93d-69b3-444b-94a8-d5528a967f03	8b2151ab-8ec8-4269-93d7-65746ab24ee2	t
0682d93d-69b3-444b-94a8-d5528a967f03	95aa00d2-ec89-4f8c-9997-31616a1967f1	t
0682d93d-69b3-444b-94a8-d5528a967f03	432d630c-d18d-4630-a3d7-0e1159801c76	t
0682d93d-69b3-444b-94a8-d5528a967f03	dc2d0890-826b-4e3f-a6ee-d2a0e502aeee	t
0682d93d-69b3-444b-94a8-d5528a967f03	bdf76a7a-3e05-40d1-a927-46efba92421f	f
0682d93d-69b3-444b-94a8-d5528a967f03	e2d8c194-521f-4ceb-93d7-2aadd62ddfd7	f
0682d93d-69b3-444b-94a8-d5528a967f03	c956c9b4-d05a-4254-9229-7b5b6776f7ef	f
0682d93d-69b3-444b-94a8-d5528a967f03	646bc4aa-0d50-4562-810e-1ca06dd18a1e	f
0682d93d-69b3-444b-94a8-d5528a967f03	61d442bc-bf7a-47a9-83b1-0ced83287aac	f
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	b936e873-7a92-493b-aa12-cc1a14da53c5	t
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	e566570a-0e0b-41b0-a0a9-515bb1f523ef	t
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	8b2151ab-8ec8-4269-93d7-65746ab24ee2	t
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	95aa00d2-ec89-4f8c-9997-31616a1967f1	t
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	432d630c-d18d-4630-a3d7-0e1159801c76	t
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	dc2d0890-826b-4e3f-a6ee-d2a0e502aeee	t
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	bdf76a7a-3e05-40d1-a927-46efba92421f	f
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	e2d8c194-521f-4ceb-93d7-2aadd62ddfd7	f
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	c956c9b4-d05a-4254-9229-7b5b6776f7ef	f
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	646bc4aa-0d50-4562-810e-1ca06dd18a1e	f
2f62880d-ea1e-4d16-a4d0-b6c95e759e24	61d442bc-bf7a-47a9-83b1-0ced83287aac	f
c504fbfb-db56-470f-923a-796d489a7796	b936e873-7a92-493b-aa12-cc1a14da53c5	t
c504fbfb-db56-470f-923a-796d489a7796	e566570a-0e0b-41b0-a0a9-515bb1f523ef	t
c504fbfb-db56-470f-923a-796d489a7796	8b2151ab-8ec8-4269-93d7-65746ab24ee2	t
c504fbfb-db56-470f-923a-796d489a7796	95aa00d2-ec89-4f8c-9997-31616a1967f1	t
c504fbfb-db56-470f-923a-796d489a7796	432d630c-d18d-4630-a3d7-0e1159801c76	t
c504fbfb-db56-470f-923a-796d489a7796	dc2d0890-826b-4e3f-a6ee-d2a0e502aeee	t
c504fbfb-db56-470f-923a-796d489a7796	bdf76a7a-3e05-40d1-a927-46efba92421f	f
c504fbfb-db56-470f-923a-796d489a7796	e2d8c194-521f-4ceb-93d7-2aadd62ddfd7	f
c504fbfb-db56-470f-923a-796d489a7796	c956c9b4-d05a-4254-9229-7b5b6776f7ef	f
c504fbfb-db56-470f-923a-796d489a7796	646bc4aa-0d50-4562-810e-1ca06dd18a1e	f
c504fbfb-db56-470f-923a-796d489a7796	61d442bc-bf7a-47a9-83b1-0ced83287aac	f
bad31dd0-85e6-4111-834d-3d78a8eb119d	9c034611-01be-497b-b007-a7c7b717d26f	t
bad31dd0-85e6-4111-834d-3d78a8eb119d	dbd836c2-479e-4c21-9a99-afd38ede0a5a	t
bad31dd0-85e6-4111-834d-3d78a8eb119d	8f54d702-7771-4261-a630-3187a6406bcc	t
bad31dd0-85e6-4111-834d-3d78a8eb119d	ecddf396-4842-46e2-a9dc-fc8ae2ab1994	t
bad31dd0-85e6-4111-834d-3d78a8eb119d	57b8203b-eb98-4316-979f-87b3b8f42484	t
bad31dd0-85e6-4111-834d-3d78a8eb119d	76ff392c-7bb0-47c5-9255-f361c431b6ad	t
bad31dd0-85e6-4111-834d-3d78a8eb119d	9ffe61f0-fffb-41c0-995a-6a1ebefd1807	f
bad31dd0-85e6-4111-834d-3d78a8eb119d	38055269-5a63-4111-a5a4-80436d1f1d7c	f
bad31dd0-85e6-4111-834d-3d78a8eb119d	009b393e-ae51-4606-ab28-99881e00119c	f
bad31dd0-85e6-4111-834d-3d78a8eb119d	77ca655c-161b-4a25-863b-10d4ad41b966	f
bad31dd0-85e6-4111-834d-3d78a8eb119d	9da5abc2-306d-4431-9c1a-4d22aeac41ce	f
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	9c034611-01be-497b-b007-a7c7b717d26f	t
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	dbd836c2-479e-4c21-9a99-afd38ede0a5a	t
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	8f54d702-7771-4261-a630-3187a6406bcc	t
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	ecddf396-4842-46e2-a9dc-fc8ae2ab1994	t
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	57b8203b-eb98-4316-979f-87b3b8f42484	t
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	76ff392c-7bb0-47c5-9255-f361c431b6ad	t
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	9ffe61f0-fffb-41c0-995a-6a1ebefd1807	f
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	38055269-5a63-4111-a5a4-80436d1f1d7c	f
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	009b393e-ae51-4606-ab28-99881e00119c	f
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	77ca655c-161b-4a25-863b-10d4ad41b966	f
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	9da5abc2-306d-4431-9c1a-4d22aeac41ce	f
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	9c034611-01be-497b-b007-a7c7b717d26f	t
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	dbd836c2-479e-4c21-9a99-afd38ede0a5a	t
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	8f54d702-7771-4261-a630-3187a6406bcc	t
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	ecddf396-4842-46e2-a9dc-fc8ae2ab1994	t
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	57b8203b-eb98-4316-979f-87b3b8f42484	t
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	76ff392c-7bb0-47c5-9255-f361c431b6ad	t
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	9ffe61f0-fffb-41c0-995a-6a1ebefd1807	f
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	38055269-5a63-4111-a5a4-80436d1f1d7c	f
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	009b393e-ae51-4606-ab28-99881e00119c	f
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	77ca655c-161b-4a25-863b-10d4ad41b966	f
1a0be5b7-e5ea-4567-a6a7-386908d04ba6	9da5abc2-306d-4431-9c1a-4d22aeac41ce	f
c06163ae-71c6-43e1-aeac-1152d0a27717	9c034611-01be-497b-b007-a7c7b717d26f	t
c06163ae-71c6-43e1-aeac-1152d0a27717	dbd836c2-479e-4c21-9a99-afd38ede0a5a	t
c06163ae-71c6-43e1-aeac-1152d0a27717	8f54d702-7771-4261-a630-3187a6406bcc	t
c06163ae-71c6-43e1-aeac-1152d0a27717	ecddf396-4842-46e2-a9dc-fc8ae2ab1994	t
c06163ae-71c6-43e1-aeac-1152d0a27717	57b8203b-eb98-4316-979f-87b3b8f42484	t
c06163ae-71c6-43e1-aeac-1152d0a27717	76ff392c-7bb0-47c5-9255-f361c431b6ad	t
c06163ae-71c6-43e1-aeac-1152d0a27717	9ffe61f0-fffb-41c0-995a-6a1ebefd1807	f
c06163ae-71c6-43e1-aeac-1152d0a27717	38055269-5a63-4111-a5a4-80436d1f1d7c	f
c06163ae-71c6-43e1-aeac-1152d0a27717	009b393e-ae51-4606-ab28-99881e00119c	f
c06163ae-71c6-43e1-aeac-1152d0a27717	77ca655c-161b-4a25-863b-10d4ad41b966	f
c06163ae-71c6-43e1-aeac-1152d0a27717	9da5abc2-306d-4431-9c1a-4d22aeac41ce	f
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	9c034611-01be-497b-b007-a7c7b717d26f	t
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	dbd836c2-479e-4c21-9a99-afd38ede0a5a	t
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	8f54d702-7771-4261-a630-3187a6406bcc	t
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	ecddf396-4842-46e2-a9dc-fc8ae2ab1994	t
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	57b8203b-eb98-4316-979f-87b3b8f42484	t
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	76ff392c-7bb0-47c5-9255-f361c431b6ad	t
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	9ffe61f0-fffb-41c0-995a-6a1ebefd1807	f
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	38055269-5a63-4111-a5a4-80436d1f1d7c	f
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	009b393e-ae51-4606-ab28-99881e00119c	f
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	77ca655c-161b-4a25-863b-10d4ad41b966	f
f6bcbfc0-1ee4-449f-81df-ed90de7e001c	9da5abc2-306d-4431-9c1a-4d22aeac41ce	f
d59e569d-28d9-4895-8e91-d4fe13d285e6	9c034611-01be-497b-b007-a7c7b717d26f	t
d59e569d-28d9-4895-8e91-d4fe13d285e6	dbd836c2-479e-4c21-9a99-afd38ede0a5a	t
d59e569d-28d9-4895-8e91-d4fe13d285e6	8f54d702-7771-4261-a630-3187a6406bcc	t
d59e569d-28d9-4895-8e91-d4fe13d285e6	ecddf396-4842-46e2-a9dc-fc8ae2ab1994	t
d59e569d-28d9-4895-8e91-d4fe13d285e6	57b8203b-eb98-4316-979f-87b3b8f42484	t
d59e569d-28d9-4895-8e91-d4fe13d285e6	76ff392c-7bb0-47c5-9255-f361c431b6ad	t
d59e569d-28d9-4895-8e91-d4fe13d285e6	9ffe61f0-fffb-41c0-995a-6a1ebefd1807	f
d59e569d-28d9-4895-8e91-d4fe13d285e6	38055269-5a63-4111-a5a4-80436d1f1d7c	f
d59e569d-28d9-4895-8e91-d4fe13d285e6	009b393e-ae51-4606-ab28-99881e00119c	f
d59e569d-28d9-4895-8e91-d4fe13d285e6	77ca655c-161b-4a25-863b-10d4ad41b966	f
d59e569d-28d9-4895-8e91-d4fe13d285e6	9da5abc2-306d-4431-9c1a-4d22aeac41ce	f
c185c938-d7ab-4c5e-947a-a0668898148a	9c034611-01be-497b-b007-a7c7b717d26f	t
c185c938-d7ab-4c5e-947a-a0668898148a	dbd836c2-479e-4c21-9a99-afd38ede0a5a	t
c185c938-d7ab-4c5e-947a-a0668898148a	8f54d702-7771-4261-a630-3187a6406bcc	t
c185c938-d7ab-4c5e-947a-a0668898148a	ecddf396-4842-46e2-a9dc-fc8ae2ab1994	t
c185c938-d7ab-4c5e-947a-a0668898148a	57b8203b-eb98-4316-979f-87b3b8f42484	t
c185c938-d7ab-4c5e-947a-a0668898148a	76ff392c-7bb0-47c5-9255-f361c431b6ad	t
c185c938-d7ab-4c5e-947a-a0668898148a	9ffe61f0-fffb-41c0-995a-6a1ebefd1807	f
c185c938-d7ab-4c5e-947a-a0668898148a	38055269-5a63-4111-a5a4-80436d1f1d7c	f
c185c938-d7ab-4c5e-947a-a0668898148a	009b393e-ae51-4606-ab28-99881e00119c	f
c185c938-d7ab-4c5e-947a-a0668898148a	77ca655c-161b-4a25-863b-10d4ad41b966	f
c185c938-d7ab-4c5e-947a-a0668898148a	9da5abc2-306d-4431-9c1a-4d22aeac41ce	f
c185c938-d7ab-4c5e-947a-a0668898148a	f6f6b0b7-c739-4b96-a1ed-ec3ad6aaeacc	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
c956c9b4-d05a-4254-9229-7b5b6776f7ef	0c910c3f-21ca-42af-b8ae-0c507079691b
009b393e-ae51-4606-ab28-99881e00119c	f84f8957-a8fd-40a5-b762-4d69b030f7d2
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
41d93672-5d98-42be-93cf-4f4639372c0e	Trusted Hosts	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	anonymous
d842f7b5-4f7b-40fc-9ab3-83ca5216d514	Consent Required	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	anonymous
754aa47c-b9e2-488d-9875-97e43854286e	Full Scope Disabled	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	anonymous
6c88da21-e3e8-4aeb-8fa1-90cd5a5cb0e1	Max Clients Limit	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	anonymous
5eee200f-991f-4121-a2a9-12df754d43ee	Allowed Protocol Mapper Types	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	anonymous
17eb3331-4169-4551-ba29-f0c3f5ec7146	Allowed Client Scopes	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	anonymous
a82e3e29-04b8-4f2b-a667-da8c3cc1e484	Allowed Protocol Mapper Types	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	authenticated
a43ad100-6c53-4294-bf0e-8f695cf4c385	Allowed Client Scopes	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	authenticated
d2a30d97-c986-43c2-bf7f-03a2302ce9ee	rsa-generated	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	rsa-generated	org.keycloak.keys.KeyProvider	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N
571a2725-2887-4c18-b405-f4e8b356772a	rsa-enc-generated	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	rsa-enc-generated	org.keycloak.keys.KeyProvider	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N
101d6385-0300-483c-8314-676ce53c1620	hmac-generated-hs512	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	hmac-generated	org.keycloak.keys.KeyProvider	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N
d39cf726-7cec-401f-a557-62f33542af90	aes-generated	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	aes-generated	org.keycloak.keys.KeyProvider	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N
00e1bdbe-ea8a-4f39-9622-a41aed22ae32	\N	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N
a554aff5-b1a2-4f37-8829-79603f91b257	rsa-generated	8d35e8a2-755c-44b9-84e1-cd723f651bbc	rsa-generated	org.keycloak.keys.KeyProvider	8d35e8a2-755c-44b9-84e1-cd723f651bbc	\N
2e0f9fd3-cce1-4ef1-bff4-8e68b16ec9cd	rsa-enc-generated	8d35e8a2-755c-44b9-84e1-cd723f651bbc	rsa-enc-generated	org.keycloak.keys.KeyProvider	8d35e8a2-755c-44b9-84e1-cd723f651bbc	\N
dd16b1e6-d20f-4d3a-b0a2-15feecd544fd	hmac-generated-hs512	8d35e8a2-755c-44b9-84e1-cd723f651bbc	hmac-generated	org.keycloak.keys.KeyProvider	8d35e8a2-755c-44b9-84e1-cd723f651bbc	\N
0ac4584a-88fc-4c0d-9022-38d06e32a135	aes-generated	8d35e8a2-755c-44b9-84e1-cd723f651bbc	aes-generated	org.keycloak.keys.KeyProvider	8d35e8a2-755c-44b9-84e1-cd723f651bbc	\N
83e3dc87-154a-4959-bb6f-c598d22a10d5	Trusted Hosts	8d35e8a2-755c-44b9-84e1-cd723f651bbc	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8d35e8a2-755c-44b9-84e1-cd723f651bbc	anonymous
9ccb1beb-4c55-4859-aa0d-0bc418225b71	Consent Required	8d35e8a2-755c-44b9-84e1-cd723f651bbc	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8d35e8a2-755c-44b9-84e1-cd723f651bbc	anonymous
a3db763c-c854-4bc4-b330-283996904cab	Full Scope Disabled	8d35e8a2-755c-44b9-84e1-cd723f651bbc	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8d35e8a2-755c-44b9-84e1-cd723f651bbc	anonymous
4f14cae3-776e-4846-af56-031cc7b55051	Max Clients Limit	8d35e8a2-755c-44b9-84e1-cd723f651bbc	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8d35e8a2-755c-44b9-84e1-cd723f651bbc	anonymous
32d2cbb4-f91f-4c16-8cb7-7179be1b78fe	Allowed Protocol Mapper Types	8d35e8a2-755c-44b9-84e1-cd723f651bbc	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8d35e8a2-755c-44b9-84e1-cd723f651bbc	anonymous
e1872e86-b507-4cf9-926b-1e7771f46a8c	Allowed Client Scopes	8d35e8a2-755c-44b9-84e1-cd723f651bbc	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8d35e8a2-755c-44b9-84e1-cd723f651bbc	anonymous
937ad5b5-a081-48ab-b03b-a469f5c5bec8	Allowed Protocol Mapper Types	8d35e8a2-755c-44b9-84e1-cd723f651bbc	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8d35e8a2-755c-44b9-84e1-cd723f651bbc	authenticated
84b8ad9a-fc60-47c7-a6cd-977660a2cbe2	Allowed Client Scopes	8d35e8a2-755c-44b9-84e1-cd723f651bbc	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8d35e8a2-755c-44b9-84e1-cd723f651bbc	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
b4f29291-aa5a-4967-bb32-dffe5a2a2b02	17eb3331-4169-4551-ba29-f0c3f5ec7146	allow-default-scopes	true
7824d6cb-7ba2-4e91-8793-fe4e49df9467	5eee200f-991f-4121-a2a9-12df754d43ee	allowed-protocol-mapper-types	saml-user-property-mapper
28d5a4bc-df87-426f-8b55-e064a36bd49b	5eee200f-991f-4121-a2a9-12df754d43ee	allowed-protocol-mapper-types	saml-role-list-mapper
a86777f3-20d1-4e9f-8c3f-daa1efcb0309	5eee200f-991f-4121-a2a9-12df754d43ee	allowed-protocol-mapper-types	oidc-address-mapper
1276a0f0-cc0e-4195-bcbe-beff61095d67	5eee200f-991f-4121-a2a9-12df754d43ee	allowed-protocol-mapper-types	oidc-full-name-mapper
dce3e819-7a4a-47e9-af47-677b0a4b19cc	5eee200f-991f-4121-a2a9-12df754d43ee	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2023941f-763c-400c-95b0-80529333184a	5eee200f-991f-4121-a2a9-12df754d43ee	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
431c7656-0861-4595-a958-e1853b6fda68	5eee200f-991f-4121-a2a9-12df754d43ee	allowed-protocol-mapper-types	saml-user-attribute-mapper
5e07beef-9f95-48ca-81e9-5a478b4eb3cd	5eee200f-991f-4121-a2a9-12df754d43ee	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
150aa67c-ac7b-42cc-8dfb-39fba5b7cb6f	a82e3e29-04b8-4f2b-a667-da8c3cc1e484	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
799c723e-e1ba-41fc-ae48-6fcdd6cd9541	a82e3e29-04b8-4f2b-a667-da8c3cc1e484	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d9013ded-6f5d-442c-901e-3f0519fddcc3	a82e3e29-04b8-4f2b-a667-da8c3cc1e484	allowed-protocol-mapper-types	oidc-full-name-mapper
fd190939-439f-4c73-af43-4835fca0be5a	a82e3e29-04b8-4f2b-a667-da8c3cc1e484	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a9c2fec9-ec12-4da7-aa36-fa4588f00d56	a82e3e29-04b8-4f2b-a667-da8c3cc1e484	allowed-protocol-mapper-types	saml-user-property-mapper
7356bc30-58cc-42a9-9b91-ebaed53a63c6	a82e3e29-04b8-4f2b-a667-da8c3cc1e484	allowed-protocol-mapper-types	oidc-address-mapper
542cce80-5554-4c58-812e-0d846fe8d7bd	a82e3e29-04b8-4f2b-a667-da8c3cc1e484	allowed-protocol-mapper-types	saml-user-attribute-mapper
3870c6b0-478b-41a5-8f79-ef2a7ef64d0a	a82e3e29-04b8-4f2b-a667-da8c3cc1e484	allowed-protocol-mapper-types	saml-role-list-mapper
200d68d8-e7ca-4678-8175-49df399f6982	41d93672-5d98-42be-93cf-4f4639372c0e	client-uris-must-match	true
bc2ae333-6d1b-40c3-8ddd-41e51acddb84	41d93672-5d98-42be-93cf-4f4639372c0e	host-sending-registration-request-must-match	true
57b78262-31cf-4990-a264-f0c194bde846	a43ad100-6c53-4294-bf0e-8f695cf4c385	allow-default-scopes	true
b8f837dc-38ce-4a77-b094-5ac635fc5919	6c88da21-e3e8-4aeb-8fa1-90cd5a5cb0e1	max-clients	200
4c87586d-da9a-42c2-9833-05d82dc8a04c	00e1bdbe-ea8a-4f39-9622-a41aed22ae32	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
ce5fff0b-e19f-4e73-be70-6778411e5a2e	101d6385-0300-483c-8314-676ce53c1620	priority	100
3dede5d4-4474-4d09-a76d-c932b32456f9	101d6385-0300-483c-8314-676ce53c1620	kid	42ad24c3-4079-44cb-b47f-8084fd8029fb
c67fd87c-133c-482f-bfc1-5e4ccefa5af0	101d6385-0300-483c-8314-676ce53c1620	algorithm	HS512
3877c6e0-d625-4561-ae02-18e2cfb2dc99	101d6385-0300-483c-8314-676ce53c1620	secret	Q9MfnDXeNT_bSUmxqRNbXekKMczGkvmBg32s8E5XqD9vAlMMAtmx3ox0_f-PrRJ8rHHcLckHjylbIHfdwB9528UXa_GLVqdngB7pLSD_5N8M-VhK7O-rViViVYKQXWZDw9J6CPpV5jRxQmPAazjO6YCxiRWUMIs47kJNEI4NfKA
85fcb761-68d9-431f-a34d-2f19a4b5ee70	d39cf726-7cec-401f-a557-62f33542af90	kid	2c85014f-9070-436f-a8ea-893d8b56b96e
83332566-6fcf-4b8f-b6e3-b4497169d60f	d39cf726-7cec-401f-a557-62f33542af90	priority	100
24e626c4-54b3-4f62-b8ba-533d4c30ec5c	d39cf726-7cec-401f-a557-62f33542af90	secret	Dyn4LZfU0rkErHHMhP98nw
60def2d7-9e1e-420d-a43f-996078092912	d2a30d97-c986-43c2-bf7f-03a2302ce9ee	keyUse	SIG
3be03b79-2e60-4f69-a17d-2f64dce0c79c	d2a30d97-c986-43c2-bf7f-03a2302ce9ee	certificate	MIICmzCCAYMCBgGYzSVuwTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODIxMTQ1ODU5WhcNMzUwODIxMTUwMDM5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq+c92pEbLJSAJlmx+z1Hl6I6mCua0fQElske/ZCKmex0KkmN9sw0ibJpWts6arJ7iRshmEQAKI/WeU9xiLYc9OiIzBGO2Bv0LULmv+13L00zTwwFVg1ARhriiUXc1mSA9+t3L7TRwVASSCx5xNRHAZXSSs1MVt+gRY/jk/8q2au+drJv3TQOr4XZYGqbucwJhWmQ6+0vDuH+d1V4vVLV8snROyGcWPX1sFER341sMHQRXsjj5ceWWi5dOAMZ22JaxBRt7nGfVlZ73/IwyZcnTw+VXJQASDdFkGrPJxb9lfmMFbKvVJgp67r9UQkbsa7LmGz8npTS7QDODQIXLE2vJAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKT4KmrQfk+Jua5j3lqcRMD6SFcdKmtFYW/Jo+7H5fGfSvf1Quc3Q0Ng/WsUw+ciVs5q9L7r4hl+QwcGDDi3Quk3YrNQpf9io80jVom0ZwL8WNQJdIIeYbHzrcnCDOuw72v+6JoHIhBf29GmPLs606iFzV3hrjW+4Rwx5DVsd6Mckt/kbuBuXvslCCfW093qaNjaYoVVW5TyHkd4npLX80T7QHbj2F7L1sKFtNzL9xGxqG3zfQDXD68N8XK8luNu2hnSOPOdQlbkuLoAplw9vWMylPlLOegrkXjj6hJP55IkndFXjfHksTKmm3beiiTyC1NZmkFh5Pt2g4XuN44skM8=
34d0b141-6532-469d-b02c-cf584ceb06fc	d2a30d97-c986-43c2-bf7f-03a2302ce9ee	priority	100
cf1741dd-5154-4d10-99b5-9833e7b33447	a554aff5-b1a2-4f37-8829-79603f91b257	certificate	MIICpTCCAY0CBgGYzScNwzANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtjb21wYW55aW5mbzAeFw0yNTA4MjExNTAwNDVaFw0zNTA4MjExNTAyMjVaMBYxFDASBgNVBAMMC2NvbXBhbnlpbmZvMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3qZpHmKfu2v43huDWhf5BLgfflTMVrpR8apvD+nInRTTbr4DREqtQk+L9zahA8Ec76vIa8oR7BU3jwJYeaL7f3RZayPsDEwwLEk4ovnIFcERjCWidZI8o/fuc456OLo92Z7GE+ScefpI2w3OMcJ8iMdhSo8u4qbevVttLJyidS0vbW73CWYRf6qBYKeXe4MzoclG/JcD/RoIZU0IHq8+j2rx5V/nvGrehEfiIzy6PAYb6KXUrZBmegkkqtd+RQBBxGJJp08/ah+QgHF6fUDEvHhdaopbVfg8O4vFpFmwJbci1ppb2QedN5HwTNHIpr+iF70vDv1kvNc0j3cWW0/C0wIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBuW1sEiuFScDpeNQAp9EgfsnK9NWjgqsazqrRfbmbvgX2465oYZ12B0aUGv8nF9y5dVx8v3MmnKlSx17OOVnGLnIQ4+BWUZ6PVfXqmlAmFrtapZDAGwwqlIQMdBnlZ3EiWGV9xz5Q59qqvxQ5y1pD1AU/pW6zyIxO6KjuxaATmkfwzbrO3jS4+f/TTQrXIFalSV8y0bfuGbtYkHNd3nhOH1pTiLdXRFKPKQRKz7H9gnM89M2vfxcVMCX+1Oye+F0Vwkee5ErGp6mJE0csHQrL9l41ovzy29A1vOBdiSa4LNJjUo4ajGlMzN8XNKh70DdORzZ84a/L9pKTzXcTCZuyh
035a6573-1709-48c2-a7e3-85cbe6bd1765	a554aff5-b1a2-4f37-8829-79603f91b257	keyUse	SIG
1dfe10a4-3505-4723-a6b6-6705fb1f93ff	a554aff5-b1a2-4f37-8829-79603f91b257	priority	100
b017bb5c-d8bf-486c-ab82-828b4124374a	d2a30d97-c986-43c2-bf7f-03a2302ce9ee	privateKey	MIIEowIBAAKCAQEAqvnPdqRGyyUgCZZsfs9R5eiOpgrmtH0BJbJHv2QipnsdCpJjfbMNImyaVrbOmqye4kbIZhEACiP1nlPcYi2HPToiMwRjtgb9C1C5r/tdy9NM08MBVYNQEYa4olF3NZkgPfrdy+00cFQEkgsecTURwGV0krNTFbfoEWP45P/Ktmrvnayb900Dq+F2WBqm7nMCYVpkOvtLw7h/ndVeL1S1fLJ0TshnFj19bBREd+NbDB0EV7I4+XHllouXTgDGdtiWsQUbe5xn1ZWe9/yMMmXJ08PlVyUAEg3RZBqzycW/ZX5jBWyr1SYKeu6/VEJG7Guy5hs/J6U0u0Azg0CFyxNryQIDAQABAoIBABPSrpZydbhGG8SszXO26QeLSuWusCCnOR+0H7wtmZRchAmWnyUi4jAWcB8DZykZADtbKk8mI69pS6gRkETMQ0iqoa4xUTe4r/Q0xfCkx9NS0m6fZntSBBGiIWxFXnlHAY1aFYbYH8sxvI1rr1oABYi9YpKDKswC9Gu2v/PaAdhcFR4fANnZELsQmsEB2p0k1VIREmE9ol8SZpVB3QVasuMgmqNlvjqS6eH1W3+oB2dd79bYIUzVmRjWuVu+FKq56x7MGj1QJhOctyPnk9pHn7fpuNV4lnPnbtwHJmW40O6HuxPn0Gzz+7EfKL3BeF+xW+DL0IzeSCFkPcTCuzzGCHECgYEA5z4gUF9rLBJ0KdqWMgfxyhvpm20P+GN0jXKp9RX1S6Z//2vQAlxVs2bebvnTXZemUznRk7ovlQnKNOiuaXvJis2V07tFOh746wBlbHglEjJ5DLmtfU6V73IqEqVTlvZYIPcBxVvSSL9418eBLVGHiV6xBw5FtRZNonRt9i9q3tkCgYEAvUfllBbvclgEM0f5UdT5cL3OiFVwMlbART8P28Kwn2Y3LmiIAMlqX9M6uqTlJSsBP9DOI8wmy5fO2Z5CEFbYDOVm/9cAdNTRu7MSTcAoc3zoW5rjS+FpQpPcTsEbp35vh20zCplWS6t4eDtnSXd09y0XFRMvBm8B93Vr2TpSvnECgYA5Z23EJfvH5AjcPvwcDWbTglxajhdx1NahKn7QbZQIJJwPvybS/zLzJy0+pVv4FuZeMLM7FfQr7lM5ES4C14zvnRt9hTapN/kY9W84HxcszkTIiOtteO21lESnfk0i46J7BHZ3FNU94/JOtqL1qhCYZF5T3xIk4xWAp6CIhbrk+QKBgQCLLJ5F8UdG0Cjme/l6jhqLJ0UBQbEpklf1kpTahaDQ05unZ/z4dyDcLLh2HGDQn3pfreykrauo74qMwKzazsA1W0gMvc38Ga/NT7IZsT0NDb7b/Fs8pBV9erL2xU7MLU9cSJLLLEwjf4UpAqTDhC5gwKrEOELPfDf5+EDAjP3iQQKBgANHReuptWBbL80u7ydw93JSI8PmLK8SE46GIap+A/RaDjK6ZfiPYkk1h7+ViXqqUDEztHHCker3hA2ImdRVLBP9UxIij1LO62X/g99o1onkC8ztJj8LWhlqYtwKFUoQyyQrShu7ACbegyCl56kFdVxjFyCXu3WaW5CAA2CdYhsf
6345782f-e384-4dee-9a44-f1170e78f576	571a2725-2887-4c18-b405-f4e8b356772a	certificate	MIICmzCCAYMCBgGYzSVvOjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODIxMTQ1ODU5WhcNMzUwODIxMTUwMDM5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCYeOmS2X8HqBEYriK60LXkNCkBKdYlesPDDcOT6x2+ft2AHmpvQ/DUNQbVXuxwA771Acsm8qkrA09QlBCwxV7eUohwc33ELdw+P6OhNJAR+hZMR1zu4vYq219LYAM5tODjkri3hH5UhVjRqu5W1JOOpx1Jpm2PWxGraJiDlTbfBtp3+lzUu63FC2nSLiAJmQcczie48Sp2TBvVmb41PqIlYNZdJdjr+kRXLjvy1N843Q2dhZhJMEMIhTeZjj3kFX74hReZvl8aBmxaJfgyoqyj0GubgYz+cSB2UKojfw0Xl+sovn3+Iow8n86a3VT+J8BC8kwGhQi5AuZqsu3rTffNAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABfRmjO/SfLBXoHboEBUAnc8u+ITvQu55mOqIRs+lh759/g3RAmnaY2wvYJZr0gYSJtkuwN90gb+zacG2f5sEuHpJkkYwMsVh4LZFL874ViJ0zd0qWTokmWBrJX7Yjg4oXh8FokYBYHEz1KMD0V670ZIhVHXpsfTVWcSIPReR6XTesUeY4vrTbPYv+d0EJ0PyFGDfaRQ2clPEhwSDr9dvmdvb/H73c15WIvWMl15FJcVqlaDUNnRmcD2xfZwOBEW7dNk7XGUjfAkf92yz7KfeSupp81Tnqj92cVtQK01x2g8re/3Mn0Ayg9o/PAZYuduMaJ6yCuXe4E6XtUfEoLG8NQ=
86273b70-7f21-4cfe-b768-2707e1fb030f	571a2725-2887-4c18-b405-f4e8b356772a	priority	100
d7f24f18-a677-440d-887f-135382cd1707	571a2725-2887-4c18-b405-f4e8b356772a	algorithm	RSA-OAEP
35704ad5-9e7d-4d9e-bc96-1630c5be5a1c	571a2725-2887-4c18-b405-f4e8b356772a	keyUse	ENC
839bdc81-c396-441d-b477-8967a8ae575d	571a2725-2887-4c18-b405-f4e8b356772a	privateKey	MIIEogIBAAKCAQEAmHjpktl/B6gRGK4iutC15DQpASnWJXrDww3Dk+sdvn7dgB5qb0Pw1DUG1V7scAO+9QHLJvKpKwNPUJQQsMVe3lKIcHN9xC3cPj+joTSQEfoWTEdc7uL2KttfS2ADObTg45K4t4R+VIVY0aruVtSTjqcdSaZtj1sRq2iYg5U23wbad/pc1LutxQtp0i4gCZkHHM4nuPEqdkwb1Zm+NT6iJWDWXSXY6/pEVy478tTfON0NnYWYSTBDCIU3mY495BV++IUXmb5fGgZsWiX4MqKso9Brm4GM/nEgdlCqI38NF5frKL59/iKMPJ/Omt1U/ifAQvJMBoUIuQLmarLt6033zQIDAQABAoIBAAFvbUbHhdmDrz+Dz3S3PL3BxkYKHQeGyjt2kHSpa1hXojb6clGK+pl2Hf2ZsmY+iXMNzy9WFu9o9/uVR+VGF7Bw50hkX0F0Fg/pnPJ08nXnhwNfo5llvl/6Zyv9jXeNreqZKbnOhTrp824BKtOwlhVVxOHkhMEAoDVfG2/CUpJ9tArQtR0ZOC1TwLKx+eSaFLFBmCMeMva8Pu5Z2AItc0GsZyUf+hQEPHluiUbZlVYnW2STSLambHIU+NTGft3ftrCM5vHL/Rv32sWvkioiqyJ9SO00WrZPK6em1e6QKKCwF9f3HKfXiwtFYTnidiMA7Bo9EcTm9TUO//G9Xk0orZkCgYEA1pEZymPu3JxQF1tCe7tWteiPtZ0J3e+PMrtpD6/IlDI0Mhur5tPZ2AK/lFyanZ/t/iQxwq99o4gtPYDBMOQlBD58MhSjim2DACToNPNoLJE5ZQXpbuOkdVn78F5Dk3QTnxxpR427YJsoh7fp+g5nXGu96Rhtm34uaukIN1kJN7UCgYEAteo7Tm6WRdlmAFt1272VtQliJH3D7HRBCwUwf3ufcLH+NMGmihz5zOmteFzHMs1hpCEbsan2f+R0OxMqxjugbv+A7Yd75x+LGoMLIS+ZI5K+jTYAK6lazzenTdE6kOft5KDFaTj0/4OM/qRILCnbY1MJFp9ccEz30pWylJoXnrkCgYB+Akj7KyUkOkhu7xFkSOjre+Cp78fTptSaHqXcqIdLQRCWPNn/fXr5+OM55giHeVzzW549j4Jhf5/R9sN+Sv3SOEAHyUciDJ5af1I/hpMvWTozsf0dOmNi562lxDY7anf7gVvywbHBUl3DFqc6Sys4g63MLqRwJPJtpt1EY+2d4QKBgAE6FTBQOp85+iAifcb/nlTcPVc1qe6cUhv66vrRIKAn8yjz7WWdEGo7YToglg9Xp0LuHjuyg8EVD1ueo3k2ybw16O6xLTq/0bZaD+cnZQcCZFqbdKDWwZAINg6mTJjRl58lHm+5PJ3Ei1zkSsBRf/NJihQm+v6e5kT7UXsDFwmxAoGAYofYwKGY3KtpgA8OkhAXsNQNCaQlPPHXqxKCx2p68cwMOCg6BSdPExv0ceXeFzIsk9sa2kI8Tj4fM0AJzj3MEwNMth7L4ji78qs72u5D1p3gV8/ZL7zfWpr9LbtqAL3DVwgozJr898xAPvZvO9u3+ytAceTAJJdqdv9NapXSb1k=
70b1c91a-0d4e-4105-9c60-572f345175b0	dd16b1e6-d20f-4d3a-b0a2-15feecd544fd	kid	c27b3ee7-74ce-47d7-a753-14a5c53a3e7d
44fd04c2-f5a6-49c0-9fe4-fac781447234	dd16b1e6-d20f-4d3a-b0a2-15feecd544fd	priority	100
ea9c6631-a4e6-4c21-8ed1-fd09108fa641	dd16b1e6-d20f-4d3a-b0a2-15feecd544fd	secret	KSoZtg0RRX3I4Qfixj7kPpfBSK1Nl8sHuLxbiCgnHOsF_1Gw7UHf9GCFDcqswasjZ-RptvnlQgaOqoQV-GT6_OCkYsZPtwaOcdxtKInngiIWt8DdLWDq8nh3-23TidDeg1UY6p21MLplvS9XwDxTRGn1IB9Id7l8bP6WBp04EFE
13dd85ec-758d-404c-823e-50f830601318	dd16b1e6-d20f-4d3a-b0a2-15feecd544fd	algorithm	HS512
da965f1f-5c48-48fa-a274-db803330bf95	0ac4584a-88fc-4c0d-9022-38d06e32a135	kid	9d569364-3e94-4d60-9cc3-56b9198d2810
789ae28f-3bd7-45d8-8958-a1589c3082bb	0ac4584a-88fc-4c0d-9022-38d06e32a135	secret	5agi9_2ROuNk8w9MrNHQpg
dd74e261-7826-43be-bd08-68430d34058d	0ac4584a-88fc-4c0d-9022-38d06e32a135	priority	100
4ed5c2d3-9b5d-41dc-b15e-41b38db1ebe2	a554aff5-b1a2-4f37-8829-79603f91b257	privateKey	MIIEogIBAAKCAQEA3qZpHmKfu2v43huDWhf5BLgfflTMVrpR8apvD+nInRTTbr4DREqtQk+L9zahA8Ec76vIa8oR7BU3jwJYeaL7f3RZayPsDEwwLEk4ovnIFcERjCWidZI8o/fuc456OLo92Z7GE+ScefpI2w3OMcJ8iMdhSo8u4qbevVttLJyidS0vbW73CWYRf6qBYKeXe4MzoclG/JcD/RoIZU0IHq8+j2rx5V/nvGrehEfiIzy6PAYb6KXUrZBmegkkqtd+RQBBxGJJp08/ah+QgHF6fUDEvHhdaopbVfg8O4vFpFmwJbci1ppb2QedN5HwTNHIpr+iF70vDv1kvNc0j3cWW0/C0wIDAQABAoIBAAhmXdPkI6OWBLsYbaGyAtaPPbzt5RGmkN3dsLf4eXWXqgxlBcmHSbcVOjIW8Qcru3Q9Vl/erUNrX3+5Nm5MXFGoKZF1tvuVykF5d7YKV2aetJNFfjYSUNBc07WvW+QU/q1dpJpuhwrBCwucnzlYXYtpfj2qXjn10rRxJRLITAbAniQX/Nex3NpbsbMuh0/0msRh2b2ZdpKN69v6iu8voems/ofCCyiqVGsLysvhBwU4RDoCFks4xRHGTdzBziJbzjqHXWW+o0gD0p+b5346LroOtQPbc11rSx50lOXyTSyHMU67b67Bo6WgE5lbYhSE34EaJQdHPVipsTyQaOkFF60CgYEA8OkN8LAbhRhLB14oHudHF4oH/XEsQSO1GZY2r8fJLZ9oKCqTd2oYfLeELt1NUZKGshM9VLVLJ8v17OegyLDBGcye2ANFcibdqPlLWMRInKzpljp8zlqIuzVOY3fLT+C2MVFWN4WjTbo2tvbe8nSLBU+tdRqnzp7M6Wpnwd+vEvcCgYEA7JiORyUwm2TiFb7Cg1lHKlSs7d21mhrU3gvFcDu2etNxmudqjSKx8JfIUvbZhVEY95oMRGcncn8iHP3MpRl0rT1U+bs6NBzir5+8kC9ZEty6GgMe3tfage4yrq+4JDwPtvoi6isvdsFbt+tA6VxnCJFt4atqSAHfpVo2Q2gBvAUCgYB6/G86bZ1PAAzlkQLoa+eWM8hKcWlHQ+RjUJVQfazNlrCEuN+ZudcQbFuV1TJwr14GMN5BjV/1zCEbNVCWw+2Arz50Ro9AbGkCp2n4whPTsE57fBZU/lEJSXhgPTrU54H7gWuDYrzwpFzkYPmGS0rhhkCmJNqAF//CNakMh5YIFwKBgCLd0InXhzQ/R7ogpJWqwHwSgnGDbNHLBne6kFwb0KaFJobHd8JYzJRCKflf+2pUKzPB9fDWqs+KwMI4/MGP4Mvu7+jlmIw5fYaYKbet4piPArX2o8P/V2oyajGoH6DnYQF8F00fFB2SHSwbdTNutJhkpibNlhoKfKTniHuihi7pAoGAOkgSCpqj6peSc/SEucZKxuTg1B14COrk/VxBxo3euHDxty5O9HLNJXEyQGPHyrKd9RxjwbReuWNahjIPJegqIX4fHDbzUSTNqvcjKkmIpTAI1HNPDrFC40E/HQgbRuHs9vi0F5euxURX6tVUMab7KVmWLQoi2IJ+s4tENmPQqdE=
05c47550-67e4-44af-a566-1a5ddd480cf3	2e0f9fd3-cce1-4ef1-bff4-8e68b16ec9cd	privateKey	MIIEowIBAAKCAQEA7BIOEfmYyPJgJr4exCIYSm7v3G4aDiER346pdVqlbjYUSOJVObe2Pl1PHmbIAd7IsTXgWtSoUkROCNYuGyR4NKoi/8zrUm/Ml1Et+KtT49scqF7drq/QwSiwtRSldTsz4onxTiRsNkMYQzCJzNMMrKjHJBng84bne5wXzS3LgRWtdmJUkpsfp1XGUV6oI4O2xi71OlT4D3m5FkWgJHedxkAXKu1YbxFRKd5LDWXuyOuGaerx1xb6Lhw7nJ+NF2G20oi6TiIJ8as2lr5zRkW/3W4kk4RPSIBCcsSllzBYvVry6VISptm10DhcfcCqloOXvDPNJyNSlBHXwe/dv+SOZwIDAQABAoIBAEoqU/ROu7Lp/s49LbJF2ebMmpvglVv6BMD88300iMOqxs2tGcRj1KQcMYamGNEJmnieKgmvROBvqCp7i4moeAFnsE44JXhFOnwRm4VD4ju0M3ksMK44ezesHnQNc/v0KRVTbBW2OK8FfkJhpfFNHu7BqarMXJF1wRTjEdE6wXQgbk24X/vf0iS8Ql74W7HLBAulFwOz1Tdu5v7m6ZLiMby/23MEbBUR4mDu7xDnzVrEsk7jVfcyo1D5Coff5V0Z7pCcSdC83WvyNYo2IwQS6cO7i1PRG/CaHwxuxedumrQeeYLb8/AhP6itVLoVJgaG2gnX1H0f7Nk2RSa3tpnL5WkCgYEA/fS8gQTAyZXOtEunX+kofqhauACExWQvEaQB+U8g34axmnsLvoWEPNZahF7sjMEoBIRfq4tRfwt58uJ2g61yadOLrtbWzIT859DuMamHCRHiOvbsO4r6MPXzA422lcxmF7zRn2NCeyQ+nRFtrpS5T0CjVxA+5rJbyR5dxfJAxwkCgYEA7fh3bARfI3A/VXipN8Bso/zduVVnuFUWqgjyf5boI6aK0qqZPjvchiazUNBR4N656fubBGqi5zfwxuD1w6F1jk125oNjtQZh6PyWUckiLymHFmyAgZTnEqF7ONWdhMO+97eQn2CLzJevJ249j2K0bJfqE/byBiYeccvjV5MfFe8CgYEA7zUutgxnF7p/WH6GaqYxWZR01yrN5Sxn1aL5pP7uxP2Xnx5VwqD7HV7/Jf5PrIloi1Cw2OHC4vtJZAoCfifLRHlZ8lc1PrHpkuXO54J6yoVI5ied/rv6zFFvFSLQICvG4ocdoJebkGhkfghjmvVF06vb729DAIRyRm/O/lwgvhkCgYAWj1ia9+shC/IlIzQ/odFq1n0apdsYYZCte/2pVOAbCR3eDOhMOxaT7TVQsv8gJ11Orliq2YUqEGaWJBuIeVUQsY1VGx2nurwrf06s4DmKaRBycsTYBArH/GEXKUEupfQDvfZK9bcrJTIotc3GOyBJrzk0vVOCe7ilJyQdWEg5JwKBgFTrQh+GEfQwaP2R187xu39bDZsto+MNYKIU5OxRaUy6Wj9I6WaSPLzaThyqE6TEMZB1DhDfMJHuKmAcSvPmCQ7nKqmH/kyPhmrdsXnOJjLoXW3z9jPv9CWoWVm3yEfP8q3YcsdqntUmrzTdppbrrwq1CcF/bXvRmuavclzdEgQA
68693464-6b44-4f7f-a7eb-41c129c717c9	2e0f9fd3-cce1-4ef1-bff4-8e68b16ec9cd	priority	100
7464560e-1d44-4bea-9cc5-3ca117274d2b	2e0f9fd3-cce1-4ef1-bff4-8e68b16ec9cd	algorithm	RSA-OAEP
70845f0c-fbe5-4180-b320-77a809aa1cba	2e0f9fd3-cce1-4ef1-bff4-8e68b16ec9cd	keyUse	ENC
eabad139-eb13-4132-97b4-859551652e5e	2e0f9fd3-cce1-4ef1-bff4-8e68b16ec9cd	certificate	MIICpTCCAY0CBgGYzScO1TANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtjb21wYW55aW5mbzAeFw0yNTA4MjExNTAwNDVaFw0zNTA4MjExNTAyMjVaMBYxFDASBgNVBAMMC2NvbXBhbnlpbmZvMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7BIOEfmYyPJgJr4exCIYSm7v3G4aDiER346pdVqlbjYUSOJVObe2Pl1PHmbIAd7IsTXgWtSoUkROCNYuGyR4NKoi/8zrUm/Ml1Et+KtT49scqF7drq/QwSiwtRSldTsz4onxTiRsNkMYQzCJzNMMrKjHJBng84bne5wXzS3LgRWtdmJUkpsfp1XGUV6oI4O2xi71OlT4D3m5FkWgJHedxkAXKu1YbxFRKd5LDWXuyOuGaerx1xb6Lhw7nJ+NF2G20oi6TiIJ8as2lr5zRkW/3W4kk4RPSIBCcsSllzBYvVry6VISptm10DhcfcCqloOXvDPNJyNSlBHXwe/dv+SOZwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAtB1/9M/v/6dh56gFVPxHiinZlSV1jHhmTztCu+mO39v4y7kF2Y0oOBTsCuowE25raJ4SUowneEyMHYLbPQtqFdPIYDuv9ZXCrksdoq03Og9ysvJCK6i5+GvJzEL9zhI7Gmh7gSitaySO8nYhHD6HoEoAbInxJX/XwlGBAEMBLT0paOvBbPwrLXP6H+r5O98SxsroRE/eayqqVS52JLIlPJIzQLkS7LG9QGzrYLMfpUq5AWS0Pm/WqVJu4onaszMpIbL006GDET5PjaWs+4gHgWr1tv646opyk9j3qjxMtR3ot+/7EVTk5PEtAhadUMzLFwP8M7bbm0vBzsJy3JRGA
42130979-76d9-482d-acac-f0afe2c7b363	83e3dc87-154a-4959-bb6f-c598d22a10d5	client-uris-must-match	true
ac82397e-3097-4b3a-b744-2d8b2161b2b7	83e3dc87-154a-4959-bb6f-c598d22a10d5	host-sending-registration-request-must-match	true
dbcce480-7216-4143-b39d-eb951ad59807	32d2cbb4-f91f-4c16-8cb7-7179be1b78fe	allowed-protocol-mapper-types	saml-user-property-mapper
f11f6cbb-b1f7-4fa7-8ecc-23193c2e9f2f	32d2cbb4-f91f-4c16-8cb7-7179be1b78fe	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
4f6163e6-d9eb-4e37-bb68-fc200683e668	32d2cbb4-f91f-4c16-8cb7-7179be1b78fe	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
83ab21f6-de6c-4c56-9e33-933da3ac9f92	32d2cbb4-f91f-4c16-8cb7-7179be1b78fe	allowed-protocol-mapper-types	oidc-address-mapper
833f6efc-3324-499e-95bf-3b2487625289	32d2cbb4-f91f-4c16-8cb7-7179be1b78fe	allowed-protocol-mapper-types	oidc-full-name-mapper
1ba6c0bb-ce1e-44b5-aa53-d26ce676838b	32d2cbb4-f91f-4c16-8cb7-7179be1b78fe	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3e516415-080c-4299-b3a8-cbdf2ac18642	32d2cbb4-f91f-4c16-8cb7-7179be1b78fe	allowed-protocol-mapper-types	saml-role-list-mapper
2af4dbb9-08f3-48ef-a7bb-d07b5fb9fd86	32d2cbb4-f91f-4c16-8cb7-7179be1b78fe	allowed-protocol-mapper-types	saml-user-attribute-mapper
6a32560a-7015-4975-a7f1-0b05968c7e41	4f14cae3-776e-4846-af56-031cc7b55051	max-clients	200
80e174df-4883-4977-b01c-12ad83ecf83f	e1872e86-b507-4cf9-926b-1e7771f46a8c	allow-default-scopes	true
074435eb-da51-4f16-b1fb-f1d56444b9e2	937ad5b5-a081-48ab-b03b-a469f5c5bec8	allowed-protocol-mapper-types	saml-user-property-mapper
9d83db38-315c-4859-8d95-0e81f451ff2f	937ad5b5-a081-48ab-b03b-a469f5c5bec8	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1c79d608-df69-47e4-962c-2f92c10b4fb5	937ad5b5-a081-48ab-b03b-a469f5c5bec8	allowed-protocol-mapper-types	oidc-full-name-mapper
34b3824f-d825-4b66-bcd8-38c7c14c5477	937ad5b5-a081-48ab-b03b-a469f5c5bec8	allowed-protocol-mapper-types	oidc-address-mapper
4b7873bd-0e8a-47e7-bffd-a3fe248c4bdb	937ad5b5-a081-48ab-b03b-a469f5c5bec8	allowed-protocol-mapper-types	saml-user-attribute-mapper
d7db2298-7e7a-4b2e-9ddb-b31207ee59cc	937ad5b5-a081-48ab-b03b-a469f5c5bec8	allowed-protocol-mapper-types	saml-role-list-mapper
aca18c55-8714-47bb-8b51-f5408b7562bd	937ad5b5-a081-48ab-b03b-a469f5c5bec8	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d06a4336-21eb-4891-a279-e93e1b63003d	937ad5b5-a081-48ab-b03b-a469f5c5bec8	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
4e4b3292-c10f-4c59-b349-53705acca585	84b8ad9a-fc60-47c7-a6cd-977660a2cbe2	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.composite_role (composite, child_role) FROM stdin;
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	d01b0ccb-c687-42cb-a9d2-42931854c4db
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	3c333636-d441-4bcb-92b3-66374a6611ef
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	874f7b6e-7ca0-473b-8628-13f9a6893e23
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	9848d75a-fae9-46f6-9fbb-289cd3d8df12
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	1f81a9b1-5820-42ce-a887-a4aaebdea4f8
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	d315888d-e193-4482-a7e7-2069f47912b2
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	f619adcb-45db-4600-8374-3eb858b42789
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	d9cd68b1-191f-4703-ad68-5a14f2a2f4d0
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	fa9025f2-e7fe-4de8-8922-1d24065f91a8
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	c969b0a8-fbda-427d-a1b7-ac9345373051
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	1459fca3-e1d0-43f5-be3f-027017f148ca
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	fc7494e0-139d-40e4-929c-c6ed901447ce
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	f0349cdf-ea50-4592-ab55-82136f92a959
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	8b07dcc3-d154-4775-83f7-9cb36650d7ca
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	5976b6c4-270e-474c-b747-7884488e2702
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	9ca18b49-8007-4bad-b0ec-72678a0c21cb
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	923b7906-1817-4853-9b9c-ebb269d6a1ef
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	5c2f47d8-41d7-4afb-947e-a8d55cd4ab4f
1f81a9b1-5820-42ce-a887-a4aaebdea4f8	9ca18b49-8007-4bad-b0ec-72678a0c21cb
9848d75a-fae9-46f6-9fbb-289cd3d8df12	5976b6c4-270e-474c-b747-7884488e2702
9848d75a-fae9-46f6-9fbb-289cd3d8df12	5c2f47d8-41d7-4afb-947e-a8d55cd4ab4f
cbceade4-5f5e-4eae-99fc-0e421955894d	6b78f570-4681-47ed-be5e-1d5b9d5dcf6e
cbceade4-5f5e-4eae-99fc-0e421955894d	4705fb17-95ea-4d79-82be-fe21cb213295
4705fb17-95ea-4d79-82be-fe21cb213295	5af88950-8f52-444b-a7c5-c0fcce7b2af1
98a6bc92-9ab1-4fe1-bd13-d884dd1f9490	814d0e6c-e686-4a47-8de5-c7a7d4d11beb
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	c8c4453a-78eb-4fc1-af96-37ad965031db
cbceade4-5f5e-4eae-99fc-0e421955894d	0c910c3f-21ca-42af-b8ae-0c507079691b
cbceade4-5f5e-4eae-99fc-0e421955894d	a2d8a42a-f194-46d4-ac19-cf4001dc0fac
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	cd935f35-858f-4060-bad2-3d79dd56eb85
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	193521cc-ae2c-4f71-9380-f60b2d91d0ff
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	19f512d7-5b46-4175-ae57-5c89d3a244d6
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	4be3873f-a596-4bbf-bf8e-2c7234ffd0cb
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	4a5a6f24-8b1a-4798-90fb-07ce9114b6a8
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	28b5899d-8363-49a1-b4f3-a0198c06fac3
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	668256f4-b3d1-423b-bc94-73c8e2091182
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	b2d6e54c-32cd-48df-aa9d-f60a9244a1da
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	efda1570-9272-49e6-b57a-bbe494fa56bb
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	b01639db-1eb3-4c8a-ac6e-b5949f2f4910
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	a49fa26f-ee17-454b-9e99-decaee7108e5
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	6eedb5be-bb8e-4b2a-8856-3107697bf38b
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	8fe85c5e-4628-4773-b70a-b30950c6277a
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	c68d43ba-5133-49d5-a3d8-3ce3034ee91c
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	64043b8c-90b3-4a7d-9a68-d5df5d560821
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	dca09c89-3f46-4230-85bf-5f926e91ae53
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	c71b8fa6-e1f8-48d2-b435-642f2ad9f804
19f512d7-5b46-4175-ae57-5c89d3a244d6	c71b8fa6-e1f8-48d2-b435-642f2ad9f804
19f512d7-5b46-4175-ae57-5c89d3a244d6	c68d43ba-5133-49d5-a3d8-3ce3034ee91c
4be3873f-a596-4bbf-bf8e-2c7234ffd0cb	64043b8c-90b3-4a7d-9a68-d5df5d560821
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	e1438656-1f77-42e4-b65c-fb584a20cbc8
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	cf412503-dad0-4b27-b4e2-af1152b8588a
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	1b8c7f5a-02a2-4847-a15b-55fa9417d763
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	1fcbbf51-b602-4697-a41e-7ac8244bbf4b
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	cf3caea6-3403-41fa-bfac-99654f6bd0f6
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	985a180d-5ff8-443e-bdf8-cfa4fd631bcc
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	d2946320-9d3c-40e9-9fba-b76b7811b21c
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	1987b4f1-a851-483c-a685-b11852f7cc66
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	fdad5850-d94b-4007-b934-d1bb562b1f9b
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	ac0d20ac-d277-4646-acfb-9eb7eb440e87
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	ecc11aff-afbb-495b-bcb3-f1ef95f294ad
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	11f86775-a5cb-4230-81de-c3d00eb9d3f4
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	55219ef5-3abb-433e-8a9c-5de66a2bb4f4
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	87c58099-272b-4d04-b371-c716ff95caab
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	30556410-23f3-4fc0-a22b-41eb314f60ce
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	100ef753-8229-4598-803a-409da03df301
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	22e5f380-addc-4e18-9f95-56dc92ced191
1b8c7f5a-02a2-4847-a15b-55fa9417d763	87c58099-272b-4d04-b371-c716ff95caab
1b8c7f5a-02a2-4847-a15b-55fa9417d763	22e5f380-addc-4e18-9f95-56dc92ced191
1fcbbf51-b602-4697-a41e-7ac8244bbf4b	30556410-23f3-4fc0-a22b-41eb314f60ce
60c98841-e4e9-413f-9e65-a1bfd4c35c14	0279bb9f-822c-475f-a3a7-3ed89426782b
60c98841-e4e9-413f-9e65-a1bfd4c35c14	5f2dc81c-cb40-4ae8-b4d3-8d1cb591597b
5f2dc81c-cb40-4ae8-b4d3-8d1cb591597b	0db1fb0f-c670-422e-a1e5-75f66a7f00db
fdf201b6-3290-4ea0-936e-abaaf6bf1db9	73168bee-1a6f-4995-b05a-d0a44d58a430
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	d92e3500-c8f0-4bb7-8db3-6a69ecfb77f9
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	b1a22d48-c7cd-4e28-9bcb-988820411af8
60c98841-e4e9-413f-9e65-a1bfd4c35c14	f84f8957-a8fd-40a5-b762-4d69b030f7d2
60c98841-e4e9-413f-9e65-a1bfd4c35c14	7dd31c81-b1d6-4a68-9c3b-ec60785af09c
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority, version) FROM stdin;
828e326b-c73a-4768-a1cd-d309cbfb7eb9	\N	password	ffbee2e6-9033-4d4a-9c11-4b7344c09b7e	1755788439493	\N	{"value":"jmY7jsBSHWPBWCv/7kbbMVpHxsXjpB1YOOnXW5KxIkI=","salt":"OK1U76r3As8CCDsExR7TNg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-08-21 15:00:33.379964	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	5788433086
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-08-21 15:00:33.389638	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	5788433086
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-08-21 15:00:33.417852	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	5788433086
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-08-21 15:00:33.420466	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5788433086
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-08-21 15:00:33.484011	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	5788433086
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-08-21 15:00:33.487537	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	5788433086
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-08-21 15:00:33.570325	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	5788433086
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-08-21 15:00:33.574093	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	5788433086
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-08-21 15:00:33.577938	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	5788433086
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-08-21 15:00:33.641362	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	5788433086
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-08-21 15:00:33.676572	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5788433086
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-08-21 15:00:33.679151	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5788433086
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-08-21 15:00:33.690266	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5788433086
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-21 15:00:33.70482	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	5788433086
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-21 15:00:33.705902	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5788433086
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-21 15:00:33.707555	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	5788433086
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-21 15:00:33.709263	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	5788433086
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-08-21 15:00:33.736898	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	5788433086
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-08-21 15:00:33.763867	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	5788433086
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-08-21 15:00:33.767177	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	5788433086
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-08-21 15:00:33.768997	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	5788433086
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-08-21 15:00:33.771193	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	5788433086
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-08-21 15:00:33.815191	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	5788433086
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-08-21 15:00:33.818795	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	5788433086
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-08-21 15:00:33.819588	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	5788433086
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-08-21 15:00:34.055657	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	5788433086
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-08-21 15:00:34.098025	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	5788433086
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-08-21 15:00:34.100259	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	5788433086
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-08-21 15:00:34.137683	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	5788433086
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-08-21 15:00:34.145178	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	5788433086
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-08-21 15:00:34.156228	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	5788433086
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-08-21 15:00:34.160103	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	5788433086
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-21 15:00:34.163544	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5788433086
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-21 15:00:34.164677	34	MARK_RAN	9:f9753208029f582525ed12011a19d054	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	5788433086
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-21 15:00:34.181042	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	5788433086
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-08-21 15:00:34.183806	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	5788433086
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-21 15:00:34.186702	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5788433086
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-08-21 15:00:34.188547	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	5788433086
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-08-21 15:00:34.191338	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	5788433086
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-21 15:00:34.192165	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	5788433086
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-21 15:00:34.193143	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	5788433086
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-08-21 15:00:34.195407	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	5788433086
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-21 15:00:35.081548	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	5788433086
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-08-21 15:00:35.083696	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	5788433086
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-21 15:00:35.0854	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	5788433086
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-21 15:00:35.087617	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	5788433086
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-21 15:00:35.088312	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	5788433086
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-21 15:00:35.149622	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	5788433086
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-21 15:00:35.151963	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	5788433086
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-08-21 15:00:35.170976	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	5788433086
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-08-21 15:00:35.340643	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	5788433086
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-08-21 15:00:35.342446	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5788433086
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-08-21 15:00:35.343846	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	5788433086
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-08-21 15:00:35.345078	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	5788433086
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-21 15:00:35.348619	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	5788433086
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-21 15:00:35.350735	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	5788433086
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-21 15:00:35.373347	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	5788433086
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-21 15:00:35.701083	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	5788433086
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-08-21 15:00:35.720624	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	5788433086
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-08-21 15:00:35.723369	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	5788433086
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-08-21 15:00:35.727018	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	5788433086
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-08-21 15:00:35.730084	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	5788433086
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-08-21 15:00:35.731845	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	5788433086
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-08-21 15:00:35.733379	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	5788433086
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-08-21 15:00:35.735014	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	5788433086
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-08-21 15:00:35.767766	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	5788433086
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-08-21 15:00:35.796667	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	5788433086
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-08-21 15:00:35.799403	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	5788433086
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-08-21 15:00:35.833954	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	5788433086
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-08-21 15:00:35.836947	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	5788433086
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-08-21 15:00:35.839233	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	5788433086
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-21 15:00:35.843176	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5788433086
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-21 15:00:35.847261	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5788433086
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-21 15:00:35.848412	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5788433086
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-21 15:00:35.860687	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	5788433086
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-21 15:00:35.896138	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	5788433086
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-21 15:00:35.898849	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	5788433086
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-21 15:00:35.8999	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	5788433086
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-21 15:00:35.90965	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	5788433086
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-21 15:00:35.910645	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	5788433086
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-21 15:00:35.940654	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	5788433086
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-21 15:00:35.941517	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5788433086
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-21 15:00:35.943495	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5788433086
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-21 15:00:35.944053	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5788433086
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-21 15:00:35.971912	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5788433086
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-08-21 15:00:35.97415	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	5788433086
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-08-21 15:00:35.978014	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	5788433086
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-08-21 15:00:35.984522	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	5788433086
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-21 15:00:35.988073	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	5788433086
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-21 15:00:35.991168	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	5788433086
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-21 15:00:36.020955	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5788433086
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-21 15:00:36.024914	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	5788433086
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-21 15:00:36.026145	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	5788433086
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-21 15:00:36.030891	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	5788433086
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-21 15:00:36.032087	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	5788433086
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-21 15:00:36.036036	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	5788433086
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-21 15:00:36.118664	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5788433086
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-21 15:00:36.119512	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5788433086
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-21 15:00:36.126985	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5788433086
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-21 15:00:36.162028	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5788433086
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-21 15:00:36.163126	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5788433086
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-21 15:00:36.200257	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	5788433086
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-21 15:00:36.203744	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	5788433086
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-08-21 15:00:36.207895	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	5788433086
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-08-21 15:00:36.239284	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	5788433086
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-08-21 15:00:36.271551	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	5788433086
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-08-21 15:00:36.305032	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	5788433086
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-08-21 15:00:36.307938	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	5788433086
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-21 15:00:36.339077	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	5788433086
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-21 15:00:36.339995	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	5788433086
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-21 15:00:36.343328	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5788433086
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-08-21 15:00:36.346934	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	5788433086
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-08-21 15:00:36.361992	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	5788433086
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-08-21 15:00:36.363711	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	5788433086
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-08-21 15:00:36.366299	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	5788433086
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-08-21 15:00:36.367109	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	5788433086
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-08-21 15:00:36.37021	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	5788433086
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-08-21 15:00:36.371802	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5788433086
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-21 15:00:36.486398	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	5788433086
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-21 15:00:36.4891	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	5788433086
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-21 15:00:36.49257	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5788433086
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-21 15:00:36.521497	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5788433086
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-21 15:00:36.523805	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	5788433086
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-21 15:00:36.524631	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5788433086
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-21 15:00:36.52568	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5788433086
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:36.52866	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	5788433086
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:36.557377	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5788433086
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:36.685226	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5788433086
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:36.788265	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5788433086
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:36.882917	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5788433086
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:36.980107	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	5788433086
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:36.981368	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5788433086
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:37.010911	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5788433086
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:37.029222	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	5788433086
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:37.038073	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	5788433086
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:37.039021	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	5788433086
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-21 15:00:37.089892	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	5788433086
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-21 15:00:37.09369	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	5788433086
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-21 15:00:37.097604	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	5788433086
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-21 15:00:37.128878	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	5788433086
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-21 15:00:37.131708	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	5788433086
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-21 15:00:37.135206	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	5788433086
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-21 15:00:37.166008	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	5788433086
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-21 15:00:37.231013	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	5788433086
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-21 15:00:37.342964	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	5788433086
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-21 15:00:37.349427	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	5788433086
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-21 15:00:37.35115	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	5788433086
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-08-21 15:00:37.356216	148	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.29.1	\N	\N	5788433086
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-08-21 15:00:37.359996	149	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	5788433086
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-08-21 15:00:37.361998	150	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.29.1	\N	\N	5788433086
26.2.0-36750	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-08-21 15:00:37.367132	151	EXECUTED	9:b49ce951c22f7eb16480ff085640a33a	createTable tableName=SERVER_CONFIG		\N	4.29.1	\N	\N	5788433086
26.2.0-26106	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-08-21 15:00:37.368781	152	EXECUTED	9:b5877d5dab7d10ff3a9d209d7beb6680	addColumn tableName=CREDENTIAL		\N	4.29.1	\N	\N	5788433086
26.2.6-39866-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-08-21 15:00:37.370806	153	EXECUTED	9:1dc67ccee24f30331db2cba4f372e40e	customChange		\N	4.29.1	\N	\N	5788433086
26.2.6-39866-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-08-21 15:00:37.373126	154	EXECUTED	9:b70b76f47210cf0a5f4ef0e219eac7cd	addUniqueConstraint constraintName=UK_MIGRATION_VERSION, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	5788433086
26.2.6-40088-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-08-21 15:00:37.374902	155	EXECUTED	9:cc7e02ed69ab31979afb1982f9670e8f	customChange		\N	4.29.1	\N	\N	5788433086
26.2.6-40088-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-08-21 15:00:37.37706	156	EXECUTED	9:5bb848128da7bc4595cc507383325241	addUniqueConstraint constraintName=UK_MIGRATION_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	5788433086
26.3.0-groups-description	keycloak	META-INF/jpa-changelog-26.3.0.xml	2025-08-21 15:00:37.379365	157	EXECUTED	9:e1a3c05574326fb5b246b73b9a4c4d49	addColumn tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5788433086
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	c956c9b4-d05a-4254-9229-7b5b6776f7ef	f
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	c0063e58-2ce8-4bba-87e4-12d6ff5d0052	t
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	d0527f9d-7a01-45eb-bb25-6dcbaef658ed	t
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	e566570a-0e0b-41b0-a0a9-515bb1f523ef	t
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	8b2151ab-8ec8-4269-93d7-65746ab24ee2	t
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	bdf76a7a-3e05-40d1-a927-46efba92421f	f
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	646bc4aa-0d50-4562-810e-1ca06dd18a1e	f
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	dc2d0890-826b-4e3f-a6ee-d2a0e502aeee	t
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	432d630c-d18d-4630-a3d7-0e1159801c76	t
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	e2d8c194-521f-4ceb-93d7-2aadd62ddfd7	f
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	b936e873-7a92-493b-aa12-cc1a14da53c5	t
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	95aa00d2-ec89-4f8c-9997-31616a1967f1	t
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	61d442bc-bf7a-47a9-83b1-0ced83287aac	f
8d35e8a2-755c-44b9-84e1-cd723f651bbc	009b393e-ae51-4606-ab28-99881e00119c	f
8d35e8a2-755c-44b9-84e1-cd723f651bbc	4f10e3bc-236d-4bef-b332-7c12bd47283c	t
8d35e8a2-755c-44b9-84e1-cd723f651bbc	5acc3b80-a66a-47d6-8220-431d8a2e61e9	t
8d35e8a2-755c-44b9-84e1-cd723f651bbc	8f54d702-7771-4261-a630-3187a6406bcc	t
8d35e8a2-755c-44b9-84e1-cd723f651bbc	dbd836c2-479e-4c21-9a99-afd38ede0a5a	t
8d35e8a2-755c-44b9-84e1-cd723f651bbc	9da5abc2-306d-4431-9c1a-4d22aeac41ce	f
8d35e8a2-755c-44b9-84e1-cd723f651bbc	77ca655c-161b-4a25-863b-10d4ad41b966	f
8d35e8a2-755c-44b9-84e1-cd723f651bbc	57b8203b-eb98-4316-979f-87b3b8f42484	t
8d35e8a2-755c-44b9-84e1-cd723f651bbc	9c034611-01be-497b-b007-a7c7b717d26f	t
8d35e8a2-755c-44b9-84e1-cd723f651bbc	38055269-5a63-4111-a5a4-80436d1f1d7c	f
8d35e8a2-755c-44b9-84e1-cd723f651bbc	76ff392c-7bb0-47c5-9255-f361c431b6ad	t
8d35e8a2-755c-44b9-84e1-cd723f651bbc	ecddf396-4842-46e2-a9dc-fc8ae2ab1994	t
8d35e8a2-755c-44b9-84e1-cd723f651bbc	9ffe61f0-fffb-41c0-995a-6a1ebefd1807	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type, description) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
cbceade4-5f5e-4eae-99fc-0e421955894d	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	f	${role_default-roles}	default-roles-master	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N	\N
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	f	${role_admin}	admin	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N	\N
d01b0ccb-c687-42cb-a9d2-42931854c4db	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	f	${role_create-realm}	create-realm	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N	\N
3c333636-d441-4bcb-92b3-66374a6611ef	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_create-client}	create-client	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
874f7b6e-7ca0-473b-8628-13f9a6893e23	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_view-realm}	view-realm	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
9848d75a-fae9-46f6-9fbb-289cd3d8df12	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_view-users}	view-users	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
1f81a9b1-5820-42ce-a887-a4aaebdea4f8	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_view-clients}	view-clients	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
d315888d-e193-4482-a7e7-2069f47912b2	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_view-events}	view-events	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
f619adcb-45db-4600-8374-3eb858b42789	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_view-identity-providers}	view-identity-providers	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
d9cd68b1-191f-4703-ad68-5a14f2a2f4d0	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_view-authorization}	view-authorization	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
fa9025f2-e7fe-4de8-8922-1d24065f91a8	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_manage-realm}	manage-realm	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
c969b0a8-fbda-427d-a1b7-ac9345373051	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_manage-users}	manage-users	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
1459fca3-e1d0-43f5-be3f-027017f148ca	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_manage-clients}	manage-clients	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
fc7494e0-139d-40e4-929c-c6ed901447ce	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_manage-events}	manage-events	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
f0349cdf-ea50-4592-ab55-82136f92a959	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_manage-identity-providers}	manage-identity-providers	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
8b07dcc3-d154-4775-83f7-9cb36650d7ca	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_manage-authorization}	manage-authorization	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
5976b6c4-270e-474c-b747-7884488e2702	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_query-users}	query-users	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
9ca18b49-8007-4bad-b0ec-72678a0c21cb	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_query-clients}	query-clients	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
923b7906-1817-4853-9b9c-ebb269d6a1ef	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_query-realms}	query-realms	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
5c2f47d8-41d7-4afb-947e-a8d55cd4ab4f	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_query-groups}	query-groups	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
6b78f570-4681-47ed-be5e-1d5b9d5dcf6e	3b574bb8-433e-48a7-8c9e-90414d96dcaa	t	${role_view-profile}	view-profile	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	3b574bb8-433e-48a7-8c9e-90414d96dcaa	\N
4705fb17-95ea-4d79-82be-fe21cb213295	3b574bb8-433e-48a7-8c9e-90414d96dcaa	t	${role_manage-account}	manage-account	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	3b574bb8-433e-48a7-8c9e-90414d96dcaa	\N
5af88950-8f52-444b-a7c5-c0fcce7b2af1	3b574bb8-433e-48a7-8c9e-90414d96dcaa	t	${role_manage-account-links}	manage-account-links	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	3b574bb8-433e-48a7-8c9e-90414d96dcaa	\N
35546834-8618-4a4c-b350-8e7918db7909	3b574bb8-433e-48a7-8c9e-90414d96dcaa	t	${role_view-applications}	view-applications	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	3b574bb8-433e-48a7-8c9e-90414d96dcaa	\N
814d0e6c-e686-4a47-8de5-c7a7d4d11beb	3b574bb8-433e-48a7-8c9e-90414d96dcaa	t	${role_view-consent}	view-consent	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	3b574bb8-433e-48a7-8c9e-90414d96dcaa	\N
98a6bc92-9ab1-4fe1-bd13-d884dd1f9490	3b574bb8-433e-48a7-8c9e-90414d96dcaa	t	${role_manage-consent}	manage-consent	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	3b574bb8-433e-48a7-8c9e-90414d96dcaa	\N
b2ee74ce-e9b7-4bdd-bd9a-97078f2d47ee	3b574bb8-433e-48a7-8c9e-90414d96dcaa	t	${role_view-groups}	view-groups	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	3b574bb8-433e-48a7-8c9e-90414d96dcaa	\N
72a2445e-d5db-4cd6-89fb-ecdef37a4b7b	3b574bb8-433e-48a7-8c9e-90414d96dcaa	t	${role_delete-account}	delete-account	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	3b574bb8-433e-48a7-8c9e-90414d96dcaa	\N
f1e73feb-6e38-489e-b0df-2d598a274936	0682d93d-69b3-444b-94a8-d5528a967f03	t	${role_read-token}	read-token	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	0682d93d-69b3-444b-94a8-d5528a967f03	\N
c8c4453a-78eb-4fc1-af96-37ad965031db	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	t	${role_impersonation}	impersonation	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	\N
0c910c3f-21ca-42af-b8ae-0c507079691b	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	f	${role_offline-access}	offline_access	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N	\N
a2d8a42a-f194-46d4-ac19-cf4001dc0fac	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	f	${role_uma_authorization}	uma_authorization	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	\N	\N
60c98841-e4e9-413f-9e65-a1bfd4c35c14	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f	${role_default-roles}	default-roles-companyinfo	8d35e8a2-755c-44b9-84e1-cd723f651bbc	\N	\N
cd935f35-858f-4060-bad2-3d79dd56eb85	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_create-client}	create-client	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
193521cc-ae2c-4f71-9380-f60b2d91d0ff	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_view-realm}	view-realm	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
19f512d7-5b46-4175-ae57-5c89d3a244d6	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_view-users}	view-users	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
4be3873f-a596-4bbf-bf8e-2c7234ffd0cb	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_view-clients}	view-clients	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
4a5a6f24-8b1a-4798-90fb-07ce9114b6a8	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_view-events}	view-events	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
28b5899d-8363-49a1-b4f3-a0198c06fac3	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_view-identity-providers}	view-identity-providers	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
668256f4-b3d1-423b-bc94-73c8e2091182	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_view-authorization}	view-authorization	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
b2d6e54c-32cd-48df-aa9d-f60a9244a1da	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_manage-realm}	manage-realm	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
efda1570-9272-49e6-b57a-bbe494fa56bb	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_manage-users}	manage-users	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
b01639db-1eb3-4c8a-ac6e-b5949f2f4910	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_manage-clients}	manage-clients	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
a49fa26f-ee17-454b-9e99-decaee7108e5	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_manage-events}	manage-events	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
6eedb5be-bb8e-4b2a-8856-3107697bf38b	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_manage-identity-providers}	manage-identity-providers	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
8fe85c5e-4628-4773-b70a-b30950c6277a	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_manage-authorization}	manage-authorization	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
c68d43ba-5133-49d5-a3d8-3ce3034ee91c	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_query-users}	query-users	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
64043b8c-90b3-4a7d-9a68-d5df5d560821	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_query-clients}	query-clients	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
dca09c89-3f46-4230-85bf-5f926e91ae53	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_query-realms}	query-realms	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
c71b8fa6-e1f8-48d2-b435-642f2ad9f804	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_query-groups}	query-groups	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
3e5cc13a-8e8d-47ad-83a1-9ff2e2524146	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_realm-admin}	realm-admin	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
e1438656-1f77-42e4-b65c-fb584a20cbc8	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_create-client}	create-client	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
cf412503-dad0-4b27-b4e2-af1152b8588a	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_view-realm}	view-realm	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
1b8c7f5a-02a2-4847-a15b-55fa9417d763	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_view-users}	view-users	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
1fcbbf51-b602-4697-a41e-7ac8244bbf4b	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_view-clients}	view-clients	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
cf3caea6-3403-41fa-bfac-99654f6bd0f6	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_view-events}	view-events	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
985a180d-5ff8-443e-bdf8-cfa4fd631bcc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_view-identity-providers}	view-identity-providers	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
d2946320-9d3c-40e9-9fba-b76b7811b21c	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_view-authorization}	view-authorization	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
1987b4f1-a851-483c-a685-b11852f7cc66	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_manage-realm}	manage-realm	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
fdad5850-d94b-4007-b934-d1bb562b1f9b	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_manage-users}	manage-users	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
ac0d20ac-d277-4646-acfb-9eb7eb440e87	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_manage-clients}	manage-clients	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
ecc11aff-afbb-495b-bcb3-f1ef95f294ad	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_manage-events}	manage-events	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
11f86775-a5cb-4230-81de-c3d00eb9d3f4	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_manage-identity-providers}	manage-identity-providers	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
55219ef5-3abb-433e-8a9c-5de66a2bb4f4	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_manage-authorization}	manage-authorization	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
87c58099-272b-4d04-b371-c716ff95caab	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_query-users}	query-users	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
30556410-23f3-4fc0-a22b-41eb314f60ce	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_query-clients}	query-clients	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
100ef753-8229-4598-803a-409da03df301	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_query-realms}	query-realms	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
22e5f380-addc-4e18-9f95-56dc92ced191	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_query-groups}	query-groups	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
0279bb9f-822c-475f-a3a7-3ed89426782b	bad31dd0-85e6-4111-834d-3d78a8eb119d	t	${role_view-profile}	view-profile	8d35e8a2-755c-44b9-84e1-cd723f651bbc	bad31dd0-85e6-4111-834d-3d78a8eb119d	\N
5f2dc81c-cb40-4ae8-b4d3-8d1cb591597b	bad31dd0-85e6-4111-834d-3d78a8eb119d	t	${role_manage-account}	manage-account	8d35e8a2-755c-44b9-84e1-cd723f651bbc	bad31dd0-85e6-4111-834d-3d78a8eb119d	\N
0db1fb0f-c670-422e-a1e5-75f66a7f00db	bad31dd0-85e6-4111-834d-3d78a8eb119d	t	${role_manage-account-links}	manage-account-links	8d35e8a2-755c-44b9-84e1-cd723f651bbc	bad31dd0-85e6-4111-834d-3d78a8eb119d	\N
c821160c-1e6a-42d5-a03f-55d498637d9c	bad31dd0-85e6-4111-834d-3d78a8eb119d	t	${role_view-applications}	view-applications	8d35e8a2-755c-44b9-84e1-cd723f651bbc	bad31dd0-85e6-4111-834d-3d78a8eb119d	\N
73168bee-1a6f-4995-b05a-d0a44d58a430	bad31dd0-85e6-4111-834d-3d78a8eb119d	t	${role_view-consent}	view-consent	8d35e8a2-755c-44b9-84e1-cd723f651bbc	bad31dd0-85e6-4111-834d-3d78a8eb119d	\N
fdf201b6-3290-4ea0-936e-abaaf6bf1db9	bad31dd0-85e6-4111-834d-3d78a8eb119d	t	${role_manage-consent}	manage-consent	8d35e8a2-755c-44b9-84e1-cd723f651bbc	bad31dd0-85e6-4111-834d-3d78a8eb119d	\N
9bdeb1b8-94e1-439b-8d74-04e60b751012	bad31dd0-85e6-4111-834d-3d78a8eb119d	t	${role_view-groups}	view-groups	8d35e8a2-755c-44b9-84e1-cd723f651bbc	bad31dd0-85e6-4111-834d-3d78a8eb119d	\N
751c82ec-1159-495e-8fc9-f7c25fd1880a	bad31dd0-85e6-4111-834d-3d78a8eb119d	t	${role_delete-account}	delete-account	8d35e8a2-755c-44b9-84e1-cd723f651bbc	bad31dd0-85e6-4111-834d-3d78a8eb119d	\N
d92e3500-c8f0-4bb7-8db3-6a69ecfb77f9	a551b881-6778-494f-86bb-c3c5ffb52a46	t	${role_impersonation}	impersonation	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	a551b881-6778-494f-86bb-c3c5ffb52a46	\N
b1a22d48-c7cd-4e28-9bcb-988820411af8	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	t	${role_impersonation}	impersonation	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f6bcbfc0-1ee4-449f-81df-ed90de7e001c	\N
bfd59362-df05-464d-8f81-7945f8ebe2b4	c06163ae-71c6-43e1-aeac-1152d0a27717	t	${role_read-token}	read-token	8d35e8a2-755c-44b9-84e1-cd723f651bbc	c06163ae-71c6-43e1-aeac-1152d0a27717	\N
f84f8957-a8fd-40a5-b762-4d69b030f7d2	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f	${role_offline-access}	offline_access	8d35e8a2-755c-44b9-84e1-cd723f651bbc	\N	\N
7dd31c81-b1d6-4a68-9c3b-ec60785af09c	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f	${role_uma_authorization}	uma_authorization	8d35e8a2-755c-44b9-84e1-cd723f651bbc	\N	\N
72ad85aa-a143-487c-b018-46a8cc7b2f12	c185c938-d7ab-4c5e-947a-a0668898148a	t	\N	uma_protection	8d35e8a2-755c-44b9-84e1-cd723f651bbc	c185c938-d7ab-4c5e-947a-a0668898148a	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migration_model (id, version, update_time) FROM stdin;
di5l3	26.3.2	1755788438
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
5433df7b-e6c8-4aca-ba3b-357545caa0cb	c504fbfb-db56-470f-923a-796d489a7796	0	1755789010	{"authMethod":"openid-connect","redirectUri":"http://localhost:8080/admin/master/console/#/companyinfo/users","notes":{"clientId":"c504fbfb-db56-470f-923a-796d489a7796","iss":"http://localhost:8080/realms/master","startedAt":"1755788479","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"71aa89e5-d305-448e-bf49-5943149b9a0d","response_mode":"query","scope":"openid","userSessionStartedAt":"1755788479","redirect_uri":"http://localhost:8080/admin/master/console/#/companyinfo/users","state":"d30c9322-7ed1-4d36-818f-23ab636bed4e","code_challenge":"K7FcakTRVsurbc9hF0Kw1-u9xrZexl1UMydCY_XxT34","prompt":"none","SSO_AUTH":"true"}}	local	local	8
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
5433df7b-e6c8-4aca-ba3b-357545caa0cb	ffbee2e6-9033-4d4a-9c11-4b7344c09b7e	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	1755788479	0	{"ipAddress":"172.28.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjguMC4xIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiQ2hyb21lLzEzOC4wLjAiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1755788479","authenticators-completed":"{\\"5489cdbf-0612-4eaa-b5bf-03e5c2fd7555\\":1755788479,\\"6d549f7c-cbbd-4a5d-8c28-6a0d2805616c\\":1755789010}"},"state":"LOGGED_IN"}	1755789010	\N	8
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
9b84021b-be9b-495f-996b-d5b46e71d552	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
13f3ce9e-501e-4b41-bc12-f7fd7579604f	defaultResourceType	urn:ciadmin:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
8ac77dd9-3363-40e8-8309-5895c10470c7	audience resolve	openid-connect	oidc-audience-resolve-mapper	2caa34fc-3296-4d55-a66c-5443a2901355	\N
ae95fe5a-6aa7-490a-a248-fe3617af7e5c	locale	openid-connect	oidc-usermodel-attribute-mapper	c504fbfb-db56-470f-923a-796d489a7796	\N
60a08271-d077-4d6f-b4da-646659ab76d1	role list	saml	saml-role-list-mapper	\N	c0063e58-2ce8-4bba-87e4-12d6ff5d0052
5ea27269-78dc-4c84-810f-7864d999a3a8	organization	saml	saml-organization-membership-mapper	\N	d0527f9d-7a01-45eb-bb25-6dcbaef658ed
46e1fb1c-9476-4797-85f9-8c959710b11e	full name	openid-connect	oidc-full-name-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
0cca07b9-004a-468c-9cc0-9bbb4c4cc78e	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
cf959d27-7c47-4766-9349-ab910476bac1	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
c41d9da8-e159-49f8-9114-a636b0d3edf3	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
339338df-9eb4-4b66-93a4-dd0c00565137	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
2bb93383-6221-4989-b5a7-4c66fe296e2a	username	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
86421a7a-e8b8-499a-baca-d35057f9b361	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
0a0f0e3a-22f3-4ce9-ab70-0fe58fb16005	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
2204a04f-e53d-4b94-8a77-ace0de873b4d	website	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
c9136c3e-7b8e-4952-8b46-b1386fa48bf6	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
1db7b8cf-d4b2-419e-af1b-2f5737894e8b	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
81c643d3-a88f-4a7f-9d17-cdac59689668	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
3138e438-82f2-4e39-9b91-4bb698d6c759	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
647dc902-eaf5-4c0c-a513-d984adda13fa	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	e566570a-0e0b-41b0-a0a9-515bb1f523ef
60e8a4e3-81dc-413b-8d5a-0e1a389cd639	email	openid-connect	oidc-usermodel-attribute-mapper	\N	8b2151ab-8ec8-4269-93d7-65746ab24ee2
12d564dd-3532-4708-9afd-ad651a356211	email verified	openid-connect	oidc-usermodel-property-mapper	\N	8b2151ab-8ec8-4269-93d7-65746ab24ee2
7aa8bff8-f67b-4e6e-9d31-a20c8b9b37e3	address	openid-connect	oidc-address-mapper	\N	bdf76a7a-3e05-40d1-a927-46efba92421f
d228e06f-545f-43e1-84af-f0b02af8a661	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	646bc4aa-0d50-4562-810e-1ca06dd18a1e
bbe94a09-fba3-453b-898c-d36bfa050067	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	646bc4aa-0d50-4562-810e-1ca06dd18a1e
bf6e66dc-9653-4306-a157-83f962a49131	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	dc2d0890-826b-4e3f-a6ee-d2a0e502aeee
426b8029-9ffc-4557-8598-a1411d835f81	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	dc2d0890-826b-4e3f-a6ee-d2a0e502aeee
10317956-a8cd-4885-9711-a45708b42150	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	dc2d0890-826b-4e3f-a6ee-d2a0e502aeee
07683e97-be70-4e58-9a86-3f0ed1bcd5b8	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	432d630c-d18d-4630-a3d7-0e1159801c76
7bea4019-793b-447e-a6b7-d4d4897ed05d	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	e2d8c194-521f-4ceb-93d7-2aadd62ddfd7
d0a3974f-61aa-4679-a5e8-8c33f12eb8a9	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	e2d8c194-521f-4ceb-93d7-2aadd62ddfd7
a79b550a-2606-4e4f-a855-c9b2698b9bd9	acr loa level	openid-connect	oidc-acr-mapper	\N	b936e873-7a92-493b-aa12-cc1a14da53c5
1d5c83d0-998f-4a11-af47-f42bb7fc7ccf	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	95aa00d2-ec89-4f8c-9997-31616a1967f1
74184d25-916f-4be8-920e-7cb32346e7d1	sub	openid-connect	oidc-sub-mapper	\N	95aa00d2-ec89-4f8c-9997-31616a1967f1
06ba65b3-85c0-469b-9187-447b8ab517b3	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	cd8df6ed-f413-43a3-9a16-5700d41f746c
817b62e9-011c-4e4c-88a7-52ae6b00db98	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	cd8df6ed-f413-43a3-9a16-5700d41f746c
1a4c2f2a-1797-4f82-915e-fd537fad480e	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	cd8df6ed-f413-43a3-9a16-5700d41f746c
d1ec7cb5-d82f-4dfb-a9f3-9868d8f16041	organization	openid-connect	oidc-organization-membership-mapper	\N	61d442bc-bf7a-47a9-83b1-0ced83287aac
2b358e04-0948-469f-ba61-060b94858856	audience resolve	openid-connect	oidc-audience-resolve-mapper	2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	\N
a20fdc3b-a371-4ef9-b7fa-5fed8b32d74a	role list	saml	saml-role-list-mapper	\N	4f10e3bc-236d-4bef-b332-7c12bd47283c
fe5162ec-302d-44b1-ad94-e3d44b4d004e	organization	saml	saml-organization-membership-mapper	\N	5acc3b80-a66a-47d6-8220-431d8a2e61e9
1c331e5d-4d41-4f14-8b5c-0c681f184725	full name	openid-connect	oidc-full-name-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
27ebcdde-808a-4676-96ef-924a954e09fb	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
77c83b1b-2557-44b9-bb20-c946d8d052fd	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
2e3a1c8d-faed-488a-a6cc-30822c2e344a	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
82d65d5d-1b5d-4f68-a14f-352163636769	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
b06cdb94-15dd-4b77-9a89-49af2c5e34ee	username	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
60d2aa06-5cc4-4c05-af99-a9139ff23fb0	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
a459647e-df75-430a-9767-bb55281ef030	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
fc4d1e0e-a800-4024-b7ce-d61530fbb1da	website	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
98d30fd4-36e8-413a-9a63-a421b79346a4	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
74caf915-b56e-4f0b-9978-65494746d90a	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
bfcae4e1-804d-4857-a3c1-f98556f58058	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
fa0e80a2-20f0-42db-8530-fb36edf3dcd1	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
eb56660d-457c-4fe0-8802-0d7b1dc56878	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	8f54d702-7771-4261-a630-3187a6406bcc
4e85df45-57a3-45bb-91b4-bb832e54fb72	email	openid-connect	oidc-usermodel-attribute-mapper	\N	dbd836c2-479e-4c21-9a99-afd38ede0a5a
76cf79ac-362d-4c8d-97c0-5d3fb75a5e79	email verified	openid-connect	oidc-usermodel-property-mapper	\N	dbd836c2-479e-4c21-9a99-afd38ede0a5a
4daaaace-d3c6-4500-8b46-f0033148007c	address	openid-connect	oidc-address-mapper	\N	9da5abc2-306d-4431-9c1a-4d22aeac41ce
677dabee-6ae8-4bed-95f3-e4fed6fcc1f7	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	77ca655c-161b-4a25-863b-10d4ad41b966
df3f08b2-6c0f-46ab-8b7d-c0be5a5aa0a9	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	77ca655c-161b-4a25-863b-10d4ad41b966
c65276fd-8ac6-494a-9718-40116c90b88b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	57b8203b-eb98-4316-979f-87b3b8f42484
abc3022a-fa43-4b64-bb65-ab36ea0cec1b	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	57b8203b-eb98-4316-979f-87b3b8f42484
8961d827-28fd-4b8a-a146-cd8eeaeb81c5	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	57b8203b-eb98-4316-979f-87b3b8f42484
bfe6e8a3-b6e5-4c32-b799-d269fac8449f	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	9c034611-01be-497b-b007-a7c7b717d26f
48f62ba4-af74-40fe-8d00-e56a586e4e03	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	38055269-5a63-4111-a5a4-80436d1f1d7c
7f5f0d14-1d3f-4a30-99b2-f35b8f0b69f2	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	38055269-5a63-4111-a5a4-80436d1f1d7c
3724e97a-ea22-4232-94f2-7fa1fafe1f3d	acr loa level	openid-connect	oidc-acr-mapper	\N	76ff392c-7bb0-47c5-9255-f361c431b6ad
7e7b9be9-ffd4-49a7-8571-37ed0d9ad955	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	ecddf396-4842-46e2-a9dc-fc8ae2ab1994
e123dd1b-e032-4b47-8435-e8c5bb00ed7c	sub	openid-connect	oidc-sub-mapper	\N	ecddf396-4842-46e2-a9dc-fc8ae2ab1994
5fc17d07-6bbc-408a-a48a-f58123c809b8	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	f6f6b0b7-c739-4b96-a1ed-ec3ad6aaeacc
18815699-2996-4b09-a789-15883d9e2105	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	f6f6b0b7-c739-4b96-a1ed-ec3ad6aaeacc
f50594c4-04fa-4594-81d8-19a67b1cb558	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	f6f6b0b7-c739-4b96-a1ed-ec3ad6aaeacc
9e043dff-1627-427e-ac2f-3d238b251ddc	organization	openid-connect	oidc-organization-membership-mapper	\N	9ffe61f0-fffb-41c0-995a-6a1ebefd1807
b11c0269-80b9-42dc-9380-ead650ae67ca	locale	openid-connect	oidc-usermodel-attribute-mapper	d59e569d-28d9-4895-8e91-d4fe13d285e6	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
ae95fe5a-6aa7-490a-a248-fe3617af7e5c	true	introspection.token.claim
ae95fe5a-6aa7-490a-a248-fe3617af7e5c	true	userinfo.token.claim
ae95fe5a-6aa7-490a-a248-fe3617af7e5c	locale	user.attribute
ae95fe5a-6aa7-490a-a248-fe3617af7e5c	true	id.token.claim
ae95fe5a-6aa7-490a-a248-fe3617af7e5c	true	access.token.claim
ae95fe5a-6aa7-490a-a248-fe3617af7e5c	locale	claim.name
ae95fe5a-6aa7-490a-a248-fe3617af7e5c	String	jsonType.label
60a08271-d077-4d6f-b4da-646659ab76d1	false	single
60a08271-d077-4d6f-b4da-646659ab76d1	Basic	attribute.nameformat
60a08271-d077-4d6f-b4da-646659ab76d1	Role	attribute.name
0a0f0e3a-22f3-4ce9-ab70-0fe58fb16005	true	introspection.token.claim
0a0f0e3a-22f3-4ce9-ab70-0fe58fb16005	true	userinfo.token.claim
0a0f0e3a-22f3-4ce9-ab70-0fe58fb16005	picture	user.attribute
0a0f0e3a-22f3-4ce9-ab70-0fe58fb16005	true	id.token.claim
0a0f0e3a-22f3-4ce9-ab70-0fe58fb16005	true	access.token.claim
0a0f0e3a-22f3-4ce9-ab70-0fe58fb16005	picture	claim.name
0a0f0e3a-22f3-4ce9-ab70-0fe58fb16005	String	jsonType.label
0cca07b9-004a-468c-9cc0-9bbb4c4cc78e	true	introspection.token.claim
0cca07b9-004a-468c-9cc0-9bbb4c4cc78e	true	userinfo.token.claim
0cca07b9-004a-468c-9cc0-9bbb4c4cc78e	lastName	user.attribute
0cca07b9-004a-468c-9cc0-9bbb4c4cc78e	true	id.token.claim
0cca07b9-004a-468c-9cc0-9bbb4c4cc78e	true	access.token.claim
0cca07b9-004a-468c-9cc0-9bbb4c4cc78e	family_name	claim.name
0cca07b9-004a-468c-9cc0-9bbb4c4cc78e	String	jsonType.label
1db7b8cf-d4b2-419e-af1b-2f5737894e8b	true	introspection.token.claim
1db7b8cf-d4b2-419e-af1b-2f5737894e8b	true	userinfo.token.claim
1db7b8cf-d4b2-419e-af1b-2f5737894e8b	birthdate	user.attribute
1db7b8cf-d4b2-419e-af1b-2f5737894e8b	true	id.token.claim
1db7b8cf-d4b2-419e-af1b-2f5737894e8b	true	access.token.claim
1db7b8cf-d4b2-419e-af1b-2f5737894e8b	birthdate	claim.name
1db7b8cf-d4b2-419e-af1b-2f5737894e8b	String	jsonType.label
2204a04f-e53d-4b94-8a77-ace0de873b4d	true	introspection.token.claim
2204a04f-e53d-4b94-8a77-ace0de873b4d	true	userinfo.token.claim
2204a04f-e53d-4b94-8a77-ace0de873b4d	website	user.attribute
2204a04f-e53d-4b94-8a77-ace0de873b4d	true	id.token.claim
2204a04f-e53d-4b94-8a77-ace0de873b4d	true	access.token.claim
2204a04f-e53d-4b94-8a77-ace0de873b4d	website	claim.name
2204a04f-e53d-4b94-8a77-ace0de873b4d	String	jsonType.label
2bb93383-6221-4989-b5a7-4c66fe296e2a	true	introspection.token.claim
2bb93383-6221-4989-b5a7-4c66fe296e2a	true	userinfo.token.claim
2bb93383-6221-4989-b5a7-4c66fe296e2a	username	user.attribute
2bb93383-6221-4989-b5a7-4c66fe296e2a	true	id.token.claim
2bb93383-6221-4989-b5a7-4c66fe296e2a	true	access.token.claim
2bb93383-6221-4989-b5a7-4c66fe296e2a	preferred_username	claim.name
2bb93383-6221-4989-b5a7-4c66fe296e2a	String	jsonType.label
3138e438-82f2-4e39-9b91-4bb698d6c759	true	introspection.token.claim
3138e438-82f2-4e39-9b91-4bb698d6c759	true	userinfo.token.claim
3138e438-82f2-4e39-9b91-4bb698d6c759	locale	user.attribute
3138e438-82f2-4e39-9b91-4bb698d6c759	true	id.token.claim
3138e438-82f2-4e39-9b91-4bb698d6c759	true	access.token.claim
3138e438-82f2-4e39-9b91-4bb698d6c759	locale	claim.name
3138e438-82f2-4e39-9b91-4bb698d6c759	String	jsonType.label
339338df-9eb4-4b66-93a4-dd0c00565137	true	introspection.token.claim
339338df-9eb4-4b66-93a4-dd0c00565137	true	userinfo.token.claim
339338df-9eb4-4b66-93a4-dd0c00565137	nickname	user.attribute
339338df-9eb4-4b66-93a4-dd0c00565137	true	id.token.claim
339338df-9eb4-4b66-93a4-dd0c00565137	true	access.token.claim
339338df-9eb4-4b66-93a4-dd0c00565137	nickname	claim.name
339338df-9eb4-4b66-93a4-dd0c00565137	String	jsonType.label
46e1fb1c-9476-4797-85f9-8c959710b11e	true	introspection.token.claim
46e1fb1c-9476-4797-85f9-8c959710b11e	true	userinfo.token.claim
46e1fb1c-9476-4797-85f9-8c959710b11e	true	id.token.claim
46e1fb1c-9476-4797-85f9-8c959710b11e	true	access.token.claim
647dc902-eaf5-4c0c-a513-d984adda13fa	true	introspection.token.claim
647dc902-eaf5-4c0c-a513-d984adda13fa	true	userinfo.token.claim
647dc902-eaf5-4c0c-a513-d984adda13fa	updatedAt	user.attribute
647dc902-eaf5-4c0c-a513-d984adda13fa	true	id.token.claim
647dc902-eaf5-4c0c-a513-d984adda13fa	true	access.token.claim
647dc902-eaf5-4c0c-a513-d984adda13fa	updated_at	claim.name
647dc902-eaf5-4c0c-a513-d984adda13fa	long	jsonType.label
81c643d3-a88f-4a7f-9d17-cdac59689668	true	introspection.token.claim
81c643d3-a88f-4a7f-9d17-cdac59689668	true	userinfo.token.claim
81c643d3-a88f-4a7f-9d17-cdac59689668	zoneinfo	user.attribute
81c643d3-a88f-4a7f-9d17-cdac59689668	true	id.token.claim
81c643d3-a88f-4a7f-9d17-cdac59689668	true	access.token.claim
81c643d3-a88f-4a7f-9d17-cdac59689668	zoneinfo	claim.name
81c643d3-a88f-4a7f-9d17-cdac59689668	String	jsonType.label
86421a7a-e8b8-499a-baca-d35057f9b361	true	introspection.token.claim
86421a7a-e8b8-499a-baca-d35057f9b361	true	userinfo.token.claim
86421a7a-e8b8-499a-baca-d35057f9b361	profile	user.attribute
86421a7a-e8b8-499a-baca-d35057f9b361	true	id.token.claim
86421a7a-e8b8-499a-baca-d35057f9b361	true	access.token.claim
86421a7a-e8b8-499a-baca-d35057f9b361	profile	claim.name
86421a7a-e8b8-499a-baca-d35057f9b361	String	jsonType.label
c41d9da8-e159-49f8-9114-a636b0d3edf3	true	introspection.token.claim
c41d9da8-e159-49f8-9114-a636b0d3edf3	true	userinfo.token.claim
c41d9da8-e159-49f8-9114-a636b0d3edf3	middleName	user.attribute
c41d9da8-e159-49f8-9114-a636b0d3edf3	true	id.token.claim
c41d9da8-e159-49f8-9114-a636b0d3edf3	true	access.token.claim
c41d9da8-e159-49f8-9114-a636b0d3edf3	middle_name	claim.name
c41d9da8-e159-49f8-9114-a636b0d3edf3	String	jsonType.label
c9136c3e-7b8e-4952-8b46-b1386fa48bf6	true	introspection.token.claim
c9136c3e-7b8e-4952-8b46-b1386fa48bf6	true	userinfo.token.claim
c9136c3e-7b8e-4952-8b46-b1386fa48bf6	gender	user.attribute
c9136c3e-7b8e-4952-8b46-b1386fa48bf6	true	id.token.claim
c9136c3e-7b8e-4952-8b46-b1386fa48bf6	true	access.token.claim
c9136c3e-7b8e-4952-8b46-b1386fa48bf6	gender	claim.name
c9136c3e-7b8e-4952-8b46-b1386fa48bf6	String	jsonType.label
cf959d27-7c47-4766-9349-ab910476bac1	true	introspection.token.claim
cf959d27-7c47-4766-9349-ab910476bac1	true	userinfo.token.claim
cf959d27-7c47-4766-9349-ab910476bac1	firstName	user.attribute
cf959d27-7c47-4766-9349-ab910476bac1	true	id.token.claim
cf959d27-7c47-4766-9349-ab910476bac1	true	access.token.claim
cf959d27-7c47-4766-9349-ab910476bac1	given_name	claim.name
cf959d27-7c47-4766-9349-ab910476bac1	String	jsonType.label
12d564dd-3532-4708-9afd-ad651a356211	true	introspection.token.claim
12d564dd-3532-4708-9afd-ad651a356211	true	userinfo.token.claim
12d564dd-3532-4708-9afd-ad651a356211	emailVerified	user.attribute
12d564dd-3532-4708-9afd-ad651a356211	true	id.token.claim
12d564dd-3532-4708-9afd-ad651a356211	true	access.token.claim
12d564dd-3532-4708-9afd-ad651a356211	email_verified	claim.name
12d564dd-3532-4708-9afd-ad651a356211	boolean	jsonType.label
60e8a4e3-81dc-413b-8d5a-0e1a389cd639	true	introspection.token.claim
60e8a4e3-81dc-413b-8d5a-0e1a389cd639	true	userinfo.token.claim
60e8a4e3-81dc-413b-8d5a-0e1a389cd639	email	user.attribute
60e8a4e3-81dc-413b-8d5a-0e1a389cd639	true	id.token.claim
60e8a4e3-81dc-413b-8d5a-0e1a389cd639	true	access.token.claim
60e8a4e3-81dc-413b-8d5a-0e1a389cd639	email	claim.name
60e8a4e3-81dc-413b-8d5a-0e1a389cd639	String	jsonType.label
7aa8bff8-f67b-4e6e-9d31-a20c8b9b37e3	formatted	user.attribute.formatted
7aa8bff8-f67b-4e6e-9d31-a20c8b9b37e3	country	user.attribute.country
7aa8bff8-f67b-4e6e-9d31-a20c8b9b37e3	true	introspection.token.claim
7aa8bff8-f67b-4e6e-9d31-a20c8b9b37e3	postal_code	user.attribute.postal_code
7aa8bff8-f67b-4e6e-9d31-a20c8b9b37e3	true	userinfo.token.claim
7aa8bff8-f67b-4e6e-9d31-a20c8b9b37e3	street	user.attribute.street
7aa8bff8-f67b-4e6e-9d31-a20c8b9b37e3	true	id.token.claim
7aa8bff8-f67b-4e6e-9d31-a20c8b9b37e3	region	user.attribute.region
7aa8bff8-f67b-4e6e-9d31-a20c8b9b37e3	true	access.token.claim
7aa8bff8-f67b-4e6e-9d31-a20c8b9b37e3	locality	user.attribute.locality
bbe94a09-fba3-453b-898c-d36bfa050067	true	introspection.token.claim
bbe94a09-fba3-453b-898c-d36bfa050067	true	userinfo.token.claim
bbe94a09-fba3-453b-898c-d36bfa050067	phoneNumberVerified	user.attribute
bbe94a09-fba3-453b-898c-d36bfa050067	true	id.token.claim
bbe94a09-fba3-453b-898c-d36bfa050067	true	access.token.claim
bbe94a09-fba3-453b-898c-d36bfa050067	phone_number_verified	claim.name
bbe94a09-fba3-453b-898c-d36bfa050067	boolean	jsonType.label
d228e06f-545f-43e1-84af-f0b02af8a661	true	introspection.token.claim
d228e06f-545f-43e1-84af-f0b02af8a661	true	userinfo.token.claim
d228e06f-545f-43e1-84af-f0b02af8a661	phoneNumber	user.attribute
d228e06f-545f-43e1-84af-f0b02af8a661	true	id.token.claim
d228e06f-545f-43e1-84af-f0b02af8a661	true	access.token.claim
d228e06f-545f-43e1-84af-f0b02af8a661	phone_number	claim.name
d228e06f-545f-43e1-84af-f0b02af8a661	String	jsonType.label
10317956-a8cd-4885-9711-a45708b42150	true	introspection.token.claim
10317956-a8cd-4885-9711-a45708b42150	true	access.token.claim
426b8029-9ffc-4557-8598-a1411d835f81	true	introspection.token.claim
426b8029-9ffc-4557-8598-a1411d835f81	true	multivalued
426b8029-9ffc-4557-8598-a1411d835f81	foo	user.attribute
426b8029-9ffc-4557-8598-a1411d835f81	true	access.token.claim
426b8029-9ffc-4557-8598-a1411d835f81	resource_access.${client_id}.roles	claim.name
426b8029-9ffc-4557-8598-a1411d835f81	String	jsonType.label
bf6e66dc-9653-4306-a157-83f962a49131	true	introspection.token.claim
bf6e66dc-9653-4306-a157-83f962a49131	true	multivalued
bf6e66dc-9653-4306-a157-83f962a49131	foo	user.attribute
bf6e66dc-9653-4306-a157-83f962a49131	true	access.token.claim
bf6e66dc-9653-4306-a157-83f962a49131	realm_access.roles	claim.name
bf6e66dc-9653-4306-a157-83f962a49131	String	jsonType.label
07683e97-be70-4e58-9a86-3f0ed1bcd5b8	true	introspection.token.claim
07683e97-be70-4e58-9a86-3f0ed1bcd5b8	true	access.token.claim
7bea4019-793b-447e-a6b7-d4d4897ed05d	true	introspection.token.claim
7bea4019-793b-447e-a6b7-d4d4897ed05d	true	userinfo.token.claim
7bea4019-793b-447e-a6b7-d4d4897ed05d	username	user.attribute
7bea4019-793b-447e-a6b7-d4d4897ed05d	true	id.token.claim
7bea4019-793b-447e-a6b7-d4d4897ed05d	true	access.token.claim
7bea4019-793b-447e-a6b7-d4d4897ed05d	upn	claim.name
7bea4019-793b-447e-a6b7-d4d4897ed05d	String	jsonType.label
d0a3974f-61aa-4679-a5e8-8c33f12eb8a9	true	introspection.token.claim
d0a3974f-61aa-4679-a5e8-8c33f12eb8a9	true	multivalued
d0a3974f-61aa-4679-a5e8-8c33f12eb8a9	foo	user.attribute
d0a3974f-61aa-4679-a5e8-8c33f12eb8a9	true	id.token.claim
d0a3974f-61aa-4679-a5e8-8c33f12eb8a9	true	access.token.claim
d0a3974f-61aa-4679-a5e8-8c33f12eb8a9	groups	claim.name
d0a3974f-61aa-4679-a5e8-8c33f12eb8a9	String	jsonType.label
a79b550a-2606-4e4f-a855-c9b2698b9bd9	true	introspection.token.claim
a79b550a-2606-4e4f-a855-c9b2698b9bd9	true	id.token.claim
a79b550a-2606-4e4f-a855-c9b2698b9bd9	true	access.token.claim
1d5c83d0-998f-4a11-af47-f42bb7fc7ccf	AUTH_TIME	user.session.note
1d5c83d0-998f-4a11-af47-f42bb7fc7ccf	true	introspection.token.claim
1d5c83d0-998f-4a11-af47-f42bb7fc7ccf	true	id.token.claim
1d5c83d0-998f-4a11-af47-f42bb7fc7ccf	true	access.token.claim
1d5c83d0-998f-4a11-af47-f42bb7fc7ccf	auth_time	claim.name
1d5c83d0-998f-4a11-af47-f42bb7fc7ccf	long	jsonType.label
74184d25-916f-4be8-920e-7cb32346e7d1	true	introspection.token.claim
74184d25-916f-4be8-920e-7cb32346e7d1	true	access.token.claim
06ba65b3-85c0-469b-9187-447b8ab517b3	client_id	user.session.note
06ba65b3-85c0-469b-9187-447b8ab517b3	true	introspection.token.claim
06ba65b3-85c0-469b-9187-447b8ab517b3	true	id.token.claim
06ba65b3-85c0-469b-9187-447b8ab517b3	true	access.token.claim
06ba65b3-85c0-469b-9187-447b8ab517b3	client_id	claim.name
06ba65b3-85c0-469b-9187-447b8ab517b3	String	jsonType.label
1a4c2f2a-1797-4f82-915e-fd537fad480e	clientAddress	user.session.note
1a4c2f2a-1797-4f82-915e-fd537fad480e	true	introspection.token.claim
1a4c2f2a-1797-4f82-915e-fd537fad480e	true	id.token.claim
1a4c2f2a-1797-4f82-915e-fd537fad480e	true	access.token.claim
1a4c2f2a-1797-4f82-915e-fd537fad480e	clientAddress	claim.name
1a4c2f2a-1797-4f82-915e-fd537fad480e	String	jsonType.label
817b62e9-011c-4e4c-88a7-52ae6b00db98	clientHost	user.session.note
817b62e9-011c-4e4c-88a7-52ae6b00db98	true	introspection.token.claim
817b62e9-011c-4e4c-88a7-52ae6b00db98	true	id.token.claim
817b62e9-011c-4e4c-88a7-52ae6b00db98	true	access.token.claim
817b62e9-011c-4e4c-88a7-52ae6b00db98	clientHost	claim.name
817b62e9-011c-4e4c-88a7-52ae6b00db98	String	jsonType.label
d1ec7cb5-d82f-4dfb-a9f3-9868d8f16041	true	introspection.token.claim
d1ec7cb5-d82f-4dfb-a9f3-9868d8f16041	true	multivalued
d1ec7cb5-d82f-4dfb-a9f3-9868d8f16041	true	id.token.claim
d1ec7cb5-d82f-4dfb-a9f3-9868d8f16041	true	access.token.claim
d1ec7cb5-d82f-4dfb-a9f3-9868d8f16041	organization	claim.name
d1ec7cb5-d82f-4dfb-a9f3-9868d8f16041	String	jsonType.label
a20fdc3b-a371-4ef9-b7fa-5fed8b32d74a	false	single
a20fdc3b-a371-4ef9-b7fa-5fed8b32d74a	Basic	attribute.nameformat
a20fdc3b-a371-4ef9-b7fa-5fed8b32d74a	Role	attribute.name
1c331e5d-4d41-4f14-8b5c-0c681f184725	true	introspection.token.claim
1c331e5d-4d41-4f14-8b5c-0c681f184725	true	userinfo.token.claim
1c331e5d-4d41-4f14-8b5c-0c681f184725	true	id.token.claim
1c331e5d-4d41-4f14-8b5c-0c681f184725	true	access.token.claim
27ebcdde-808a-4676-96ef-924a954e09fb	true	introspection.token.claim
27ebcdde-808a-4676-96ef-924a954e09fb	true	userinfo.token.claim
27ebcdde-808a-4676-96ef-924a954e09fb	lastName	user.attribute
27ebcdde-808a-4676-96ef-924a954e09fb	true	id.token.claim
27ebcdde-808a-4676-96ef-924a954e09fb	true	access.token.claim
27ebcdde-808a-4676-96ef-924a954e09fb	family_name	claim.name
27ebcdde-808a-4676-96ef-924a954e09fb	String	jsonType.label
2e3a1c8d-faed-488a-a6cc-30822c2e344a	true	introspection.token.claim
2e3a1c8d-faed-488a-a6cc-30822c2e344a	true	userinfo.token.claim
2e3a1c8d-faed-488a-a6cc-30822c2e344a	middleName	user.attribute
2e3a1c8d-faed-488a-a6cc-30822c2e344a	true	id.token.claim
2e3a1c8d-faed-488a-a6cc-30822c2e344a	true	access.token.claim
2e3a1c8d-faed-488a-a6cc-30822c2e344a	middle_name	claim.name
2e3a1c8d-faed-488a-a6cc-30822c2e344a	String	jsonType.label
60d2aa06-5cc4-4c05-af99-a9139ff23fb0	true	introspection.token.claim
60d2aa06-5cc4-4c05-af99-a9139ff23fb0	true	userinfo.token.claim
60d2aa06-5cc4-4c05-af99-a9139ff23fb0	profile	user.attribute
60d2aa06-5cc4-4c05-af99-a9139ff23fb0	true	id.token.claim
60d2aa06-5cc4-4c05-af99-a9139ff23fb0	true	access.token.claim
60d2aa06-5cc4-4c05-af99-a9139ff23fb0	profile	claim.name
60d2aa06-5cc4-4c05-af99-a9139ff23fb0	String	jsonType.label
74caf915-b56e-4f0b-9978-65494746d90a	true	introspection.token.claim
74caf915-b56e-4f0b-9978-65494746d90a	true	userinfo.token.claim
74caf915-b56e-4f0b-9978-65494746d90a	birthdate	user.attribute
74caf915-b56e-4f0b-9978-65494746d90a	true	id.token.claim
74caf915-b56e-4f0b-9978-65494746d90a	true	access.token.claim
74caf915-b56e-4f0b-9978-65494746d90a	birthdate	claim.name
74caf915-b56e-4f0b-9978-65494746d90a	String	jsonType.label
77c83b1b-2557-44b9-bb20-c946d8d052fd	true	introspection.token.claim
77c83b1b-2557-44b9-bb20-c946d8d052fd	true	userinfo.token.claim
77c83b1b-2557-44b9-bb20-c946d8d052fd	firstName	user.attribute
77c83b1b-2557-44b9-bb20-c946d8d052fd	true	id.token.claim
77c83b1b-2557-44b9-bb20-c946d8d052fd	true	access.token.claim
77c83b1b-2557-44b9-bb20-c946d8d052fd	given_name	claim.name
77c83b1b-2557-44b9-bb20-c946d8d052fd	String	jsonType.label
82d65d5d-1b5d-4f68-a14f-352163636769	true	introspection.token.claim
82d65d5d-1b5d-4f68-a14f-352163636769	true	userinfo.token.claim
82d65d5d-1b5d-4f68-a14f-352163636769	nickname	user.attribute
82d65d5d-1b5d-4f68-a14f-352163636769	true	id.token.claim
82d65d5d-1b5d-4f68-a14f-352163636769	true	access.token.claim
82d65d5d-1b5d-4f68-a14f-352163636769	nickname	claim.name
82d65d5d-1b5d-4f68-a14f-352163636769	String	jsonType.label
98d30fd4-36e8-413a-9a63-a421b79346a4	true	introspection.token.claim
98d30fd4-36e8-413a-9a63-a421b79346a4	true	userinfo.token.claim
98d30fd4-36e8-413a-9a63-a421b79346a4	gender	user.attribute
98d30fd4-36e8-413a-9a63-a421b79346a4	true	id.token.claim
98d30fd4-36e8-413a-9a63-a421b79346a4	true	access.token.claim
98d30fd4-36e8-413a-9a63-a421b79346a4	gender	claim.name
98d30fd4-36e8-413a-9a63-a421b79346a4	String	jsonType.label
a459647e-df75-430a-9767-bb55281ef030	true	introspection.token.claim
a459647e-df75-430a-9767-bb55281ef030	true	userinfo.token.claim
a459647e-df75-430a-9767-bb55281ef030	picture	user.attribute
a459647e-df75-430a-9767-bb55281ef030	true	id.token.claim
a459647e-df75-430a-9767-bb55281ef030	true	access.token.claim
a459647e-df75-430a-9767-bb55281ef030	picture	claim.name
a459647e-df75-430a-9767-bb55281ef030	String	jsonType.label
b06cdb94-15dd-4b77-9a89-49af2c5e34ee	true	introspection.token.claim
b06cdb94-15dd-4b77-9a89-49af2c5e34ee	true	userinfo.token.claim
b06cdb94-15dd-4b77-9a89-49af2c5e34ee	username	user.attribute
b06cdb94-15dd-4b77-9a89-49af2c5e34ee	true	id.token.claim
b06cdb94-15dd-4b77-9a89-49af2c5e34ee	true	access.token.claim
b06cdb94-15dd-4b77-9a89-49af2c5e34ee	preferred_username	claim.name
b06cdb94-15dd-4b77-9a89-49af2c5e34ee	String	jsonType.label
bfcae4e1-804d-4857-a3c1-f98556f58058	true	introspection.token.claim
bfcae4e1-804d-4857-a3c1-f98556f58058	true	userinfo.token.claim
bfcae4e1-804d-4857-a3c1-f98556f58058	zoneinfo	user.attribute
bfcae4e1-804d-4857-a3c1-f98556f58058	true	id.token.claim
bfcae4e1-804d-4857-a3c1-f98556f58058	true	access.token.claim
bfcae4e1-804d-4857-a3c1-f98556f58058	zoneinfo	claim.name
bfcae4e1-804d-4857-a3c1-f98556f58058	String	jsonType.label
eb56660d-457c-4fe0-8802-0d7b1dc56878	true	introspection.token.claim
eb56660d-457c-4fe0-8802-0d7b1dc56878	true	userinfo.token.claim
eb56660d-457c-4fe0-8802-0d7b1dc56878	updatedAt	user.attribute
eb56660d-457c-4fe0-8802-0d7b1dc56878	true	id.token.claim
eb56660d-457c-4fe0-8802-0d7b1dc56878	true	access.token.claim
eb56660d-457c-4fe0-8802-0d7b1dc56878	updated_at	claim.name
eb56660d-457c-4fe0-8802-0d7b1dc56878	long	jsonType.label
fa0e80a2-20f0-42db-8530-fb36edf3dcd1	true	introspection.token.claim
fa0e80a2-20f0-42db-8530-fb36edf3dcd1	true	userinfo.token.claim
fa0e80a2-20f0-42db-8530-fb36edf3dcd1	locale	user.attribute
fa0e80a2-20f0-42db-8530-fb36edf3dcd1	true	id.token.claim
fa0e80a2-20f0-42db-8530-fb36edf3dcd1	true	access.token.claim
fa0e80a2-20f0-42db-8530-fb36edf3dcd1	locale	claim.name
fa0e80a2-20f0-42db-8530-fb36edf3dcd1	String	jsonType.label
fc4d1e0e-a800-4024-b7ce-d61530fbb1da	true	introspection.token.claim
fc4d1e0e-a800-4024-b7ce-d61530fbb1da	true	userinfo.token.claim
fc4d1e0e-a800-4024-b7ce-d61530fbb1da	website	user.attribute
fc4d1e0e-a800-4024-b7ce-d61530fbb1da	true	id.token.claim
fc4d1e0e-a800-4024-b7ce-d61530fbb1da	true	access.token.claim
fc4d1e0e-a800-4024-b7ce-d61530fbb1da	website	claim.name
fc4d1e0e-a800-4024-b7ce-d61530fbb1da	String	jsonType.label
4e85df45-57a3-45bb-91b4-bb832e54fb72	true	introspection.token.claim
4e85df45-57a3-45bb-91b4-bb832e54fb72	true	userinfo.token.claim
4e85df45-57a3-45bb-91b4-bb832e54fb72	email	user.attribute
4e85df45-57a3-45bb-91b4-bb832e54fb72	true	id.token.claim
4e85df45-57a3-45bb-91b4-bb832e54fb72	true	access.token.claim
4e85df45-57a3-45bb-91b4-bb832e54fb72	email	claim.name
4e85df45-57a3-45bb-91b4-bb832e54fb72	String	jsonType.label
76cf79ac-362d-4c8d-97c0-5d3fb75a5e79	true	introspection.token.claim
76cf79ac-362d-4c8d-97c0-5d3fb75a5e79	true	userinfo.token.claim
76cf79ac-362d-4c8d-97c0-5d3fb75a5e79	emailVerified	user.attribute
76cf79ac-362d-4c8d-97c0-5d3fb75a5e79	true	id.token.claim
76cf79ac-362d-4c8d-97c0-5d3fb75a5e79	true	access.token.claim
76cf79ac-362d-4c8d-97c0-5d3fb75a5e79	email_verified	claim.name
76cf79ac-362d-4c8d-97c0-5d3fb75a5e79	boolean	jsonType.label
4daaaace-d3c6-4500-8b46-f0033148007c	formatted	user.attribute.formatted
4daaaace-d3c6-4500-8b46-f0033148007c	country	user.attribute.country
4daaaace-d3c6-4500-8b46-f0033148007c	true	introspection.token.claim
4daaaace-d3c6-4500-8b46-f0033148007c	postal_code	user.attribute.postal_code
4daaaace-d3c6-4500-8b46-f0033148007c	true	userinfo.token.claim
4daaaace-d3c6-4500-8b46-f0033148007c	street	user.attribute.street
4daaaace-d3c6-4500-8b46-f0033148007c	true	id.token.claim
4daaaace-d3c6-4500-8b46-f0033148007c	region	user.attribute.region
4daaaace-d3c6-4500-8b46-f0033148007c	true	access.token.claim
4daaaace-d3c6-4500-8b46-f0033148007c	locality	user.attribute.locality
677dabee-6ae8-4bed-95f3-e4fed6fcc1f7	true	introspection.token.claim
677dabee-6ae8-4bed-95f3-e4fed6fcc1f7	true	userinfo.token.claim
677dabee-6ae8-4bed-95f3-e4fed6fcc1f7	phoneNumber	user.attribute
677dabee-6ae8-4bed-95f3-e4fed6fcc1f7	true	id.token.claim
677dabee-6ae8-4bed-95f3-e4fed6fcc1f7	true	access.token.claim
677dabee-6ae8-4bed-95f3-e4fed6fcc1f7	phone_number	claim.name
677dabee-6ae8-4bed-95f3-e4fed6fcc1f7	String	jsonType.label
df3f08b2-6c0f-46ab-8b7d-c0be5a5aa0a9	true	introspection.token.claim
df3f08b2-6c0f-46ab-8b7d-c0be5a5aa0a9	true	userinfo.token.claim
df3f08b2-6c0f-46ab-8b7d-c0be5a5aa0a9	phoneNumberVerified	user.attribute
df3f08b2-6c0f-46ab-8b7d-c0be5a5aa0a9	true	id.token.claim
df3f08b2-6c0f-46ab-8b7d-c0be5a5aa0a9	true	access.token.claim
df3f08b2-6c0f-46ab-8b7d-c0be5a5aa0a9	phone_number_verified	claim.name
df3f08b2-6c0f-46ab-8b7d-c0be5a5aa0a9	boolean	jsonType.label
8961d827-28fd-4b8a-a146-cd8eeaeb81c5	true	introspection.token.claim
8961d827-28fd-4b8a-a146-cd8eeaeb81c5	true	access.token.claim
abc3022a-fa43-4b64-bb65-ab36ea0cec1b	true	introspection.token.claim
abc3022a-fa43-4b64-bb65-ab36ea0cec1b	true	multivalued
abc3022a-fa43-4b64-bb65-ab36ea0cec1b	foo	user.attribute
abc3022a-fa43-4b64-bb65-ab36ea0cec1b	true	access.token.claim
abc3022a-fa43-4b64-bb65-ab36ea0cec1b	resource_access.${client_id}.roles	claim.name
abc3022a-fa43-4b64-bb65-ab36ea0cec1b	String	jsonType.label
c65276fd-8ac6-494a-9718-40116c90b88b	true	introspection.token.claim
c65276fd-8ac6-494a-9718-40116c90b88b	true	multivalued
c65276fd-8ac6-494a-9718-40116c90b88b	foo	user.attribute
c65276fd-8ac6-494a-9718-40116c90b88b	true	access.token.claim
c65276fd-8ac6-494a-9718-40116c90b88b	realm_access.roles	claim.name
c65276fd-8ac6-494a-9718-40116c90b88b	String	jsonType.label
bfe6e8a3-b6e5-4c32-b799-d269fac8449f	true	introspection.token.claim
bfe6e8a3-b6e5-4c32-b799-d269fac8449f	true	access.token.claim
48f62ba4-af74-40fe-8d00-e56a586e4e03	true	introspection.token.claim
48f62ba4-af74-40fe-8d00-e56a586e4e03	true	userinfo.token.claim
48f62ba4-af74-40fe-8d00-e56a586e4e03	username	user.attribute
48f62ba4-af74-40fe-8d00-e56a586e4e03	true	id.token.claim
48f62ba4-af74-40fe-8d00-e56a586e4e03	true	access.token.claim
48f62ba4-af74-40fe-8d00-e56a586e4e03	upn	claim.name
48f62ba4-af74-40fe-8d00-e56a586e4e03	String	jsonType.label
7f5f0d14-1d3f-4a30-99b2-f35b8f0b69f2	true	introspection.token.claim
7f5f0d14-1d3f-4a30-99b2-f35b8f0b69f2	true	multivalued
7f5f0d14-1d3f-4a30-99b2-f35b8f0b69f2	foo	user.attribute
7f5f0d14-1d3f-4a30-99b2-f35b8f0b69f2	true	id.token.claim
7f5f0d14-1d3f-4a30-99b2-f35b8f0b69f2	true	access.token.claim
7f5f0d14-1d3f-4a30-99b2-f35b8f0b69f2	groups	claim.name
7f5f0d14-1d3f-4a30-99b2-f35b8f0b69f2	String	jsonType.label
3724e97a-ea22-4232-94f2-7fa1fafe1f3d	true	introspection.token.claim
3724e97a-ea22-4232-94f2-7fa1fafe1f3d	true	id.token.claim
3724e97a-ea22-4232-94f2-7fa1fafe1f3d	true	access.token.claim
7e7b9be9-ffd4-49a7-8571-37ed0d9ad955	AUTH_TIME	user.session.note
7e7b9be9-ffd4-49a7-8571-37ed0d9ad955	true	introspection.token.claim
7e7b9be9-ffd4-49a7-8571-37ed0d9ad955	true	id.token.claim
7e7b9be9-ffd4-49a7-8571-37ed0d9ad955	true	access.token.claim
7e7b9be9-ffd4-49a7-8571-37ed0d9ad955	auth_time	claim.name
7e7b9be9-ffd4-49a7-8571-37ed0d9ad955	long	jsonType.label
e123dd1b-e032-4b47-8435-e8c5bb00ed7c	true	introspection.token.claim
e123dd1b-e032-4b47-8435-e8c5bb00ed7c	true	access.token.claim
18815699-2996-4b09-a789-15883d9e2105	clientHost	user.session.note
18815699-2996-4b09-a789-15883d9e2105	true	introspection.token.claim
18815699-2996-4b09-a789-15883d9e2105	true	id.token.claim
18815699-2996-4b09-a789-15883d9e2105	true	access.token.claim
18815699-2996-4b09-a789-15883d9e2105	clientHost	claim.name
18815699-2996-4b09-a789-15883d9e2105	String	jsonType.label
5fc17d07-6bbc-408a-a48a-f58123c809b8	client_id	user.session.note
5fc17d07-6bbc-408a-a48a-f58123c809b8	true	introspection.token.claim
5fc17d07-6bbc-408a-a48a-f58123c809b8	true	id.token.claim
5fc17d07-6bbc-408a-a48a-f58123c809b8	true	access.token.claim
5fc17d07-6bbc-408a-a48a-f58123c809b8	client_id	claim.name
5fc17d07-6bbc-408a-a48a-f58123c809b8	String	jsonType.label
f50594c4-04fa-4594-81d8-19a67b1cb558	clientAddress	user.session.note
f50594c4-04fa-4594-81d8-19a67b1cb558	true	introspection.token.claim
f50594c4-04fa-4594-81d8-19a67b1cb558	true	id.token.claim
f50594c4-04fa-4594-81d8-19a67b1cb558	true	access.token.claim
f50594c4-04fa-4594-81d8-19a67b1cb558	clientAddress	claim.name
f50594c4-04fa-4594-81d8-19a67b1cb558	String	jsonType.label
9e043dff-1627-427e-ac2f-3d238b251ddc	true	introspection.token.claim
9e043dff-1627-427e-ac2f-3d238b251ddc	true	multivalued
9e043dff-1627-427e-ac2f-3d238b251ddc	true	id.token.claim
9e043dff-1627-427e-ac2f-3d238b251ddc	true	access.token.claim
9e043dff-1627-427e-ac2f-3d238b251ddc	organization	claim.name
9e043dff-1627-427e-ac2f-3d238b251ddc	String	jsonType.label
b11c0269-80b9-42dc-9380-ead650ae67ca	true	introspection.token.claim
b11c0269-80b9-42dc-9380-ead650ae67ca	true	userinfo.token.claim
b11c0269-80b9-42dc-9380-ead650ae67ca	locale	user.attribute
b11c0269-80b9-42dc-9380-ead650ae67ca	true	id.token.claim
b11c0269-80b9-42dc-9380-ead650ae67ca	true	access.token.claim
b11c0269-80b9-42dc-9380-ead650ae67ca	locale	claim.name
b11c0269-80b9-42dc-9380-ead650ae67ca	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
8d35e8a2-755c-44b9-84e1-cd723f651bbc	60	300	300	\N	\N	\N	t	f	0	\N	companyinfo	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	a551b881-6778-494f-86bb-c3c5ffb52a46	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	1ca7dd80-1e3b-4e96-80b0-355a8557693f	05ad9daa-38c2-4b51-8afb-8e679173329b	68f86973-4dff-4573-b6a2-688a7115369b	10e25710-6342-4830-ab2c-cc2189c688b4	43c1624d-d333-4908-be14-e8d504e7e492	2592000	f	900	t	f	4f03d95c-1922-4a94-b23e-4aab0b7ca8e8	0	f	0	0	60c98841-e4e9-413f-9e65-a1bfd4c35c14
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	2f62880d-ea1e-4d16-a4d0-b6c95e759e24	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f4e10254-e06b-49a2-afb1-578c8955ef81	c3a7f5aa-7a02-490b-b02c-2ad8df936350	0445f87f-73e8-428a-b92b-036ee35b7859	e0ba9c72-75e8-45e7-b949-2cf004810e6b	fd1b36d1-1760-4981-9db3-c76774617ac9	2592000	f	900	t	f	b4a11079-de7d-411a-84d4-d3de38d3086f	0	f	0	0	cbceade4-5f5e-4eae-99fc-0e421955894d
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	
_browser_header.xContentTypeOptions	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	nosniff
_browser_header.referrerPolicy	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	no-referrer
_browser_header.xRobotsTag	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	none
_browser_header.xFrameOptions	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	SAMEORIGIN
_browser_header.contentSecurityPolicy	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	max-age=31536000; includeSubDomains
bruteForceProtected	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	false
permanentLockout	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	false
maxTemporaryLockouts	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	0
bruteForceStrategy	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	MULTIPLE
maxFailureWaitSeconds	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	900
minimumQuickLoginWaitSeconds	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	60
waitIncrementSeconds	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	60
quickLoginCheckMilliSeconds	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	1000
maxDeltaTimeSeconds	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	43200
failureFactor	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	30
realmReusableOtpCode	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	false
firstBrokerLoginFlowId	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	5634af62-d1bd-411b-89c2-e7f96dd40ac3
displayName	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	Keycloak
displayNameHtml	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	RS256
offlineSessionMaxLifespanEnabled	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	false
offlineSessionMaxLifespan	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	5184000
_browser_header.contentSecurityPolicyReportOnly	8d35e8a2-755c-44b9-84e1-cd723f651bbc	
_browser_header.xContentTypeOptions	8d35e8a2-755c-44b9-84e1-cd723f651bbc	nosniff
_browser_header.referrerPolicy	8d35e8a2-755c-44b9-84e1-cd723f651bbc	no-referrer
_browser_header.xRobotsTag	8d35e8a2-755c-44b9-84e1-cd723f651bbc	none
_browser_header.xFrameOptions	8d35e8a2-755c-44b9-84e1-cd723f651bbc	SAMEORIGIN
_browser_header.contentSecurityPolicy	8d35e8a2-755c-44b9-84e1-cd723f651bbc	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	8d35e8a2-755c-44b9-84e1-cd723f651bbc	max-age=31536000; includeSubDomains
bruteForceProtected	8d35e8a2-755c-44b9-84e1-cd723f651bbc	false
permanentLockout	8d35e8a2-755c-44b9-84e1-cd723f651bbc	false
maxTemporaryLockouts	8d35e8a2-755c-44b9-84e1-cd723f651bbc	0
bruteForceStrategy	8d35e8a2-755c-44b9-84e1-cd723f651bbc	MULTIPLE
maxFailureWaitSeconds	8d35e8a2-755c-44b9-84e1-cd723f651bbc	900
minimumQuickLoginWaitSeconds	8d35e8a2-755c-44b9-84e1-cd723f651bbc	60
waitIncrementSeconds	8d35e8a2-755c-44b9-84e1-cd723f651bbc	60
quickLoginCheckMilliSeconds	8d35e8a2-755c-44b9-84e1-cd723f651bbc	1000
maxDeltaTimeSeconds	8d35e8a2-755c-44b9-84e1-cd723f651bbc	43200
failureFactor	8d35e8a2-755c-44b9-84e1-cd723f651bbc	30
realmReusableOtpCode	8d35e8a2-755c-44b9-84e1-cd723f651bbc	false
defaultSignatureAlgorithm	8d35e8a2-755c-44b9-84e1-cd723f651bbc	RS256
offlineSessionMaxLifespanEnabled	8d35e8a2-755c-44b9-84e1-cd723f651bbc	false
offlineSessionMaxLifespan	8d35e8a2-755c-44b9-84e1-cd723f651bbc	5184000
actionTokenGeneratedByAdminLifespan	8d35e8a2-755c-44b9-84e1-cd723f651bbc	43200
actionTokenGeneratedByUserLifespan	8d35e8a2-755c-44b9-84e1-cd723f651bbc	300
oauth2DeviceCodeLifespan	8d35e8a2-755c-44b9-84e1-cd723f651bbc	600
oauth2DevicePollingInterval	8d35e8a2-755c-44b9-84e1-cd723f651bbc	5
webAuthnPolicyRpEntityName	8d35e8a2-755c-44b9-84e1-cd723f651bbc	keycloak
webAuthnPolicySignatureAlgorithms	8d35e8a2-755c-44b9-84e1-cd723f651bbc	ES256,RS256
webAuthnPolicyRpId	8d35e8a2-755c-44b9-84e1-cd723f651bbc	
webAuthnPolicyAttestationConveyancePreference	8d35e8a2-755c-44b9-84e1-cd723f651bbc	not specified
webAuthnPolicyAuthenticatorAttachment	8d35e8a2-755c-44b9-84e1-cd723f651bbc	not specified
webAuthnPolicyRequireResidentKey	8d35e8a2-755c-44b9-84e1-cd723f651bbc	not specified
webAuthnPolicyUserVerificationRequirement	8d35e8a2-755c-44b9-84e1-cd723f651bbc	not specified
webAuthnPolicyCreateTimeout	8d35e8a2-755c-44b9-84e1-cd723f651bbc	0
webAuthnPolicyAvoidSameAuthenticatorRegister	8d35e8a2-755c-44b9-84e1-cd723f651bbc	false
webAuthnPolicyRpEntityNamePasswordless	8d35e8a2-755c-44b9-84e1-cd723f651bbc	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	8d35e8a2-755c-44b9-84e1-cd723f651bbc	ES256,RS256
webAuthnPolicyRpIdPasswordless	8d35e8a2-755c-44b9-84e1-cd723f651bbc	
webAuthnPolicyAttestationConveyancePreferencePasswordless	8d35e8a2-755c-44b9-84e1-cd723f651bbc	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	8d35e8a2-755c-44b9-84e1-cd723f651bbc	not specified
webAuthnPolicyRequireResidentKeyPasswordless	8d35e8a2-755c-44b9-84e1-cd723f651bbc	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	8d35e8a2-755c-44b9-84e1-cd723f651bbc	not specified
webAuthnPolicyCreateTimeoutPasswordless	8d35e8a2-755c-44b9-84e1-cd723f651bbc	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	8d35e8a2-755c-44b9-84e1-cd723f651bbc	false
cibaBackchannelTokenDeliveryMode	8d35e8a2-755c-44b9-84e1-cd723f651bbc	poll
cibaExpiresIn	8d35e8a2-755c-44b9-84e1-cd723f651bbc	120
cibaInterval	8d35e8a2-755c-44b9-84e1-cd723f651bbc	5
cibaAuthRequestedUserHint	8d35e8a2-755c-44b9-84e1-cd723f651bbc	login_hint
parRequestUriLifespan	8d35e8a2-755c-44b9-84e1-cd723f651bbc	60
firstBrokerLoginFlowId	8d35e8a2-755c-44b9-84e1-cd723f651bbc	0a5685ff-3190-4507-82a6-6219f9d3f227
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	jboss-logging
8d35e8a2-755c-44b9-84e1-cd723f651bbc	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d
password	password	t	t	8d35e8a2-755c-44b9-84e1-cd723f651bbc
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.redirect_uris (client_id, value) FROM stdin;
3b574bb8-433e-48a7-8c9e-90414d96dcaa	/realms/master/account/*
2caa34fc-3296-4d55-a66c-5443a2901355	/realms/master/account/*
c504fbfb-db56-470f-923a-796d489a7796	/admin/master/console/*
bad31dd0-85e6-4111-834d-3d78a8eb119d	/realms/companyinfo/account/*
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	/realms/companyinfo/account/*
d59e569d-28d9-4895-8e91-d4fe13d285e6	/admin/companyinfo/console/*
c185c938-d7ab-4c5e-947a-a0668898148a	/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
442f2357-992d-4a13-9685-1a2494636a4e	VERIFY_EMAIL	Verify Email	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	t	f	VERIFY_EMAIL	50
56e6c774-ca17-4291-85fa-0005bde83fa2	UPDATE_PROFILE	Update Profile	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	t	f	UPDATE_PROFILE	40
7edab9e9-b4ff-4384-ae29-9980bda04167	CONFIGURE_TOTP	Configure OTP	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	t	f	CONFIGURE_TOTP	10
dd71e34e-8241-4462-b3dc-8a7dcc218b5e	UPDATE_PASSWORD	Update Password	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	t	f	UPDATE_PASSWORD	30
dfbf6401-fc4d-41a5-a365-553800c3034f	TERMS_AND_CONDITIONS	Terms and Conditions	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	f	f	TERMS_AND_CONDITIONS	20
c8975868-f5bb-4c0d-9b92-27df3e0517ca	delete_account	Delete Account	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	f	f	delete_account	60
09a6de32-086d-42d8-ade3-881a4bf668c3	delete_credential	Delete Credential	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	t	f	delete_credential	100
464dbcc7-4f69-45ab-a195-daf5ca9a2565	update_user_locale	Update User Locale	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	t	f	update_user_locale	1000
769672d1-a7ce-49d0-8615-b444a1a4c94b	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	120
6f482d19-6453-4a73-91fe-4e1a64f525d9	webauthn-register	Webauthn Register	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	t	f	webauthn-register	70
da23a725-b52e-4ef8-a4ca-42632890a776	webauthn-register-passwordless	Webauthn Register Passwordless	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	t	f	webauthn-register-passwordless	80
42dd0ead-6f47-41fd-9d51-0545de37fdd1	VERIFY_PROFILE	Verify Profile	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	t	f	VERIFY_PROFILE	90
901c2f66-cbe8-47fb-be0a-97f849f22f09	idp_link	Linking Identity Provider	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	t	f	idp_link	110
6d316984-c813-41b2-869c-9f903aa1e199	VERIFY_EMAIL	Verify Email	8d35e8a2-755c-44b9-84e1-cd723f651bbc	t	f	VERIFY_EMAIL	50
6ab184ed-0f80-4ad0-a9af-088ed94afbcd	UPDATE_PROFILE	Update Profile	8d35e8a2-755c-44b9-84e1-cd723f651bbc	t	f	UPDATE_PROFILE	40
a666cf7e-743f-4790-a800-ccc8d9246124	CONFIGURE_TOTP	Configure OTP	8d35e8a2-755c-44b9-84e1-cd723f651bbc	t	f	CONFIGURE_TOTP	10
1d695ae3-cc99-425b-8c40-5f737e00af6e	UPDATE_PASSWORD	Update Password	8d35e8a2-755c-44b9-84e1-cd723f651bbc	t	f	UPDATE_PASSWORD	30
18477b96-5fc6-409f-9c12-b1997920e25e	TERMS_AND_CONDITIONS	Terms and Conditions	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f	f	TERMS_AND_CONDITIONS	20
9e85ebd3-eb03-4437-8d98-dc3880312b0e	delete_account	Delete Account	8d35e8a2-755c-44b9-84e1-cd723f651bbc	f	f	delete_account	60
4e0e0bab-aea5-4577-8288-0df27748fb97	delete_credential	Delete Credential	8d35e8a2-755c-44b9-84e1-cd723f651bbc	t	f	delete_credential	100
0fbba3e4-5e6a-4598-bb2d-057eda38adce	update_user_locale	Update User Locale	8d35e8a2-755c-44b9-84e1-cd723f651bbc	t	f	update_user_locale	1000
6fdb8bba-09a2-422c-a852-58b7b60317a4	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	8d35e8a2-755c-44b9-84e1-cd723f651bbc	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	120
3422e68e-f760-4a61-a1e7-dec781d3a34d	webauthn-register	Webauthn Register	8d35e8a2-755c-44b9-84e1-cd723f651bbc	t	f	webauthn-register	70
27b3deea-72a2-46f8-9c8b-2c8a03ad165b	webauthn-register-passwordless	Webauthn Register Passwordless	8d35e8a2-755c-44b9-84e1-cd723f651bbc	t	f	webauthn-register-passwordless	80
8515897c-06ed-4e52-a2eb-b05f079c2de5	VERIFY_PROFILE	Verify Profile	8d35e8a2-755c-44b9-84e1-cd723f651bbc	t	f	VERIFY_PROFILE	90
27d260f0-556b-4e55-a410-a395d3e1f64a	idp_link	Linking Identity Provider	8d35e8a2-755c-44b9-84e1-cd723f651bbc	t	f	idp_link	110
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
c185c938-d7ab-4c5e-947a-a0668898148a	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
9b84021b-be9b-495f-996b-d5b46e71d552	Default Policy	A policy that grants access only for users within this realm	js	0	0	c185c938-d7ab-4c5e-947a-a0668898148a	\N
13f3ce9e-501e-4b41-bc12-f7fd7579604f	Default Permission	A permission that applies to the default resource type	resource	1	0	c185c938-d7ab-4c5e-947a-a0668898148a	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
f4581898-362f-4c92-a99a-a107ac15bf08	Default Resource	urn:ciadmin:resources:default	\N	c185c938-d7ab-4c5e-947a-a0668898148a	c185c938-d7ab-4c5e-947a-a0668898148a	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_uris (resource_id, value) FROM stdin;
f4581898-362f-4c92-a99a-a107ac15bf08	/*
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
2caa34fc-3296-4d55-a66c-5443a2901355	4705fb17-95ea-4d79-82be-fe21cb213295
2caa34fc-3296-4d55-a66c-5443a2901355	b2ee74ce-e9b7-4bdd-bd9a-97078f2d47ee
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	9bdeb1b8-94e1-439b-8d74-04e60b751012
2b6b10b4-14f7-4b68-9c61-d3ad7b81251e	5f2dc81c-cb40-4ae8-b4d3-8d1cb591597b
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.server_config (server_config_key, value, version) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	ffbee2e6-9033-4d4a-9c11-4b7344c09b7e	a14e9875-cce8-4851-b76e-1083a6918cb2	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
ffbee2e6-9033-4d4a-9c11-4b7344c09b7e	\N	785ba5f5-c634-4d79-9839-7266158d5139	f	t	\N	\N	\N	ff0d2f9a-aeee-45a5-b9c8-49f18ec3ed9d	admin	1755788439416	\N	0
553779d2-4d86-4d08-a7aa-daecf23a16f2	\N	a0d34447-aa8c-4df4-a522-93e3d6269846	f	t	\N	\N	\N	8d35e8a2-755c-44b9-84e1-cd723f651bbc	service-account-ciadmin	1755788582124	c185c938-d7ab-4c5e-947a-a0668898148a	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
cbceade4-5f5e-4eae-99fc-0e421955894d	ffbee2e6-9033-4d4a-9c11-4b7344c09b7e
aeaa00f6-b1ca-4bff-bcdc-192942ff21c7	ffbee2e6-9033-4d4a-9c11-4b7344c09b7e
60c98841-e4e9-413f-9e65-a1bfd4c35c14	553779d2-4d86-4d08-a7aa-daecf23a16f2
72ad85aa-a143-487c-b018-46a8cc7b2f12	553779d2-4d86-4d08-a7aa-daecf23a16f2
e1438656-1f77-42e4-b65c-fb584a20cbc8	553779d2-4d86-4d08-a7aa-daecf23a16f2
1987b4f1-a851-483c-a685-b11852f7cc66	553779d2-4d86-4d08-a7aa-daecf23a16f2
1b8c7f5a-02a2-4847-a15b-55fa9417d763	553779d2-4d86-4d08-a7aa-daecf23a16f2
fdad5850-d94b-4007-b934-d1bb562b1f9b	553779d2-4d86-4d08-a7aa-daecf23a16f2
87c58099-272b-4d04-b371-c716ff95caab	553779d2-4d86-4d08-a7aa-daecf23a16f2
55219ef5-3abb-433e-8a9c-5de66a2bb4f4	553779d2-4d86-4d08-a7aa-daecf23a16f2
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.web_origins (client_id, value) FROM stdin;
c504fbfb-db56-470f-923a-796d489a7796	+
d59e569d-28d9-4895-8e91-d4fe13d285e6	+
c185c938-d7ab-4c5e-947a-a0668898148a	/*
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: migration_model uk_migration_update_time; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_update_time UNIQUE (update_time);


--
-- Name: migration_model uk_migration_version; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_version UNIQUE (version);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

