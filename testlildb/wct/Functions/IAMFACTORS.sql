CREATE FUNCTION [wct].[IAMFACTORS]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Issue DATETIME NULL, @Rate FLOAT (53) NULL, @Price FLOAT (53) NULL, @Yield FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [A]   FLOAT (53) NULL,
        [B]   FLOAT (53) NULL,
        [DIM] FLOAT (53) NULL,
        [DSM] FLOAT (53) NULL,
        [P]   FLOAT (53) NULL,
        [AI]  FLOAT (53) NULL,
        [Y]   FLOAT (53) NULL,
        [TI]  FLOAT (53) NULL,
        [DP]  FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[IAMFACTORS]

