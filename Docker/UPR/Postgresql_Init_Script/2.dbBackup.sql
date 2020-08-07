--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3 (Debian 12.3-1.pgdg100+1)
-- Dumped by pg_dump version 12.3 (Debian 12.3-1.pgdg100+1)

-- Started on 2020-08-06 14:30:42 UTC

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
-- TOC entry 2 (class 3079 OID 24642)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 3926 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 25710)
-- Name: Crop; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Crop" (
    "Id" uuid NOT NULL,
    "Name" text NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 25734)
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
-- TOC entry 222 (class 1259 OID 25815)
-- Name: DataSharingRequest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DataSharingRequest" (
    "Id" uuid NOT NULL,
    "RequesteeId" uuid NOT NULL,
    "RequesterId" uuid NOT NULL,
    "RequestStatusDescription" text NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 25805)
-- Name: DataSharingRequestStatus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DataSharingRequestStatus" (
    "Id" integer NOT NULL,
    "Description" text NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 25718)
-- Name: Dss; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Dss" (
    "Id" uuid NOT NULL,
    "Name" text NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 25657)
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
-- TOC entry 213 (class 1259 OID 25682)
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
-- TOC entry 219 (class 1259 OID 25764)
-- Name: FieldCropDecisionCombination; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."FieldCropDecisionCombination" (
    "FielId" uuid NOT NULL,
    "CropDecisionCombinationId" uuid NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 25696)
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
-- TOC entry 217 (class 1259 OID 25726)
-- Name: Pest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Pest" (
    "Id" uuid NOT NULL,
    "Name" text NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 24628)
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
-- TOC entry 212 (class 1259 OID 25665)
-- Name: UserFarm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserFarm" (
    "UserId" uuid NOT NULL,
    "FarmId" uuid NOT NULL,
    "Authorised" boolean DEFAULT false NOT NULL,
    "UserFarmTypeDescription" text DEFAULT ''::text NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 25788)
-- Name: UserFarmType; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserFarmType" (
    "Id" integer NOT NULL,
    "Description" text NOT NULL
);

--
-- TOC entry 204 (class 1259 OID 24618)
-- Name: UserProfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserProfile" (
    "FirstName" character varying(80) NOT NULL,
    "LastName" text,
    "PhoneNumber" text,
    "MobileNumber" text,
    "UserId" uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    "UserAddressId" uuid
);


--
-- TOC entry 203 (class 1259 OID 24613)
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


--
-- TOC entry 3752 (class 2606 OID 25814)
-- Name: DataSharingRequestStatus AK_DataSharingRequestStatus_Description; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DataSharingRequestStatus"
    ADD CONSTRAINT "AK_DataSharingRequestStatus_Description" UNIQUE ("Description");


--
-- TOC entry 3747 (class 2606 OID 25797)
-- Name: UserFarmType AK_UserFarmType_Description; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFarmType"
    ADD CONSTRAINT "AK_UserFarmType_Description" UNIQUE ("Description");


--
-- TOC entry 3732 (class 2606 OID 25717)
-- Name: Crop PK_Crop; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Crop"
    ADD CONSTRAINT "PK_Crop" PRIMARY KEY ("Id");


--
-- TOC entry 3742 (class 2606 OID 25762)
-- Name: CropDecisionCombination PK_CropDecisionCombination; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CropDecisionCombination"
    ADD CONSTRAINT "PK_CropDecisionCombination" PRIMARY KEY ("Id");


--
-- TOC entry 3760 (class 2606 OID 25923)
-- Name: DataSharingRequest PK_DataSharingRequest; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DataSharingRequest"
    ADD CONSTRAINT "PK_DataSharingRequest" PRIMARY KEY ("Id");


--
-- TOC entry 3755 (class 2606 OID 25812)
-- Name: DataSharingRequestStatus PK_DataSharingRequestStatus; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DataSharingRequestStatus"
    ADD CONSTRAINT "PK_DataSharingRequestStatus" PRIMARY KEY ("Id");


--
-- TOC entry 3734 (class 2606 OID 25725)
-- Name: Dss PK_Dss; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Dss"
    ADD CONSTRAINT "PK_Dss" PRIMARY KEY ("Id");


--
-- TOC entry 3720 (class 2606 OID 25664)
-- Name: Farm PK_Farm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Farm"
    ADD CONSTRAINT "PK_Farm" PRIMARY KEY ("Id");


--
-- TOC entry 3727 (class 2606 OID 25689)
-- Name: Field PK_Field; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Field"
    ADD CONSTRAINT "PK_Field" PRIMARY KEY ("Id");


--
-- TOC entry 3745 (class 2606 OID 25768)
-- Name: FieldCropDecisionCombination PK_FieldCropDecisionCombination; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."FieldCropDecisionCombination"
    ADD CONSTRAINT "PK_FieldCropDecisionCombination" PRIMARY KEY ("FielId", "CropDecisionCombinationId");


--
-- TOC entry 3730 (class 2606 OID 25703)
-- Name: FieldObservation PK_FieldObservation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."FieldObservation"
    ADD CONSTRAINT "PK_FieldObservation" PRIMARY KEY ("Id");


