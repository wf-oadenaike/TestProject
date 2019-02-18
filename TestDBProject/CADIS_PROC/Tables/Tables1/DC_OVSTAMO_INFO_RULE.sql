CREATE TABLE [CADIS_PROC].[DC_OVSTAMO_INFO_RULE] (
    [SfAccountId]              VARCHAR (18) NOT NULL,
    [Sector]                   VARCHAR (10) NOT NULL,
    [AccountOwnerId__RULEID]   INT          NULL,
    [IsPriorityClient__RULEID] INT          NULL,
    [Metrics__RULEID]          INT          NULL,
    [MoveValue__RULEID]        INT          NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC, [Sector] ASC) WITH (FILLFACTOR = 80)
);

