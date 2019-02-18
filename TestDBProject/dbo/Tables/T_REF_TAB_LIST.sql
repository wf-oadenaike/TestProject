﻿CREATE TABLE [dbo].[T_REF_TAB_LIST] (
    [TAB_LIST_ID]            INT           IDENTITY (1, 1) NOT NULL,
    [LIST_TYPE]              VARCHAR (50)  NULL,
    [LIST_VALUE]             VARCHAR (50)  NULL,
    [LIST_ORDER]             INT           NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION    NOT NULL,
    PRIMARY KEY CLUSTERED ([TAB_LIST_ID] ASC) WITH (FILLFACTOR = 80)
);
