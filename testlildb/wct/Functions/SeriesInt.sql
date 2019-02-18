CREATE FUNCTION [wct].[SeriesInt]
(@StartValue FLOAT (53) NULL, @StopValue FLOAT (53) NULL, @StepValue FLOAT (53) NULL, @MaxIterations FLOAT (53) NULL, @SeriesType NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [Seq]         INT NULL,
        [SeriesValue] INT NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[SeriesInt]

