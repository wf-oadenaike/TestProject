﻿CREATE TABLE [CADIS_PROC].[DM_MP1_RESULT_ARCHIVE_2015] (
    [AUDITDATE]    DATETIME       NOT NULL,
    [SOURCEID]     INT            NOT NULL,
    [SOURCEROWID]  INT            NOT NULL,
    [RESULTID]     INT            NOT NULL,
    [CADISID]      INT            NOT NULL,
    [PRIORITY]     TINYINT        NOT NULL,
    [RULEID]       INT            NOT NULL,
    [PROVISIONAL]  TINYINT        NOT NULL,
    [INSERTED]     DATETIME       NOT NULL,
    [UPDATED]      DATETIME       NOT NULL,
    [CHANGEDBY]    NVARCHAR (100) NOT NULL,
    [ARCHIVE_DATE] DATETIME       NOT NULL
);

