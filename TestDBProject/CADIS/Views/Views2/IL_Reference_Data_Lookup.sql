﻿CREATE VIEW "CADIS"."IL_Reference_Data_Lookup" AS 
SELECT V."ENTITY" AS "Entity",V."SUB_ENTITY" AS "Sub Entity",V."FIELD" AS "Field",V."FIELD_VALUE" AS "Field Value",V."LOOKUP_VALUE" AS "Lookup Value",V."CHAR_VALUE" AS "Char Value",V."INT_VALUE" AS "Int Value",V."SORT" AS "Sort",V."CADIS_SYSTEM_INSERTED" AS "System Inserted",V."CADIS_SYSTEM_UPDATED" AS "System Updated",V."CADIS_SYSTEM_CHANGEDBY" AS "System Changed by",V."CADIS_SYSTEM_PRIORITY" AS "System Priority" FROM "dbo"."T_REF_LOOKUP" V
