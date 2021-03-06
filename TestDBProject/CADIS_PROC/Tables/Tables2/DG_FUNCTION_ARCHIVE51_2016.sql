﻿CREATE TABLE [CADIS_PROC].[DG_FUNCTION_ARCHIVE51_2016] (
    [ID]                      INT             NOT NULL,
    [IDENTIFIER]              INT             NOT NULL,
    [INSERTED]                DATETIME        NOT NULL,
    [CHANGEDBY]               NVARCHAR (256)  NOT NULL,
    [FIELDNAME]               NVARCHAR (200)  NOT NULL,
    [ACTION]                  TINYINT         NOT NULL,
    [OLDVALUE]                NVARCHAR (4000) NULL,
    [NEWVALUE]                NVARCHAR (4000) NULL,
    [VALIDATION]              NVARCHAR (4000) NULL,
    [CADIS_SYSTEM_ARCHIVED]   DATETIME        NULL,
    [KEY_MeetingOccurrenceId] INT             NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_ARCHIVE51_2016]([INSERTED] ASC);

