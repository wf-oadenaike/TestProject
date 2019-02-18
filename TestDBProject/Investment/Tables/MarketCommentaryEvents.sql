CREATE TABLE [Investment].[MarketCommentaryEvents] (
    [CommentaryEventId]         INT             IDENTITY (1, 1) NOT NULL,
    [CommentaryId]              INT             NOT NULL,
    [SecurityName]              NVARCHAR (255)  NOT NULL,
    [SecurityValue]             DECIMAL (19, 5) NOT NULL,
    [Rank]                      INT             NOT NULL,
    [Fund]                      NVARCHAR (255)  NOT NULL,
    [EventType]                 NVARCHAR (255)  NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        CONSTRAINT [DF_MCE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        CONSTRAINT [DF_MCE__CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   CONSTRAINT [DF_MCE__CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             CONSTRAINT [DF_MCE__CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION      NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        CONSTRAINT [DF_MCE__CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [MarketCommentaryEvents_CommentaryEventId] PRIMARY KEY CLUSTERED ([CommentaryEventId] ASC),
    CONSTRAINT [FK_MarketCommentaryEvents_Investment.MarketCommentary] FOREIGN KEY ([CommentaryId]) REFERENCES [Investment].[MarketCommentary] ([CommentaryId])
);

