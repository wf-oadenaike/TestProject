﻿CREATE TABLE [Fact].[FinancialsFact] (
    [FinancialFactId]     BIGINT        IDENTITY (1, 1) NOT NULL,
    [DepartmentId]        SMALLINT      NOT NULL,
    [PostingDateId]       INT           NOT NULL,
    [TransactionDateId]   INT           NOT NULL,
    [BudgetAmount]        MONEY         NULL,
    [ActualAmount]        MONEY         NULL,
    [ControlId]           BIGINT        NOT NULL,
    [SourceSystemId]      SMALLINT      NOT NULL,
    [FinancialLineTypeId] SMALLINT      NOT NULL,
    [AccountRef]          VARCHAR (20)  NULL,
    [NominalCode]         INT           NOT NULL,
    [TransactionNo]       INT           CONSTRAINT [DF_FF_TN] DEFAULT ((-1)) NOT NULL,
    [TaxCode]             CHAR (3)      NULL,
    [DetailNotes]         VARCHAR (255) NULL,
    [ProjectCode]         VARCHAR (31)  NULL,
    [TransactionTypeId]   SMALLINT      CONSTRAINT [DF_FF_TTI] DEFAULT ((-1)) NOT NULL,
    [IsDiscretionary]     BIT           NULL,
    [CountOf]             INT           CONSTRAINT [DF_FF_CO] DEFAULT ((1)) NOT NULL,
    [CurrentRow]          BIT           CONSTRAINT [DF_FF_CR] DEFAULT ((1)) NOT NULL,
    [CurrentRowSwitchId]  BIGINT        CONSTRAINT [DF_FF_CRSI] DEFAULT ((-1)) NOT NULL,
    [DeletedRow]          BIT           CONSTRAINT [DF_FF_DR] DEFAULT ((0)) NOT NULL,
    [JournalLineID]       VARCHAR (100) NOT NULL,
    CONSTRAINT [XPKFinancialsFact] PRIMARY KEY CLUSTERED ([DepartmentId] ASC, [PostingDateId] ASC, [TransactionDateId] ASC, [FinancialLineTypeId] ASC, [CurrentRow] ASC, [CurrentRowSwitchId] ASC, [DeletedRow] ASC, [JournalLineID] ASC),
    CONSTRAINT [FinancialsFactAccountSuppliers] FOREIGN KEY ([AccountRef]) REFERENCES [Finance].[AccountSuppliers] ([AccountRef]),
    CONSTRAINT [FinancialsFactDepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Core].[Departments] ([DepartmentId]),
    CONSTRAINT [FinancialsFactFinancialLineTypeId] FOREIGN KEY ([FinancialLineTypeId]) REFERENCES [Finance].[FinancialLineTypes] ([FinancialLineTypeId]),
    CONSTRAINT [FinancialsFactNominalCodes] FOREIGN KEY ([NominalCode]) REFERENCES [Finance].[AccountNominalCodes] ([NominalCode]),
    CONSTRAINT [FinancialsFactPostingDateId] FOREIGN KEY ([PostingDateId]) REFERENCES [Core].[Calendar] ([CalendarId]),
    CONSTRAINT [FinancialsFactProjectCode] FOREIGN KEY ([ProjectCode]) REFERENCES [Finance].[AccountProjects] ([ProjectCode]),
    CONSTRAINT [FinancialsFactSourceSystemId] FOREIGN KEY ([SourceSystemId]) REFERENCES [Audit].[SourceSystems] ([SourceSystemId]),
    CONSTRAINT [FinancialsFactTransactionDateId] FOREIGN KEY ([TransactionDateId]) REFERENCES [Core].[Calendar] ([CalendarId]),
    CONSTRAINT [FinancialsFactTransactionTypeId] FOREIGN KEY ([TransactionTypeId]) REFERENCES [Finance].[TransactionTypes] ([TransactionTypeId])
);


GO
CREATE NONCLUSTERED INDEX [IX1_FiancialsFact]
    ON [Fact].[FinancialsFact]([CurrentRow] ASC)
    INCLUDE([TransactionDateId], [BudgetAmount], [ActualAmount], [NominalCode], [FinancialLineTypeId]);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IXU_FiancialsFact]
    ON [Fact].[FinancialsFact]([FinancialFactId] ASC);


GO
CREATE NONCLUSTERED INDEX [FinancialsFact_idx]
    ON [Fact].[FinancialsFact]([FinancialLineTypeId] ASC, [CurrentRow] ASC, [DeletedRow] ASC)
    INCLUDE([FinancialFactId], [DepartmentId], [TransactionDateId], [BudgetAmount], [NominalCode]);

