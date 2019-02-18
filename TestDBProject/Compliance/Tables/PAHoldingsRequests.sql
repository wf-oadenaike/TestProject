CREATE TABLE [Compliance].[PAHoldingsRequests] (
    [PAHoldingsRequestId]                   INT              IDENTITY (1, 1) NOT NULL,
    [RequestDetails]                        VARCHAR (MAX)    NULL,
    [OwnerId]                               SMALLINT         NOT NULL,
    [ReviewerId]                            SMALLINT         NULL,
    [Status]                                VARCHAR (128)    NOT NULL,
    [BoxFolderId]                           VARCHAR (25)     NULL,
    [JIRAIssueKey]                          VARCHAR (255)    NULL,
    [Active]                                BIT              NOT NULL,
    [DocumentationFolderLink]               VARCHAR (2000)   NULL,
    [JoinGUID]                              UNIQUEIDENTIFIER NOT NULL,
    [PAHoldingsRequestCreationDatetime]     DATETIME         CONSTRAINT [DF_PAH_CD] DEFAULT (getdate()) NOT NULL,
    [PAHoldingsRequestLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PAH_LMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                 DATETIME         CONSTRAINT [DF_PAH_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                  DATETIME         CONSTRAINT [DF_PAH_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                NVARCHAR (50)    CONSTRAINT [DF_PAH_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                 INT              CONSTRAINT [DF_PAH_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]             DATETIME         CONSTRAINT [DF_PAH_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKPAHoldingsRequests] PRIMARY KEY CLUSTERED ([PAHoldingsRequestId] ASC),
    CONSTRAINT [PAHoldingsRequestsOwnerId] FOREIGN KEY ([OwnerId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [PAHoldingsRequestsReviewerId] FOREIGN KEY ([ReviewerId]) REFERENCES [Core].[Persons] ([PersonId])
);

