CREATE TABLE [Organisation].[MeetingTypes] (
    [MeetingTypeId]   SMALLINT     IDENTITY (1, 1) NOT NULL,
    [MeetingTypeBK]   VARCHAR (25) NOT NULL,
    [MeetingTypeName] [sysname]    NOT NULL,
    CONSTRAINT [PKMeetingTypes] PRIMARY KEY CLUSTERED ([MeetingTypeBK] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIMeetingType]
    ON [Organisation].[MeetingTypes]([MeetingTypeId] ASC);

