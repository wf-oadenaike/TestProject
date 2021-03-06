﻿CREATE TABLE [CADIS_SYS].[CO_SECURITYROLE_AUDIT] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [CHANGEDBY]   NVARCHAR (256) NOT NULL,
    [CHANGEDDATE] DATETIME       CONSTRAINT [DF_CO_SECURITYROLE_AUDIT_CHANGEDDATE] DEFAULT (getdate()) NOT NULL,
    [ACTIONTYPE]  NVARCHAR (6)   NOT NULL,
    [ROLENAME]    NVARCHAR (128) NOT NULL,
    [MEMBERNAME]  NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_CO_SECURITYROLE_AUDIT] PRIMARY KEY CLUSTERED ([ID] ASC)
);

