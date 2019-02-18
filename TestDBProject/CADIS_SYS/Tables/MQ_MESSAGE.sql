﻿CREATE TABLE [CADIS_SYS].[MQ_MESSAGE] (
    [ID]                    INT            IDENTITY (1, 1) NOT NULL,
    [QUEUEID]               INT            NOT NULL,
    [PRIORITY]              TINYINT        NULL,
    [LABEL]                 NVARCHAR (100) NULL,
    [MESSAGE]               NVARCHAR (MAX) NOT NULL,
    [CADIS_SYSTEM_INSERTED] DATETIME       CONSTRAINT [DF_MQ_MESSAGE_CADIS_SYSTEM_INSERTED] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_MQ_MESSAGE] PRIMARY KEY CLUSTERED ([QUEUEID] ASC, [ID] ASC),
    CONSTRAINT [FK_MQ_MESSAGE_MQ_QUEUE] FOREIGN KEY ([QUEUEID]) REFERENCES [CADIS_SYS].[MQ_QUEUE] ([ID])
);


GO
CREATE NONCLUSTERED INDEX [IX_MQ_MESSAGE]
    ON [CADIS_SYS].[MQ_MESSAGE]([PRIORITY] ASC, [ID] ASC);
