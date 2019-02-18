﻿CREATE VIEW "CADIS"."DG_FUNCTION573_RESULTS" AS 
SELECT ET."ID",ET."Name",ET."SubsectorID",ET."StatusID",ET."Description",ET."InternalNotes",ET."SFAccountID",ET."ReferrerSFContactID",ET."BoxFolderID",ET."SubmittedBy",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CountryID",ET."InvestmentAnalystPersonID",ET."FundManagerPersonID" FROM "Investment"."T_UnquotedCompanyReferrals" ET WITH (NOLOCK)
