CREATE TABLE [dbo].[T_UNQUOTED_FUNDING] (
    [FUNDING_ID]             INT           IDENTITY (1, 1) NOT NULL,
    [ISSUER]                 VARCHAR (80)  NULL,
    [EDM_SEC_ID]             INT           NULL,
    [TRADE_DATE]             DATETIME      NULL,
    [SETTLEMENT_DATE]        DATETIME      NULL,
    [FUNDING_STATUS]         VARCHAR (20)  NULL,
    [IS_LEGAL]               BIT           NULL,
    [IS_REPUTATIONAL]        BIT           NULL,
    [FUNDING_TYPE]           VARCHAR (20)  NULL,
    [FUNDING_SUB_TYPE]       VARCHAR (20)  NULL,
    [PUSH_BACK_UNIT]         VARCHAR (1)   NULL,
    [PUSH_BACK_MAGNITUDE]    INT           NULL,
    [PULL_FORWARD_UNIT]      VARCHAR (1)   NULL,
    [PULL_FORWARD_MAGNITUDE] INT           NULL,
    [TECH_STATUS]            VARCHAR (20)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [JiraIssueKey]           VARCHAR (18)  NULL,
    [IssuerID]               INT           NULL,
    PRIMARY KEY CLUSTERED ([FUNDING_ID] ASC) WITH (FILLFACTOR = 80)
);

