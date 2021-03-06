CREATE ROLE upr_user WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	NOINHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'xxxxxx';

GRANT CONNECT ON DATABASE "H2020.IPMDecisions.UPR" TO upr_user;

GRANT USAGE ON SCHEMA public TO upr_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLES TO upr_user;