CREATE TABLE [Sales.BP].[Actual] (
    [ActualId]                   VARCHAR (25)    NOT NULL,
    [OwnerId]                    VARCHAR (25)    NOT NULL,
    [Subject]                    NVARCHAR (1000) NULL,
    [ActivityDate]               DATETIME        NULL,
    [Type]                       VARCHAR (50)    NULL,
    [Status]                     VARCHAR (50)    NULL,
    [AccountId]                  VARCHAR (25)    NULL,
    [Description]                NVARCHAR (MAX)  NULL,
    [PlanActivityType]           VARCHAR (50)    NULL,
    [IsActive]                   BIT             NOT NULL,
    [ActualCreationDatetime]     DATETIME        CONSTRAINT [DF_ACT_ACTCDT] DEFAULT (getdate()) NOT NULL,
    [ActualLastModifiedDatetime] DATETIME        CONSTRAINT [DF_ACT_ACTLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKActualId] PRIMARY KEY CLUSTERED ([ActualId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_SBPA_1]
    ON [Sales.BP].[Actual]([OwnerId] ASC, [IsActive] ASC)
    INCLUDE([ActivityDate], [Type], [Status], [AccountId], [Description]);

