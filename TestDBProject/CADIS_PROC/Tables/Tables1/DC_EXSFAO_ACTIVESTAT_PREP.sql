CREATE TABLE [CADIS_PROC].[DC_EXSFAO_ACTIVESTAT_PREP] (
    [sf_sfaccountid] VARCHAR (18)   NOT NULL,
    [sf_FCAId]       VARCHAR (100)  NULL,
    [sf_OutletId]    VARCHAR (50)   NULL,
    [sf_Value]       VARCHAR (2000) NULL,
    [mx_Value]       VARCHAR (2000) NULL,
    [OverrideChoice] VARCHAR (10)   NULL,
    [OverrideValue]  VARCHAR (2000) NULL,
    [OverrideStatus] VARCHAR (10)   NULL,
    PRIMARY KEY CLUSTERED ([sf_sfaccountid] ASC) WITH (FILLFACTOR = 80)
);

