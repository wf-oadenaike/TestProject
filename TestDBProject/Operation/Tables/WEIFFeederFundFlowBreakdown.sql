﻿CREATE TABLE [Operation].[WEIFFeederFundFlowBreakdown] (
    [InternalRef]                     NVARCHAR (255)  NULL,
    [Dealtype]                        NVARCHAR (255)  NOT NULL,
    [SubDealType]                     NVARCHAR (255)  NULL,
    [DealRef]                         BIGINT          NOT NULL,
    [RegisterName]                    NVARCHAR (511)  NOT NULL,
    [RegisterID]                      BIGINT          NULL,
    [SubRegisterID]                   NVARCHAR (255)  NULL,
    [ClientID]                        BIGINT          NULL,
    [EstConfDeal]                     CHAR (1)        NOT NULL,
    [FullPartialRedemption]           NVARCHAR (31)   NULL,
    [OrderedUnitsShareDeals]          DECIMAL (18, 6) NOT NULL,
    [OrderedCashDeals]                DECIMAL (18, 2) NULL,
    [SettlementCurrency]              CHAR (3)        NOT NULL,
    [FXRate]                          FLOAT (53)      NOT NULL,
    [ShareClassCurrency]              CHAR (3)        NOT NULL,
    [EstConfUnitsShares]              DECIMAL (18, 6) NOT NULL,
    [EstConfInvestorAmt]              DECIMAL (18, 2) NOT NULL,
    [Price]                           FLOAT (53)      NOT NULL,
    [PriceDate]                       DATE            NOT NULL,
    [AgentName]                       NVARCHAR (511)  NOT NULL,
    [AgentID]                         BIGINT          NOT NULL,
    [FundShareClassID]                NVARCHAR (31)   NULL,
    [FundShareClassName]              NVARCHAR (255)  NULL,
    [TotalInitialCharge]              NVARCHAR (15)   NOT NULL,
    [TotalRedemptionFee]              NVARCHAR (15)   NOT NULL,
    [AgentCommission]                 NVARCHAR (15)   NOT NULL,
    [MgmtCharge]                      NVARCHAR (15)   NOT NULL,
    [ADL]                             NVARCHAR (15)   NOT NULL,
    [TotalInitialChargeAmt]           FLOAT (53)      NOT NULL,
    [TotalRedemptionFeeChargeAmt]     FLOAT (53)      NOT NULL,
    [AgentCommissionChargeAmt]        FLOAT (53)      NOT NULL,
    [MgmtChargeAmt]                   FLOAT (53)      NOT NULL,
    [ADLChargeAmt]                    FLOAT (53)      NOT NULL,
    [FundMovement]                    FLOAT (53)      NOT NULL,
    [Description]                     NVARCHAR (255)  NULL,
    [SettlementDate]                  DATE            NOT NULL,
    [CashReceived]                    CHAR (1)        NOT NULL,
    [SwitchfromtoFundandShareClassID] NVARCHAR (255)  NULL,
    [SwitchfromtoundShareClassName]   NVARCHAR (255)  NULL,
    [CountryofResidence]              NVARCHAR (255)  NULL,
    [FundID]                          NVARCHAR (255)  NULL,
    [ShareClassID]                    NVARCHAR (255)  NULL,
    [TradeDate]                       DATE            NOT NULL,
    [Filename]                        NVARCHAR (511)  NOT NULL,
    [CADIS_SYSTEM_INSERTED]           DATETIME        CONSTRAINT [DF_wfffb_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]            DATETIME        CONSTRAINT [DF_wfffb_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]          NVARCHAR (50)   CONSTRAINT [DF_wfffb_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]           INT             CONSTRAINT [DF_wfffb_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]          ROWVERSION      NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]       DATETIME        CONSTRAINT [DF_wfffb_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [pk_WEIFFeederFundFlowBreakdown] PRIMARY KEY CLUSTERED ([DealRef] ASC, [TradeDate] DESC)
);

