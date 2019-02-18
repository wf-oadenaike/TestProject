CREATE TABLE [CADIS_PROC].[DC_OVSTAMO_INFO_VALUE] (
    [SfAccountId]            VARCHAR (18)    NOT NULL,
    [Sector]                 VARCHAR (10)    NOT NULL,
    [AccountOwnerId]         VARCHAR (18)    NULL,
    [IsPriorityClient]       BIT             NULL,
    [Metrics]                VARCHAR (20)    NULL,
    [MoveValue]              DECIMAL (18, 2) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC, [Sector] ASC) WITH (FILLFACTOR = 80)
);

