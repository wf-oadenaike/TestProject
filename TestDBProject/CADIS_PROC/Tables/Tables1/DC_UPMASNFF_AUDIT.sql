﻿CREATE TABLE [CADIS_PROC].[DC_UPMASNFF_AUDIT] (
    [ACCOUNT_NUMBER]         VARCHAR (50)    NOT NULL,
    [TNARRLONG]              VARCHAR (255)   NOT NULL,
    [NET_AMOUNT__BASE]       DECIMAL (20, 6) NOT NULL,
    [RECOGNITION_DATE]       DATETIME        NOT NULL,
    [NTRANCATG]              VARCHAR (100)   NOT NULL,
    [IEXTLREF]               VARCHAR (50)    NOT NULL,
    [CADIS_SYSTEM_RUNID]     INT             NOT NULL,
    [CADIS_SYSTEM_FIELDNAME] NVARCHAR (128)  NOT NULL,
    [CADIS_SYSTEM_RULEID]    INT             NULL,
    [CADIS_SYSTEM_NEWVAL]    SQL_VARIANT     NULL,
    PRIMARY KEY CLUSTERED ([ACCOUNT_NUMBER] ASC, [TNARRLONG] ASC, [NET_AMOUNT__BASE] ASC, [RECOGNITION_DATE] ASC, [NTRANCATG] ASC, [IEXTLREF] ASC, [CADIS_SYSTEM_RUNID] ASC, [CADIS_SYSTEM_FIELDNAME] ASC)
);
