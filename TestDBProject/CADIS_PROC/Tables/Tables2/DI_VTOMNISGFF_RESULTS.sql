CREATE TABLE [CADIS_PROC].[DI_VTOMNISGFF_RESULTS] (
    [Transaction Date Populated?] BIT           NULL,
    [ROW_NUMBER]                  INT           NOT NULL,
    [TYPE]                        VARCHAR (20)  NOT NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC)
);

