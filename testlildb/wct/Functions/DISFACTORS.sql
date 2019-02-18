CREATE FUNCTION [wct].[DISFACTORS]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Redemption FLOAT (53) NULL, @DRate FLOAT (53) NULL, @Price FLOAT (53) NULL, @Yield FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [DSM] FLOAT (53) NULL,
        [B]   FLOAT (53) NULL,
        [P]   FLOAT (53) NULL,
        [D]   FLOAT (53) NULL,
        [Y]   FLOAT (53) NULL,
        [T]   FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[DISFACTORS]

