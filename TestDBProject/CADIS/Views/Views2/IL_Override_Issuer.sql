﻿CREATE VIEW "CADIS"."IL_Override_Issuer" AS 
SELECT V."EDM_Issuer_ID" AS "Issuer ID",V."Issuer_Name" AS "Issuer Name",V."Ticker_exchange" AS "Ticker",V."Country_Of_Risk" AS "Country Of Risk",V."Country_Of_Domicile" AS "Country of Domicile",V."LEI" AS "LEI",V."ID_BB_GLOBAL_CO" AS "Bloomberg ID",V."Country_Of_Incorporation" AS "Country of Incorporation",V."CompanyType" AS "Company Type",V."Salesforce_Account_Id" AS "Salesforce ID",V."BoxFolderID" AS "Box Folder ID",V."JiraEpicKey" AS "Jira Epic Key",V."PrimaryAnalystPersonID" AS "Primary Analyst",V."SecondaryAnalystPersonID" AS "Secondary Analyst",V."Currency" AS "Currency",V."CADIS_SYSTEM_INSERTED" AS "CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED" AS "CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY" AS "CADIS_SYSTEM_CHANGEDBY" FROM "dbo"."T_OVERRIDE_ISSUER" V
