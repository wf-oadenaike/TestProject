CREATE TABLE [CADIS_PROC].[DC_ALLOC_INFO_RUNID] (
    [FileName]         VARCHAR (256) NOT NULL,
    [Sector__RUNID]    INT           NOT NULL,
    [Port__RUNID]      INT           NOT NULL,
    [Bench__RUNID]     INT           NOT NULL,
    [PlusMinus__RUNID] INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([FileName] ASC) WITH (FILLFACTOR = 80)
);

