CREATE TABLE [Investment].[ConcentrationBreachRegister] (
    [ConcentrationBreachId]                   INT              IDENTITY (1, 1) NOT NULL,
    [FundCode]                                VARCHAR (20)     NOT NULL,
    [Check5_40]                               DECIMAL (10, 2)  NULL,
    [ScenarioCheck5_40]                       DECIMAL (10, 2)  NULL,
    [IsCheck10]                               BIT              NULL,
    [BreachDate]                              DATETIME         NOT NULL,
    [BreachNotes]                             VARCHAR (MAX)    NULL,
    [JoinGUID]                                UNIQUEIDENTIFIER NULL,
    [ConcentrationBreachCreationDatetime]     DATETIME         CONSTRAINT [DF_CBR_CBRCDT] DEFAULT (getdate()) NOT NULL,
    [ConcentrationBreachLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CBR_CBRLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                   DATETIME         CONSTRAINT [DF_CBR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                    DATETIME         CONSTRAINT [DF_CBR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                  NVARCHAR (50)    CONSTRAINT [DF_CBR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                   INT              CONSTRAINT [DF_CBR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                  ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]               DATETIME         CONSTRAINT [DF_CBR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKConcentrationBreachRegister] PRIMARY KEY CLUSTERED ([ConcentrationBreachId] ASC)
);

