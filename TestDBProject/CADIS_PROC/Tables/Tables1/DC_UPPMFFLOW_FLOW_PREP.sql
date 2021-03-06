﻿CREATE TABLE [CADIS_PROC].[DC_UPPMFFLOW_FLOW_PREP] (
    [FUND_SHORT_NAME]  VARCHAR (15)    NOT NULL,
    [THROUGH_DATE]     DATETIME        NOT NULL,
    [NTRANCATG]        VARCHAR (100)   NOT NULL,
    [NET_AMOUNT_BASE]  DECIMAL (38, 6) NULL,
    [RECOGNITION_DATE] DATETIME        NOT NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [THROUGH_DATE] ASC, [NTRANCATG] ASC, [RECOGNITION_DATE] ASC) WITH (FILLFACTOR = 80)
);

