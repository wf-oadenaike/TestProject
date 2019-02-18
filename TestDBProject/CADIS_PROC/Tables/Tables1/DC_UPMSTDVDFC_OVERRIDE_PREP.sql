CREATE TABLE [CADIS_PROC].[DC_UPMSTDVDFC_OVERRIDE_PREP] (
    [FundShortName]          VARCHAR (20)    NOT NULL,
    [EDM_SEC_ID]             INT             NOT NULL,
    [CalendarYear]           INT             NOT NULL,
    [Q1ExDate]               DATETIME        NULL,
    [Q1Rate]                 DECIMAL (20, 6) NULL,
    [Q2ExDate]               DATETIME        NULL,
    [Q2Rate]                 DECIMAL (20, 6) NULL,
    [Q3ExDate]               DATETIME        NULL,
    [Q3Rate]                 DECIMAL (20, 6) NULL,
    [Q4ExDate]               DATETIME        NULL,
    [Q4Rate]                 DECIMAL (20, 6) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION      NOT NULL,
    PRIMARY KEY CLUSTERED ([FundShortName] ASC, [EDM_SEC_ID] ASC, [CalendarYear] ASC) WITH (FILLFACTOR = 80)
);

