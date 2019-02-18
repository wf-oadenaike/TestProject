CREATE TABLE [Compliance].[TrainingTypes] (
    [TrainingTypeId]               SMALLINT         IDENTITY (1, 1) NOT NULL,
    [TrainingType]                 VARCHAR (128)    NOT NULL,
    [JoinGUID]                     UNIQUEIDENTIFIER NULL,
    [TrainingTypeCreationDate]     DATETIME         CONSTRAINT [DF_TT_CDT] DEFAULT (getdate()) NOT NULL,
    [TrainingTypeLastModifiedDate] DATETIME         CONSTRAINT [DF_TT_LMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]        DATETIME         CONSTRAINT [DF_TT_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]         DATETIME         CONSTRAINT [DF_TT_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]       NVARCHAR (50)    CONSTRAINT [DF_TT_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]        INT              CONSTRAINT [DF_TT_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]       ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]    DATETIME         CONSTRAINT [DF_TT_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKTrainingTypes] PRIMARY KEY CLUSTERED ([TrainingTypeId] ASC) WITH (FILLFACTOR = 90)
);

