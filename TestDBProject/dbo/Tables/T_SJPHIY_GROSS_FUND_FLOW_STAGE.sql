﻿CREATE TABLE [dbo].[T_SJPHIY_GROSS_FUND_FLOW_STAGE] (
    [ROW_NUMBER]                INT             NOT NULL,
    [TYPE]                      VARCHAR (20)    NOT NULL,
    [FUND]                      VARCHAR (50)    NULL,
    [TRANSACTION_DATE]          DATETIME        NULL,
    [FUND_FLOW_TYPE]            VARCHAR (20)    NULL,
    [FLOW_TYPE]                 VARCHAR (100)   NULL,
    [SETTLEMENT_DATE]           DATETIME        NULL,
    [MARKET_VALUE]              DECIMAL (18, 2) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        CONSTRAINT [DF__T_SJPHIY___CADIS__0576BDD0] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        CONSTRAINT [DF__T_SJPHIY___CADIS__066AE209] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   CONSTRAINT [DF__T_SJPHIY___CADIS__075F0642] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             CONSTRAINT [DF__T_SJPHIY___CADIS__08532A7B] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        CONSTRAINT [DF__T_SJPHIY___CADIS__09474EB4] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__T_SJPHIY__EED2195991D3B98B] PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC) WITH (FILLFACTOR = 90)
);
