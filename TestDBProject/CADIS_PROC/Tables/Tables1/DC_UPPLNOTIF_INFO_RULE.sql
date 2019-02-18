﻿CREATE TABLE [CADIS_PROC].[DC_UPPLNOTIF_INFO_RULE] (
    [RUNID]                     INT           NOT NULL,
    [PROCESS_NAME]              VARCHAR (250) NOT NULL,
    [PROCESS_TYPE]              VARCHAR (50)  NOT NULL,
    [NOTIFICATION_SENT__RULEID] INT           NULL,
    [RUNSTART__RULEID]          INT           NULL,
    [RUNEND__RULEID]            INT           NULL,
    [RUNSUCCESSFUL__RULEID]     INT           NULL,
    PRIMARY KEY CLUSTERED ([RUNID] ASC, [PROCESS_NAME] ASC, [PROCESS_TYPE] ASC)
);

