CREATE TABLE [BCP].[T_DepartmentCriticalFunctionTests] (
    [ID]              INT           IDENTITY (1, 1) NOT NULL,
    [DepartmentID]    INT           NULL,
    [Requirement]     VARCHAR (255) NULL,
    [SuccessCriteria] VARCHAR (255) NULL,
    [IsActive]        BIT           NULL
);

