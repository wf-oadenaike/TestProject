CREATE PROCEDURE [dbo].[usp_PivotCashLadder] AS
-------------------------------------------------------------------------------------- 
-- Name:			[dbo].[usp_PivotCashLadder]
-- 
-- Params:			
-- 
-------------------------------------------------------------------------------------- 
-- History:			

-- WHO				WHEN				WHY
-- D.Bacchus:		01/02/2017			JIRA: DAP-1032 based on code provided by D. Fanning
--
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE	@strProcedureName		VARCHAR(100)	= '[dbo].[usp_PivotCashLadder]';

	BEGIN TRANSACTION

	-- ****** START Logic goes here, bear in mind the size of the transnaction, there may be reason to have several transactions.


		DECLARE @tmpCashDates TABLE
		(
			xDate DATETIME NULL, 
			Idx INTEGER NULL, 
			[Name] [varchar](50) NULL
		);

		DECLARE @tmpInScopeCashDates TABLE
		(
			xDate DATETIME NULL, 
			Idx INTEGER NULL, 
			[Name] [varchar](50) NULL
		);


		--// For the T_CASH_LADDER_STAGE_STORE table, get the all date columns, these are in ascending order.
		insert into @tmpCashDates (xDate, Idx, [Name])
		select convert(date, column_name) as xDate, convert(integer, ORDINAL_POSITION) as idx, column_name -- into #tmp
		from information_schema.columns
		where TABLE_NAME = 'T_CASH_LADDER_STAGE_STORE'
		and isdate(column_name) = 1


		--// Get replace 2nd with 1st lines below for PROD.
		declare @Date datetime
		SET @Date = convert(date, ISNULL(@Date, GetDate()))



		--// For the target date T (in PROD current date), get T-6 to T+6 range of dates.
		--// The date range should be wide enough to cover the T-1 to T+2 requirements accounting for holidays etc.
		--// Store selected date columns
		declare @todaysIdx integer
		set @todaysIdx = (select idx From @tmpCashDates where xDate = @Date)

		insert into @tmpInScopeCashDates (xDate, Idx, [Name])
		select xDate, Idx, [Name] from @tmpCashDates where idx between (@todaysIdx - 6) and (@todaysIdx + 6)


		--// There maybe multiple cash data loads per day, so get the latest
		declare @latestCashLadderDateTime datetime
		SET @latestCashLadderDateTime = (SELECT MAX(Store_Date) FROM [dbo].[T_CASH_LADDER_STAGE_STORE])


		--// Get distinct values of the PIVOT Column needed to dynamically build the pivot query below with the relevant dates
		DECLARE @ColumnName AS NVARCHAR(MAX)
		SELECT @ColumnName= ISNULL(@ColumnName + ',','') + quotename([Name]) FROM (SELECT [Name] FROM @tmpInScopeCashDates) AS dateIdx



		--// For a selected set of date columns (excl. weekends) and a given store_date transpose the date data
		DECLARE @DynamicPivotQuery AS NVARCHAR(MAX)
		SET @DynamicPivotQuery = 
		N'
		INSERT INTO [dbo].[T_PIVOT_CASH_LADDER_STAGE_STORE]([ReportDate], [Fund], [CCY], [AsOfDate], [Value])
		SELECT convert(datetime, Store_date) ReportDate, Fund, CCY, convert(date, Yr) AsOfDate, convert(decimal(18,6), [Value]) [Value] 
		FROM [dbo].[T_CASH_LADDER_STAGE_STORE]
		UNPIVOT([Value] FOR Yr IN (' + @ColumnName + ')) AS SUBTAB
		WHERE STORE_DATE = CONVERT(DATETIME, ''' + CONVERT(VARCHAR(50), @latestCashLadderDateTime, 13) + ''')
		AND DATEPART (WEEKDAY, Yr) NOT IN (1, 7); '

		/*
		Sample of what the Dynamic SQL Will produce based on GETDATE() = 2017-08-01 09:31:58.550
		INSERT INTO [dbo].[T_PIVOT_CASH_LADDER_STAGE_STORE]([ReportDate], [Fund], [CCY], [AsOfDate], [Value])
		SELECT convert(datetime, Store_date) ReportDate, Fund, CCY, convert(date, Yr) AsOfDate, convert(decimal(18,6), [Value]) [Value] 
		FROM [dbo].[T_CASH_LADDER_STAGE_STORE]
		UNPIVOT([Value] FOR Yr IN ([7/26/17],[7/27/17],[7/28/17],[7/29/17],[7/30/17],[7/31/17],[8/1/17],[8/2/17],[8/3/17],[8/4/17],[8/5/17],[8/6/17],[8/7/17])) AS SUBTAB
		WHERE STORE_DATE = CONVERT(DATETIME, '31 Jul 2017 05:09:45:000')
		AND DATEPART (WEEKDAY, Yr) NOT IN (1, 7); 
		*/

		--// Execute placing results into [dbo].[T_PIVOT_CASH_LADDER_STAGE_STORE]
		EXEC sp_executesql @DynamicPivotQuery



	-- ****** END Logic goes here, bear in mind the size of the transnaction, there may be reason to have several transactions.

	COMMIT TRANSACTION

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

	EXECUTE dbo.usp_LogProcErrors



/*

-- this secion can be enabled if you want the error to print on the screen

    DECLARE
        @ERROR_SEVERITY INT,
        @ERROR_STATE    INT,
        @ERROR_NUMBER   INT,
        @ERROR_LINE     INT,
        @ERROR_MESSAGE  NVARCHAR(4000);


    SELECT
        @ERROR_SEVERITY = ERROR_SEVERITY(),
        @ERROR_STATE    = ERROR_STATE(),
        @ERROR_NUMBER   = ERROR_NUMBER(),
        @ERROR_LINE     = ERROR_LINE(),
        @ERROR_MESSAGE  = @strProcedureName + ' - ' + ERROR_MESSAGE() ;

    RAISERROR('Msg %d, Line %d, :%s',
        @ERROR_SEVERITY,
        @ERROR_STATE,
        @ERROR_NUMBER,
        @ERROR_LINE,
        @ERROR_MESSAGE);
*/

END CATCH

