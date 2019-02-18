CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION415_INBOXINS]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @CADIS_SYSTEM_INSERTED DATETIME, @CADIS_SYSTEM_INSERTED_UPDATE BIT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @DepartmentId SMALLINT, @DepartmentId_UPDATE BIT, @BudgetOwnerPersonId SMALLINT, @BudgetOwnerPersonId_UPDATE BIT, @FinancialYear VARCHAR (25), @FinancialYear_UPDATE BIT, @BudgetSubmittedDate DATE, @BudgetSubmittedDate_UPDATE BIT, @BudgetApproved BIT, @BudgetApproved_UPDATE BIT, @BudgetStatus VARCHAR (25), @BudgetStatus_UPDATE BIT, @DiscrBudgetSummary VARCHAR (MAX), @DiscrBudgetSummary_UPDATE BIT, @DiscrEstimatedBudgetImpact BIGINT, @DiscrEstimatedBudgetImpact_UPDATE BIT, @DiscrBudgetImpactExceeds500K BIT, @DiscrBudgetImpactExceeds500K_UPDATE BIT, @DiscrJIRAEpicKey VARCHAR (2000), @DiscrJIRAEpicKey_UPDATE BIT, @DiscrReviewerComments VARCHAR (MAX), @DiscrReviewerComments_UPDATE BIT, @NonDiscrBudgetSummary VARCHAR (MAX), @NonDiscrBudgetSummary_UPDATE BIT, @NonDiscrEstimatedBudgetImpact BIGINT, @NonDiscrEstimatedBudgetImpact_UPDATE BIT, @NonDiscrBudgetImpactExceeds500K BIT, @NonDiscrBudgetImpactExceeds500K_UPDATE BIT, @NonDiscrJIRAEpicKey VARCHAR (2000), @NonDiscrJIRAEpicKey_UPDATE BIT, @NonDiscrReviewerComments VARCHAR (MAX), @NonDiscrReviewerComments_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @SubflowJoinURL VARCHAR (2000), @SubflowJoinURL_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @AnnualBudgetLastModifiedDatetime DATETIME, @AnnualBudgetLastModifiedDatetime_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


