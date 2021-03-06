﻿CREATE TABLE [dbo].[T_BBG_COMPLIANCE_RULE_REVISION_ATTRIBUTE_AFTER] (
    [CADIS_PARENT_ID]        VARCHAR (50)  NULL,
    [VALUE_VALUE_INNERTEXT]  VARCHAR (50)  NULL,
    [VALUE_VALUE_INNERTEXT2] VARCHAR (50)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_BBG_COM__CADIS__570385A5] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_BBG_COM__CADIS__57F7A9DE] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_BBG_COM__CADIS__58EBCE17] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           CONSTRAINT [DF__T_BBG_COM__CADIS__59DFF250] DEFAULT ((1)) NULL
);

