--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3 (Debian 12.3-1.pgdg100+1)
-- Dumped by pg_dump version 12.3 (Debian 12.3-1.pgdg100+1)

-- Started on 2020-07-28 10:20:16 UTC

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

--
-- TOC entry 13 (class 2615 OID 19141)
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA IF NOT EXISTS tiger;


--
-- TOC entry 14 (class 2615 OID 19411)
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA IF NOT EXISTS tiger_data;


--
-- TOC entry 10 (class 2615 OID 18986)
-- Name: topology; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA IF NOT EXISTS topology;


--
-- TOC entry 4449 (class 0 OID 0)
-- Dependencies: 10
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- TOC entry 4 (class 3079 OID 19130)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 4450 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- TOC entry 5 (class 3079 OID 17978)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4451 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- TOC entry 3 (class 3079 OID 19142)
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- TOC entry 4452 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- TOC entry 2 (class 3079 OID 18987)
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- TOC entry 4453 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_table_access_method = heap;

--
-- TOC entry 277 (class 1259 OID 19683)
-- Name: Crop; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Crop" (
    "Id" uuid NOT NULL,
    "Name" text NOT NULL
);


--
-- TOC entry 280 (class 1259 OID 19707)
-- Name: CropDecisionCombination; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CropDecisionCombination" (
    "CropId" uuid NOT NULL,
    "DssId" uuid NOT NULL,
    "PestId" uuid NOT NULL,
    "Inf1" text,
    "Id" uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL
);


--
-- TOC entry 278 (class 1259 OID 19691)
-- Name: Dss; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Dss" (
    "Id" uuid NOT NULL,
    "Name" text NOT NULL
);


--
-- TOC entry 273 (class 1259 OID 19630)
-- Name: Farm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Farm" (
    "Id" uuid NOT NULL,
    "Name" text NOT NULL,
    "Inf1" text,
    "Inf2" text,
    "Location" public.geometry(Point) NOT NULL
);


--
-- TOC entry 275 (class 1259 OID 19655)
-- Name: Field; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Field" (
    "Id" uuid NOT NULL,
    "Name" text NOT NULL,
    "Inf1" text,
    "Inf2" text,
    "FarmId" uuid NOT NULL
);


--
-- TOC entry 281 (class 1259 OID 19737)
-- Name: FieldCropDecisionCombination; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."FieldCropDecisionCombination" (
    "FielId" uuid NOT NULL,
    "CropDecisionCombinationId" uuid NOT NULL
);


--
-- TOC entry 276 (class 1259 OID 19669)
-- Name: FieldObservation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."FieldObservation" (
    "Id" uuid NOT NULL,
    "FieldId" uuid NOT NULL,
    "CropEppoCode" character varying(6) DEFAULT ''::character varying NOT NULL,
    "Location" public.geometry(Point) NOT NULL,
    "PestEppoCode" character varying(6) DEFAULT ''::character varying NOT NULL,
    "Time" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 279 (class 1259 OID 19699)
-- Name: Pest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Pest" (
    "Id" uuid NOT NULL,
    "Name" text NOT NULL
);


--
-- TOC entry 272 (class 1259 OID 19609)
-- Name: UserAddress; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserAddress" (
    "Id" uuid NOT NULL,
    "Street" text,
    "City" text,
    "Postcode" text,
    "Country" text
);


--
-- TOC entry 274 (class 1259 OID 19638)
-- Name: UserFarm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserFarm" (
    "UserId" uuid NOT NULL,
    "FarmId" uuid NOT NULL
);


--
-- TOC entry 270 (class 1259 OID 19572)
-- Name: UserProfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserProfile" (
    "Id" uuid NOT NULL,
    "FirstName" character varying(80) NOT NULL,
    "LastName" text,
    "PhoneNumber" text,
    "MobileNumber" text,
    "UserId" uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    "UserAddressId" uuid
);


--
-- TOC entry 271 (class 1259 OID 19579)
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


--
-- TOC entry 4255 (class 2606 OID 19629)
-- Name: UserProfile AK_UserProfile_UserId; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserProfile"
    ADD CONSTRAINT "AK_UserProfile_UserId" UNIQUE ("UserId");


