﻿CREATE VIEW "CADIS"."DG_FUNCTION751_RESULTS" AS 
SELECT ET."EDM_Issuer_ID",ET."Issuer_Name",ET."Ticker_exchange",ET."Country_Of_Risk",ET."Country_Of_Domicile",ET."LEI",ET."ID_BB_GLOBAL_CO",ET."Country_Of_Incorporation",ET."CompanyType",ET."Salesforce_Account_Id",ET."BoxFolderID",ET."JiraEpicKey",ET."PrimaryAnalystPersonID",ET."SecondaryAnalystPersonID",ET."Currency",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "dbo"."T_MASTER_ISSUER" ET WITH (NOLOCK)
