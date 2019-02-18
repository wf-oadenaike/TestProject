CREATE VIEW "CADIS"."DG_FUNCTION377_RESULTS" AS 
SELECT ET."ProjectId",ET."ProjectName",ET."ProposedStartDate",ET."EstimatedDuration",ET."EstimatedCost",ET."ProjectStatus",ET."DepartmentId",ET."DepartmentName",ET."RAGStatus",ET."ActualStartDate",ET."ActualEndDate" FROM "Access.WebDev"."ProjectsRegisterRAGStatusVw" ET WITH (NOLOCK)
