﻿CREATE TABLE [dbo].[T_OVERRIDE_CASH_LADDER_FUND] (
    [OVERRIDE_ID]            INT              NOT NULL,
    [FUND_SHORT_NAME]        VARCHAR (15)     NOT NULL,
    [VALUE]                  DECIMAL (38, 15) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([OVERRIDE_ID] ASC, [FUND_SHORT_NAME] ASC) WITH (FILLFACTOR = 80)
);
