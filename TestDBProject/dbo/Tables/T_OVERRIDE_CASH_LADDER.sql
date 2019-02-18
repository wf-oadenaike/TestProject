﻿CREATE TABLE [dbo].[T_OVERRIDE_CASH_LADDER] (
    [OVERRIDE_ID]            INT           IDENTITY (1, 1) NOT NULL,
    [DESCRIPTION]            VARCHAR (100) NULL,
    [AS_OF_DATE]             DATETIME      NOT NULL,
    [CCY]                    VARCHAR (3)   NOT NULL,
    [ACTIVE]                 BIT           NULL,
    [COMMENTS]               VARCHAR (200) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([OVERRIDE_ID] ASC) WITH (FILLFACTOR = 80)
);

