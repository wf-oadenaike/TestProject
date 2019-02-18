CREATE TABLE [Investment].[ResearchBrokerBudgetChanges] (
    [BudgetChangeId]                   INT              NOT NULL,
    [ResearchBrokerId]                 INT              NOT NULL,
    [PerformanceChange]                BIT              NULL,
    [ResourceChange]                   BIT              NULL,
    [SectorChange]                     BIT              NULL,
    [BudgetChangeComments]             VARCHAR (MAX)    NULL,
    [ChangeAmount]                     DECIMAL (19, 2)  NULL,
    [BudgetAmendmentDate]              DATETIME         NOT NULL,
    [AmendedByPersonId]                SMALLINT         NOT NULL,
    [DocumentationFolderLink]          VARCHAR (2000)   NULL,
    [JoinGUID]                         UNIQUEIDENTIFIER NOT NULL,
    [BudgetChangeCreationDatetime]     DATETIME         NOT NULL,
    [BudgetChangeLastModifiedDatetime] DATETIME         NOT NULL
);

