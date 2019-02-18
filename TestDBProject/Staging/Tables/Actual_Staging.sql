CREATE TABLE [Staging].[Actual_Staging] (
    [ActualId]         VARCHAR (25)    COLLATE SQL_Latin1_General_CP1_CS_AS NOT NULL,
    [OwnerId]          VARCHAR (25)    NOT NULL,
    [Subject]          NVARCHAR (1000) NULL,
    [ActivityDate]     DATETIME        NULL,
    [Type]             VARCHAR (50)    NULL,
    [Status]           VARCHAR (50)    NULL,
    [AccountId]        VARCHAR (25)    NULL,
    [Description]      NVARCHAR (MAX)  NULL,
    [IsActive]         BIT             DEFAULT ((0)) NOT NULL,
    [PlanActivityType] VARCHAR (50)    NULL
);

