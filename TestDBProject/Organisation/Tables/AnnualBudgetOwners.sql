CREATE TABLE [Organisation].[AnnualBudgetOwners] (
    [DepartmentId]            SMALLINT     NOT NULL,
    [BudgetOwnerPersonId]     SMALLINT     NOT NULL,
    [BoxFolderId]             VARCHAR (50) NULL,
    [BoxProjectFolderId]      VARCHAR (50) NULL,
    [BudgetOwnerCreationDate] DATETIME     CONSTRAINT [DF_ABO_BOCD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKAnnualBudgetOwners] PRIMARY KEY CLUSTERED ([DepartmentId] ASC, [BudgetOwnerPersonId] ASC),
    CONSTRAINT [AnnualBudgetOwnerBudgetOwnerPersonId] FOREIGN KEY ([BudgetOwnerPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [AnnualBudgetOwnerDepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Core].[Departments] ([DepartmentId])
);

