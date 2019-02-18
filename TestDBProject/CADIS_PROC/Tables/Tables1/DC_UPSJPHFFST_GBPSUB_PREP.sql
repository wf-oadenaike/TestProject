﻿CREATE TABLE [CADIS_PROC].[DC_UPSJPHFFST_GBPSUB_PREP] (
    [ROW_NUMBER]           INT             NOT NULL,
    [TRANSACTION_DATE]     DATETIME        NULL,
    [MARKET_VALUE]         DECIMAL (38, 2) NULL,
    [FLOW_TYPE]            VARCHAR (12)    NOT NULL,
    [SETTLEMENT_DATE]      DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED] DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC) WITH (FILLFACTOR = 80)
);

