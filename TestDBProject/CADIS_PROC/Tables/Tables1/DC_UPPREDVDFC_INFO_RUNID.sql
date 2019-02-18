CREATE TABLE [CADIS_PROC].[DC_UPPREDVDFC_INFO_RUNID] (
    [FundShortName]         VARCHAR (20) NOT NULL,
    [EDM_SEC_ID]            INT          NOT NULL,
    [CalendarYear]          INT          NOT NULL,
    [SecurityName__RUNID]   INT          NOT NULL,
    [DvdCCY__RUNID]         INT          NOT NULL,
    [WithholdingTax__RUNID] INT          NOT NULL,
    [SpotRate__RUNID]       INT          NOT NULL,
    [DeclaredDate__RUNID]   INT          NOT NULL,
    [PositionDate__RUNID]   INT          NOT NULL,
    [BidPrice__RUNID]       INT          NOT NULL,
    [Position__RUNID]       INT          NOT NULL,
    [MarketValue__RUNID]    INT          NOT NULL,
    [Q1ExDate__RUNID]       INT          NOT NULL,
    [Q1Rate__RUNID]         INT          NOT NULL,
    [Q2ExDate__RUNID]       INT          NOT NULL,
    [Q2Rate__RUNID]         INT          NOT NULL,
    [Q3ExDate__RUNID]       INT          NOT NULL,
    [Q3Rate__RUNID]         INT          NOT NULL,
    [Q4ExDate__RUNID]       INT          NOT NULL,
    [Q4Rate__RUNID]         INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([FundShortName] ASC, [EDM_SEC_ID] ASC, [CalendarYear] ASC) WITH (FILLFACTOR = 80)
);

