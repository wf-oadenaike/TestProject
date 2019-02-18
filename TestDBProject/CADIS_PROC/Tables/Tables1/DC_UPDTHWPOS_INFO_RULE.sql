CREATE TABLE [CADIS_PROC].[DC_UPDTHWPOS_INFO_RULE] (
    [EDM_SEC_ID__RULEID]         INT          NULL,
    [FILE_NAME__RULEID]          INT          NULL,
    [FILE_TYPE__RULEID]          INT          NULL,
    [FILE_DATE__RULEID]          INT          NULL,
    [CUSTOMER_CODE__RULEID]      INT          NULL,
    [MODEL_CODE]                 VARCHAR (20) NOT NULL,
    [MODEL_DATE__RULEID]         INT          NULL,
    [MODEL_DESCRIPTION__RULEID]  INT          NULL,
    [INSTRUMENT_UII]             VARCHAR (12) NOT NULL,
    [SEDOL__RULEID]              INT          NULL,
    [CURRENCY__RULEID]           INT          NULL,
    [STOCK_SHORT_NAME__RULEID]   INT          NULL,
    [SECTOR_CODE__RULEID]        INT          NULL,
    [UII_ALLOCATION_PCT__RULEID] INT          NULL,
    [CURRENT_PERCENTAGE__RULEID] INT          NULL,
    [CHANGE_PERCENTAGE__RULEID]  INT          NULL,
    [START_PRICE__RULEID]        INT          NULL,
    [START_PRICE_DATE__RULEID]   INT          NULL,
    [CURRENT_PRICE__RULEID]      INT          NULL,
    [CURRENT_DATE]               DATETIME     NOT NULL,
    PRIMARY KEY CLUSTERED ([MODEL_CODE] ASC, [INSTRUMENT_UII] ASC, [CURRENT_DATE] ASC) WITH (FILLFACTOR = 80)
);

