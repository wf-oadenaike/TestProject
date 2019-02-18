CREATE FUNCTION [wct].[BONDAMORT]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Rate FLOAT (53) NULL, @FaceAmount FLOAT (53) NULL, @CleanPrice FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL, @IssueDate DATETIME NULL, @FirstInterestDate DATETIME NULL, @LastInterestDate DATETIME NULL, @Holidays NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [amort_date]     DATETIME   NULL,
        [dtm]            INT        NULL,
        [begin_book_val] FLOAT (53) NULL,
        [dly_coup]       FLOAT (53) NULL,
        [dly_eff_rate]   FLOAT (53) NULL,
        [dly_amort]      FLOAT (53) NULL,
        [end_book_val]   FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BONDAMORT]

