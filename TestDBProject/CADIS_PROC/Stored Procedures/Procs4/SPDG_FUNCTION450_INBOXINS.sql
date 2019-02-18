﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION450_INBOXINS]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @CADIS_SYSTEM_INSERTED DATETIME, @CADIS_SYSTEM_INSERTED_UPDATE BIT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @Qtr CHAR (5), @Qtr_UPDATE BIT, @SubmittedByPersonId SMALLINT, @SubmittedByPersonId_UPDATE BIT, @DvdRate DECIMAL (18, 6), @DvdRate_UPDATE BIT, @OverrideNetIncome DECIMAL (28, 6), @OverrideNetIncome_UPDATE BIT, @OverrideUnitsInIssue DECIMAL (18, 4), @OverrideUnitsInIssue_UPDATE BIT, @OverrideCommentary VARCHAR (MAX), @OverrideCommentary_UPDATE BIT, @OverrideDvdChangeReasonId INT, @OverrideDvdChangeReasonId_UPDATE BIT, @EventDate DATETIME, @EventDate_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @DvdNTHighLevelOverrideEventLastModifiedDatetime DATETIME, @DvdNTHighLevelOverrideEventLastModifiedDatetime_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


