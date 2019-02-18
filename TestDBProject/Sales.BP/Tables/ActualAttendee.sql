CREATE TABLE [Sales.BP].[ActualAttendee] (
    [ActualId]                           VARCHAR (25) NOT NULL,
    [ContactId]                          VARCHAR (25) NOT NULL,
    [IsActive]                           BIT          NOT NULL,
    [ActualAttendeeCreationDatetime]     DATETIME     CONSTRAINT [DF_AA_AACDT] DEFAULT (getdate()) NOT NULL,
    [ActualAttendeeLastModifiedDatetime] DATETIME     CONSTRAINT [DF_AA_AALMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKActualAttendee] PRIMARY KEY CLUSTERED ([ActualId] ASC, [ContactId] ASC)
);

