CREATE TABLE [Compliance].[ComplaintEventTypes] (
    [ComplaintEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ComplaintEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKComplaintEventTypes] PRIMARY KEY CLUSTERED ([ComplaintEventTypeId] ASC)
);

