﻿CREATE TABLE [CADIS_PROC].[DC_UPBPSDVHIS_INFO_RUNID] (
    [STOCK]                    VARCHAR (20) NOT NULL,
    [ROW_ID]                   INT          NOT NULL,
    [ISIN__RUNID]              INT          NOT NULL,
    [ERROR_CODE__RUNID]        INT          NOT NULL,
    [DELIMITER__RUNID]         INT          NOT NULL,
    [NUM_OF_DIMENSIONS__RUNID] INT          NOT NULL,
    [NUM_OF_ROWS__RUNID]       INT          NOT NULL,
    [NUM_OF_COLS__RUNID]       INT          NOT NULL,
    [DECLARED_DATE__RUNID]     INT          NOT NULL,
    [EX_DATE__RUNID]           INT          NOT NULL,
    [RECORD_DATE__RUNID]       INT          NOT NULL,
    [PAYABLE_DATE__RUNID]      INT          NOT NULL,
    [DVD_VALUE__RUNID]         INT          NOT NULL,
    [FREQUENCY__RUNID]         INT          NOT NULL,
    [DVD_TYPE__RUNID]          INT          NOT NULL,
    [EDM_SEC_ID__RUNID]        INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([STOCK] ASC, [ROW_ID] ASC)
);

