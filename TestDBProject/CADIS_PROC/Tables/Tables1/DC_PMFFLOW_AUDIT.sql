﻿CREATE TABLE [CADIS_PROC].[DC_PMFFLOW_AUDIT] (
    [FUND_SHORT_NAME]        VARCHAR (15)   NOT NULL,
    [TRANSACTION_DATE]       DATETIME       NOT NULL,
    [CURRENCY]               VARCHAR (20)   NOT NULL,
    [FUND_FLOW_TYPE]         VARCHAR (20)   NOT NULL,
    [FLOW_TYPE]              VARCHAR (100)  NOT NULL,
    [SOURCE_TYPE]            VARCHAR (20)   DEFAULT ('CONFIRMED') NOT NULL,
    [CADIS_SYSTEM_RUNID]     INT            NOT NULL,
    [CADIS_SYSTEM_FIELDNAME] NVARCHAR (128) NOT NULL,
    [CADIS_SYSTEM_RULEID]    INT            NULL,
    [CADIS_SYSTEM_NEWVAL]    SQL_VARIANT    NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [TRANSACTION_DATE] ASC, [CURRENCY] ASC, [FUND_FLOW_TYPE] ASC, [FLOW_TYPE] ASC, [SOURCE_TYPE] ASC, [CADIS_SYSTEM_RUNID] ASC, [CADIS_SYSTEM_FIELDNAME] ASC)
);

