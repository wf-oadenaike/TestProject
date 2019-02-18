CREATE TABLE [Investment].[DvdNTHighLevelOverrideEvents] (
    [DvdNTHighLevelOverrideEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [Qtr]                                             CHAR (5)         NOT NULL,
    [SubmittedByPersonId]                             SMALLINT         CONSTRAINT [DF_NTHLOE_SLESP] DEFAULT ((-1)) NOT NULL,
    [DvdRate]                                         DECIMAL (18, 6)  NULL,
    [OverrideNetIncome]                               DECIMAL (28, 6)  NULL,
    [OverrideUnitsInIssue]                            DECIMAL (18, 4)  NULL,
    [OverrideCommentary]                              VARCHAR (MAX)    NULL,
    [OverrideDvdChangeReasonId]                       INT              NULL,
    [EventDate]                                       DATETIME         NULL,
    [JoinGUID]                                        UNIQUEIDENTIFIER NOT NULL,
    [DvdNTHighLevelOverrideEventCreationDatetime]     DATETIME         CONSTRAINT [DF_NTHLOE_NTHLOECD] DEFAULT (getdate()) NOT NULL,
    [DvdNTHighLevelOverrideEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_NTHLOE_NTHLOELMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                           DATETIME         CONSTRAINT [DF_NTHLOE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                            DATETIME         CONSTRAINT [DF_NTHLOE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                          NVARCHAR (50)    CONSTRAINT [DF_NTHLOE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                           INT              CONSTRAINT [DF_NTHLOE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                          ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                       DATETIME         CONSTRAINT [DF_NTHLOE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKDvdNTHighLevelOverrideEvents] PRIMARY KEY CLUSTERED ([DvdNTHighLevelOverrideEventId] ASC),
    CONSTRAINT [DvdNTHighLevelOverrideEventsOverrideDvdChangeReasonId] FOREIGN KEY ([OverrideDvdChangeReasonId]) REFERENCES [Investment].[DvdChangeReasons] ([DvdChangeReasonId]),
    CONSTRAINT [DvdNTHighLevelOverrideEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

