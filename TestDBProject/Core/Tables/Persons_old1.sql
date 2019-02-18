CREATE TABLE [Core].[Persons_old1] (
    [PersonId]            SMALLINT      IDENTITY (1, 1) NOT NULL,
    [DepartmentId]        SMALLINT      NULL,
    [PersonsName]         [sysname]     NULL,
    [ControlId]           BIGINT        NOT NULL,
    [DepartmentHead]      BIT           CONSTRAINT [DF_P_DH1] DEFAULT ((0)) NOT NULL,
    [EmployeeBK]          VARCHAR (15)  NULL,
    [FullEmployeeBK]      VARCHAR (18)  NULL,
    [SourceSystemId]      SMALLINT      NOT NULL,
    [ActiveFlag]          BIT           CONSTRAINT [DF_P_AF1] DEFAULT ((1)) NOT NULL,
    [ActiveFlagDateTime]  DATETIME      CONSTRAINT [DF_P_AFDT1] DEFAULT (getdate()) NOT NULL,
    [ContactEmailAddress] VARCHAR (256) NULL,
    [PerInitials]         VARCHAR (5)   NULL,
    [UserBK]              VARCHAR (18)  NULL,
    [JobTitle]            [sysname]     NULL,
    [EmploymentState]     [sysname]     NULL,
    [EmployeeIdBK]        VARCHAR (18)  NULL,
    [IsTeamLeader]        BIT           NULL,
    [BloombergID]         VARCHAR (20)  NULL,
    CONSTRAINT [XPKPersons1] PRIMARY KEY CLUSTERED ([PersonId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [PersonsDepartmentId1] FOREIGN KEY ([DepartmentId]) REFERENCES [Core].[Departments] ([DepartmentId]),
    CONSTRAINT [PersonsSourceSystemId1] FOREIGN KEY ([SourceSystemId]) REFERENCES [Audit].[SourceSystems] ([SourceSystemId])
);

