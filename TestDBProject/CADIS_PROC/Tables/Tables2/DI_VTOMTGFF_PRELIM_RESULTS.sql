CREATE TABLE [CADIS_PROC].[DI_VTOMTGFF_PRELIM_RESULTS] (
    [Transaction Date Populated?]         BIT            NULL,
    [ROW_NUMBER]                          INT            NOT NULL,
    [TYPE]                                VARCHAR (20)   NOT NULL,
    [CADIS_SYSTEM_CHANGEDBY]              NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]               DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                DATETIME       DEFAULT (getdate()) NULL,
    [Transaction Date Populated?__RULEID] INT            DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_ROWKEY]                 NVARCHAR (MAX) NOT NULL,
    [OMT EXISTS]                          BIT            DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC)
);

