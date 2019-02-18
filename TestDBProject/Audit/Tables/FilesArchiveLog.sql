CREATE TABLE [Audit].[FilesArchiveLog] (
    [FileArchiveDateTime] DATETIME      NOT NULL,
    [FileName]            VARCHAR (150) NULL,
    [LoadSource]          VARCHAR (20)  NULL
);

