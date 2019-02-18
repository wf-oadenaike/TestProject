﻿CREATE VIEW "CADIS"."IL_T_PKGD_FILE_ACTION_AUDIT" AS 
SELECT V."NO" AS "TopLevelRunID",V."BTNID" AS "UIButtonID",V."ACTION" AS "Action",V."FILENAME" AS "Filename",V."USER" AS "User",V."CADIS_SYSTEM_INSERTED" AS "Cadis Inserted",V."CADIS_SYSTEM_UPDATED" AS "Cadis Updated",V."CADIS_SYSTEM_CHANGEDBY" AS "Cadis Changedby" FROM "dbo"."T_PKGD_FILE_ACTION_AUDIT" V
