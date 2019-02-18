﻿CREATE VIEW "CADIS"."DG_FUNCTION231_RESULTS" AS 
SELECT ET."CompanyKeyBusinessDateId",ET."BusinessActivity",ET."BusinessActivityTypeId",ET."BusinessActivityType",ET."FinancialYearReference",ET."ReporterName",ET."ReporterRoleId",ET."ReporterRole",ET."AssigneePerson",ET."AssigneeRoleId",ET."AssigneeRole",ET."CompanyKeyBusinessDateEventId",ET."FinancialYear",ET."EventDate",ET."DueDate",ET."ClosedDate",ET."Status",ET."CreatedDate" FROM "Access.ManyWho"."CompanyKeyBusinessDateEventsReadOnlyVw" ET WITH (NOLOCK)