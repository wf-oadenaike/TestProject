CREATE TABLE [CADIS_PROC].[DI_VSJPGFFI_PRELIM_RESULTS] (
    [ROW_NUMBER]                          INT            NOT NULL,
    [TYPE]                                VARCHAR (20)   NOT NULL,
    [Fund Short Name Populated?]          BIT            NULL,
    [Transaction Date Populated?]         BIT            NULL,
    [CADIS_SYSTEM_CHANGEDBY]              NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]               DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                DATETIME       DEFAULT (getdate()) NULL,
    [Fund Short Name Populated?__RULEID]  INT            DEFAULT ((0)) NOT NULL,
    [Transaction Date Populated?__RULEID] INT            DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_ROWKEY]                 NVARCHAR (MAX) NOT NULL,
    [SJP EXISTS]                          BIT            DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC)
);

