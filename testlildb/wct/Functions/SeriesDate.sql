CREATE FUNCTION [wct].[SeriesDate]
(@StartDate DATETIME NULL, @StopDate DATETIME NULL, @StepDays FLOAT (53) NULL, @MaxIterations FLOAT (53) NULL, @SeriesType NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [Seq]         INT      NULL,
        [SeriesValue] DATETIME NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[SeriesDate]

