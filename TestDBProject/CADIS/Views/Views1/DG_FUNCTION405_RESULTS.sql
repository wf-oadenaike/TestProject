﻿CREATE VIEW "CADIS"."DG_FUNCTION405_RESULTS" AS 
SELECT ET."BrokerOnBoardingRegisterId",ET."BrokerOnBoardingEventTypeId",ET."PersonId",ET."RoleId",ET."DepartmentId",ET."BrokerOnBoardingEventCreationDatetime",ET."BrokerOnBoardingEventId",ET."ReviewCollection",ET."EventDetails",ET."EventDate",ET."EventTrueFalse",ET."DocumentationFolderLink",ET."WorkflowVersionGUID",ET."JoinGUID",ET."BrokerOnBoardingEventLastModifiedDatetime" FROM "Organisation"."BrokerOnBoardingEvents" ET WITH (NOLOCK)