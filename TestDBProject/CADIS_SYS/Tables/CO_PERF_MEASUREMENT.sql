﻿CREATE TABLE [CADIS_SYS].[CO_PERF_MEASUREMENT] (
    [ID]        BIGINT        IDENTITY (1, 1) NOT NULL,
    [DATE]      DATETIME      NOT NULL,
    [SESSIONID] VARCHAR (50)  NOT NULL,
    [KEY]       VARCHAR (255) NOT NULL,
    [VALUE]     FLOAT (53)    NULL,
    CONSTRAINT [PK_CO_PERF_MEASUREMENT] PRIMARY KEY CLUSTERED ([ID] ASC)
);
