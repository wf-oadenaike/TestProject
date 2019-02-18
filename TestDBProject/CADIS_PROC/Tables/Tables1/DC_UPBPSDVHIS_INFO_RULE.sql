CREATE TABLE [CADIS_PROC].[DC_UPBPSDVHIS_INFO_RULE] (
    [STOCK]                     VARCHAR (20) NOT NULL,
    [ROW_ID]                    INT          NOT NULL,
    [ISIN__RULEID]              INT          NULL,
    [ERROR_CODE__RULEID]        INT          NULL,
    [DELIMITER__RULEID]         INT          NULL,
    [NUM_OF_DIMENSIONS__RULEID] INT          NULL,
    [NUM_OF_ROWS__RULEID]       INT          NULL,
    [NUM_OF_COLS__RULEID]       INT          NULL,
    [DECLARED_DATE__RULEID]     INT          NULL,
    [EX_DATE__RULEID]           INT          NULL,
    [RECORD_DATE__RULEID]       INT          NULL,
    [PAYABLE_DATE__RULEID]      INT          NULL,
    [DVD_VALUE__RULEID]         INT          NULL,
    [FREQUENCY__RULEID]         INT          NULL,
    [DVD_TYPE__RULEID]          INT          NULL,
    [EDM_SEC_ID__RULEID]        INT          NULL,
    PRIMARY KEY CLUSTERED ([STOCK] ASC, [ROW_ID] ASC)
);

