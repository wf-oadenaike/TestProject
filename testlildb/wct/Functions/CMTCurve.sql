CREATE FUNCTION [wct].[CMTCurve]
(@Curve NVARCHAR (MAX) NULL, @InterpMethod NVARCHAR (4000) NULL, @Freq INT NULL)
RETURNS 
     TABLE (
        [T]         FLOAT (53) NULL,
        [r]         FLOAT (53) NULL,
        [df]        FLOAT (53) NULL,
        [spot]      FLOAT (53) NULL,
        [cczero]    FLOAT (53) NULL,
        [bootstrap] BIT        NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CMTCurve]

