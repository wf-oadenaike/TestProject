CREATE TABLE [Investment].[DepartmentalBudgets] (
    [DepartmentBudgetId]                     INT             IDENTITY (1, 1) NOT NULL,
    [DepartmentId]                           SMALLINT        NOT NULL,
    [MonthNumber]                            INT             NOT NULL,
    [CalendarYear]                           INT             NOT NULL,
    [ActualAmount]                           DECIMAL (19, 5) NULL,
    [ForecastAmount]                         DECIMAL (19, 5) NULL,
    [DepartmentalBudgetCreationDatetime]     DATETIME        CONSTRAINT [DF_DB_DBCDT] DEFAULT (getdate()) NOT NULL,
    [DepartmentalBudgetLastModifiedDatetime] DATETIME        CONSTRAINT [DF_DB_DBLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKDepartmentalBudgets] PRIMARY KEY CLUSTERED ([DepartmentBudgetId] ASC),
    CONSTRAINT [DepartmentalBudgetsDepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Core].[Departments] ([DepartmentId])
);

