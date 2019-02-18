
CREATE PROCEDURE [ETL].[OperationsMergeWEIFFeederFundData]
AS
MERGE INTO [Operation].[WEIFFeederFundFlowBreakdown] Tar
 USING ( SELECT [InternalRef]
  ,[Dealtype]
  ,[SubDealType]
  ,CONVERT(BIGINT,ROUND([DealRef],0)) AS [DealRef]
  ,[RegisterName]
  ,CONVERT(BIGINT, ROUND([RegisterID],0)) AS RegisterID
  ,[SubRegisterID]
  ,CONVERT(BIGINT,ROUND([ClientID],0)) AS [ClientID]
  ,CONVERT(CHAR(1),[EstConfDeal]) AS [EstConfDeal]
  ,[FullPartialRedemption]
  ,CONVERT(DECIMAL(18,6),[OrderedUnitsShareDeals]) AS [OrderedUnitsShareDeals]
  ,CONVERT(DECIMAL(18,2), CONVERT(FLOAT, [OrderedCashDeals])) AS [OrderedCashDeals]
  ,CONVERT(CHAR(3),[SettlementCurrency]) AS [SettlementCurrency]
  ,CONVERT(FLOAT,[FXRate]) AS [FXRate]
  ,CONVERT(CHAR(3),[ShareClassCurrency]) AS [ShareClassCurrency]
  ,CONVERT(DECIMAL(18,6), CONVERT(FLOAT, [EstConfUnitsShares])) AS [EstConfUnitsShares]
  ,CONVERT(DECIMAL(18,2),CONVERT(FLOAT, [EstConfInvestorAmt])) AS [EstConfInvestorAmt]
  ,CONVERT(FLOAT,[Price]) AS [Price]
  ,CONVERT(DATE,SUBSTRING([PriceDate], 25,4) + ' ' + SUBSTRING([PriceDate], 5,3) + ' ' +SUBSTRING([PriceDate], 9,2) ) AS [PriceDate]
  ,[AgentName]
  ,CONVERT(BIGINT, ROUND([AgentID],0)) AS [AgentID]
  ,[FundShareClassID]
  ,[FundShareClassName]
  ,[TotalInitialCharge]
  ,[TotalRedemptionFee]
  ,[AgentCommission]
  ,[MgmtCharge]
  ,[ADL]
  ,CONVERT(FLOAT,[TotalInitialChargeAmt]) AS [TotalInitialChargeAmt]
  ,CONVERT(FLOAT,[TotalRedemptionFeeChargeAmt]) AS [TotalRedemptionFeeChargeAmt]
  ,CONVERT(FLOAT,[AgentCommissionChargeAmt]) AS [AgentCommissionChargeAmt]
  ,CONVERT(FLOAT,[MgmtChargeAmt]) AS [MgmtChargeAmt]
  ,CONVERT(FLOAT,[ADLChargeAmt]) AS [ADLChargeAmt]
  ,CONVERT(FLOAT,[FundMovement]) AS [FundMovement]
  ,[Description]
  ,CONVERT(DATE,SUBSTRING([SettlementDate], 25,4) + ' ' + SUBSTRING([SettlementDate], 5,3) + ' ' +SUBSTRING([SettlementDate], 9,2) ) AS [SettlementDate]
  ,CONVERT(CHAR(1),[CashReceived]) AS [CashReceived]
  ,[SwitchfromtoFundandShareClassID]
  ,[SwitchfromtoundShareClassName]
  ,[CountryofResidence]
  ,[FundID]
  ,[ShareClassID]
  ,CONVERT(DATE,SUBSTRING([TradeDate], 25,4) + ' ' + SUBSTRING([TradeDate], 5,3) + ' ' +SUBSTRING([TradeDate], 9,2) ) AS [TradeDate]
  ,[Filename]
FROM [Staging.NT].[FeederFundCashDeals]
where coalesce(dealtype,'x')='Subscription'
			) as Src
	ON ( Tar.[DealRef] = Src.[DealRef] AND Tar.[TradeDate] = Src.[TradeDate]
		)
	WHEN NOT MATCHED THEN
		INSERT ([InternalRef]
      ,[Dealtype]
      ,[SubDealType]
      ,[DealRef]
      ,[RegisterName]
      ,[RegisterID]
      ,[SubRegisterID]
      ,[ClientID]
      ,[EstConfDeal]
      ,[FullPartialRedemption]
      ,[OrderedUnitsShareDeals]
      ,[OrderedCashDeals]
      ,[SettlementCurrency]
      ,[FXRate]
      ,[ShareClassCurrency]
      ,[EstConfUnitsShares]
      ,[EstConfInvestorAmt]
      ,[Price]
      ,[PriceDate]
      ,[AgentName]
      ,[AgentID]
      ,[FundShareClassID]
      ,[FundShareClassName]
      ,[TotalInitialCharge]
      ,[TotalRedemptionFee]
      ,[AgentCommission]
      ,[MgmtCharge]
      ,[ADL]
      ,[TotalInitialChargeAmt]
      ,[TotalRedemptionFeeChargeAmt]
      ,[AgentCommissionChargeAmt]
      ,[MgmtChargeAmt]
      ,[ADLChargeAmt]
      ,[FundMovement]
      ,[Description]
      ,[SettlementDate]
      ,[CashReceived]
      ,[SwitchfromtoFundandShareClassID]
      ,[SwitchfromtoundShareClassName]
      ,[CountryofResidence]
      ,[FundID]
      ,[ShareClassID]
      ,[TradeDate]
      ,[Filename])
			VALUES (
			Src.[InternalRef]
      ,Src.[Dealtype]
      ,Src.[SubDealType]
      ,Src.[DealRef]
      ,Src.[RegisterName]
      ,Src.[RegisterID]
      ,Src.[SubRegisterID]
      ,Src.[ClientID]
      ,Src.[EstConfDeal]
      ,Src.[FullPartialRedemption]
      ,Src.[OrderedUnitsShareDeals]
      ,Src.[OrderedCashDeals]
      ,Src.[SettlementCurrency]
      ,Src.[FXRate]
      ,Src.[ShareClassCurrency]
      ,Src.[EstConfUnitsShares]
      ,Src.[EstConfInvestorAmt]
      ,Src.[Price]
      ,Src.[PriceDate]
      ,Src.[AgentName]
      ,Src.[AgentID]
      ,Src.[FundShareClassID]
      ,Src.[FundShareClassName]
      ,Src.[TotalInitialCharge]
      ,Src.[TotalRedemptionFee]
      ,Src.[AgentCommission]
      ,Src.[MgmtCharge]
      ,Src.[ADL]
      ,Src.[TotalInitialChargeAmt]
      ,Src.[TotalRedemptionFeeChargeAmt]
      ,Src.[AgentCommissionChargeAmt]
      ,Src.[MgmtChargeAmt]
      ,Src.[ADLChargeAmt]
      ,Src.[FundMovement]
      ,Src.[Description]
      ,Src.[SettlementDate]
      ,Src.[CashReceived]
      ,Src.[SwitchfromtoFundandShareClassID]
      ,Src.[SwitchfromtoundShareClassName]
      ,Src.[CountryofResidence]
      ,Src.[FundID]
      ,Src.[ShareClassID]
      ,Src.[TradeDate]
      ,Src.[Filename])
 WHEN MATCHED AND (
 ISNULL(tar.[InternalRef],'ABCDEFG') <> ISNULL(Src.[InternalRef],'ABCDEFG')
      OR tar.[Dealtype] <> Src.[Dealtype]
      OR ISNULL(tar.[SubDealType],'ABCDEFG') <> ISNULL(Src.[SubDealType],'ABCDEFG')
      OR tar.[DealRef] <> Src.[DealRef]
      OR tar.[RegisterName] <> Src.[RegisterName]
      OR ISNULL(tar.[RegisterID],-9999) <> ISNULL(Src.[RegisterID],-9999)
      OR ISNULL(tar.[SubRegisterID],'ABCDEFG') <> ISNULL(Src.[SubRegisterID],'ABCDEFG')
      OR ISNULL(tar.[ClientID],-9999) <> ISNULL(Src.[ClientID],-9999)
      OR tar.[EstConfDeal] <> Src.[EstConfDeal]
      OR ISNULL(tar.[FullPartialRedemption],'ABCDEFG') <> ISNULL(Src.[FullPartialRedemption],'ABCDEFG')
      OR ISNULL(tar.[OrderedUnitsShareDeals],-9999.00) <> ISNULL(Src.[OrderedUnitsShareDeals],-9999.00)
      OR tar.[OrderedCashDeals] <> Src.[OrderedCashDeals]
      OR tar.[SettlementCurrency] <> Src.[SettlementCurrency]
      OR tar.[FXRate] <> Src.[FXRate]
      OR tar.[ShareClassCurrency] <> Src.[ShareClassCurrency]
      OR tar.[EstConfUnitsShares] <> Src.[EstConfUnitsShares]
      OR tar.[EstConfInvestorAmt] <> Src.[EstConfInvestorAmt]
      OR tar.[Price] <> Src.[Price]
      OR tar.[AgentName] <> Src.[AgentName]
      OR tar.[AgentID] <> Src.[AgentID]
      OR ISNULL(tar.[FundShareClassID],'ABCDEFG') <> ISNULL(Src.[FundShareClassID],'ABCDEFG')
      OR ISNULL(tar.[FundShareClassName],'ABCDEFG') <> ISNULL(Src.[FundShareClassName],'ABCDEFG')
      OR tar.[TotalInitialCharge] <> Src.[TotalInitialCharge]
      OR tar.[TotalRedemptionFee] <> Src.[TotalRedemptionFee]
      OR tar.[AgentCommission] <> Src.[AgentCommission]
      OR tar.[MgmtCharge] <> Src.[MgmtCharge]
      OR tar.[ADL] <> Src.[ADL]
      OR tar.[TotalInitialChargeAmt] <> Src.[TotalInitialChargeAmt]
      OR tar.[TotalRedemptionFeeChargeAmt] <> Src.[TotalRedemptionFeeChargeAmt]
      OR tar.[AgentCommissionChargeAmt] <> Src.[AgentCommissionChargeAmt]
      OR tar.[MgmtChargeAmt] <> Src.[MgmtChargeAmt]
      OR tar.[ADLChargeAmt] <> Src.[ADLChargeAmt]
      OR tar.[FundMovement] <> Src.[FundMovement]
      OR tar.[Description] <> Src.[Description]
      OR tar.[SettlementDate] <> Src.[SettlementDate]
      OR tar.[CashReceived] <> Src.[CashReceived]
      OR ISNULL(tar.[SwitchfromtoFundandShareClassID],'ABCDEFG') <> ISNULL(Src.[SwitchfromtoFundandShareClassID],'ABCDEFG')
      OR ISNULL(tar.[SwitchfromtoundShareClassName],'ABCDEFG') <> ISNULL(Src.[SwitchfromtoundShareClassName],'ABCDEFG')
      OR ISNULL(tar.[CountryofResidence],'ABCDEFG') <> ISNULL(Src.[CountryofResidence],'ABCDEFG')
      OR ISNULL(tar.[FundID],'ABCDEFG') <> ISNULL(Src.[FundID],'ABCDEFG')
      OR ISNULL(tar.[ShareClassID],'ABCDEFG') <> ISNULL(Src.[ShareClassID],'ABCDEFG')
      OR ISNULL(tar.[TradeDate], '01 Jan 2199') <> ISNULL(Src.[TradeDate],'01 Jan 2199')
      OR tar.[Filename] <> Src.[Filename]
 ) THEN 
 UPDATE 
	SET InternalRef = src.InternalRef
      ,Dealtype = src.Dealtype
      ,SubDealType = src.SubDealType
      ,RegisterName = src.RegisterName
      ,RegisterID = src.RegisterID
      ,SubRegisterID = src.SubRegisterID
      ,ClientID = src.ClientID
      ,EstConfDeal = src.EstConfDeal
      ,FullPartialRedemption = src.FullPartialRedemption
      ,OrderedUnitsShareDeals = src.OrderedUnitsShareDeals
      ,OrderedCashDeals = src.OrderedCashDeals
      ,SettlementCurrency = src.SettlementCurrency
      ,FXRate = src.FXRate
      ,ShareClassCurrency = src.ShareClassCurrency
      ,EstConfUnitsShares = src.EstConfUnitsShares
      ,EstConfInvestorAmt = src.EstConfInvestorAmt
      ,Price = src.Price
      ,PriceDate = src.PriceDate
      ,AgentName = src.AgentName
      ,AgentID = src.AgentID
      ,FundShareClassID = src.FundShareClassID
      ,FundShareClassName = src.FundShareClassName
      ,TotalInitialCharge = src.TotalInitialCharge
      ,TotalRedemptionFee = src.TotalRedemptionFee
      ,AgentCommission = src.AgentCommission
      ,MgmtCharge = src.MgmtCharge
      ,ADL = src.ADL
      ,TotalInitialChargeAmt = src.TotalInitialChargeAmt
      ,TotalRedemptionFeeChargeAmt = src.TotalRedemptionFeeChargeAmt
      ,AgentCommissionChargeAmt = src.AgentCommissionChargeAmt
      ,MgmtChargeAmt = src.MgmtChargeAmt
      ,ADLChargeAmt = src.ADLChargeAmt
      ,FundMovement = src.FundMovement
      ,Description = src.Description
      ,SettlementDate = src.SettlementDate
      ,CashReceived = src.CashReceived
      ,SwitchfromtoFundandShareClassID = src.SwitchfromtoFundandShareClassID
      ,SwitchfromtoundShareClassName = src.SwitchfromtoundShareClassName
      ,CountryofResidence = src.CountryofResidence
      ,FundID = src.FundID
      ,ShareClassID = src.ShareClassID
      ,TradeDate = src.TradeDate
      ,Filename = src.Filename
	  ,[CADIS_SYSTEM_LASTMODIFIED] = GETDATE()
	;
RETURN 0;

