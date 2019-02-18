CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION409_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @DvdForecastCalcOverrideId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @EDM_SEC_ID INT, @EDM_SEC_ID_UPDATE BIT, @SECURITY_NAME VARCHAR (100), @SECURITY_NAME_UPDATE BIT, @Qtr CHAR (5), @Qtr_UPDATE BIT, @OverrideExDate DATE, @OverrideExDate_UPDATE BIT, @OverrideDvdValue DECIMAL (18, 6), @OverrideDvdValue_UPDATE BIT, @OverrideSpecialCumShares DECIMAL (15, 2), @OverrideSpecialCumShares_UPDATE BIT, @TotalNetDvd DECIMAL (28, 6), @TotalNetDvd_UPDATE BIT, @NTCustodyCommentary VARCHAR (MAX), @NTCustodyCommentary_UPDATE BIT, @NTCustodyDvdChangeReasonId INT, @NTCustodyDvdChangeReasonId_UPDATE BIT, @UseNTCustodyValue VARCHAR (10), @UseNTCustodyValue_UPDATE BIT, @NTFACommentary VARCHAR (MAX), @NTFACommentary_UPDATE BIT, @UseNTFAValue VARCHAR (10), @UseNTFAValue_UPDATE BIT, @SubmittedByPersonId SMALLINT, @SubmittedByPersonId_UPDATE BIT, @OverrideDvdChangeReasonId INT, @OverrideDvdChangeReasonId_UPDATE BIT, @OverrideCommentary VARCHAR (MAX), @OverrideCommentary_UPDATE BIT, @IsActive BIT, @IsActive_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @DvdForecastCalcOverrideLastModifiedDatetime DATETIME, @DvdForecastCalcOverrideLastModifiedDatetime_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