--
-- TOC entry 4277 (class 2606 OID 19690)
-- Name: Crop PK_Crop; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Crop"
    ADD CONSTRAINT "PK_Crop" PRIMARY KEY ("Id");


--
-- TOC entry 4287 (class 2606 OID 19735)
-- Name: CropDecisionCombination PK_CropDecisionCombination; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CropDecisionCombination"
    ADD CONSTRAINT "PK_CropDecisionCombination" PRIMARY KEY ("Id");


--
-- TOC entry 4279 (class 2606 OID 19698)
-- Name: Dss PK_Dss; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Dss"
    ADD CONSTRAINT "PK_Dss" PRIMARY KEY ("Id");


--
-- TOC entry 4266 (class 2606 OID 19637)
-- Name: Farm PK_Farm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Farm"
    ADD CONSTRAINT "PK_Farm" PRIMARY KEY ("Id");


--
-- TOC entry 4272 (class 2606 OID 19662)
-- Name: Field PK_Field; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Field"
    ADD CONSTRAINT "PK_Field" PRIMARY KEY ("Id");


--
-- TOC entry 4290 (class 2606 OID 19741)
-- Name: FieldCropDecisionCombination PK_FieldCropDecisionCombination; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."FieldCropDecisionCombination"
    ADD CONSTRAINT "PK_FieldCropDecisionCombination" PRIMARY KEY ("FielId", "CropDecisionCombinationId");


--
-- TOC entry 4275 (class 2606 OID 19676)
-- Name: FieldObservation PK_FieldObservation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."FieldObservation"
    ADD CONSTRAINT "PK_FieldObservation" PRIMARY KEY ("Id");


--
-- TOC entry 4281 (class 2606 OID 19706)
-- Name: Pest PK_Pest; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Pest"
    ADD CONSTRAINT "PK_Pest" PRIMARY KEY ("Id");


--
-- TOC entry 4263 (class 2606 OID 19616)
-- Name: UserAddress PK_UserAddress; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserAddress"
    ADD CONSTRAINT "PK_UserAddress" PRIMARY KEY ("Id");


--
-- TOC entry 4269 (class 2606 OID 19642)
-- Name: UserFarm PK_UserFarm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFarm"
    ADD CONSTRAINT "PK_UserFarm" PRIMARY KEY ("UserId", "FarmId");


--
-- TOC entry 4259 (class 2606 OID 19583)
-- Name: UserProfile PK_UserProfile; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserProfile"
    ADD CONSTRAINT "PK_UserProfile" PRIMARY KEY ("Id");


--
-- TOC entry 4261 (class 2606 OID 19585)
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- TOC entry 4282 (class 1259 OID 19730)
-- Name: IX_CropDecisionCombination_CropId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_CropDecisionCombination_CropId" ON public."CropDecisionCombination" USING btree ("CropId");


--
-- TOC entry 4283 (class 1259 OID 19736)
-- Name: IX_CropDecisionCombination_CropId_DssId_PestId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_CropDecisionCombination_CropId_DssId_PestId" ON public."CropDecisionCombination" USING btree ("CropId", "DssId", "PestId");


--
-- TOC entry 4284 (class 1259 OID 19731)
-- Name: IX_CropDecisionCombination_DssId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_CropDecisionCombination_DssId" ON public."CropDecisionCombination" USING btree ("DssId");


--
-- TOC entry 4285 (class 1259 OID 19732)
-- Name: IX_CropDecisionCombination_PestId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_CropDecisionCombination_PestId" ON public."CropDecisionCombination" USING btree ("PestId");


--
-- TOC entry 4264 (class 1259 OID 19653)
-- Name: IX_Farm_Location; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Farm_Location" ON public."Farm" USING btree ("Location");


--
-- TOC entry 4288 (class 1259 OID 19752)
-- Name: IX_FieldCropDecisionCombination_CropDecisionCombinationId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_FieldCropDecisionCombination_CropDecisionCombinationId" ON public."FieldCropDecisionCombination" USING btree ("CropDecisionCombinationId");


--
-- TOC entry 4273 (class 1259 OID 19682)
-- Name: IX_FieldObservation_FieldId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_FieldObservation_FieldId" ON public."FieldObservation" USING btree ("FieldId");


