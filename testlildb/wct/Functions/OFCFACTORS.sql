CREATE FUNCTION [wct].[OFCFACTORS]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Issue DATETIME NULL, @FirstCoupon DATETIME NULL, @Rate FLOAT (53) NULL, @Price FLOAT (53) NULL, @Yield FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [E]          FLOAT (53) NULL,
        [DSC]        FLOAT (53) NULL,
        [N]          INT        NULL,
        [NCF]        INT        NULL,
        [A1]         FLOAT (53) NULL,
        [DFC1]       FLOAT (53) NULL,
        [NLF1]       FLOAT (53) NULL,
        [A2]         FLOAT (53) NULL,
        [DFC2]       FLOAT (53) NULL,
        [NLF2]       FLOAT (53) NULL,
        [Nqf]        FLOAT (53) NULL,
        [quasistart] DATETIME   NULL,
        [quasicoup]  DATETIME   NULL,
        [C]          FLOAT (53) NULL,
        [FC]         FLOAT (53) NULL,
        [P]          FLOAT (53) NULL,
        [AI]         FLOAT (53) NULL,
        [Y]          FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[OFCFACTORS]

