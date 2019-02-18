CREATE FUNCTION [wct].[SimpleAccrual]
(@date_start DATETIME NULL, @date_end DATETIME NULL, @bal_start FLOAT (53) NULL, @Rate SQL_VARIANT NULL, @Spread SQL_VARIANT NULL, @CashMvMnt NVARCHAR (MAX) NULL, @Basis NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [aDate]    DATETIME   NULL,
        [Rate]     FLOAT (53) NULL,
        [Spread]   FLOAT (53) NULL,
        [BalBegin] FLOAT (53) NULL,
        [Movement] FLOAT (53) NULL,
        [BalEnd]   FLOAT (53) NULL,
        [Interest] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[SimpleAccrual]

