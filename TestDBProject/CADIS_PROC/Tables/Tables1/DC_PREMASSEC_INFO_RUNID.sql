﻿CREATE TABLE [CADIS_PROC].[DC_PREMASSEC_INFO_RUNID] (
    [EDM_SEC_ID]                            INT NOT NULL,
    [SECURITY_NAME__RUNID]                  INT NOT NULL,
    [SECURITY_DESCRIPTION__RUNID]           INT NOT NULL,
    [SECURITY_SHORTNAME__RUNID]             INT NOT NULL,
    [ASSET_TYPE__RUNID]                     INT NOT NULL,
    [SECURITY_TYPE__RUNID]                  INT NOT NULL,
    [CUSIP__RUNID]                          INT NOT NULL,
    [ISIN__RUNID]                           INT NOT NULL,
    [SEDOL__RUNID]                          INT NOT NULL,
    [TICKER__RUNID]                         INT NOT NULL,
    [VALOREN__RUNID]                        INT NOT NULL,
    [WERTPAPIER__RUNID]                     INT NOT NULL,
    [SECURITY_ISO_CCY__RUNID]               INT NOT NULL,
    [RISK_ISO_CCY__RUNID]                   INT NOT NULL,
    [FIXED_ISO_CCY__RUNID]                  INT NOT NULL,
    [INCORPORATION_ISO_CTY__RUNID]          INT NOT NULL,
    [DOMICILE_ISO_CTY__RUNID]               INT NOT NULL,
    [ISSUE_COUNTRY_ISO__RUNID]              INT NOT NULL,
    [RISK_ISO_CTY__RUNID]                   INT NOT NULL,
    [MIC_EXCHANGE_CODE__RUNID]              INT NOT NULL,
    [STATE_CODE__RUNID]                     INT NOT NULL,
    [ACTIVE_TRADE_INDICATOR__RUNID]         INT NOT NULL,
    [144A_INDICATOR__RUNID]                 INT NOT NULL,
    [PRIVATE_PLACEMENT_INDICATOR__RUNID]    INT NOT NULL,
    [ILLIQUID__RUNID]                       INT NOT NULL,
    [QUOTE_TYPE__RUNID]                     INT NOT NULL,
    [DAYS_TO_SETTLE__RUNID]                 INT NOT NULL,
    [TRADE_SETTLEMENT_CALENDAR_CODE__RUNID] INT NOT NULL,
    [UNIQUE_BLOOMBERG_ID__RUNID]            INT NOT NULL,
    [BBG_EXCHANGE_CODE__RUNID]              INT NOT NULL,
    [BBG_SECTOR__RUNID]                     INT NOT NULL,
    [BBG_SUBSECTOR__RUNID]                  INT NOT NULL,
    [BBG_GROUP__RUNID]                      INT NOT NULL,
    [IS_IPO__RUNID]                         INT NOT NULL,
    [PARSEKEYABLE_DESCRIPTION__RUNID]       INT NOT NULL,
    [SECURITY_IDENTIFIER__RUNID]            INT NOT NULL,
    [IRISH_SEDOL_NUMBER__RUNID]             INT NOT NULL,
    [ISSUER__RUNID]                         INT NOT NULL,
    [CUR_MAR_CAP__RUNID]                    INT NOT NULL,
    [PRIMARY_EXCHANGE_NAME__RUNID]          INT NOT NULL,
    [SECURITY_HAS_ADRS__RUNID]              INT NOT NULL,
    [WITHHOLDING_TAX__RUNID]                INT NOT NULL,
    [VOL_AVG_5D__RUNID]                     INT NOT NULL,
    [VOL_AVG_20D__RUNID]                    INT NOT NULL,
    [EDM_ISSUER_ID__RUNID]                  INT NOT NULL,
    [ADV_TOTAL_VOLUME__RUNID]               INT NOT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC) WITH (FILLFACTOR = 80)
);

