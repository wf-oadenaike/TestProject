﻿CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT24_ARCHIVED_20180201_124039] (
    [ID]              INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]      INT             NOT NULL,
    [INSERTED]        DATETIME        NOT NULL,
    [CHANGEDBY]       NVARCHAR (256)  NOT NULL,
    [FIELDNAME]       NVARCHAR (200)  NOT NULL,
    [ACTION]          TINYINT         NOT NULL,
    [OLDVALUE]        NVARCHAR (4000) NULL,
    [NEWVALUE]        NVARCHAR (4000) NULL,
    [VALIDATION]      NVARCHAR (4000) NULL,
    [KEY_ConflictId]  INT             NOT NULL,
    [KEY_MeetingDate] DATETIME        NOT NULL
);

