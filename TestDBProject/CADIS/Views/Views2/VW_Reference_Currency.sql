﻿CREATE VIEW "CADIS"."VW_Reference_Currency"
AS
SELECT
T1.* 
FROM
"dbo"."T_REF_CURRENCY" T1
WHERE
T1.[ACTIVE] = 'Y'
