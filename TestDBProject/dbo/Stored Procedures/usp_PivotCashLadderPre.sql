CREATE PROCEDURE [dbo].[usp_PivotCashLadderPre] AS
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[usp_PivotCashLadderPre]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 15/11/2017 JIRA: DAP-1484 takes raw Cash Ladder Data from T_BBG_CASH_LADDER_PRE
--								pivots it and populates T_BBG_CASH_LADDER_PRE
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[dbo].[usp_PivotCashLadderPre]';
BEGIN TRANSACTION

DECLARE @Dates varchar(8000),
		@RowData varchar(8000),
		@FieldDate datetime,
		@FieldNum integer,
		@FundShortName varchar(10),
		@RowFundShortName varchar(10),
		@Currency varchar(5),
		@RowCurrency varchar(100),
		@FieldValue varchar(50),
		@FileName varchar(50),
		@FileDate varchar(20)

SELECT @dates = SUBSTRING(ROW_DATA,26, LEN(ROW_DATA) - 25)
FROM "dbo"."T_BBG_CASH_LADDER_PRE" WHERE CASH_LADDER_ID = 1

-- Put list of dates into temporary table
SELECT CAST(splitdata AS DATE) AS CASH_DATE, ROW_NUMBER() OVER (ORDER BY CAST(splitdata AS DATE) ASC) AS ROW_ID INTO #CashDates FROM dbo.ufnSplitString(@dates, ',')

-- Cursor to loop through rows in T_CASH_LADDER_PRE
DECLARE	ROW_CURSOR CURSOR
FOR		SELECT	[ROW_DATA], [FILE_NAME], [FILE_DATE]
		FROM	T_BBG_CASH_LADDER_PRE 
		WHERE	CASH_LADDER_ID <> 1
		ORDER	BY CASH_LADDER_ID ASC

OPEN	ROW_CURSOR

FETCH	NEXT FROM ROW_CURSOR
INTO	@RowData, @FileName, @FileDate

WHILE	@@FETCH_STATUS = 0 
BEGIN

		-- Get fund short name
		SET @RowFundShortName = substring(@RowData, 1, charindex(',',@RowData,0) - 1)
		IF LEN(@RowFundShortName) <> 0
		BEGIN
			SELECT	@FundShortName = @RowFundShortName
		END
				
		-- Get currency
		SET @RowCurrency = substring(
		(
		substring(@RowData,charindex(',',@RowData,0) + 1, len(@RowData) - charindex(',',@RowData,0))
		),
		1, 
		charindex(',',substring(@RowData,charindex(',',@RowData,0) + 1, len(@RowData) - charindex(',',@RowData,0))) - 1
		)
		IF LEN(@RowCurrency) <> 0
		BEGIN
			SELECT	@Currency = @RowCurrency
		END

		-- Strip Fund Name from row data		
		SET @RowData = substring(@RowData,charindex(',',@RowData,0) + 1,len(@RowData) - charindex(',',@RowData,0))
		-- Strip Currency from row data		
		SET @RowData = substring(@RowData,charindex(',',@RowData,0) + 1,len(@RowData) - charindex(',',@RowData,0))

		DECLARE	FIELD_CURSOR CURSOR
		FOR		SELECT	CASH_DATE, ROW_ID
				FROM	#CashDates
				ORDER	BY ROW_ID ASC

		OPEN	FIELD_CURSOR

		FETCH	NEXT FROM FIELD_CURSOR
		INTO	@FieldDate, @FieldNum

		WHILE	@@FETCH_STATUS = 0 
		BEGIN
				-- Get value for given Date
				IF charindex(',',@RowData,0) <> 0
				BEGIN
					SET @FieldValue = substring(@RowData, 1, charindex(',',@RowData,0) - 1)
					SET @RowData = substring(@RowData,charindex(',',@RowData,0) + 1,len(@RowData) - charindex(',',@RowData,0))
				END
				ELSE
				SET @FieldValue = @RowData

--				PRINT	@FundShortName 
--				PRINT	@Currency
--				PRINT	@FieldDate
--				PRINT	@FieldValue

				-- insert record into T_BBG_CASH_LADDER_UNTYPED
				INSERT	DBO.T_BBG_CASH_LADDER_UNTYPED
						([FILE_NAME],[FILE_DATE],[FUND_SHORT_NAME],[CCY],[AS_OF_DATE],[VALUE])
				VALUES	(@FileName, @FileDate, @FundShortName, @Currency, @FieldDate, @FieldValue)
				
				FETCH	NEXT FROM FIELD_CURSOR
				INTO	@FieldDate, @FieldNum
		END
		
		CLOSE	FIELD_CURSOR
		DEALLOCATE FIELD_CURSOR

		FETCH	NEXT FROM ROW_CURSOR
		INTO	@RowData, @FileName, @FileDate


END
CLOSE	ROW_CURSOR
DEALLOCATE ROW_CURSOR


DROP TABLE #CashDates

COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors


-- this secion can be enabled if you want the error to print on the screen
DECLARE
@ERROR_SEVERITY INT,
@ERROR_STATE INT,
@ERROR_NUMBER INT,
@ERROR_LINE INT,
@ERROR_MESSAGE NVARCHAR(4000);

SELECT
@ERROR_SEVERITY = ERROR_SEVERITY(),
@ERROR_STATE = ERROR_STATE(),
@ERROR_NUMBER = ERROR_NUMBER(),
@ERROR_LINE = ERROR_LINE(),
@ERROR_MESSAGE = @strProcedureName + ' - ' + ERROR_MESSAGE() ;
RAISERROR('Msg %d, Line %d, :%s',
@ERROR_SEVERITY,
@ERROR_STATE,
@ERROR_NUMBER,
@ERROR_LINE,
@ERROR_MESSAGE);

END CATCH

