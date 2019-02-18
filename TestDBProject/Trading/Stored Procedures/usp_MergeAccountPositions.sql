
CREATE PROCEDURE [Trading].[usp_MergeAccountPositions]
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Trading].[usp_MergeAccountPositions]
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
	Declare	@strProcedureName		VARCHAR(100)	= '[Trading].[usp_MergeAccountPositions]';
	
	-- archive [Staging.BBG].[STG_Position] data
	INSERT INTO [Staging.BBG].[STG_PositionArchived] ([TicketNumber],[TradeDate],[SecurityIdentifierFlag],[SecurityIdentifier],[SettlementDate],[Long_ShortIndicator],
	                 [Position],[Account],[PriceFractionalIndicator],[Price],[ExchangeCode],[ProductCode],[BradyStyleFactor],[UniqueBloombergID],
	                 [FXForwardPoints],[SwapPay_ReceiveFlag],[SwapFee],[PayNotionalAmount],[ReceiveNotionalAmount],
	                 [FXAverageCost],[ISShort],[ISCFD],[PrimeBroker],[StrategyName])
	SELECT [TicketNumber],[TradeDate],[SecurityIdentifierFlag],[SecurityIdentifier],[SettlementDate],[Long_ShortIndicator],
	       [Position],[Account],[PriceFractionalIndicator],[Price],[ExchangeCode],[ProductCode],[BradyStyleFactor],[UniqueBloombergID],
	       [FXForwardPoints],[SwapPay_ReceiveFlag],[SwapFee],[PayNotionalAmount],[ReceiveNotionalAmount],
	       [FXAverageCost],[ISShort],[ISCFD],[PrimeBroker],[StrategyName]
	FROM [Staging.BBG].[STG_Position];
	
	--PRINT @@ROWCOUNT

	MERGE INTO [Trading].[AccountPositions] ap
	USING (SELECT CAST (TicketNumber as integer) as TicketNumber
                 ,CAST (TradeDate as date) as TradeDate
                 ,CAST (SecurityIdentifierFlag as integer) as SecurityIdentifierFlag
                 ,SecurityIdentifier
                 ,CAST (SettlementDate as date) as SettlementDate
                 ,CASE WHEN Long_ShortIndicator = '-' THEN 0 ELSE 1 END as ISLong
                 ,CAST(Position as decimal(19,5)) as Position
                 ,Account as AccountName
	             ,CASE WHEN ISNULL(PriceFractionalIndicator,0) > 0 THEN CAST(CAST(Price as decimal)/power(10,PriceFractionalIndicator) as decimal (19,9))
                       ELSE CAST(Price as decimal (19,9)) END as Price
                 ,CAST(ExchangeCode as integer) as ExchangeCode
                 ,CAST(ProductCode as integer) as ProductCode
                 ,CAST(BradyStyleFactor as integer) as BradyStyleFactor
                 ,UniqueBloombergID
                 ,CAST(FXForwardPoints as integer) as FXForwardPoints
                 ,SwapPay_ReceiveFlag
                 ,CAST (SwapFee as decimal(19,5)) as SwapFee
                 ,CAST( PayNotionalAmount as decimal(19,5)) as PayNotionalAmount
                 ,CAST(ReceiveNotionalAmount as decimal(19,5)) as ReceiveNotionalAmount
                 ,CAST(FXAverageCost as decimal(19,8)) as FXAverageCost
                 ,CASE WHEN ISShort = 'Y' THEN 1 ELSE 0 END as ISShort
                 ,CASE WHEN ISCFD = 'Y' THEN 1 ELSE 0 END as ISCFD
                 ,PrimeBroker
                 ,StrategyName
                 ,GetDate () as AccountPositionModifiedDatetime
           FROM [Staging.BBG].[STG_Position]				
			) Src
	ON (ap.TradeDate = Src.TradeDate
	AND ISNULL(ap.UniqueBloombergID,'x') = ISNULL(Src.UniqueBloombergID,'x')
    AND ISNULL(ap.AccountName,'x') = ISNULL(Src.AccountName,'x')
	AND ISNULL(ap.SecurityIdentifier,'x') = ISNULL(Src.SecurityIdentifier,'x')
	AND ap.SecurityIdentifierFlag = Src.SecurityIdentifierFlag
	)
	WHEN NOT MATCHED
		THEN INSERT ([TicketNumber],[TradeDate],[SecurityIdentifierFlag],[SecurityIdentifier],[SettlementDate],[ISLong],
	                 [Position],[AccountName],[Price],[ExchangeCode],[ProductCode],[BradyStyleFactor],[UniqueBloombergID],
	                 [FXForwardPoints],[SwapPay_ReceiveFlag],[SwapFee],[PayNotionalAmount],[ReceiveNotionalAmount],
	                 [FXAverageCost],[ISShort],[ISCFD],[PrimeBroker],[StrategyName])
				VALUES (Src.[TicketNumber],Src.[TradeDate],Src.[SecurityIdentifierFlag],Src.[SecurityIdentifier],Src.[SettlementDate],Src.[ISLong],
	                 Src.[Position],Src.[AccountName],Src.[Price],Src.[ExchangeCode],Src.[ProductCode],Src.[BradyStyleFactor],Src.[UniqueBloombergID],
	                 Src.[FXForwardPoints],Src.[SwapPay_ReceiveFlag],Src.[SwapFee],Src.[PayNotionalAmount],Src.[ReceiveNotionalAmount],
	                 Src.[FXAverageCost],Src.[ISShort],Src.[ISCFD],Src.[PrimeBroker],Src.[StrategyName])
	   	WHEN MATCHED 
			THEN UPDATE SET ap.[TicketNumber] = Src.[TicketNumber]
					, ap.[SettlementDate] = Src.[SettlementDate]
					, ap.[ISLong] = Src.[ISLong]
					, ap.[Position] = Src.[Position]
					, ap.[Price] = Src.[Price]
					, ap.[ExchangeCode] = Src.[ExchangeCode]
					, ap.[ProductCode] = Src.[ProductCode]
					, ap.[BradyStyleFactor] = Src.[BradyStyleFactor]
					, ap.[FXForwardPoints] = Src.[FXForwardPoints]
					, ap.[SwapPay_ReceiveFlag] = Src.[SwapPay_ReceiveFlag]
					, ap.[SwapFee] = Src.[SwapFee]
					, ap.[PayNotionalAmount] = Src.[PayNotionalAmount]
					, ap.[ReceiveNotionalAmount] = Src.[ReceiveNotionalAmount]					
					, ap.[FXAverageCost] = Src.[FXAverageCost]
					, ap.[ISShort] = Src.[FXAverageCost]
					, ap.[ISCFD] = Src.[ISCFD]
					, ap.[PrimeBroker] = Src.[PrimeBroker]
					, ap.[StrategyName] = Src.[StrategyName]					
					, ap.AccountPositionModifiedDatetime = Src.AccountPositionModifiedDatetime
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
