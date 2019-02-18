CREATE TABLE [Organisation].[DepartmentalJiraProjectTypes] (
    [DepartmentalJiraProjectTypeId] SMALLINT     NOT NULL,
    [DepartmentalJiraProjectType]   VARCHAR (31) NOT NULL,
    [DateCreated]                   DATETIME     CONSTRAINT [DF_DJPT_DC] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKDepartmentalJiraProjectTypes] PRIMARY KEY CLUSTERED ([DepartmentalJiraProjectTypeId] ASC)
);

