CREATE TABLE [CADIS_PROC].[DI_VITGRERC_PRELIM_RESULTS] (
    [Order Row Counts Match?]         BIT            NULL,
    [ORDERID]                         INT            NOT NULL,
    [CADIS_SYSTEM_CHANGEDBY]          NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]           DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]            DATETIME       DEFAULT (getdate()) NULL,
    [Order Row Counts Match?__RULEID] INT            DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_ROWKEY]             NVARCHAR (MAX) NOT NULL,
    [IN EXISTS]                       BIT            DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ORDERID] ASC)
);

