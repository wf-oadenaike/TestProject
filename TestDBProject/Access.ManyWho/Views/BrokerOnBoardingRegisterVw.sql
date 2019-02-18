CREATE VIEW [Access.ManyWho].[BrokerOnBoardingRegisterVw]
	AS
	SELECT 
		  br.BrokerOnBoardingRegisterId
		, br.ContactName
		, br.ContactSalesforceIdBK
		, br.ExecutionAccountSalesforceId
	    , br.BrokerCompanyName
		, br.ContactEmailAddress
		, br.BrokerOnBoardingDetails
	    , br.ProposerPersonId
		, p.PersonsName AS ProposerPersonName
		, br.BrokerOnBoardingStatus
	    , br.OneTimeUse
		, br.ProposalDate
		, br.ApprovalDate
		, br.BERCMeetingRegisterId
	    , br.BERCMeetingDateTime
		, br.MeetingJIRAEpicKey
		, br.BloombergId
		, br.MasterBloombergId
		, br.BrokerServiceTypeId
	    , br.JIRAEpicKey
		, br.NewBrokerJIRAIssueKey
		, br.NewMasterBroker
		, br.DocumentationFolderLink
		, br.WorkflowVersionGUID
		, br.JoinGUID
	    , br.BrokerOnBoardingCreationDatetime
		, br.BrokerOnBoardingLastModifiedDatetime
		, br.ExpectedDateUse
		, br.RelationshipOwnerId
		, pp.PersonsName AS RelationshipOwnerName
	FROM Organisation.BrokerOnBoardingRegister br
	LEFT OUTER JOIN Core.Persons p
		ON br.ProposerPersonId = p.PersonId
		AND p.ActiveFlag = 1
	LEFT OUTER JOIN Core.Persons pp
		ON br.RelationshipOwnerId = pp.PersonId
		AND pp.ActiveFlag = 1
	;

