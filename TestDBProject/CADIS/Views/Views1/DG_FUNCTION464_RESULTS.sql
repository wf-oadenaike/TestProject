﻿CREATE VIEW "CADIS"."DG_FUNCTION464_RESULTS" AS 
SELECT ET."STOCK",ET."ROW_ID",ET."ISIN",ET."ERROR_CODE",ET."DELIMITER",ET."NUM_OF_DIMENSIONS",ET."NUM_OF_ROWS",ET."NUM_OF_COLS",ET."DECLARED_DATE",ET."EX_DATE",ET."RECORD_DATE",ET."PAYABLE_DATE",ET."DVD_VALUE",ET."FREQUENCY",ET."DVD_TYPE",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."EDM_SEC_ID" FROM "dbo"."T_BPS_DVD_HIST" ET WITH (NOLOCK)