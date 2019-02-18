CREATE TABLE [BCP].[T_BusinessContinuityTestEvents] (
    [ID]                       INT           IDENTITY (1, 1) NOT NULL,
    [BusinessContinuityTestID] INT           NULL,
    [OversightPersonID]        INT           NULL,
    [Year]                     INT           NULL,
    [Date]                     DATE          NULL,
    [StartTime]                TIME (7)      NULL,
    [Type]                     VARCHAR (255) NULL
);