--
-- TOC entry 3736 (class 2606 OID 25733)
-- Name: Pest PK_Pest; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Pest"
    ADD CONSTRAINT "PK_Pest" PRIMARY KEY ("Id");


--
-- TOC entry 3715 (class 2606 OID 24635)
-- Name: UserAddress PK_UserAddress; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserAddress"
    ADD CONSTRAINT "PK_UserAddress" PRIMARY KEY ("Id");


--
-- TOC entry 3724 (class 2606 OID 25879)
-- Name: UserFarm PK_UserFarm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFarm"
    ADD CONSTRAINT "PK_UserFarm" PRIMARY KEY ("UserId", "FarmId");


--
-- TOC entry 3750 (class 2606 OID 25795)
-- Name: UserFarmType PK_UserFarmType; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFarmType"
    ADD CONSTRAINT "PK_UserFarmType" PRIMARY KEY ("Id");


--
-- TOC entry 3713 (class 2606 OID 25877)
-- Name: UserProfile PK_UserProfile; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserProfile"
    ADD CONSTRAINT "PK_UserProfile" PRIMARY KEY ("UserId");


--
-- TOC entry 3710 (class 2606 OID 24617)
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- TOC entry 3737 (class 1259 OID 25757)
-- Name: IX_CropDecisionCombination_CropId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_CropDecisionCombination_CropId" ON public."CropDecisionCombination" USING btree ("CropId");


--
-- TOC entry 3738 (class 1259 OID 25763)
-- Name: IX_CropDecisionCombination_CropId_DssId_PestId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_CropDecisionCombination_CropId_DssId_PestId" ON public."CropDecisionCombination" USING btree ("CropId", "DssId", "PestId");


--
-- TOC entry 3739 (class 1259 OID 25758)
-- Name: IX_CropDecisionCombination_DssId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_CropDecisionCombination_DssId" ON public."CropDecisionCombination" USING btree ("DssId");


--
-- TOC entry 3740 (class 1259 OID 25759)
-- Name: IX_CropDecisionCombination_PestId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_CropDecisionCombination_PestId" ON public."CropDecisionCombination" USING btree ("PestId");


--
-- TOC entry 3753 (class 1259 OID 25841)
-- Name: IX_DataSharingRequestStatus_Description; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_DataSharingRequestStatus_Description" ON public."DataSharingRequestStatus" USING btree ("Description");


--
-- TOC entry 3756 (class 1259 OID 25838)
-- Name: IX_DataSharingRequest_RequestStatusDescription; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_DataSharingRequest_RequestStatusDescription" ON public."DataSharingRequest" USING btree ("RequestStatusDescription");


--
-- TOC entry 3757 (class 1259 OID 25924)
-- Name: IX_DataSharingRequest_RequesteeId_RequesterId; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_DataSharingRequest_RequesteeId_RequesterId" ON public."DataSharingRequest" USING btree ("RequesteeId", "RequesterId");


--
-- TOC entry 3758 (class 1259 OID 25840)
-- Name: IX_DataSharingRequest_RequesterId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_DataSharingRequest_RequesterId" ON public."DataSharingRequest" USING btree ("RequesterId");


--
-- TOC entry 3718 (class 1259 OID 25680)
-- Name: IX_Farm_Location; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Farm_Location" ON public."Farm" USING btree ("Location");


--
-- TOC entry 3743 (class 1259 OID 25779)
-- Name: IX_FieldCropDecisionCombination_CropDecisionCombinationId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_FieldCropDecisionCombination_CropDecisionCombinationId" ON public."FieldCropDecisionCombination" USING btree ("CropDecisionCombinationId");


--
-- TOC entry 3728 (class 1259 OID 25709)
-- Name: IX_FieldObservation_FieldId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_FieldObservation_FieldId" ON public."FieldObservation" USING btree ("FieldId");


--
-- TOC entry 3725 (class 1259 OID 25695)
-- Name: IX_Field_FarmId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Field_FarmId" ON public."Field" USING btree ("FarmId");


--
-- TOC entry 3748 (class 1259 OID 25799)
-- Name: IX_UserFarmType_Description; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_UserFarmType_Description" ON public."UserFarmType" USING btree ("Description");


--
-- TOC entry 3721 (class 1259 OID 25681)
-- Name: IX_UserFarm_FarmId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_UserFarm_FarmId" ON public."UserFarm" USING btree ("FarmId");


--
-- TOC entry 3722 (class 1259 OID 25798)
-- Name: IX_UserFarm_UserFarmTypeDescription; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_UserFarm_UserFarmTypeDescription" ON public."UserFarm" USING btree ("UserFarmTypeDescription");


--
-- TOC entry 3711 (class 1259 OID 24636)
-- Name: IX_UserProfile_UserAddressId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_UserProfile_UserAddressId" ON public."UserProfile" USING btree ("UserAddressId");


--
-- TOC entry 3767 (class 2606 OID 25742)
-- Name: CropDecisionCombination FK_CropCombination_Crop; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CropDecisionCombination"
    ADD CONSTRAINT "FK_CropCombination_Crop" FOREIGN KEY ("CropId") REFERENCES public."Crop"("Id");


