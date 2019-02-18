CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION487_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @EventId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @EventSummary NVARCHAR (MAX), @EventSummary_UPDATE BIT, @EventDate DATETIME, @EventDate_UPDATE BIT, @DateIdentified DATETIME, @DateIdentified_UPDATE BIT, @ReportedDate DATETIME, @ReportedDate_UPDATE BIT, @JIRAKey NVARCHAR (50), @JIRAKey_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @SlackChannel NVARCHAR (21), @SlackChannel_UPDATE BIT, @RecordedByPersonId SMALLINT, @RecordedByPersonId_UPDATE BIT, @ReportedByPersonId SMALLINT, @ReportedByPersonId_UPDATE BIT, @EventName VARCHAR (100), @EventName_UPDATE BIT, @SubCategoryID SMALLINT, @SubCategoryID_UPDATE BIT, @PotentialLoss DECIMAL (18, 6), @PotentialLoss_UPDATE BIT, @IsActive BIT, @IsActive_UPDATE BIT, @WorstCaseScenario VARCHAR (MAX), @WorstCaseScenario_UPDATE BIT, @EventOwnerPersonId SMALLINT, @EventOwnerPersonId_UPDATE BIT, @ActualEvent BIT, @ActualEvent_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


