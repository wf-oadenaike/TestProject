CREATE TABLE [Organisation].[MeetingAttendees] (
    [MeetingRegisterId]           SMALLINT         NOT NULL,
    [AttendeeRoleId]              SMALLINT         NOT NULL,
    [ActiveFlag]                  BIT              CONSTRAINT [DF_MA_AF] DEFAULT ((1)) NOT NULL,
    [WorkflowVersionGUID]         UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                    UNIQUEIDENTIFIER NOT NULL,
    [MeetingAttendeeFromDatetime] DATETIME         CONSTRAINT [DF_MA_MAFDT] DEFAULT (getdate()) NOT NULL,
    [MeetingAttendeeToDatetime]   DATETIME         CONSTRAINT [DF_MA_MATDT] DEFAULT (dateadd(dayofyear,(10),getdate())) NOT NULL,
    CONSTRAINT [PKMeetingAttendees] PRIMARY KEY CLUSTERED ([MeetingRegisterId] ASC, [AttendeeRoleId] ASC),
    CONSTRAINT [MeetingAttendeesRegisterId] FOREIGN KEY ([MeetingRegisterId]) REFERENCES [Organisation].[MeetingsRegister] ([MeetingRegisterId]),
    CONSTRAINT [MeetingAttendeesRoleId] FOREIGN KEY ([AttendeeRoleId]) REFERENCES [Core].[Roles] ([RoleId])
);

