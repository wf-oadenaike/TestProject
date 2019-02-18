CREATE TABLE [Audit].[ETL_Log] (
    [ItemStartDateTime] DATETIME      NOT NULL,
    [ItemEndDateTime]   DATETIME      NULL,
    [FileName]          VARCHAR (256) NULL,
    [LoadStatus]        VARCHAR (50)  NULL,
    [ProcessName]       VARCHAR (50)  NULL,
    [ErrorMessage]      VARCHAR (256) NULL,
    [MailSent]          BIT           NULL,
    [LoadSource]        VARCHAR (20)  NULL
);

