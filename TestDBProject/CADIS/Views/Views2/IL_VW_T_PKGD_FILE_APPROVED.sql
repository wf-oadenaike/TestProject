﻿CREATE VIEW "CADIS"."IL_VW_T_PKGD_FILE_APPROVED" AS 
SELECT V."NO" AS "Top Level RunID",V."PKGFILE" AS "Package FileName",V."STATUS" AS "Status" FROM "CADIS"."VW_T_PKGD_FILE_APPROVED" V
