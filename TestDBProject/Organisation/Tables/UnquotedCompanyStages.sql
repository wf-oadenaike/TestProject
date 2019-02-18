CREATE TABLE [Organisation].[UnquotedCompanyStages] (
    [UnquotedCompanyStage]            VARCHAR (5)   NOT NULL,
    [UnquotedCompanyStageDescription] VARCHAR (256) NOT NULL,
    [Sequence]                        SMALLINT      NOT NULL,
    [CADIS_SYSTEM_INSERTED]           DATETIME      CONSTRAINT [DF_UCS_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]            DATETIME      CONSTRAINT [DF_UCS_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]          NVARCHAR (50) CONSTRAINT [DF_UCS_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]           INT           CONSTRAINT [DF_UCS_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]          ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]       DATETIME      CONSTRAINT [DF_UCS_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKUnquotedCompanyStages] PRIMARY KEY CLUSTERED ([UnquotedCompanyStage] ASC)
);

