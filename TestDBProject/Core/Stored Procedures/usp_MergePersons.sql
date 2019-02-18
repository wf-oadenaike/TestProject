
CREATE PROCEDURE [Core].[usp_MergePersons]
		@ControlId BIGINT=-1
AS
-------------------------------------------------------------------------------------- 
-- Name:			Core.usp_MergePersons
-- 
-- Note:			
-- 
-- Author:			I Pearson
-- Date:			06/05/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- 2017-01-02 	Joe Tapper	added column BloomnbergID
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Core].[usp_MergePersons]';

	BEGIN TRANSACTION

		IF (@ControlId = -1) BEGIN
			SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
		END;

		DECLARE @RstTbl TABLE 
				( RstAct varchar(12), PersonId smallint
						, IActiveFlag bit null, DActiveFlag bit null)
						;

		MERGE INTO [Core].[Persons] as Tar
		USING ( SELECT DISTINCT IsNull(d.DepartmentId, -1) as DepartmentId
		                , e.[Employee: Employee name] as PersonsName
						, CASE WHEN e.[job title] LIKE 'Head%' THEN 1
						       WHEN e.[job title] LIKE 'Chief Executive Officer%' THEN 1
								ELSE 0
							   END as DepartmentHead
						, LEFT( e.UserId, 15) as EmployeeBK
						, e.UserId as FullEmployeeBK
						, IsNull(ss.SourceSystemId, -1) as SourceSystemId
						, CASE WHEN e.[HR user status] = 'Active' and (e.[Leaving date] > getdate() or e.[Leaving date] is NULL) THEN 1 
							ELSE 0 END ActiveFlag
						, e.[Work email address] as ContactEMailAddress
						, LEFT( e.[UserId], 15) as UserBK
						, e.[job title] as JobTitle
						, e.[Employment status] as EmploymentState
						, e.[Employee: ID]  as EmployeeIdBK
						, e.[Employee: Owner Alias] as BBGID
						--, @ControlId as ControlId
				FROM [Staging.Salesforce].[EmployeesSrc] e
					INNER JOIN ( SELECT [Employee: Employee name] as PersonsName, MAX( CONVERT( datetime, ps.[Start date])) as LastCreatedDate
											, MAX( ps.[Start date]) as MaxCreatedDate
								FROM [Staging.Salesforce].[EmployeesSrc] ps
								GROUP BY [Employee: Employee name]) MaxPs
						ON (e.[Employee: Employee name] = Maxps.PersonsName
						and e.[Start date] = Maxps.MaxCreatedDate)
					LEFT OUTER JOIN Core.Departments d
						ON (e.[Department] = d.DepartmentName)
					LEFT OUTER JOIN Audit.SourceSystems ss
						ON ('SFDC' = SourceSystemCode)
				) Src
		ON Src.FullEmployeeBK = Tar.FullEmployeeBK
		WHEN NOT MATCHED BY TARGET
			THEN INSERT (DepartmentId, PersonsName, ControlId, DepartmentHead, EmployeeBK, SourceSystemId, ActiveFlag, ActiveFlagDateTime, ContactEmailAddress,
			 UserBK, JobTitle, EmploymentState, EmployeeIdBK, FullEmployeeBK,[BloombergID])
				 VALUES (Src.DepartmentId, Src.PersonsName, @ControlId, Src.DepartmentHead
						, Src.EmployeeBK, Src.SourceSystemId, Src.ActiveFlag, GetDate(), Src.ContactEMailAddress
						, Src.UserBK, Src.JobTitle, Src.EmploymentState, Src.EmployeeIdBK,Src.FullEmployeeBK
						,Src.BBGID)
		WHEN MATCHED AND (Tar.DepartmentId <> Src.DepartmentId
					OR Tar.PersonsName <> Src.PersonsName
					OR Tar.DepartmentHead <> Src.DepartmentHead
					OR Tar.SourceSystemId <> Src.SourceSystemId
					OR Tar.ActiveFlag <> Src.ActiveFlag
					OR Tar.ContactEmailAddress <> Src.ContactEMailAddress OR Tar.ContactEmailAddress IS NULL
					OR Tar.UserBK <> Src.UserBK OR Tar.UserBK IS NULL
					OR Tar.JobTitle <> Src.JobTitle OR Tar.JobTitle IS NULL
					OR Tar.EmploymentState <> Src.EmploymentState OR Tar.EmploymentState IS NULL
					OR Tar.EmployeeIdBK <> Src.EmployeeIdBK OR Tar.EmployeeIdBK IS NULL
					OR Tar.[BloombergID] <> Src.BBGID OR Tar.[BloombergID] IS NULL
					)
			THEN UPDATE SET DepartmentId = Src.DepartmentId
					, PersonsName = Src.PersonsName
					, ControlId = @ControlId
					, DepartmentHead = Src.DepartmentHead
					, SourceSystemId = Src.SourceSystemId
					, ActiveFlag = Src.ActiveFlag
					, ActiveFlagDateTime = CASE WHEN Tar.ActiveFlag = 1 AND Src.ActiveFlag = 0 THEN GetDate() ELSE ActiveFlagDateTime END
					, ContactEmailAddress = Src.ContactEMailAddress
					, UserBK = Src.UserBK
					, JobTitle = Src.JobTitle
					, EmploymentState = Src.EmploymentState
					, EmployeeIdBK = Src.EmployeeIdBK
					, [BloombergID] = Src.BBGID
		WHEN NOT MATCHED BY SOURCE
			THEN UPDATE SET ActiveFlag = 0
						, ActiveFlagDateTime = GetDate()
		OUTPUT $action, INSERTED.PersonId, INSERTED.ActiveFlag, DELETED.ActiveFlag
			INTO @RstTbl( RstAct, PersonId, IActiveFlag, DActiveFlag)
		;

		UPDATE rp
			SET rp.ActiveFlag = 0
			, rp.ActiveToDatetime = GETDATE()
			, rp.ControlId = @ControlId
			--OUTPUT INSERTED.RoleId, DELETED.RoleId, INSERTED.PersonId, DELETED.PersonId, INSERTED.ActiveFlag, DELETED.ActiveFlag
			--		, INSERTED.ActiveFromDatetime, DELETED.ActiveFromDatetime, INSERTED.ActiveToDatetime, DELETED.ActiveToDatetime
			FROM @RstTbl rt
				INNER JOIN Core.RolePersonRelationship rp
					ON rt.PersonId = rp.PersonId
			WHERE rt.iActiveFlag = 0
			AND rt.RstAct = 'INSERTED'
			;

	SET @InsertRowCount = @@ROWCOUNT;

	SELECT @ProcessRowCount AS ProcessRowCount
		, @InsertRowCount AS InsertRowCount
		, @UpdateRowCount AS UpdateRowCount
		, @DeleteRowCount AS DeleteRowCount
		;

	COMMIT;

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		IF @@TRANCOUNT > 0 ROLLBACK;

		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity 	-- Severity.
				, @ErrorState		-- State.
			  );
		Return @ErrorNumber;
END CATCH

