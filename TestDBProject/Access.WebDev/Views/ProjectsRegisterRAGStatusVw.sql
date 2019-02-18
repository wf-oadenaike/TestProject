CREATE VIEW [Access.WebDev].[ProjectsRegisterRAGStatusVw]
	AS 
	SELECT
			pr.[ProjectId]
		   ,pr.[ProjectName]
		   ,pr.[ProposedStartDate]
		   ,pr.[EstimatedDuration]
		   ,pr.[EstimatedCost]
		   ,pr.[ProjectStatus]
		   ,pr.[DepartmentId]
		   ,d.[DepartmentName]
		   ,pr.[RAGStatus]
		   ,pr.[ActualStartDate]
		   ,pr.[ActualEndDate]
	FROM [Organisation].[NewProjectsRegister] pr
	INNER JOIN [Core].[Departments] d
	ON pr.DepartmentId = d.DepartmentId
	WHERE ProjectStatus in ('Approved','Live','Completed', 'Descoped')
;
