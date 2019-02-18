CREATE TABLE [Staging].[UserSrc] (
    [ID]                 NVARCHAR (25)  NOT NULL,
    [Name]               NVARCHAR (55)  NOT NULL,
    [Email]              NVARCHAR (255) NULL,
    [Slack_Username]     NVARCHAR (100) NULL,
    [Atlassian_Username] NVARCHAR (100) NULL,
    [IsActive]           NVARCHAR (50)  NULL
);

