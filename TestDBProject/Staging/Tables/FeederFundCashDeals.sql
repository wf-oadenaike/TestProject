﻿CREATE TABLE [Staging].[FeederFundCashDeals] (
    [InternalRef]                     NVARCHAR (255) NULL,
    [Dealtype]                        NVARCHAR (255) NULL,
    [SubDealType]                     NVARCHAR (255) NULL,
    [DealRef]                         NVARCHAR (255) NULL,
    [RegisterName]                    NVARCHAR (511) NULL,
    [RegisterID]                      NVARCHAR (255) NULL,
    [SubRegisterID]                   NVARCHAR (255) NULL,
    [ClientID]                        NVARCHAR (255) NULL,
    [EstConfDeal]                     NVARCHAR (255) NULL,
    [FullPartialRedemption]           NVARCHAR (255) NULL,
    [OrderedUnitsShareDeals]          NVARCHAR (255) NULL,
    [OrderedCashDeals]                NVARCHAR (255) NULL,
    [SettlementCurrency]              NVARCHAR (255) NULL,
    [FXRate]                          NVARCHAR (255) NULL,
    [ShareClassCurrency]              NVARCHAR (255) NULL,
    [EstConfUnitsShares]              NVARCHAR (255) NULL,
    [EstConfInvestorAmt]              NVARCHAR (255) NULL,
    [Price]                           NVARCHAR (255) NULL,
    [PriceDate]                       NVARCHAR (255) NULL,
    [AgentName]                       NVARCHAR (511) NULL,
    [AgentID]                         NVARCHAR (255) NULL,
    [FundShareClassID]                NVARCHAR (255) NULL,
    [FundShareClassName]              NVARCHAR (511) NULL,
    [TotalInitialCharge]              NVARCHAR (255) NULL,
    [TotalRedemptionFee]              NVARCHAR (255) NULL,
    [AgentCommission]                 NVARCHAR (255) NULL,
    [MgmtCharge]                      NVARCHAR (255) NULL,
    [ADL]                             NVARCHAR (255) NULL,
    [TotalInitialChargeAmt]           NVARCHAR (255) NULL,
    [TotalRedemptionFeeChargeAmt]     NVARCHAR (255) NULL,
    [AgentCommissionChargeAmt]        NVARCHAR (255) NULL,
    [MgmtChargeAmt]                   NVARCHAR (255) NULL,
    [ADLChargeAmt]                    NVARCHAR (255) NULL,
    [FundMovement]                    NVARCHAR (255) NULL,
    [Description]                     NVARCHAR (255) NULL,
    [SettlementDate]                  NVARCHAR (255) NULL,
    [CashReceived]                    NVARCHAR (255) NULL,
    [SwitchfromtoFundandShareClassID] NVARCHAR (255) NULL,
    [SwitchfromtoundShareClassName]   NVARCHAR (255) NULL,
    [CountryofResidence]              NVARCHAR (255) NULL,
    [FundID]                          NVARCHAR (255) NULL,
    [ShareClassID]                    NVARCHAR (255) NULL,
    [TradeDate]                       NVARCHAR (255) NULL,
    [Filename]                        NVARCHAR (511) NULL,
    [CreatedDate]                     DATETIME       CONSTRAINT [df_ffcd_cd] DEFAULT (getdate()) NOT NULL
);

