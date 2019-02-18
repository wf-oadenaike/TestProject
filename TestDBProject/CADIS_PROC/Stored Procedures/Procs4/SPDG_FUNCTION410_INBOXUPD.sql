CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION410_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @Qtr CHAR (5), @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @OverrideNetIncome DECIMAL (28, 6), @OverrideNetIncome_UPDATE BIT, @OverrideUnitsInIssue DECIMAL (18, 4), @OverrideUnitsInIssue_UPDATE BIT, @OverrideDvdChangeReasonId INT, @OverrideDvdChangeReasonId_UPDATE BIT, @OverrideCommentary VARCHAR (MAX), @OverrideCommentary_UPDATE BIT, @SubmittedByPersonId SMALLINT, @SubmittedByPersonId_UPDATE BIT, @IsActive BIT, @IsActive_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @DvdNTCalcHighLevelOverrideLastModifiedDatetime DATETIME, @DvdNTCalcHighLevelOverrideLastModifiedDatetime_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


