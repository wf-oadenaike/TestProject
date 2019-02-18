CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION98_INBOXINS]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @BudgetChangeId INT, @ResearchBrokerId INT, @ResearchBrokerId_UPDATE BIT, @PerformanceChange BIT, @PerformanceChange_UPDATE BIT, @ResourceChange BIT, @ResourceChange_UPDATE BIT, @SectorChange BIT, @SectorChange_UPDATE BIT, @BudgetChangeComments VARCHAR (MAX), @BudgetChangeComments_UPDATE BIT, @ChangeAmount DECIMAL (19, 2), @ChangeAmount_UPDATE BIT, @BudgetAmendmentDate DATETIME, @BudgetAmendmentDate_UPDATE BIT, @AmendedByPersonId SMALLINT, @AmendedByPersonId_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @BudgetChangeLastModifiedDatetime DATETIME, @BudgetChangeLastModifiedDatetime_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


