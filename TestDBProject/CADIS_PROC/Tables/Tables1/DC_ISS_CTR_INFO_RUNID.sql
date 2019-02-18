CREATE TABLE [CADIS_PROC].[DC_ISS_CTR_INFO_RUNID] (
    [EDM_SEC_ID__RUNID]     INT           NOT NULL,
    [PortfolioGroup__RUNID] INT           NOT NULL,
    [ReportDate__RUNID]     INT           NOT NULL,
    [Issuer__RUNID]         INT           NOT NULL,
    [Security__RUNID]       INT           NOT NULL,
    [AvgWgt__RUNID]         INT           NOT NULL,
    [CTR__RUNID]            INT           NOT NULL,
    [TotRtn__RUNID]         INT           NOT NULL,
    [TotAttr__RUNID]        INT           NOT NULL,
    [Alloc__RUNID]          INT           NOT NULL,
    [Selec__RUNID]          INT           NOT NULL,
    [Curr__RUNID]           INT           NOT NULL,
    [ID059]                 VARCHAR (250) NOT NULL,
    [Ticker__RUNID]         INT           NOT NULL,
    [CUSIP__RUNID]          INT           NOT NULL,
    [ISIN__RUNID]           INT           NOT NULL,
    [SEDOL1__RUNID]         INT           NOT NULL,
    [FILENAME__RUNID]       INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([ID059] ASC) WITH (FILLFACTOR = 80)
);

