CREATE TABLE [dbo].[T_REF_SECURITY_EXCEPTIONS] (
    [EXCEPTION_ID]           BIGINT        IDENTITY (1, 1) NOT NULL,
    [EDM_SEC_ID]             INT           NULL,
    [FUND_SHORT_NAME]        VARCHAR (50)  NULL,
    [IsActive]               BIT           DEFAULT ((1)) NULL,
    [EffectiveDate]          DATETIME      NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL
);

