CREATE VIEW [Reporting].[ComplianceTrainingCompetenceVw]
	AS 
SELECT [MandatoryTrainingId]
      ,[LearningId]
	  ,p.[PersonId] 
      ,COALESCE([EmployeeName], p.PersonsName) AS [PersonName]
      ,[StartDate]
      ,[TrainingName]
      ,[ProposedDate]
      ,[AttestationDate]
      ,(CASE WHEN [AttestationRequired] = 'false' THEN 0 ELSE 1 END) AS [AttestationRequired]
      ,(CASE WHEN [AttestationComplete] = 'false' THEN 0 ELSE 1 END) AS [AttestationComplete]
      ,p.[EmploymentState]
      ,(CASE WHEN [ExpiryDate] IS NULL AND AttestationDate IS NOT NULL THEN DATEADD(yy,1,AttestationDate) ELSE [ExpiryDate] END) AS [ExpiryDate]
      ,p.[ActiveFlag] AS [HRUserStatus]
      ,[TrainingStatus]
      ,COALESCE(pm.[PersonsName],[ManagerName]) AS [ManagerName]
	  ,pm.[PersonId] AS ManagerPersonId
      ,[AttendanceApprover]
  FROM [Core].[Persons] p 
  FULL OUTER JOIN
		[Compliance].[MandatoryTraining] mt 
		 ON p.PersonsName = mt.EmployeeName
  LEFT JOIN
		[Core].[Persons] pm ON pm.PersonsName = mt.[ManagerName]
  WHERE
--		TrainingStatus IN ('Completed','Expired') --Only use these as these are from the flow. Others are legacy.
		p.PersonId <> -1
