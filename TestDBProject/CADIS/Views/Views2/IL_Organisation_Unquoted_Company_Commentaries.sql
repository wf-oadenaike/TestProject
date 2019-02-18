﻿CREATE VIEW "CADIS"."IL_Organisation_Unquoted_Company_Commentaries" AS 
SELECT V."UnquotedCompanyCommentaryId" AS "Unquoted Company Commentary ID", J1.DF AS "Unquoted Company Stage",V."UnquotedCompanyId" AS "Unquoted Company ID",V."Commentary" AS "Commentary", J4.DF AS "Commentary By Person ID", J5.DF AS "Commentary By Role ID",V."CommentaryCreatedDate" AS "Commentary Created Date",V."CommentaryLastModifiedDate" AS "Commentary Last Modified Date",V."JoinGUID" AS "Join GUID",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY",V."CADIS_SYSTEM_PRIORITY",V."CADIS_SYSTEM_TIMESTAMP",V."CADIS_SYSTEM_LASTMODIFIED" FROM "Organisation"."UnquotedCompanyCommentaries" V LEFT OUTER JOIN (SELECT DISTINCT "UnquotedCompanyStage" AS JF,"UnquotedCompanyStageDescription" AS DF FROM "Organisation"."UnquotedCompanyStages")  J1 ON  J1.JF=V."UnquotedCompanyStage" LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J4 ON  J4.JF=V."CommentaryByPersonId" LEFT OUTER JOIN (SELECT DISTINCT "RoleId" AS JF,"RoleName" AS DF FROM "Core"."Roles")  J5 ON  J5.JF=V."CommentaryByRoleId"