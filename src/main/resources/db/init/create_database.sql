SET client_encoding = 'UTF8';

-- Create bug_hunter_roles, bug_hunter, bug_shooter

DROP ROLE IF EXISTS bug_hunter_roles;

CREATE ROLE bug_hunter_roles
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;

DROP ROLE IF EXISTS bug_hunter;

CREATE ROLE bug_hunter
  LOGIN
  ENCRYPTED PASSWORD 'md576e0457d46c7a973d582ee0feff5388f'
  SUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;

DROP ROLE IF EXISTS bug_shooter;

CREATE ROLE bug_shooter
  LOGIN
  ENCRYPTED PASSWORD 'md595fa4632b9c40bf43859752c5e90a7ea'
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;

-- Create database social_network

DROP DATABASE IF EXISTS "social_network";

CREATE DATABASE "social_network"
WITH OWNER = bug_hunter
ENCODING = 'UTF8'
TEMPLATE template0
TABLESPACE = pg_default
CONNECTION LIMIT = -1;

-- Grant role privileges

GRANT bug_hunter_roles TO bug_shooter;
GRANT ALL ON DATABASE "social_network" TO bug_hunter;
GRANT ALL ON DATABASE "social_network" TO bug_shooter;
REVOKE ALL ON DATABASE "social_network" FROM public;