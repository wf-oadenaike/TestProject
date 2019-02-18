CREATE TABLE [CADIS_PROC].[DC_UBPSDVHISA_STAGE_PREP] (
    [STOCK]                  VARCHAR (20)    NOT NULL,
    [ROW_ID]                 INT             NOT NULL,
    [AS_AT_DATE]             DATETIME        NOT NULL,
    [ERROR_CODE]             INT             NULL,
    [DELIMITER]              INT             NULL,
    [NUM_OF_DIMENSIONS]      INT             NULL,
    [NUM_OF_ROWS]            INT             NULL,
    [NUM_OF_COLS]            INT             NULL,
    [DECLARED_DATE]          DATE            NULL,
    [EX_DATE]                DATE            NULL,
    [RECORD_DATE]            DATE            NULL,
    [PAYABLE_DATE]           DATE            NULL,
    [DVD_VALUE]              DECIMAL (18, 6) NULL,
    [FREQUENCY]              VARCHAR (20)    NULL,
    [DVD_TYPE]               VARCHAR (20)    NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([STOCK] ASC, [ROW_ID] ASC, [AS_AT_DATE] ASC) WITH (FILLFACTOR = 80)
);

