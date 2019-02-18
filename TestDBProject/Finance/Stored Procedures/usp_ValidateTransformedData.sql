CREATE PROCEDURE [Finance].[usp_ValidateTransformedData]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Finance.usp_ValidateTransformedData
-- 
-- Note:			
-- 
-- Author:			K Wu
-- Date:			07/08/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 
DECLARE @errorTable TABLE(
    ErrorMessage varchar(2048) NOT NULL,
	SourceValue VARCHAR(2048) NULL,
	TargetValue VARCHAR(2048) NULL
);

DECLARE @MinDate DATETIME
DECLARE @MaxDate DATETIME

SELECT @MinDate = MIN(CONVERT(DATETIME, SUBSTRING(s.[DATE], 25,4) + ' ' + SUBSTRING(s.[DATE], 5,3) + ' ' + SUBSTRING(s.[DATE], 9, 2), 103)) FROM [Staging].[GL_LLP] s
SELECT @MaxDate =  MAX(CONVERT(DATETIME,SUBSTRING(s.[DATE], 25,4) + ' ' + SUBSTRING(s.[DATE], 5,3) + ' ' + SUBSTRING(s.[DATE], 9, 2), 103)) FROM [Staging].[GL_LLP] s

-- Check if rows in the source table is the same as the target table
DECLARE @srcCount INT
DECLARE @tarCount INT
SELECT @srcCount = COUNT(*) FROM [Staging].[GL_LLP] WHERE [TRAN_NUMBER] IS NOT NULL
SELECT @tarCount = COUNT(*) FROM [Finance].[OriginalFileVw] WHERE CONVERT(DATETIME, FullDateUK, 103) >= @MinDate AND CONVERT(DATETIME, FullDateUK, 103) <= @MaxDate

IF (@srcCount <> @tarCount)
BEGIN
	INSERT INTO @errorTable (ErrorMessage, SourceValue, TargetValue)
	SELECT 'Total row count is different', CONVERT(VARCHAR(16), @srcCount), CONVERT(VARCHAR(16), @tarCount) 
END

-- Check if totals are the same
DECLARE @srcTotal MONEY
DECLARE @tarTotal MONEY
SELECT @srcTotal = SUM(CONVERT(MONEY, [Amount])) FROM [Staging].[GL_LLP] WHERE ISNUMERIC([Amount]) = 1
SELECT @tarTotal = SUM(CONVERT(MONEY, [ActualAmount])) FROM [Finance].[OriginalFileVw] WHERE CONVERT(DATETIME, FullDateUK, 103) >= @MinDate AND CONVERT(DATETIME, FullDateUK, 103) <= @MaxDate

IF (@srcTotal <> @tarTotal)
BEGIN
	INSERT INTO @errorTable (ErrorMessage, SourceValue, TargetValue)
	SELECT 'Sum of total is different', CONVERT(VARCHAR(16), @srcTotal), CONVERT(VARCHAR(16), @tarTotal) 
END

-- Check if totals are the same
DECLARE @srcAbs MONEY
DECLARE @tarAbs MONEY
SELECT @srcAbs = SUM(ABS(CONVERT(MONEY, [Amount]))) FROM [Staging].[GL_LLP] WHERE ISNUMERIC([Amount]) = 1
SELECT @tarAbs = SUM(ABS(CONVERT(MONEY, [ActualAmount]))) FROM [Finance].[OriginalFileVw] WHERE CONVERT(DATETIME, FullDateUK, 103) >= @MinDate AND CONVERT(DATETIME, FullDateUK, 103) <= @MaxDate

IF (@srcAbs <> @tarAbs)
BEGIN
	INSERT INTO @errorTable (ErrorMessage, SourceValue, TargetValue)
	SELECT 'Sum of absolute total is different', CONVERT(VARCHAR(16), @srcAbs), CONVERT(VARCHAR(16), @tarAbs) 
END

