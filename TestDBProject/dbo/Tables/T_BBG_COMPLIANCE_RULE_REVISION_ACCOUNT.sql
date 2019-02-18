﻿CREATE TABLE [dbo].[T_BBG_COMPLIANCE_RULE_REVISION_ACCOUNT] (
    [CADIS_PARENT_ID]           VARCHAR (50)  NULL,
    [EVALUATION_EVALTYPEAFTER]  VARCHAR (50)  NULL,
    [EVALUATION_EVALTYPEBEFORE] VARCHAR (50)  NULL,
    [SCOPE_ACCOUNTNAMEAFTER]    VARCHAR (50)  NULL,
    [SCOPE_ACCOUNTNAMEBEFORE]   VARCHAR (50)  NULL,
    [SCOPE_ACCOUNTTYPEAFTER]    VARCHAR (50)  NULL,
    [SCOPE_ACCOUNTTYPEBEFORE]   VARCHAR (50)  NULL,
    [SCOPE_BROKERNAMEAFTER]     VARCHAR (50)  NULL,
    [SCOPE_BROKERNAMEBEFORE]    VARCHAR (50)  NULL,
    [SCOPE_BROKERTYPEAFTER]     VARCHAR (50)  NULL,
    [SCOPE_BROKERTYPEBEFORE]    VARCHAR (50)  NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF__T_BBG_COM__CADIS__47C14215] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF__T_BBG_COM__CADIS__48B5664E] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF__T_BBG_COM__CADIS__49A98A87] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF__T_BBG_COM__CADIS__4A9DAEC0] DEFAULT ((1)) NULL
);
