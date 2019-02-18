﻿CREATE VIEW "CADIS"."IL_Organisation_Valuation_Reviews" AS 
SELECT V."ValuationReviewId" AS "Valuation Review ID",V."UnquotedCompanyId" AS "Unquoted Company ID",V."ValuationReviewMeetingDate" AS "Valuation Review Meeting Date",V."BoxUrl" AS "Box URL",V."ValuationReviewCreationDate" AS "Valuation Review Creation Date", J7.DF AS "Valuation Review Created By Person ID",V."ValuationReviewModifiedDate" AS "Valuation Review Modified Date", J9.DF AS "Valuation Review Last Modified By Person ID",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY",V."CADIS_SYSTEM_PRIORITY",V."CADIS_SYSTEM_TIMESTAMP",V."CADIS_SYSTEM_LASTMODIFIED" FROM "Organisation"."ValuationReviews" V LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J7 ON  J7.JF=V."ValuationReviewCreatedByPersonId" LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J9 ON  J9.JF=V."ValuationReviewLastModifiedByPersonId"