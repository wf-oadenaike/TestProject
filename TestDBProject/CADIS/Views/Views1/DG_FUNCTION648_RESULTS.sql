﻿CREATE VIEW "CADIS"."DG_FUNCTION648_RESULTS" AS 
SELECT ET."MemberName",ET."RoleName",ET."AssignSQL",ET."RemoveSQL" FROM "CADIS"."VW_SQL_Roles_and_Permissions" ET WITH (NOLOCK)