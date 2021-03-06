﻿CREATE TABLE [CADIS_SYS].[MQ_QUEUE] (
    [ID]   INT           IDENTITY (1, 1) NOT NULL,
    [NAME] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_MQ_QUEUE] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MQ_QUEUE]
    ON [CADIS_SYS].[MQ_QUEUE]([NAME] ASC);

