CREATE TABLE [BCP].[T_DepartmentCriticalFunctionTestEvents] (
    [ID]                               INT           IDENTITY (1, 1) NOT NULL,
    [DepartmentContinuityTestEventID]  INT           NULL,
    [DepartmentCriticalFunctionTestID] INT           NULL,
    [TesterPersonID]                   INT           NULL,
    [Result]                           VARCHAR (255) NULL,
    [Comments]                         VARCHAR (255) NULL
);

