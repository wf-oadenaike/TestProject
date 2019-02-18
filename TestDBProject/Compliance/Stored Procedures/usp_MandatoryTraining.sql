CREATE PROCEDURE [Compliance].[usp_MandatoryTraining]
		
AS
/*-------------------------------------------------------------------------------------- 
 Name:			Compliance.usp_MandatoryTraining
 
 Note:			
 
 Author:		Faheem
 Date:			09/12/2015
------------------------------------------------------------------------------------ 
 History:		Initial Write 

 
--------------------------------------------------------------------------------------*/ 

BEGIN TRY

	SET NOCOUNT ON;
	SET DATEFORMAT dmy;

	BEGIN TRANSACTION

	DECLARE @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	DECLARE	@strProcedureName		VARCHAR(100)	= 'Compliance.usp_MandatoryTraining';

		MERGE INTO  [Compliance].[MandatoryTraining] AS Tar
		USING ( SELECT 
					 learn.Id AS LearningId
					,emp.PersonsName AS EmployeeName
					,CONVERT(DATE,EmployeesSrc.[Start date],103) StartDate
					,learn.CourseName AS 'TrainingName'
					,CONVERT(DATE,learn.ProposedDate,103) ProposedDate
					,CONVERT(DATE,learn.AttestationDate,103) AttestationDate
					,learn.AttestationRequired
					,learn.AttestationComplete
					,EmployeesSrc.[Employment status] EmploymentStatus
					,EmployeesSrc.[Employment type] EmploymentType
					,CONVERT(DATE,learn.ExpiryDate,103) ExpiryDate
					,EmployeesSrc.[HR user status] AS HRUserStatus
					,learn.Status AS 'TrainingStatus'
					,CONVERT(DATE,learn.DateApproved,103) DateApproved
					,man.PersonsName as	ManagerName
					,Approver.PersonsName as AttendanceApprover
					,CASE WHEN CONVERT(DATE,ISNULL(learn.ExpiryDate,DATEADD(d, -2, GETDATE())),103)<CONVERT(DATE, DATEADD(d, -1, GETDATE()))
							AND learn.CourseName NOT IN
							(
							'Compliance induction' 
							,'PA Dealing discussion'
							,'Introduction to Agile'
							)
					  THEN 'Yes'
					  ELSE 'No'
					 END AS Required
				FROM [Staging.Salesforce].[LearningHistorySrc] learn
				LEFT JOIN core.persons emp
				ON emp.EmployeeIdBK = learn.Employee
				LEFT JOIN core.persons man
				ON man.FullEmployeeBK = learn.Manager
				LEFT JOIN core.persons Approver
				ON Approver.FullEmployeeBK = learn.AttendanceApprover
				LEFT JOIN [Staging.Salesforce].EmployeesSrc 
				ON EmployeesSrc.[Employee: ID]=learn.Employee

				) Src
		ON Src.LearningId = Tar.LearningId
		--AND Src.TrainingName = Tar.TrainingName
		--AND ISNULL(Src.AttestationDate,'2099-12-31') = ISNULL(Tar.AttestationDate,'2099-12-31')
		--AND ISNULL(Src.DateApproved,'2099-12-31') = ISNULL(Tar.DateApproved,'2099-12-31')
		WHEN NOT MATCHED
		THEN 
			INSERT   (  LearningId
					   ,[EmployeeName]
					   ,[StartDate]
					   ,[TrainingName]
					   ,[ProposedDate]
					   ,[AttestationDate]
					   ,[AttestationRequired]
					   ,[AttestationComplete]
					   ,[EmploymentStatus]
					   ,[EmploymentType]
					   ,[ExpiryDate]
					   ,[HRUserStatus]
					   ,[TrainingStatus]
					   ,[DateApproved]
					   ,[ManagerName]
					   ,[AttendanceApprover]
					   ,[Required])
				 VALUES
					   ( Src.LearningId
					   , Src.EmployeeName
					   , Src.StartDate
					   , Src.TrainingName
					   , Src.ProposedDate
					   , Src.AttestationDate
					   , Src.AttestationRequired
					   , Src.AttestationComplete
					   , Src.EmploymentStatus
					   , Src.EmploymentType
					   , Src.ExpiryDate
					   , Src.HRUserStatus
					   , Src.TrainingStatus
					   , Src.DateApproved
					   , Src.ManagerName
					   , Src.AttendanceApprover
					   , Src.Required
					   )

			WHEN MATCHED AND (Tar.HRUserStatus <> Src.HRUserStatus
					OR Tar.TrainingStatus <> Src.TrainingStatus
					OR Tar.Required <> Src.Required
					OR Tar.ExpiryDate <> Src.ExpiryDate
					OR Tar.EmploymentStatus <> Src.EmploymentStatus
					OR Tar.EmploymentType <> Src.EmploymentType
					OR Tar.ProposedDate <> Src.ProposedDate
					OR Tar.AttestationRequired <> Src.AttestationRequired
					OR Tar.AttestationComplete <> Src.AttestationComplete
					OR Tar.ManagerName <> Src.ManagerName
					OR Tar.AttendanceApprover <> Src.AttendanceApprover

					)
			THEN UPDATE SET   Tar.HRUserStatus = Src.HRUserStatus
							, Tar.TrainingStatus = Src.TrainingStatus
							, Tar.Required = Src.Required
							, Tar.ExpiryDate = Src.ExpiryDate
							, Tar.EmploymentStatus = Src.EmploymentStatus
							, Tar.EmploymentType = Src.EmploymentType
							, Tar.ProposedDate = Src.ProposedDate
							, Tar.AttestationRequired = Src.AttestationRequired
							, Tar.AttestationComplete = Src.AttestationComplete
							, Tar.ManagerName = Src.ManagerName
							, Tar.AttendanceApprover = Src.AttendanceApprover
			;
					
		SET @InsertRowCount = @@ROWCOUNT;

	COMMIT;

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
		ROLLBACK;
		 
		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		Return @ErrorNumber;
END CATCH
