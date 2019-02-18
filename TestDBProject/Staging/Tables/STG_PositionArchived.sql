﻿CREATE TABLE [Staging].[STG_PositionArchived] (
    [TicketNumber]             VARCHAR (70) NULL,
    [TradeDate]                VARCHAR (70) NULL,
    [SecurityIdentifierFlag]   VARCHAR (70) NULL,
    [SecurityIdentifier]       VARCHAR (70) NULL,
    [SettlementDate]           VARCHAR (70) NULL,
    [Long_ShortIndicator]      VARCHAR (70) NULL,
    [Position]                 VARCHAR (70) NULL,
    [Account]                  VARCHAR (70) NULL,
    [PriceFractionalIndicator] VARCHAR (70) NULL,
    [Price]                    VARCHAR (70) NULL,
    [ExchangeCode]             VARCHAR (70) NULL,
    [ProductCode]              VARCHAR (70) NULL,
    [BradyStyleFactor]         VARCHAR (70) NULL,
    [UniqueBloombergID]        VARCHAR (70) NULL,
    [FXForwardPoints]          VARCHAR (70) NULL,
    [SwapPay_ReceiveFlag]      VARCHAR (70) NULL,
    [SwapFee]                  VARCHAR (70) NULL,
    [PayNotionalAmount]        VARCHAR (70) NULL,
    [ReceiveNotionalAmount]    VARCHAR (70) NULL,
    [FXAverageCost]            VARCHAR (70) NULL,
    [ISShort]                  VARCHAR (70) NULL,
    [ISCFD]                    VARCHAR (70) NULL,
    [PrimeBroker]              VARCHAR (70) NULL,
    [StrategyName]             VARCHAR (70) NULL,
    [ArchivedCreatedDatetime]  DATETIME     CONSTRAINT [DF_SPA_ACDT] DEFAULT (getdate()) NOT NULL
);

