CREATE TABLE [dbo].[T_UNQUOTED_ALLOCATION] (
    [ALLOCATION_ID]          INT              IDENTITY (1, 1) NOT NULL,
    [FUND_SHORT_NAME]        VARCHAR (20)     NULL,
    [ALLOCATION]             DECIMAL (24, 10) NULL,
    [FUNDING_ID]             INT              NULL,
    [REVALUATION_ID]         INT              NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL
);

