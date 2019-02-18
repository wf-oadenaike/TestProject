CREATE TABLE [CADIS_PROC].[DC_ALLOC_INFO_RULE] (
    [FileName]          VARCHAR (256) NOT NULL,
    [Sector__RULEID]    INT           NULL,
    [Port__RULEID]      INT           NULL,
    [Bench__RULEID]     INT           NULL,
    [PlusMinus__RULEID] INT           NULL,
    PRIMARY KEY CLUSTERED ([FileName] ASC) WITH (FILLFACTOR = 80)
);

