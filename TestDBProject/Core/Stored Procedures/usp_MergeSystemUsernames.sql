CREATE PROCEDURE [Core].[usp_MergeSystemUsernames]
		
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Core].[usp_MergeSystemUsernames]
-- 
-- Note:			
-- 
-- Author:			Faheem
-- Date:			17/11/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

BEGIN TRY

	SET NOCOUNT ON;


	BEGIN TRANSACTION

	DECLARE	@strProcedureName		VARCHAR(100)	= 'Core.usp_MergeSystemUsernames';



	Update Tar 
	Set Tar.Username=Src.Username from 
	[Core].[SystemUsernames] Tar join 
	 (

			Select p.PersonId,Systems.SourceSystemId,GTA_Customers.GTA_CustomerId as Username
			FROM Core.Persons p
			INNER JOIN [Staging].[GTA_Customers] 
			ON p.ContactEmailAddress =GTA_Customers.EMAIL
			CROSS JOIN Audit.SourceSystems Systems
			WHERE	 Systems.SourceSystemCode = 'GTA' --AND gta.SourceSystemId = GTAUser.SourceSystemId
			AND p.ActiveFlag = 1 AND GTA_Customers.GTA_CustomerId IS NOT NULL

			UNION

			Select p.PersonId,Systems.SourceSystemId,Slack.Slack_Username as Username
			FROM Core.Persons p
			INNER JOIN [Staging.Salesforce].[UserSrc] Slack
			ON p.ContactEmailAddress =Slack.EMAIL
			AND Slack.IsActive='true'
			CROSS JOIN Audit.SourceSystems Systems
			WHERE	 Systems.SourceSystemCode = 'SLCK' --AND gta.SourceSystemId = GTAUser.SourceSystemId
			AND p.ActiveFlag = 1  AND Slack.Slack_Username IS NOT NULL

			UNION
			Select p.PersonId,Systems.SourceSystemId,JIRA.Atlassian_Username as Username
			FROM Core.Persons p
			INNER JOIN [Staging.Salesforce].[UserSrc] JIRA
			ON p.ContactEmailAddress =JIRA.EMAIL AND JIRA.IsActive='true'
			CROSS JOIN Audit.SourceSystems Systems
			WHERE	 Systems.SourceSystemCode = 'JIRA' --AND gta.SourceSystemId = GTAUser.SourceSystemId
			AND p.ActiveFlag = 1 AND JIRA.Atlassian_Username IS NOT NULL
			) Src
	on 
	 Tar.SourceSystemId = Src.SourceSystemId
	 AND Tar.PersonId = Src.PersonId
	where Tar.Username<> Src.Username;

	
	
	
	
	Insert into  [Core].[SystemUsernames] (PersonID,SourceSystemID,Username)
	Select Src.* from 
	(
			Select p.PersonId,Systems.SourceSystemId,GTA_Customers.GTA_CustomerId as Username
			FROM Core.Persons p
			INNER JOIN [Staging].[GTA_Customers] 
			ON p.ContactEmailAddress =GTA_Customers.EMAIL
			CROSS JOIN Audit.SourceSystems Systems
			WHERE	 Systems.SourceSystemCode = 'GTA' --AND gta.SourceSystemId = GTAUser.SourceSystemId
			AND p.ActiveFlag = 1 AND GTA_Customers.GTA_CustomerId IS NOT NULL

			UNION

			Select p.PersonId,Systems.SourceSystemId,Slack.Slack_Username as Username
			FROM Core.Persons p
			INNER JOIN [Staging.Salesforce].[UserSrc] Slack
			ON p.ContactEmailAddress =Slack.EMAIL
			AND Slack.IsActive='true'
			CROSS JOIN Audit.SourceSystems Systems
			WHERE	 Systems.SourceSystemCode = 'SLCK' --AND gta.SourceSystemId = GTAUser.SourceSystemId
			AND p.ActiveFlag = 1  AND Slack.Slack_Username IS NOT NULL

			UNION
			Select p.PersonId,Systems.SourceSystemId,JIRA.Atlassian_Username as Username
			FROM Core.Persons p
			INNER JOIN [Staging.Salesforce].[UserSrc] JIRA
			ON p.ContactEmailAddress =JIRA.EMAIL AND JIRA.IsActive='true'
			CROSS JOIN Audit.SourceSystems Systems
			WHERE	 Systems.SourceSystemCode = 'JIRA' --AND gta.SourceSystemId = GTAUser.SourceSystemId
			AND p.ActiveFlag = 1 AND JIRA.Atlassian_Username IS NOT NULL
			) Src
  left join [Core].[SystemUsernames] Tar on
		Tar.Username = Src.Username
		AND Tar.SourceSystemId = Src.SourceSystemId
		AND Tar.PersonId = Src.PersonId
  Where Tar.PersonID is null;		 

					



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
