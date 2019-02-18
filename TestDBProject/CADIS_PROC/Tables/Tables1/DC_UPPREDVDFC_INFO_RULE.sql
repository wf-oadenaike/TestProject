CREATE TABLE [CADIS_PROC].[DC_UPPREDVDFC_INFO_RULE] (
    [FundShortName]          VARCHAR (20) NOT NULL,
    [EDM_SEC_ID]             INT          NOT NULL,
    [CalendarYear]           INT          NOT NULL,
    [SecurityName__RULEID]   INT          NULL,
    [DvdCCY__RULEID]         INT          NULL,
    [WithholdingTax__RULEID] INT          NULL,
    [SpotRate__RULEID]       INT          NULL,
    [DeclaredDate__RULEID]   INT          NULL,
    [PositionDate__RULEID]   INT          NULL,
    [BidPrice__RULEID]       INT          NULL,
    [Position__RULEID]       INT          NULL,
    [MarketValue__RULEID]    INT          NULL,
    [Q1ExDate__RULEID]       INT          NULL,
    [Q1Rate__RULEID]         INT          NULL,
    [Q2ExDate__RULEID]       INT          NULL,
    [Q2Rate__RULEID]         INT          NULL,
    [Q3ExDate__RULEID]       INT          NULL,
    [Q3Rate__RULEID]         INT          NULL,
    [Q4ExDate__RULEID]       INT          NULL,
    [Q4Rate__RULEID]         INT          NULL,
    PRIMARY KEY CLUSTERED ([FundShortName] ASC, [EDM_SEC_ID] ASC, [CalendarYear] ASC) WITH (FILLFACTOR = 80)
);

