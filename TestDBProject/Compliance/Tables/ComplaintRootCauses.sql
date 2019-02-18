CREATE TABLE [Compliance].[ComplaintRootCauses] (
    [RootCauseId]          SMALLINT      IDENTITY (1, 1) NOT NULL,
    [RootCause]            VARCHAR (25)  NOT NULL,
    [RootCauseDescription] VARCHAR (128) NOT NULL,
    CONSTRAINT [PKComplaintRootCauseId] PRIMARY KEY CLUSTERED ([RootCauseId] ASC)
);

