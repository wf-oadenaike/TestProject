CREATE TABLE [Staging].[PeopleSrc] (
    [SrcId]              [Staging].[SalesforceIdDom] NOT NULL,
    [PersonsName]        [sysname]                   NOT NULL,
    [PersonEMailAddress] [sysname]                   NOT NULL,
    [PersonWorkNo]       VARCHAR (15)                NULL,
    [CompanyName]        [sysname]                   NULL,
    [CompanySrcId]       [Staging].[SalesforceIdDom] NULL,
    [DepartmentName]     [sysname]                   NOT NULL,
    [ManagersSrcId]      [Staging].[SalesforceIdDom] NULL,
    [JobTitle]           [sysname]                   NULL,
    [EmploymentStatus]   BIT                         DEFAULT ((1)) NULL,
    [EndDate]            VARCHAR (20)                NULL,
    [IsDeleted]          BIT                         DEFAULT ((0)) NOT NULL,
    [CreatedDate]        VARCHAR (20)                DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKPeopleSrc] PRIMARY KEY CLUSTERED ([SrcId] ASC)
);

