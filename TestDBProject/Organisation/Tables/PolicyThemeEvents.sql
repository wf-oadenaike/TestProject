CREATE TABLE [Organisation].[PolicyThemeEvents] (
    [PolicyThemeEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [PolicyThemeRegisterId]                INT              NOT NULL,
    [PolicyThemeEventTypeId]               SMALLINT         NOT NULL,
    [ReviewCollection]                     INT              CONSTRAINT [PolicyThemeEventsReviewCollection] DEFAULT (NEXT VALUE FOR [Organisation].[PolicyThemeEventCollectionSeq]) NOT NULL,
    [PersonId]                             SMALLINT         CONSTRAINT [DF_PTE_PI] DEFAULT ((-1)) NOT NULL,
    [RoleId]                               SMALLINT         CONSTRAINT [DF_PTE_RI] DEFAULT ((-1)) NOT NULL,
    [EventDetails]                         VARCHAR (MAX)    NULL,
    [EventDate]                            DATETIME         NULL,
    [EventTrueFalse]                       BIT              NULL,
    [DocumentationFolderLink]              VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]                  UNIQUEIDENTIFIER NULL,
    [JoinGUID]                             UNIQUEIDENTIFIER NULL,
    [PolicyThemeEventCreationDatetime]     DATETIME         CONSTRAINT [DF_PTE_PTECDT] DEFAULT (getdate()) NOT NULL,
    [PolicyThemeEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PTE_PTELMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKPolicyThemeEvents] PRIMARY KEY CLUSTERED ([PolicyThemeRegisterId] ASC, [PolicyThemeEventTypeId] ASC, [ReviewCollection] ASC, [PersonId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIXPolicyProceduresEvents]
    ON [Organisation].[PolicyThemeEvents]([PolicyThemeEventId] ASC);

