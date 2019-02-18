CREATE FUNCTION [wct].[MCNEMAR_TV]
(@InputData_RangeQuery NVARCHAR (MAX) NULL, @Correct BIT NULL)
RETURNS 
     TABLE (
        [X] FLOAT (53) NULL,
        [P] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[MCNEMAR_TV]

