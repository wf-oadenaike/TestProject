CREATE TABLE [dbo].[LogProcErrors] (
    [LogProcErrorsId]        INT           IDENTITY (1, 1) NOT NULL,
    [ErrorNumber]            INT           NULL,
    [ErrorSeverity]          INT           NULL,
    [ErrorState]             INT           NULL,
    [ErrorProcedure]         VARCHAR (150) NULL,
    [ErrorLine]              INT           NULL,
    [ErrorMessage]           VARCHAR (300) NULL,
    [ErrorDate]              DATETIME      NULL,
    [ErrorUser]              VARCHAR (60)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF_LPE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF_LPE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF_LPE_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKLogProcErrors] PRIMARY KEY CLUSTERED ([LogProcErrorsId] ASC)
);

