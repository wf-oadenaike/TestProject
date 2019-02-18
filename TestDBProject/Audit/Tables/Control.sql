CREATE TABLE [Audit].[Control] (
    [ControlId]             BIGINT   NOT NULL,
    [RunInitiationDate]     DATETIME CONSTRAINT [DF_Control_RunInitiationDate] DEFAULT (getdate()) NOT NULL,
    [CurrentRunStartDate]   DATETIME CONSTRAINT [DF_Control_CurrentRunStartDate] DEFAULT (getdate()) NOT NULL,
    [RunStateId]            INT      CONSTRAINT [DF_Control_RunStateId] DEFAULT ('-1') NOT NULL,
    [ExtractPointStartDate] DATETIME CONSTRAINT [DF_Control_ExtractPointStartDate] DEFAULT ('01/01/1900') NULL,
    [ExtractPointEndDate]   DATETIME CONSTRAINT [DF_Control_ExtractPointEndDate] DEFAULT ('01/01/1989') NULL,
    [ScheduleId]            INT      NOT NULL,
    CONSTRAINT [XPKControl] PRIMARY KEY CLUSTERED ([ControlId] ASC)
);

