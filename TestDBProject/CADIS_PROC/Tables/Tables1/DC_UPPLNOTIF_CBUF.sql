﻿CREATE TABLE [CADIS_PROC].[DC_UPPLNOTIF_CBUF] (
    [RUNID]        INT           NOT NULL,
    [PROCESS_NAME] VARCHAR (250) NOT NULL,
    [PROCESS_TYPE] VARCHAR (50)  NOT NULL,
    PRIMARY KEY CLUSTERED ([RUNID] ASC, [PROCESS_NAME] ASC, [PROCESS_TYPE] ASC)
);

