CREATE TABLE [CADIS_PROC].[DC_INPUT229_PROCESSKEYS] (
    [FundShortName] VARCHAR (50) NOT NULL,
    [EDM_SEC_ID]    INT          NOT NULL,
    [CalendarYear]  INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([FundShortName] ASC, [EDM_SEC_ID] ASC, [CalendarYear] ASC) WITH (FILLFACTOR = 80)
);

