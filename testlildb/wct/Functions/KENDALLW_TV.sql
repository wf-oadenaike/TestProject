CREATE FUNCTION [wct].[KENDALLW_TV]
(@InputData_RangeQuery NVARCHAR (MAX) NULL, @CorrectTies BIT NULL)
RETURNS 
     TABLE (
        [W]   FLOAT (53) NULL,
        [X]   FLOAT (53) NULL,
        [DF1] FLOAT (53) NULL,
        [P]   FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[KENDALLW_TV]

