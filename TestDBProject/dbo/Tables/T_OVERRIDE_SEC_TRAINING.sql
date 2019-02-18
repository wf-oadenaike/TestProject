﻿CREATE TABLE [dbo].[T_OVERRIDE_SEC_TRAINING] (
    [EDM_SEC_ID]                     INT             NOT NULL,
    [SECURITY_NAME]                  VARCHAR (100)   NULL,
    [SECURITY_DESCRIPTION]           VARCHAR (200)   NULL,
    [SECURITY_SHORTNAME]             VARCHAR (30)    NULL,
    [ASSET_TYPE]                     VARCHAR (30)    NULL,
    [SECURITY_TYPE]                  VARCHAR (50)    NULL,
    [CUSIP]                          VARCHAR (9)     NULL,
    [ISIN]                           VARCHAR (12)    NULL,
    [SEDOL]                          VARCHAR (7)     NULL,
    [TICKER]                         VARCHAR (26)    NULL,
    [VALOREN]                        VARCHAR (12)    NULL,
    [WERTPAPIER]                     VARCHAR (12)    NULL,
    [SECURITY_ISO_CCY]               VARCHAR (3)     NULL,
    [RISK_ISO_CCY]                   VARCHAR (3)     NULL,
    [FIXED_ISO_CCY]                  VARCHAR (3)     NULL,
    [INCORPORATION_ISO_CTY]          VARCHAR (4)     NULL,
    [DOMICILE_ISO_CTY]               VARCHAR (4)     NULL,
    [ISSUE_COUNTRY_ISO]              VARCHAR (4)     NULL,
    [RISK_ISO_CTY]                   VARCHAR (4)     NULL,
    [MIC_EXCHANGE_CODE]              VARCHAR (4)     NULL,
    [STATE_CODE]                     VARCHAR (8)     NULL,
    [ACTIVE_TRADE_INDICATOR]         VARCHAR (1)     NULL,
    [144A_INDICATOR]                 VARCHAR (1)     NULL,
    [PRIVATE_PLACEMENT_INDICATOR]    VARCHAR (1)     NULL,
    [ILLIQUID]                       VARCHAR (1)     NULL,
    [QUOTE_TYPE]                     VARCHAR (8)     NULL,
    [DAYS_TO_SETTLE]                 INT             NULL,
    [TRADE_SETTLEMENT_CALENDAR_CODE] VARCHAR (4)     NULL,
    [CADIS_SYSTEM_INSERTED]          DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]           DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]         NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]          INT             DEFAULT ((1)) NULL,
    [UNIQUE_BLOOMBERG_ID]            VARCHAR (30)    NULL,
    [BBG_EXCHANGE_CODE]              VARCHAR (20)    NULL,
    [CADIS_SYSTEM_LASTMODIFIED]      DATETIME        DEFAULT (getdate()) NULL,
    [BBG_SECTOR]                     VARCHAR (20)    NULL,
    [BBG_SUBSECTOR]                  VARCHAR (20)    NULL,
    [BBG_GROUP]                      VARCHAR (20)    NULL,
    [IS_IPO]                         VARCHAR (20)    NULL,
    [PARSEKEYABLE_DESCRIPTION]       VARCHAR (100)   NULL,
    [SECURITY_IDENTIFIER]            VARCHAR (20)    NULL,
    [IRISH_SEDOL_NUMBER]             VARCHAR (20)    NULL,
    [ISSUER]                         VARCHAR (80)    NULL,
    [CUR_MAR_CAP]                    VARCHAR (20)    NULL,
    [PRIMARY_EXCHANGE_NAME]          VARCHAR (30)    NULL,
    [SECURITY_HAS_ADRS]              VARCHAR (4)     NULL,
    [CADIS_SYSTEM_TIMESTAMP]         ROWVERSION      NOT NULL,
    [WITHHOLDING_TAX]                DECIMAL (26, 6) NULL,
    [VOL_AVG_5D]                     DECIMAL (26, 6) NULL,
    [VOL_AVG_20D]                    DECIMAL (26, 6) NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC) WITH (FILLFACTOR = 80)
);

