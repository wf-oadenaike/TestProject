CREATE TABLE [Operation].[InvestmentOpsEvents] (
    [InvestmentOpsEventId]              INT              IDENTITY (1, 1) NOT NULL,
    [InvestmentOpsDailyTasksRegisterId] INT              NOT NULL,
    [InvestmentOpsEventDate]            DATETIME         NOT NULL,
    [InvestmentOpsEventStatus]          VARCHAR (10)     NOT NULL,
    [JIRAIssueKey]                      VARCHAR (128)    NOT NULL,
    [JoinGUID]                          UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]             DATETIME         CONSTRAINT [DF_IOE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]              DATETIME         CONSTRAINT [DF_IOE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]            NVARCHAR (50)    CONSTRAINT [DF_IOE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]             INT              CONSTRAINT [DF_IOE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]            ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]         DATETIME         CONSTRAINT [DF_IOE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKInvestmentOpsEvents] PRIMARY KEY CLUSTERED ([InvestmentOpsEventId] ASC),
    CONSTRAINT [InvestmentOpsEventsInvestmentOpsDailyTasksRegisterId] FOREIGN KEY ([InvestmentOpsDailyTasksRegisterId]) REFERENCES [Operation].[InvestmentOpsDailyTasksRegister] ([InvestmentOpsDailyTasksRegisterId])
);