-- Check total rows per department
;WITH SRC_CTE
AS
(
	SELECT
		ROUND(DEPT_NUMBER,0) AS Department
		,COUNT(*) AS Total
	FROM 
		[Staging].[GL_LLP]
	GROUP BY
		DEPT_NUMBER
)
, TAR_CTE
AS
(
	SELECT
		DepartmentNumber AS Department
		,COUNT(*) AS Total
	FROM 
		 [Finance].[OriginalFileVw] WHERE CONVERT(DATETIME, FullDateUK, 103) >= @MinDate AND CONVERT(DATETIME, FullDateUK, 103) <= @MaxDate
	GROUP BY
		DepartmentNumber
)
INSERT INTO @errorTable (ErrorMessage, SourceValue, TargetValue)
SELECT 'Department ' + CONVERT(VARCHAR(15), Src.Department) + ' has a different row count.', CONVERT(VARCHAR(15), src.Total), CONVERT(VARCHAR(15), tar.Total) FROM SRC_CTE src FULL OUTER JOIN TAR_CTE tar ON tar.Department = src.Department
WHERE src.Total <> tar.Total

/*
-- Check total rows per category
;WITH SRC_CTE
AS
(
	SELECT
		[ACCOUNT CATEGORY] AS Label
		,COUNT(*) AS Total
	FROM 
		[Staging].[GL_LLP]
	GROUP BY
		[ACCOUNT CATEGORY]
)
, TAR_CTE
AS
(
	SELECT
		[Account Category] AS Label
		,COUNT(*) AS Total
	FROM 
		 [Finance].[OriginalFileVw] WHERE CONVERT(DATETIME, FullDateUK, 103) >= @MinDate AND CONVERT(DATETIME, FullDateUK, 103) <= @MaxDate
	GROUP BY
		[Account Category]
)
INSERT INTO @errorTable (ErrorMessage, SourceValue, TargetValue)
SELECT 'Account category ' + CONVERT(VARCHAR(256), Src.Label) + ' has a different row count.', CONVERT(VARCHAR(15), src.Total), CONVERT(VARCHAR(15), tar.Total) FROM SRC_CTE src FULL OUTER JOIN TAR_CTE tar ON tar.Label = src.Label
WHERE src.Total <> tar.Total

-- Check total rows per account name
;WITH SRC_CTE
AS
(
	SELECT
		[F20] AS Label
		,COUNT(*) AS Total
	FROM 
		[Staging].[GL_LLP]
	GROUP BY
		[F20]
)
, TAR_CTE
AS
(
	SELECT
		[F20] AS Label
		,COUNT(*) AS Total
	FROM 
		 [Finance].[OriginalFileVw] WHERE CONVERT(DATETIME, FullDateUK, 103) >= @MinDate AND CONVERT(DATETIME, FullDateUK, 103) <= @MaxDate
	GROUP BY
		[F20]
)
INSERT INTO @errorTable (ErrorMessage, SourceValue, TargetValue)
SELECT 'Account name ' + CONVERT(VARCHAR(256), Src.Label) + ' has a different row count.', CONVERT(VARCHAR(15), src.Total), CONVERT(VARCHAR(15), tar.Total) FROM SRC_CTE src FULL OUTER JOIN TAR_CTE tar ON tar.Label = src.Label
WHERE src.Total <> tar.Total
*/
-- Check total rows per Nominal Code
;WITH SRC_CTE
AS
(
	SELECT
		[NOMINAL_CODE] AS Label
		,COUNT(*) AS Total
	FROM 
		[Staging].[GL_LLP]
	GROUP BY
		[NOMINAL_CODE]
)
, TAR_CTE
AS
(
	SELECT
		[NOMINALCODE] AS Label
		,COUNT(*) AS Total
	FROM 
		 [Finance].[OriginalFileVw] WHERE CONVERT(DATETIME, FullDateUK, 103) >= @MinDate AND CONVERT(DATETIME, FullDateUK, 103) <= @MaxDate
	GROUP BY
		[NOMINALCODE]
)
INSERT INTO @errorTable (ErrorMessage, SourceValue, TargetValue)
SELECT 'Nominal code ' + CONVERT(VARCHAR(256), Src.Label) + ' has a different row count.', CONVERT(VARCHAR(15), src.Total), CONVERT(VARCHAR(15), tar.Total) FROM SRC_CTE src FULL OUTER JOIN TAR_CTE tar ON tar.Label = src.Label
WHERE src.Total <> tar.Total


-- OUTPUT the results
SELECT * FROM @errorTable
