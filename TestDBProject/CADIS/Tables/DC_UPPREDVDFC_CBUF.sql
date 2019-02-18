CREATE TABLE [CADIS].[DC_UPPREDVDFC_CBUF] (
    [FundShortName] VARCHAR (20) NOT NULL,
    [EDM_SEC_ID]    INT          NOT NULL,
    [CalendarYear]  INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([FundShortName] ASC, [EDM_SEC_ID] ASC, [CalendarYear] ASC) WITH (FILLFACTOR = 80)
);

