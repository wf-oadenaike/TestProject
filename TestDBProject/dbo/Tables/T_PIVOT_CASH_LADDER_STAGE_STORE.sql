CREATE TABLE [dbo].[T_PIVOT_CASH_LADDER_STAGE_STORE] (
    [PIVOT_CASH_LADDER_ID]   INT             IDENTITY (1, 1) NOT NULL,
    [ReportDate]             DATETIME        NULL,
    [Fund]                   NVARCHAR (50)   NULL,
    [CCY]                    NVARCHAR (5)    NULL,
    [AsOfDate]               DATE            NULL,
    [Value]                  DECIMAL (18, 6) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([PIVOT_CASH_LADDER_ID] ASC)
);

