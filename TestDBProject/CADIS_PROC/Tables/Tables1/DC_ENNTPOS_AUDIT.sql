﻿CREATE TABLE [CADIS_PROC].[DC_ENNTPOS_AUDIT] (
    [TRADE_DATE]             DATETIME        NOT NULL,
    [POSITION]               DECIMAL (15, 2) NOT NULL,
    [ACCOUNT]                VARCHAR (15)    NOT NULL,
    [PRICE]                  DECIMAL (18, 2) NOT NULL,
    [UNIQUE_BLOOMBERG_ID]    VARCHAR (20)    NOT NULL,
    [CADIS_SYSTEM_RUNID]     INT             NOT NULL,
    [CADIS_SYSTEM_FIELDNAME] NVARCHAR (128)  NOT NULL,
    [CADIS_SYSTEM_RULEID]    INT             NULL,
    [CADIS_SYSTEM_NEWVAL]    SQL_VARIANT     NULL,
    PRIMARY KEY CLUSTERED ([TRADE_DATE] ASC, [POSITION] ASC, [ACCOUNT] ASC, [PRICE] ASC, [UNIQUE_BLOOMBERG_ID] ASC, [CADIS_SYSTEM_RUNID] ASC, [CADIS_SYSTEM_FIELDNAME] ASC)
);

