CREATE TABLE [CADIS_PROC].[DI_VSJPGFFI_RESULTS] (
    [ROW_NUMBER]                  INT           NOT NULL,
    [TYPE]                        VARCHAR (20)  NOT NULL,
    [Fund Short Name Populated?]  BIT           NULL,
    [Transaction Date Populated?] BIT           NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC)
);

