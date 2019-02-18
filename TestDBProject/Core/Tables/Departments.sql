CREATE TABLE [Core].[Departments] (
    [DepartmentId]                   SMALLINT     IDENTITY (1, 1) NOT NULL,
    [DepartmentName]                 [sysname]    NOT NULL,
    [DepartmentNumber]               SMALLINT     NOT NULL,
    [ControlId]                      BIGINT       NOT NULL,
    [ActiveFlag]                     BIT          CONSTRAINT [DF_D_AF] DEFAULT ((1)) NOT NULL,
    [ActiveFlagDateTime]             DATETIME     CONSTRAINT [DF_D_AFDT] DEFAULT (getdate()) NOT NULL,
    [DepartmentSrcId]                VARCHAR (18) NOT NULL,
    [SourceSystemId]                 SMALLINT     NOT NULL,
    [DepartmentCreationDatetime]     DATETIME     CONSTRAINT [DF_D_DCDT] DEFAULT (getdate()) NOT NULL,
    [DepartmentLastModifiedDatetime] DATETIME     CONSTRAINT [DF_D_DLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKDepartments] PRIMARY KEY CLUSTERED ([DepartmentId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIXDepartments]
    ON [Core].[Departments]([DepartmentNumber] ASC);

