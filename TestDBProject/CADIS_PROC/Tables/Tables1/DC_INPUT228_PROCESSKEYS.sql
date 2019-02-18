CREATE TABLE [CADIS_PROC].[DC_INPUT228_PROCESSKEYS] (
    [FundShortName] VARCHAR (20) NOT NULL,
    [EDM_SEC_ID]    INT          NOT NULL,
    [CalendarYear]  INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([FundShortName] ASC, [EDM_SEC_ID] ASC, [CalendarYear] ASC) WITH (FILLFACTOR = 80)
);

