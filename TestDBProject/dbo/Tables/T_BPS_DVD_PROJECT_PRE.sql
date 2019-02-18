CREATE TABLE [dbo].[T_BPS_DVD_PROJECT_PRE] (
    [FILE_DATE]              VARCHAR (8)    NULL,
    [STOCK]                  VARCHAR (20)   NULL,
    [ERROR_CODE]             INT            NULL,
    [DELIMITER]              VARCHAR (20)   NULL,
    [NUM_OF_DIMENSIONS]      VARCHAR (20)   NULL,
    [NUM_OF_ROWS]            VARCHAR (20)   NULL,
    [NUM_OF_COLS]            INT            NULL,
    [BDVD_ALL_PROJECTIONS]   VARCHAR (8000) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL
);

