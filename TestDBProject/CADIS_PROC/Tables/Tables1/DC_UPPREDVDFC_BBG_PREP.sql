CREATE TABLE [CADIS_PROC].[DC_UPPREDVDFC_BBG_PREP] (
    [FundShortName]  VARCHAR (50)     NOT NULL,
    [EDM_SEC_ID]     INT              NOT NULL,
    [CalendarYear]   INT              NOT NULL,
    [SecurityName]   VARCHAR (100)    NULL,
    [DeclaredDate]   DATE             NULL,
    [DvdCCY]         VARCHAR (10)     NULL,
    [SpotRate]       DECIMAL (24, 16) NULL,
    [Position]       DECIMAL (20, 6)  NULL,
    [PositionDate]   DATE             NULL,
    [BidPrice]       DECIMAL (24, 10) NULL,
    [WithholdingTax] DECIMAL (26, 6)  NULL,
    [Q1ExDate]       DATE             NULL,
    [Q1Rate]         DECIMAL (20, 6)  NULL,
    [Q2ExDate]       DATE             NULL,
    [Q2Rate]         DECIMAL (20, 6)  NULL,
    [Q3ExDate]       DATE             NULL,
    [Q3Rate]         DECIMAL (20, 6)  NULL,
    [Q4ExDate]       DATE             NULL,
    [Q4Rate]         DECIMAL (20, 6)  NULL,
    PRIMARY KEY CLUSTERED ([FundShortName] ASC, [EDM_SEC_ID] ASC, [CalendarYear] ASC) WITH (FILLFACTOR = 80)
);

