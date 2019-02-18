CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION14_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @PADealingRequestRegisterId INT, @RequestorPersonId SMALLINT, @RequestorPersonId_UPDATE BIT, @RequestorRoleId SMALLINT, @RequestorRoleId_UPDATE BIT, @RequestedDate DATETIME, @RequestedDate_UPDATE BIT, @PADealingRequestStatus VARCHAR (128), @PADealingRequestStatus_UPDATE BIT, @OnStopList BIT, @OnStopList_UPDATE BIT, @InvestmentName VARCHAR (128), @InvestmentName_UPDATE BIT, @InvestmentType VARCHAR (50), @InvestmentType_UPDATE BIT, @PADealingTransactionTypeBK VARCHAR (25), @PADealingTransactionTypeBK_UPDATE BIT, @WoodfordInvestmentYesNo BIT, @WoodfordInvestmentYesNo_UPDATE BIT, @Value DECIMAL (19, 2), @Value_UPDATE BIT, @EmployeeComments VARCHAR (2048), @EmployeeComments_UPDATE BIT, @ComplianceComments VARCHAR (2048), @ComplianceComments_UPDATE BIT, @ComplianceDecisionDate DATETIME, @ComplianceDecisionDate_UPDATE BIT, @CompliancePersonId SMALLINT, @CompliancePersonId_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @WorkflowVersionGUID UNIQUEIDENTIFIER, @WorkflowVersionGUID_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @PADealingRequestCreationDatetime DATETIME, @PADealingRequestCreationDatetime_UPDATE BIT, @PADealingRequestLastModifiedDatetime DATETIME, @PADealingRequestLastModifiedDatetime_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


