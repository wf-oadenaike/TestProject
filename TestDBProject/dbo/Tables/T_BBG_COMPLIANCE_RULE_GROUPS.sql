﻿CREATE TABLE [dbo].[T_BBG_COMPLIANCE_RULE_GROUPS] (
    [CADIS_PARENT_ID]             VARCHAR (50)  NULL,
    [RULEGROUP_FOLDERNAME]        VARCHAR (50)  NULL,
    [RULEGROUP_FOLDERNUM]         VARCHAR (50)  NULL,
    [RULEGROUP_GROUPFOLDERITEMID] VARCHAR (50)  NULL,
    [RULEGROUP_RULEGROUPNAME]     VARCHAR (50)  NULL,
    [RULEGROUP_RULEGROUPNUM]      VARCHAR (50)  NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]       INT           DEFAULT ((1)) NULL
);

