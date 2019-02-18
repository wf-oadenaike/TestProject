CREATE FUNCTION [wct].[OLCFACTORS]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @LastCoupon DATETIME NULL, @Rate FLOAT (53) NULL, @Price FLOAT (53) NULL, @Yield FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [A]             FLOAT (53) NULL,
        [DSC]           FLOAT (53) NULL,
        [E]             FLOAT (53) NULL,
        [N]             INT        NULL,
        [NCL]           INT        NULL,
        [A1]            FLOAT (53) NULL,
        [DSC1]          FLOAT (53) NULL,
        [DLC1]          FLOAT (53) NULL,
        [NLL1]          FLOAT (53) NULL,
        [A2]            FLOAT (53) NULL,
        [DSC2]          FLOAT (53) NULL,
        [DLC2]          FLOAT (53) NULL,
        [NLL2]          FLOAT (53) NULL,
        [quasicoup]     DATETIME   NULL,
        [quasimaturity] DATETIME   NULL,
        [C]             FLOAT (53) NULL,
        [LC]            FLOAT (53) NULL,
        [P]             FLOAT (53) NULL,
        [AI]            FLOAT (53) NULL,
        [Y]             FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[OLCFACTORS]

