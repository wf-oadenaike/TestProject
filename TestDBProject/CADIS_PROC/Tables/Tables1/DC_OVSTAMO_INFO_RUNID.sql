CREATE TABLE [CADIS_PROC].[DC_OVSTAMO_INFO_RUNID] (
    [SfAccountId]             VARCHAR (18) NOT NULL,
    [Sector]                  VARCHAR (10) NOT NULL,
    [AccountOwnerId__RUNID]   INT          NOT NULL,
    [IsPriorityClient__RUNID] INT          NOT NULL,
    [Metrics__RUNID]          INT          NOT NULL,
    [MoveValue__RUNID]        INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC, [Sector] ASC) WITH (FILLFACTOR = 80)
);

