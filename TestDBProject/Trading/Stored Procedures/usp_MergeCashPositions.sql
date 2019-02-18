
CREATE PROCEDURE [Trading].[usp_MergeCashPositions]
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Trading].[usp_MergeCashPositions]
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			13/10/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on;
	--SET DATEFORMAT dmy;

	BEGIN TRANSACTION

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Trading].[usp_MergeCashPositions]';
	
	-- archive [Staging.BBG].[STG_Cash] data
	INSERT INTO [Staging.BBG].[STG_CashArchived] ([TradeDate],[AccountName],[CashUpdateType],[CashAdjustmentAmount],[TradeDateCash],[SettlementDateCash],
					 [CurrencyCode],[CashTicketCode],[Asofdate],[Security],[Notes],[PrimeBroker],[Strategy],[ClassID],[NumberofUnits],[UnitValue])
	SELECT [TradeDate],[AccountName],[CashUpdateType],[CashAdjustmentAmount],[TradeDateCash],[SettlementDateCash],
		   [CurrencyCode],[CashTicketCode],[Asofdate],[Security],[Notes],[PrimeBroker],[Strategy],[ClassID],[NumberofUnits],[UnitValue]
	FROM [Staging.BBG].[STG_Cash];
	
	--PRINT @@ROWCOUNT

	MERGE INTO [Trading].[CashPositions] cp
	USING (SELECT Distinct CAST (TradeDate as date) as TradeDate
                 ,AccountName
                 ,CAST(CashUpdateType as integer) as CashUpdateType
                 ,CAST (CashAdjustmentAmount as decimal(19,5)) as CashAdjustmentAmount
                 ,sum(CAST( TradeDateCash as decimal(19,5))) as TradeDateCash
                 ,sum(CAST(SettlementDateCash as decimal(19,5))) as SettlementDateCash
				 ,CurrencyCode
				 ,CashTicketCode
				 ,CAST (Asofdate as date) as Asofdate
				 ,Security
				 ,Notes
				 ,PrimeBroker
				 ,Strategy
                 ,CAST(ClassID as integer) as ClassID
                 ,CAST(NumberofUnits as decimal(19,5)) as NumberofUnits
                 ,CAST(UnitValue as decimal(19,5)) as UnitValue
                 ,GetDate () as CashPositionModifiedDatetime
           FROM [Staging.BBG].[STG_Cash]
group by CAST (TradeDate as date),AccountName,CAST(CashUpdateType as integer),
CAST (CashAdjustmentAmount as decimal(19,5)),
CurrencyCode,CashTicketCode,CAST (Asofdate as date),Security,Notes,PrimeBroker,Strategy,
CAST(ClassID as integer),CAST(NumberofUnits as decimal(19,5)),CAST(UnitValue as decimal(19,5))				
			) Src
	ON (cp.TradeDate = Src.TradeDate
    AND cp.AccountName = Src.AccountName
	AND cp.CurrencyCode = Src.CurrencyCode
	AND cp.CashTicketCode=Src.CashTicketCode
	--JT 2017-01-2017
	AND ISNULL(Src.SettlementDateCash,-99999999) = ISNULL(cp.SettlementDateCash, -99999999)
	AND ISNULL(Src.TradeDateCash,-99999999) = ISNULL(cp.TradeDateCash, -99999999)
	)
	WHEN NOT MATCHED
		THEN INSERT ([TradeDate],[AccountName],[CashUpdateType],[CashAdjustmentAmount],[TradeDateCash],[SettlementDateCash],
					 [CurrencyCode],[CashTicketCode],[Asofdate],[Security],[Notes],[PrimeBroker],[Strategy],[ClassID],[NumberofUnits],[UnitValue])
				VALUES (Src.[TradeDate],Src.[AccountName],Src.[CashUpdateType],Src.[CashAdjustmentAmount],Src.[TradeDateCash],Src.[SettlementDateCash],
					 Src.[CurrencyCode],Src.[CashTicketCode],Src.[Asofdate],Src.[Security],Src.[Notes],Src.[PrimeBroker],Src.[Strategy],Src.[ClassID],Src.[NumberofUnits],Src.[UnitValue])
	   	WHEN MATCHED 
			THEN UPDATE SET cp.[CashUpdateType] = Src.[CashUpdateType]
					, cp.[CashAdjustmentAmount] = Src.[CashAdjustmentAmount]
					, cp.[TradeDateCash] = Src.[TradeDateCash]
					, cp.[SettlementDateCash] = Src.[SettlementDateCash]
					, cp.[CashTicketCode] = Src.[CashTicketCode]
					, cp.[Asofdate] = Src.[Asofdate]
					, cp.[Security] = Src.[Security]
					, cp.[Notes] = Src.[Notes]
					, cp.[PrimeBroker] = Src.[PrimeBroker]
					, cp.[Strategy] = Src.[Strategy]
					, cp.[ClassID] = Src.[ClassID]
					, cp.[NumberofUnits] = Src.[NumberofUnits]
					, cp.[UnitValue] = Src.[UnitValue]				
					, cp.CashPositionModifiedDatetime = Src.CashPositionModifiedDatetime
		;

	SET @InsertRowCount = @@ROWCOUNT;

	SELECT @ProcessRowCount AS ProcessRowCount
		, @InsertRowCount AS InsertRowCount
		, @UpdateRowCount AS UpdateRowCount
		, @DeleteRowCount AS DeleteRowCount
		;

	COMMIT;

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
		ROLLBACK;
		 
		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		Return @ErrorNumber;
END CATCH
