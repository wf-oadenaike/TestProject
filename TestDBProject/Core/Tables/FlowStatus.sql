CREATE TABLE [Core].[FlowStatus] (
    [FlowStatusId]           INT           IDENTITY (1, 1) NOT NULL,
    [FlowStatusName]         VARCHAR (100) NOT NULL,
    [FlowStatusCategory]     VARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) NULL,
    CONSTRAINT [PKFlowStatus] PRIMARY KEY CLUSTERED ([FlowStatusId] ASC) WITH (FILLFACTOR = 80)
);

