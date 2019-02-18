﻿CREATE VIEW "CADIS"."DG_FUNCTION276_RESULTS" AS 
SELECT ET."JoinGUID",ET."ChangeManagementRegisterCreationDatetime",ET."ChangeManagementRegisterLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."ChangeID",ET."ServiceTypeID",ET."StatusID",ET."ChangeTitle",ET."PriorityID",ET."UrgencyID",ET."DueLiveDate",ET."PlanDueDate",ET."ChangeTypeID",ET."Description",ET."ReasonJustification",ET."ImpactID",ET."ImpactDesc",ET."ComplexityID",ET."RiskID",ET."EstimatedHoursRequired",ET."BuildInstruction",ET."ProgressNote",ET."IsBuildComplete",ET."TesterPersonID",ET."JIRAIssueKey",ET."IsDocumentationProvided",ET."AttachmentsFolder",ET."IsChangeReady",ET."CreatedDate",ET."SubmittedByPersonID",ET."DocumentationFolderLink",ET."TestCompleteDueDate",ET."TestPlan",ET."TestingComplete",ET."PlanApproverPersonID",ET."DeploymentApproverPersonID",ET."ComplexityDesc",ET."RiskDesc",ET."IncidentId",ET."IncidentTitle",ET."Backout",ET."RuleID",ET."RuleDescription",ET."DashboardUpdate",ET."CADIS_SYSTEM_TIMESTAMP" FROM "ChangeManagement"."ChangeManagementRegister" ET WITH (NOLOCK)