--
-- TOC entry 4270 (class 1259 OID 19668)
-- Name: IX_Field_FarmId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Field_FarmId" ON public."Field" USING btree ("FarmId");


--
-- TOC entry 4267 (class 1259 OID 19654)
-- Name: IX_UserFarm_FarmId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_UserFarm_FarmId" ON public."UserFarm" USING btree ("FarmId");


--
-- TOC entry 4256 (class 1259 OID 19617)
-- Name: IX_UserProfile_UserAddressId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_UserProfile_UserAddressId" ON public."UserProfile" USING btree ("UserAddressId");


--
-- TOC entry 4257 (class 1259 OID 19586)
-- Name: IX_UserProfile_UserId; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_UserProfile_UserId" ON public."UserProfile" USING btree ("UserId");


--
-- TOC entry 4296 (class 2606 OID 19715)
-- Name: CropDecisionCombination FK_CropCombination_Crop; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CropDecisionCombination"
    ADD CONSTRAINT "FK_CropCombination_Crop" FOREIGN KEY ("CropId") REFERENCES public."Crop"("Id");


--
-- TOC entry 4297 (class 2606 OID 19720)
-- Name: CropDecisionCombination FK_CropCombination_Dss; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CropDecisionCombination"
    ADD CONSTRAINT "FK_CropCombination_Dss" FOREIGN KEY ("DssId") REFERENCES public."Dss"("Id");


--
-- TOC entry 4298 (class 2606 OID 19725)
-- Name: CropDecisionCombination FK_CropCombination_Pest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CropDecisionCombination"
    ADD CONSTRAINT "FK_CropCombination_Pest" FOREIGN KEY ("PestId") REFERENCES public."Pest"("Id");


--
-- TOC entry 4299 (class 2606 OID 19742)
-- Name: FieldCropDecisionCombination FK_FieldCropDecision_CropDecision; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."FieldCropDecisionCombination"
    ADD CONSTRAINT "FK_FieldCropDecision_CropDecision" FOREIGN KEY ("CropDecisionCombinationId") REFERENCES public."CropDecisionCombination"("Id") ON DELETE CASCADE;


--
-- TOC entry 4300 (class 2606 OID 19747)
-- Name: FieldCropDecisionCombination FK_FieldCropDecision_Field; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."FieldCropDecisionCombination"
    ADD CONSTRAINT "FK_FieldCropDecision_Field" FOREIGN KEY ("FielId") REFERENCES public."Field"("Id") ON DELETE CASCADE;


--
-- TOC entry 4294 (class 2606 OID 19663)
-- Name: Field FK_Field_Farm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Field"
    ADD CONSTRAINT "FK_Field_Farm" FOREIGN KEY ("FarmId") REFERENCES public."Farm"("Id") ON DELETE CASCADE;


--
-- TOC entry 4295 (class 2606 OID 19677)
-- Name: FieldObservation FK_Observation_Field; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."FieldObservation"
    ADD CONSTRAINT "FK_Observation_Field" FOREIGN KEY ("FieldId") REFERENCES public."Field"("Id") ON DELETE CASCADE;


--
-- TOC entry 4292 (class 2606 OID 19643)
-- Name: UserFarm FK_UserFarm_Farm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFarm"
    ADD CONSTRAINT "FK_UserFarm_Farm" FOREIGN KEY ("FarmId") REFERENCES public."Farm"("Id") ON DELETE CASCADE;


--
-- TOC entry 4293 (class 2606 OID 19648)
-- Name: UserFarm FK_UserFarm_User; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFarm"
    ADD CONSTRAINT "FK_UserFarm_User" FOREIGN KEY ("UserId") REFERENCES public."UserProfile"("UserId") ON DELETE CASCADE;


--
-- TOC entry 4291 (class 2606 OID 19623)
-- Name: UserProfile FK_User_UserAddress; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserProfile"
    ADD CONSTRAINT "FK_User_UserAddress" FOREIGN KEY ("UserAddressId") REFERENCES public."UserAddress"("Id") ON DELETE CASCADE;


-- Completed on 2020-07-28 10:20:16 UTC

--
-- PostgreSQL database dump complete
--