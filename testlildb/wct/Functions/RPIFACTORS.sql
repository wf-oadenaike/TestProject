CREATE FUNCTION [wct].[RPIFACTORS]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Rate FLOAT (53) NULL, @Price FLOAT (53) NULL, @Yield FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [PrevCoup] DATETIME   NULL,
        [NextCoup] DATETIME   NULL,
        [A]        FLOAT (53) NULL,
        [DSC]      FLOAT (53) NULL,
        [E]        FLOAT (53) NULL,
        [N]        INT        NULL,
        [C]        FLOAT (53) NULL,
        [P]        FLOAT (53) NULL,
        [AI]       FLOAT (53) NULL,
        [Y]        FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RPIFACTORS]

