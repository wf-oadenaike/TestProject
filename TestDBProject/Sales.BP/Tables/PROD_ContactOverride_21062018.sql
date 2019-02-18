CREATE TABLE [Sales.BP].[PROD_ContactOverride_21062018] (
    [sf_SfContactId]         VARCHAR (18)   NOT NULL,
    [DataField]              VARCHAR (50)   NOT NULL,
    [sf_SfAccountId]         VARCHAR (18)   NULL,
    [sf_FcaId]               VARCHAR (18)   NULL,
    [sf_ContractMatrixId]    VARCHAR (18)   NULL,
    [sf_AccountFcaId]        VARCHAR (18)   NULL,
    [sf_LastName]            VARCHAR (200)  NULL,
    [sf_FirstName]           VARCHAR (200)  NULL,
    [sf_Value]               VARCHAR (2000) NULL,
    [mx_Value]               VARCHAR (2000) NULL,
    [OverrideValue]          VARCHAR (2000) NULL,
    [OverrideChoice]         VARCHAR (10)   NULL,
    [OverrideStatus]         VARCHAR (10)   NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  NULL
);

