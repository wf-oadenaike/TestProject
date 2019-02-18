CREATE TABLE [dbo].[T_BPS_DVD_PROJECT_UNTYPED] (
    [STOCK]                  VARCHAR (20)    NOT NULL,
    [ROW_ID]                 INT             NOT NULL,
    [FILE_DATE]              VARCHAR (8)     NULL,
    [ERROR_CODE]             INT             NULL,
    [DELIMITER]              INT             NULL,
    [NUM_OF_DIMENSIONS]      INT             NULL,
    [NUM_OF_ROWS]            INT             NULL,
    [NUM_OF_COLS]            INT             NULL,
    [DECLARED_DATE]          DATE            NULL,
    [EX_DATE]                DATE            NULL,
    [DVD_VALUE]              DECIMAL (18, 6) NULL,
    [DVD_TREND]              DECIMAL (18, 6) NULL,
    [IMP_RANGE_LOW]          DECIMAL (18, 6) NULL,
    [IMP_RANGE_HIGH]         DECIMAL (18, 6) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([STOCK] ASC, [ROW_ID] ASC) WITH (FILLFACTOR = 80)
);

