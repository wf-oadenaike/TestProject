﻿CREATE VIEW "CADIS"."IL_Override_Net_Fund_Flow_Reset" AS 
SELECT V."FILE_NAME",V."FILE_TYPE",V."FILE_DATE",V."NUMBER_OF_RECORDS",V."CONSOLIDATION" AS "Consolidation",V."ACCOUNT_NUMBER" AS "Account Number",V."FUND_SHORT_NAME" AS "Fund Short Name",V."FROM_DATE" AS "From Date",V."THROUGH_DATE" AS "Through Date",V."TASTDESCMED" AS "Description",V."TNARRLONG" AS "Narrative",V."ABASBSE" AS "BAS Base",V."NET_AMOUNT__BASE" AS "Net Amount Base",V."AMKTVAL" AS "Market Value",V."ARLSDGAIN" AS "RLSDGAIN",V."AEXCHGNLS" AS "Exchange Gain Loss",V."RECOGNITION_DATE" AS "Recognition Date",V."NTRANCATG" AS "Transaction Category",V."ASSET_IDENTIFIER" AS "Asset Identifier",V."CTEMPLTYPE" AS "Template Type",V."CVALNTYPEO" AS "Valuation Type",V."TSHAREPAR" AS "Share Par",V."REVERSAL_INDICATOR" AS "Reversal Indicator",V."ALOTCOSTGNLS" AS "Lot Cost Gain Loss",V."DTRANPROC" AS "Transaction Process Date",V."CSORTCDE3" AS "Sort Code",V."ERROR_CODE" AS "Error Code",V."CONSOLIDATION_AUDIT_INDICATOR_FLAG" AS "Consolidation Audit Indicator Flag",V."IEXTLREF" AS "External Ref",V."CASSETLIAB" AS "Asset Liability",V."ACCRUED_INTEREST" AS "Accrued Interest",V."DSET" AS "Set",V."ACCRUAL_CHANGE_FROM_SECURITY_MOVEMENTS_OFFSET" AS "Accrual Change from Security Movement Offset",V."CADIS_SYSTEM_INSERTED" AS "System Inserted",V."CADIS_SYSTEM_UPDATED" AS "System Updated",V."CADIS_SYSTEM_CHANGEDBY" AS "System Changed By",V."CADIS_SYSTEM_PRIORITY" AS "System Priority",V."CADIS_SYSTEM_LASTMODIFIED" AS "System Last Modified",V."CADIS_SYSTEM_TIMESTAMP" FROM "dbo"."T_OVERRIDE_NET_FUND_FLOW_RESET" V
