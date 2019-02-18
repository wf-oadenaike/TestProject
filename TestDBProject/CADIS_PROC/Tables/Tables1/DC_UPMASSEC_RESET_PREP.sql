﻿CREATE TABLE [CADIS_PROC].[DC_UPMASSEC_RESET_PREP] (
    [EDM_SEC_ID]                     INT           NOT NULL,
    [SECURITY_NAME]                  BIT           NULL,
    [SECURITY_DESCRIPTION]           BIT           NULL,
    [SECURITY_SHORTNAME]             BIT           NULL,
    [ASSET_TYPE]                     BIT           NULL,
    [SECURITY_TYPE]                  BIT           NULL,
    [CUSIP]                          BIT           NULL,
    [ISIN]                           BIT           NULL,
    [SEDOL]                          BIT           NULL,
    [TICKER]                         BIT           NULL,
    [VALOREN]                        BIT           NULL,
    [WERTPAPIER]                     BIT           NULL,
    [SECURITY_ISO_CCY]               BIT           NULL,
    [RISK_ISO_CCY]                   BIT           NULL,
    [FIXED_ISO_CCY]                  BIT           NULL,
    [INCORPORATION_ISO_CTY]          BIT           NULL,
    [DOMICILE_ISO_CTY]               BIT           NULL,
    [ISSUE_COUNTRY_ISO]              BIT           NULL,
    [RISK_ISO_CTY]                   BIT           NULL,
    [MIC_EXCHANGE_CODE]              BIT           NULL,
    [BBG_EXCHANGE_CODE]              BIT           NULL,
    [STATE_CODE]                     BIT           NULL,
    [ACTIVE_TRADE_INDICATOR]         BIT           NULL,
    [144A_INDICATOR]                 BIT           NULL,
    [PRIVATE_PLACEMENT_INDICATOR]    BIT           NULL,
    [ILLIQUID]                       BIT           NULL,
    [QUOTE_TYPE]                     BIT           NULL,
    [DAYS_TO_SETTLE]                 BIT           NULL,
    [TRADE_SETTLEMENT_CALENDAR_CODE] BIT           NULL,
    [UNIQUE_BLOOMBERG_ID]            BIT           NULL,
    [BBG_SECTOR]                     BIT           NULL,
    [BBG_SUBSECTOR]                  BIT           NULL,
    [BBG_GROUP]                      BIT           NULL,
    [IS_IPO]                         BIT           NULL,
    [PARSEKEYABLE_DESCRIPTION]       BIT           NULL,
    [SECURITY_IDENTIFIER]            BIT           NULL,
    [IRISH_SEDOL_NUMBER]             BIT           NULL,
    [ISSUER]                         BIT           NULL,
    [CUR_MAR_CAP]                    BIT           NULL,
    [PRIMARY_EXCHANGE_NAME]          BIT           NULL,
    [SECURITY_HAS_ADRS]              BIT           NULL,
    [WITHHOLDING_TAX]                BIT           NULL,
    [VOL_AVG_5D]                     BIT           NULL,
    [VOL_AVG_20D]                    BIT           NULL,
    [ADV_TOTAL_VOLUME]               BIT           NULL,
    [CADIS_SYSTEM_INSERTED]          DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]           DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]         NVARCHAR (50) NULL,
    [CADIS_SYSTEM_PRIORITY]          INT           NULL,
    [CADIS_SYSTEM_LASTMODIFIED]      DATETIME      NULL,
    [CADIS_SYSTEM_TIMESTAMP]         ROWVERSION    NOT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC) WITH (FILLFACTOR = 80)
);
