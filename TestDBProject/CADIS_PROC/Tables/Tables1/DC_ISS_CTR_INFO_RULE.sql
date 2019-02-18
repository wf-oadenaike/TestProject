CREATE TABLE [CADIS_PROC].[DC_ISS_CTR_INFO_RULE] (
    [EDM_SEC_ID__RULEID]     INT           NULL,
    [PortfolioGroup__RULEID] INT           NULL,
    [ReportDate__RULEID]     INT           NULL,
    [Issuer__RULEID]         INT           NULL,
    [Security__RULEID]       INT           NULL,
    [AvgWgt__RULEID]         INT           NULL,
    [CTR__RULEID]            INT           NULL,
    [TotRtn__RULEID]         INT           NULL,
    [TotAttr__RULEID]        INT           NULL,
    [Alloc__RULEID]          INT           NULL,
    [Selec__RULEID]          INT           NULL,
    [Curr__RULEID]           INT           NULL,
    [ID059]                  VARCHAR (250) NOT NULL,
    [Ticker__RULEID]         INT           NULL,
    [CUSIP__RULEID]          INT           NULL,
    [ISIN__RULEID]           INT           NULL,
    [SEDOL1__RULEID]         INT           NULL,
    [FILENAME__RULEID]       INT           NULL,
    PRIMARY KEY CLUSTERED ([ID059] ASC) WITH (FILLFACTOR = 80)
);

