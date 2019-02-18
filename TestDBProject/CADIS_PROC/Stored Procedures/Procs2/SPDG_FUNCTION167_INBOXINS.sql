﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION167_INBOXINS]
@CADIS_SYSTEM_INSERTED DATETIME, @CADIS_SYSTEM_INSERTED_UPDATE BIT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @RequestedByPersonId SMALLINT, @RequestedByPersonId_UPDATE BIT, @RequestDate DATE, @RequestDate_UPDATE BIT, @ApprovalDate DATE, @ApprovalDate_UPDATE BIT, @ApprovedByPersonId SMALLINT, @ApprovedByPersonId_UPDATE BIT, @DepartmentId SMALLINT, @DepartmentId_UPDATE BIT, @ReviewerPersonId SMALLINT, @ReviewerPersonId_UPDATE BIT, @Summary NVARCHAR (MAX), @Summary_UPDATE BIT, @Description NVARCHAR (MAX), @Description_UPDATE BIT, @Category VARCHAR (50), @Category_UPDATE BIT, @SubCategory VARCHAR (50), @SubCategory_UPDATE BIT, @Status VARCHAR (50), @Status_UPDATE BIT, @Amount DECIMAL (19, 2), @Amount_UPDATE BIT, @NewTechnologyYesNo BIT, @NewTechnologyYesNo_UPDATE BIT, @NewResourceYesNo BIT, @NewResourceYesNo_UPDATE BIT, @UrgentRequestYesNo BIT, @UrgentRequestYesNo_UPDATE BIT, @RequestType VARCHAR (50), @RequestType_UPDATE BIT, @NominalCode INT, @NominalCode_UPDATE BIT, @JiraEPICKey VARCHAR (128), @JiraEPICKey_UPDATE BIT, @WorkFlowLink VARCHAR (2000), @WorkFlowLink_UPDATE BIT, @SupplierSalesforceId VARCHAR (18), @SupplierSalesforceId_UPDATE BIT, @SupplierName VARCHAR (127), @SupplierName_UPDATE BIT, @Invoiced BIT, @Invoiced_UPDATE BIT, @UnquotedCompanyId INT, @UnquotedCompanyId_UPDATE BIT, @UnquotedDueDiligenceYesNo BIT, @UnquotedDueDiligenceYesNo_UPDATE BIT, @ResearchBrokerId INT, @ResearchBrokerId_UPDATE BIT, @BrokerResearchYesNo BIT, @BrokerResearchYesNo_UPDATE BIT, @CoveredByWoodfordYesNo BIT, @CoveredByWoodfordYesNo_UPDATE BIT, @FlowId UNIQUEIDENTIFIER, @FlowId_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @RequestCreationDate DATETIME, @RequestCreationDate_UPDATE BIT, @RequestLastModifiedDate DATETIME, @RequestLastModifiedDate_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