GO
CREATE TRIGGER [Access.ManyWho].[BrokerOnBoardingRegisterTri]
ON [Access.ManyWho].[BrokerOnBoardingRegisterVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	Declare	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[BrokerOnBoardingRegisterTri]';

	MERGE INTO Organisation.BrokerOnBoardingRegister Tar
		USING (
				SELECT 
				    i.BrokerOnBoardingRegisterId
				   ,i.ContactName
				   ,i.ContactSalesforceIdBK
				   ,i.ExecutionAccountSalesforceId
				   ,i.BrokerCompanyName
				   ,i.ContactEmailAddress
				   ,i.BrokerOnBoardingDetails
				   ,COALESCE( i.ProposerPersonId, p.PersonId, -1) AS ProposerPersonId
				   ,i.BrokerOnBoardingStatus
				   ,i.OneTimeUse
				   ,i.ProposalDate
				   ,i.ApprovalDate
				   ,i.MeetingJIRAEpicKey
				   ,i.BERCMeetingRegisterId
				   ,i.BERCMeetingDateTime
				   ,i.BloombergId
				   ,i.MasterBloombergId
				   ,i.BrokerServiceTypeId
				   ,i.JIRAEpicKey
				   ,i.NewBrokerJIRAIssueKey
				   ,i.NewMasterBroker
				   ,i.DocumentationFolderLink
				   ,i.WorkflowVersionGUID
				   ,i.JoinGUID
				   ,GetDate() AS BrokerOnBoardingCreationDatetime
				   ,GetDate() AS BrokerOnBoardingLastModifiedDatetime
				   ,i.ExpectedDateUse
				   ,ISNULL(i.RelationshipOwnerId,-1) AS RelationshipOwnerId
				FROM inserted i
				LEFT OUTER JOIN Core.Persons p
				ON i.ProposerPersonId = p.PersonId
				AND p.ActiveFlag = 1
				) Src
		ON Tar.BrokerOnBoardingRegisterId = Src.BrokerOnBoardingRegisterId
		WHEN NOT MATCHED 
			THEN INSERT ([ContactName]
						,[ContactSalesforceIdBK]
						,[ExecutionAccountSalesforceId]
						,[BrokerCompanyName]
						,[ContactEmailAddress]
						,[BrokerOnBoardingDetails]
						,[ProposerPersonId]
						,[BrokerOnBoardingStatus]
						,[OneTimeUse]
						,[ProposalDate]
						,[ApprovalDate]
						,[MeetingJIRAEpicKey]
						,[BERCMeetingRegisterId]
						,[BERCMeetingDateTime]
						,[BloombergId]
						,[MasterBloombergId]
						,[BrokerServiceTypeId]
						,[JIRAEpicKey]
						,[NewBrokerJIRAIssueKey]
				        ,[NewMasterBroker]
						,[DocumentationFolderLink]
						,[WorkflowVersionGUID]
						,[JoinGUID]
						,[BrokerOnBoardingCreationDatetime]
						,[BrokerOnBoardingLastModifiedDatetime]
						, ExpectedDateUse
						, RelationshipOwnerId
						)
				VALUES (    SRC.ContactName
						   ,SRC.ContactSalesforceIdBK
						   ,SRC.ExecutionAccountSalesforceId
						   ,SRC.BrokerCompanyName
						   ,SRC.ContactEmailAddress
						   ,SRC.BrokerOnBoardingDetails
						   ,SRC.ProposerPersonId
						   ,'Initial Setup'--SRC.BrokerOnBoardingStatus
						   ,SRC.OneTimeUse
						   ,SRC.ProposalDate
						   ,SRC.ApprovalDate
						   ,SRC.MeetingJIRAEpicKey
						   ,SRC.BERCMeetingRegisterId
						   ,SRC.BERCMeetingDateTime
						   ,SRC.BloombergId
						   ,SRC.MasterBloombergId
						   ,SRC.BrokerServiceTypeId
						   ,SRC.JIRAEpicKey
						   ,SRC.NewBrokerJIRAIssueKey
						   ,SRC.NewMasterBroker
						   ,SRC.DocumentationFolderLink
						   ,SRC.WorkflowVersionGUID
						   ,SRC.JoinGUID
						   ,SRC.BrokerOnBoardingCreationDatetime
						   ,SRC.BrokerOnBoardingLastModifiedDatetime
						   ,SRC.ExpectedDateUse
						   ,SRC.RelationshipOwnerId
						)
		WHEN MATCHED AND (   (Tar.ContactName IS NULL AND Src.ContactName IS NOT NULL)
		                    OR (Tar.ContactName IS NOT NULL AND Src.ContactName IS NULL)
							OR Tar.ContactName <> Src.ContactName
							OR (Tar.ContactSalesforceIdBK IS NULL AND Src.ContactSalesforceIdBK IS NOT NULL)
		                    OR (Tar.ContactSalesforceIdBK IS NOT NULL AND Src.ContactSalesforceIdBK IS NULL)
							OR Tar.ContactSalesforceIdBK <> Src.ContactSalesforceIdBK
							OR Tar.BrokerCompanyName <> Src.BrokerCompanyName
							OR (Tar.ExecutionAccountSalesforceId IS NULL AND Src.ExecutionAccountSalesforceId IS NOT NULL)
		                    OR (Tar.ExecutionAccountSalesforceId IS NOT NULL AND Src.ExecutionAccountSalesforceId IS NULL)
							OR Tar.ExecutionAccountSalesforceId <> Src.ExecutionAccountSalesforceId		
							OR (Tar.ContactEmailAddress IS NULL AND Src.ContactEmailAddress IS NOT NULL)
		                    OR (Tar.ContactEmailAddress IS NOT NULL AND Src.ContactEmailAddress IS NULL)							
							OR Tar.ContactEmailAddress <> Src.ContactEmailAddress
							OR (Tar.BrokerOnBoardingDetails IS NULL AND Src.BrokerOnBoardingDetails IS NOT NULL)
		                    OR (Tar.BrokerOnBoardingDetails IS NOT NULL AND Src.BrokerOnBoardingDetails IS NULL)	
							OR Tar.BrokerOnBoardingDetails <> Src.BrokerOnBoardingDetails
							OR Tar.ProposerPersonId <> Src.ProposerPersonId
							OR Tar.BrokerOnBoardingStatus <> Src.BrokerOnBoardingStatus
							OR Tar.OneTimeUse <> Src.OneTimeUse
							OR (Tar.ProposalDate IS NULL AND Src.ProposalDate IS NOT NULL)
		                    OR (Tar.ProposalDate IS NOT NULL AND Src.ProposalDate IS NULL)
							OR Tar.ProposalDate <> Src.ProposalDate
							OR (Tar.ApprovalDate IS NULL AND Src.ApprovalDate IS NOT NULL)
		                    OR (Tar.ApprovalDate IS NOT NULL AND Src.ApprovalDate IS NULL)
							OR Tar.ApprovalDate <> Src.ApprovalDate
							OR (Tar.MeetingJIRAEpicKey IS NULL AND Src.MeetingJIRAEpicKey IS NOT NULL)
		                    OR (Tar.MeetingJIRAEpicKey IS NOT NULL AND Src.MeetingJIRAEpicKey IS NULL)						
							OR Tar.MeetingJIRAEpicKey <> Src.MeetingJIRAEpicKey
							OR (Tar.BERCMeetingRegisterId IS NULL AND Src.BERCMeetingRegisterId IS NOT NULL)
		                    OR (Tar.BERCMeetingRegisterId IS NOT NULL AND Src.BERCMeetingRegisterId IS NULL)							
							OR Tar.BERCMeetingRegisterId <> Src.BERCMeetingRegisterId
							OR (Tar.BERCMeetingDateTime IS NULL AND Src.BERCMeetingDateTime IS NOT NULL)
		                    OR (Tar.BERCMeetingDateTime IS NOT NULL AND Src.BERCMeetingDateTime IS NULL)
							OR Tar.BERCMeetingDateTime <> Src.BERCMeetingDateTime
							OR (Tar.Bloombergid IS NULL AND Src.Bloombergid IS NOT NULL)
		                    OR (Tar.Bloombergid IS NOT NULL AND Src.Bloombergid IS NULL)							
							OR Tar.Bloombergid <> Src.Bloombergid
							OR (Tar.MasterBloombergid IS NULL AND Src.MasterBloombergid IS NOT NULL)
		                    OR (Tar.MasterBloombergid IS NOT NULL AND Src.MasterBloombergid IS NULL)
							OR Tar.MasterBloombergid <> Src.MasterBloombergid
							OR (Tar.BrokerServiceTypeid IS NULL AND Src.BrokerServiceTypeid IS NOT NULL)
		                    OR (Tar.BrokerServiceTypeid IS NOT NULL AND Src.BrokerServiceTypeid IS NULL)							
							OR Tar.BrokerServiceTypeid <> Src.BrokerServiceTypeid	
							OR (Tar.JIRAEpicKey IS NULL AND Src.JIRAEpicKey IS NOT NULL)
		                    OR (Tar.JIRAEpicKey IS NOT NULL AND Src.JIRAEpicKey IS NULL)							
							OR Tar.JIRAEpicKey <> Src.JIRAEpicKey
							OR (Tar.DocumentationFolderLink IS NULL AND Src.DocumentationFolderLink IS NOT NULL)
		                    OR (Tar.DocumentationFolderLink IS NOT NULL AND Src.DocumentationFolderLink IS NULL)							
							OR Tar.DocumentationFolderLink <> Src.DocumentationFolderLink
							OR Tar.JoinGUID <> Src.JoinGUID
							OR (Tar.ExpectedDateUse IS NULL AND Src.ExpectedDateUse IS NOT NULL)
		                    OR (Tar.ExpectedDateUse IS NOT NULL AND Src.ExpectedDateUse IS NULL)							
							OR Tar.ExpectedDateUse <> Src.ExpectedDateUse
							OR (Tar.RelationshipOwnerId IS NULL AND Src.RelationshipOwnerId IS NOT NULL)
		                    OR (Tar.RelationshipOwnerId IS NOT NULL AND Src.RelationshipOwnerId IS NULL)						
							OR Tar.RelationshipOwnerId <> Src.RelationshipOwnerId
							OR (Tar.NewBrokerJIRAIssueKey IS NULL AND Src.NewBrokerJIRAIssueKey IS NOT NULL)
		                    OR (Tar.NewBrokerJIRAIssueKey IS NOT NULL AND Src.NewBrokerJIRAIssueKey IS NULL)						
							OR Tar.NewBrokerJIRAIssueKey <> Src.NewBrokerJIRAIssueKey
						    OR (Tar.NewMasterBroker IS NULL AND Src.NewMasterBroker IS NOT NULL)
		                    OR (Tar.NewMasterBroker IS NOT NULL AND Src.NewMasterBroker IS NULL)						
							OR Tar.NewMasterBroker <> Src.NewMasterBroker
							)
			THEN UPDATE SET
						 	 Tar.ContactName = Src.ContactName
							,Tar.ContactSalesforceIdBK = Src.ContactSalesforceIdBK
							,Tar.ExecutionAccountSalesforceId = Src.ExecutionAccountSalesforceId
							,Tar.BrokerCompanyName = Src.BrokerCompanyName
							,Tar.ContactEmailAddress = Src.ContactEmailAddress
							,Tar.BrokerOnBoardingDetails = Src.BrokerOnBoardingDetails
							,Tar.ProposerPersonId = Src.ProposerPersonId
							,Tar.BrokerOnBoardingStatus = Src.BrokerOnBoardingStatus
							,Tar.OneTimeUse = Src.OneTimeUse
							,Tar.ProposalDate = Src.ProposalDate
							,Tar.ApprovalDate = Src.ApprovalDate
							,Tar.MeetingJIRAEpicKey = Src.MeetingJIRAEpicKey
							,Tar.BERCMeetingRegisterId = Src.BERCMeetingRegisterId
							,Tar.BERCMeetingDateTime = Src.BERCMeetingDateTime
							,Tar.BloombergId = Src.BloombergId
							,Tar.MasterBloombergId = Src.MasterBloombergId
							,Tar.BrokerServiceTypeId = Src.BrokerServiceTypeId
							,Tar.JIRAEpicKey = Src.JIRAEpicKey
							,Tar.NewBrokerJIRAIssueKey = Src.NewBrokerJIRAIssueKey
							,Tar.NewMasterBroker = Src.NewMasterBroker
							,Tar.DocumentationFolderLink = Src.DocumentationFolderLink
							,Tar.JoinGUID = Src.JoinGUID
							,Tar.ExpectedDateUse = Src.ExpectedDateUse
							,Tar.RelationshipOwnerId = Src.RelationshipOwnerId
							,Tar.BrokerOnBoardingLastModifiedDatetime = Src.BrokerOnBoardingLastModifiedDatetime
			;
END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strTriggerName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
END CATCH
;
