﻿CREATE TABLE [dbo].[T_OVERRIDE_FND_FLOW] (
    [FUND_SHORT_NAME]           VARCHAR (15)    NOT NULL,
    [TRANSACTION_DATE]          DATETIME        NOT NULL,
    [FLOW_TYPE]                 VARCHAR (100)   NOT NULL,
    [MARKET_VALUE]              DECIMAL (20, 6) NULL,
    [RECOGNITION_DATE]          DATETIME        NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [TRANSACTION_DATE] ASC, [FLOW_TYPE] ASC, [RECOGNITION_DATE] ASC) WITH (FILLFACTOR = 90)
);

