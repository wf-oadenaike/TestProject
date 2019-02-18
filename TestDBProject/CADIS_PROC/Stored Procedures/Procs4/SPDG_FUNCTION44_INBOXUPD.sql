﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION44_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @PlacingRegisterId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @PlacingName VARCHAR (128), @PlacingName_UPDATE BIT, @PlacingStatus VARCHAR (128), @PlacingStatus_UPDATE BIT, @IsThisThroughABroker BIT, @IsThisThroughABroker_UPDATE BIT, @BrokerContactName VARCHAR (128), @BrokerContactName_UPDATE BIT, @BrokerSalesforceId VARCHAR (128), @BrokerSalesforceId_UPDATE BIT, @SubmitterPersonId SMALLINT, @SubmitterPersonId_UPDATE BIT, @ProjectLeadId SMALLINT, @ProjectLeadId_UPDATE BIT, @InitialAllocations VARCHAR (2048), @InitialAllocations_UPDATE BIT, @FundCode VARCHAR (16), @FundCode_UPDATE BIT, @SettlementType VARCHAR (25), @SettlementType_UPDATE BIT, @SettlementInstructions VARCHAR (MAX), @SettlementInstructions_UPDATE BIT, @SettlementDate DATETIME, @SettlementDate_UPDATE BIT, @TradeDate DATETIME, @TradeDate_UPDATE BIT, @EstimatedDate DATETIME, @EstimatedDate_UPDATE BIT, @ApprovalDate DATETIME, @ApprovalDate_UPDATE BIT, @PaymentMethod VARCHAR (128), @PaymentMethod_UPDATE BIT, @Ticker VARCHAR (20), @Ticker_UPDATE BIT, @IsStopRequiredYesNo BIT, @IsStopRequiredYesNo_UPDATE BIT, @AddedToStopListYesNo BIT, @AddedToStopListYesNo_UPDATE BIT, @DateStopped DATETIME, @DateStopped_UPDATE BIT, @IPOorPlacing VARCHAR (128), @IPOorPlacing_UPDATE BIT, @Notes VARCHAR (MAX), @Notes_UPDATE BIT, @JiraIssueKey VARCHAR (128), @JiraIssueKey_UPDATE BIT, @IrrevocableYesNo BIT, @IrrevocableYesNo_UPDATE BIT, @OperationsComments VARCHAR (MAX), @OperationsComments_UPDATE BIT, @DealDocumentationFolderLink VARCHAR (2000), @DealDocumentationFolderLink_UPDATE BIT, @AllocDocumentationFolderLink VARCHAR (2000), @AllocDocumentationFolderLink_UPDATE BIT, @AdditionalFolderLink VARCHAR (2000), @AdditionalFolderLink_UPDATE BIT, @RaiseAmount DECIMAL (18, 6), @RaiseAmount_UPDATE BIT, @Exchange VARCHAR (100), @Exchange_UPDATE BIT, @WestJiraTaskKey VARCHAR (20), @WestJiraTaskKey_UPDATE BIT, @PreMoneyRange VARCHAR (100), @PreMoneyRange_UPDATE BIT, @IsFCARegulated BIT, @IsFCARegulated_UPDATE BIT, @IsSRARegulated BIT, @IsSRARegulated_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @PlacingCreationDatetime DATETIME, @PlacingCreationDatetime_UPDATE BIT, @PlacingLastModifiedDatetime DATETIME, @PlacingLastModifiedDatetime_UPDATE BIT, @IsUnquoted BIT, @IsUnquoted_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


