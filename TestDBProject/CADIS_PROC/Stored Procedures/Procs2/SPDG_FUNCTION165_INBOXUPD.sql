﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION165_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @ApprovalId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @ApprovedByPersonId SMALLINT, @ApprovedByPersonId_UPDATE BIT, @ApprovalDate DATE, @ApprovalDate_UPDATE BIT, @ApproverComments NVARCHAR (MAX), @ApproverComments_UPDATE BIT, @Status VARCHAR (50), @Status_UPDATE BIT, @Summary NVARCHAR (MAX), @Summary_UPDATE BIT, @Description NVARCHAR (MAX), @Description_UPDATE BIT, @Category VARCHAR (50), @Category_UPDATE BIT, @SubCategory VARCHAR (50), @SubCategory_UPDATE BIT, @ChangeID INT, @ChangeID_UPDATE BIT, @SubmittedByPersonID SMALLINT, @SubmittedByPersonID_UPDATE BIT, @DepartmentId SMALLINT, @DepartmentId_UPDATE BIT, @ApprovalType VARCHAR (50), @ApprovalType_UPDATE BIT, @FlowId UNIQUEIDENTIFIER, @FlowId_UPDATE BIT, @JiraIssueKey VARCHAR (20), @JiraIssueKey_UPDATE BIT, @FinanceRequestId INT, @FinanceRequestId_UPDATE BIT, @SalesForceLeaveRequestId VARCHAR (20), @SalesForceLeaveRequestId_UPDATE BIT, @GTAIncidentId VARCHAR (50), @GTAIncidentId_UPDATE BIT, @JoinGUID1 UNIQUEIDENTIFIER, @JoinGUID1_UPDATE BIT, @JoinGUID2 UNIQUEIDENTIFIER, @JoinGUID2_UPDATE BIT, @ApprovalCreationDate DATETIME, @ApprovalCreationDate_UPDATE BIT, @ApprovalLastModifiedDate DATETIME, @ApprovalLastModifiedDate_UPDATE BIT, @VisitorAccessRequestID INT, @VisitorAccessRequestID_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


