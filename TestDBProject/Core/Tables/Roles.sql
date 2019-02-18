CREATE TABLE [Core].[Roles] (
    [RoleId]                   SMALLINT     IDENTITY (1, 1) NOT NULL,
    [RoleName]                 [sysname]    NOT NULL,
    [ActiveFlag]               BIT          CONSTRAINT [DF_R_AF] DEFAULT ((0)) NOT NULL,
    [RoleNameSCD1]             [sysname]    NULL,
    [ControlId]                BIGINT       NULL,
    [RoleBK]                   VARCHAR (18) NOT NULL,
    [SourceSystemId]           SMALLINT     NULL,
    [RoleCreationDatetime]     DATETIME     CONSTRAINT [DF_R_RCDT] DEFAULT (getdate()) NOT NULL,
    [RoleLastModifiedDatetime] DATETIME     CONSTRAINT [DF_R_RLMDT] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([RoleId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIXRoleName]
    ON [Core].[Roles]([RoleName] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIXRoleBK]
    ON [Core].[Roles]([RoleBK] ASC);

