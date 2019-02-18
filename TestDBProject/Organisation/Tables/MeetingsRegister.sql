CREATE TABLE [Organisation].[MeetingsRegister] (
    [MeetingRegisterId]                   SMALLINT         IDENTITY (1, 1) NOT NULL,
    [MeetingTypeId]                       SMALLINT         NOT NULL,
    [MeetingNameBK]                       [sysname]        NOT NULL,
    [MeetingSummary]                      VARCHAR (2048)   NOT NULL,
    [MeetingOwnerRoleId]                  SMALLINT         NOT NULL,
    [AssigneeRoleId]                      SMALLINT         NOT NULL,
    [JIRAProjectKey]                      VARCHAR (128)    NOT NULL,
    [LagDays]                             SMALLINT         CONSTRAINT [DF_MR_MDLD] DEFAULT ((-10)) NULL,
    [ActiveFlag]                          BIT              CONSTRAINT [DF_MR_AF] DEFAULT ((1)) NOT NULL,
    [DocumentationFolderLink]             VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]                 UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                            UNIQUEIDENTIFIER NOT NULL,
    [MeetingRegisterCreationDatetime]     DATETIME         CONSTRAINT [DF_MR_MRCDT] DEFAULT (getdate()) NOT NULL,
    [MeetingRegisterLastModifiedDatetime] DATETIME         CONSTRAINT [DF_MR_MRLMDT] DEFAULT (getdate()) NOT NULL,
    [MeetingDay]                          VARCHAR (20)     NULL,
    CONSTRAINT [PKMeetingsRegister] PRIMARY KEY CLUSTERED ([MeetingNameBK] ASC),
    CONSTRAINT [MeetingRegisterAssigneeRoleId] FOREIGN KEY ([AssigneeRoleId]) REFERENCES [Core].[Roles] ([RoleId]),
    CONSTRAINT [MeetingRegisterMeetingTypeId] FOREIGN KEY ([MeetingTypeId]) REFERENCES [Organisation].[MeetingTypes] ([MeetingTypeId]),
    CONSTRAINT [MeetingRegisterOwnerRoleId] FOREIGN KEY ([MeetingOwnerRoleId]) REFERENCES [Core].[Roles] ([RoleId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIMeetingRegister]
    ON [Organisation].[MeetingsRegister]([MeetingRegisterId] ASC);