--
-- TOC entry 3768 (class 2606 OID 25747)
-- Name: CropDecisionCombination FK_CropCombination_Dss; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CropDecisionCombination"
    ADD CONSTRAINT "FK_CropCombination_Dss" FOREIGN KEY ("DssId") REFERENCES public."Dss"("Id");


--
-- TOC entry 3769 (class 2606 OID 25752)
-- Name: CropDecisionCombination FK_CropCombination_Pest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CropDecisionCombination"
    ADD CONSTRAINT "FK_CropCombination_Pest" FOREIGN KEY ("PestId") REFERENCES public."Pest"("Id");


--
-- TOC entry 3772 (class 2606 OID 25823)
-- Name: DataSharingRequest FK_DataSharingRequest_RequestStatus_RequestDescription; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DataSharingRequest"
    ADD CONSTRAINT "FK_DataSharingRequest_RequestStatus_RequestDescription" FOREIGN KEY ("RequestStatusDescription") REFERENCES public."DataSharingRequestStatus"("Description");


--
-- TOC entry 3773 (class 2606 OID 25880)
-- Name: DataSharingRequest FK_DataSharingRequest_UserProfile_RequesteeId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DataSharingRequest"
    ADD CONSTRAINT "FK_DataSharingRequest_UserProfile_RequesteeId" FOREIGN KEY ("RequesteeId") REFERENCES public."UserProfile"("UserId") ON DELETE CASCADE;


--
-- TOC entry 3774 (class 2606 OID 25885)
-- Name: DataSharingRequest FK_DataSharingRequest_UserProfile_RequesterId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DataSharingRequest"
    ADD CONSTRAINT "FK_DataSharingRequest_UserProfile_RequesterId" FOREIGN KEY ("RequesterId") REFERENCES public."UserProfile"("UserId") ON DELETE CASCADE;


--
-- TOC entry 3770 (class 2606 OID 25769)
-- Name: FieldCropDecisionCombination FK_FieldCropDecision_CropDecision; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."FieldCropDecisionCombination"
    ADD CONSTRAINT "FK_FieldCropDecision_CropDecision" FOREIGN KEY ("CropDecisionCombinationId") REFERENCES public."CropDecisionCombination"("Id") ON DELETE CASCADE;


--
-- TOC entry 3771 (class 2606 OID 25774)
-- Name: FieldCropDecisionCombination FK_FieldCropDecision_Field; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."FieldCropDecisionCombination"
    ADD CONSTRAINT "FK_FieldCropDecision_Field" FOREIGN KEY ("FielId") REFERENCES public."Field"("Id") ON DELETE CASCADE;


--
-- TOC entry 3765 (class 2606 OID 25690)
-- Name: Field FK_Field_Farm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Field"
    ADD CONSTRAINT "FK_Field_Farm" FOREIGN KEY ("FarmId") REFERENCES public."Farm"("Id") ON DELETE CASCADE;


--
-- TOC entry 3766 (class 2606 OID 25704)
-- Name: FieldObservation FK_Observation_Field; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."FieldObservation"
    ADD CONSTRAINT "FK_Observation_Field" FOREIGN KEY ("FieldId") REFERENCES public."Field"("Id") ON DELETE CASCADE;


--
-- TOC entry 3763 (class 2606 OID 25895)
-- Name: UserFarm FK_UserFarm_Farm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFarm"
    ADD CONSTRAINT "FK_UserFarm_Farm" FOREIGN KEY ("FarmId") REFERENCES public."Farm"("Id") ON DELETE CASCADE;


--
-- TOC entry 3764 (class 2606 OID 25900)
-- Name: UserFarm FK_UserFarm_User; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFarm"
    ADD CONSTRAINT "FK_UserFarm_User" FOREIGN KEY ("UserId") REFERENCES public."UserProfile"("UserId") ON DELETE CASCADE;


--
-- TOC entry 3762 (class 2606 OID 25800)
-- Name: UserFarm FK_UserFarm_UserFarmType_UserFarmTypeDescription; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFarm"
    ADD CONSTRAINT "FK_UserFarm_UserFarmType_UserFarmTypeDescription" FOREIGN KEY ("UserFarmTypeDescription") REFERENCES public."UserFarmType"("Description");


--
-- TOC entry 3761 (class 2606 OID 25650)
-- Name: UserProfile FK_User_UserAddress; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserProfile"
    ADD CONSTRAINT "FK_User_UserAddress" FOREIGN KEY ("UserAddressId") REFERENCES public."UserAddress"("Id") ON DELETE CASCADE;


--
-- INSERT DATA
--


INSERT INTO public."UserFarmType" ("Id", "Description") VALUES
    (0,	'Unknown'),
    (1,	'Owner'),
    (3,	'Advisor');


INSERT INTO public."DataSharingRequestStatus" ("Id", "Description") VALUES
    (0,	'Pending'),
    (1,	'Accepted'),
    (3,	'Declined');


-- Completed on 2020-08-06 14:30:43 UTC

--
-- PostgreSQL database dump complete
--

