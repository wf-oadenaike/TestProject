﻿CREATE VIEW "CADIS"."DG_FUNCTION185_RESULTS" AS 
SELECT ET."ACCOUNT_NUMBER",ET."TNARRLONG",ET."NET_AMOUNT__BASE",ET."RECOGNITION_DATE",ET."NTRANCATG",ET."IEXTLREF",ET."FILE_NAME",ET."FILE_TYPE",ET."FILE_DATE",ET."NUMBER_OF_RECORDS",ET."CONSOLIDATION",ET."FUND_SHORT_NAME",ET."FROM_DATE",ET."THROUGH_DATE",ET."TASTDESCMED",ET."ABASBSE",ET."AMKTVAL",ET."ARLSDGAIN",ET."AEXCHGNLS",ET."ASSET_IDENTIFIER",ET."CTEMPLTYPE",ET."CVALNTYPEO",ET."TSHAREPAR",ET."REVERSAL_INDICATOR",ET."ALOTCOSTGNLS",ET."DTRANPROC",ET."CSORTCDE3",ET."ERROR_CODE",ET."CONSOLIDATION_AUDIT_INDICATOR_FLAG",ET."CASSETLIAB",ET."ACCRUED_INTEREST",ET."DSET",ET."ACCRUAL_CHANGE_FROM_SECURITY_MOVEMENTS_OFFSET",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "dbo"."T_OVERRIDE_NET_FUND_FLOW_EXPIRY" ET WITH (NOLOCK)
