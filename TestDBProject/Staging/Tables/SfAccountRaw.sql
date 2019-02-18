﻿CREATE TABLE [Staging].[SfAccountRaw] (
    [AccFcaId]                       NVARCHAR (1000) NULL,
    [AccSalesforceId]                NVARCHAR (1000) NULL,
    [AccMatrixOutletId]              NVARCHAR (1000) NULL,
    [AccSivId]                       NVARCHAR (1000) NULL,
    [AccParentSivId]                 NVARCHAR (1000) NULL,
    [AccOwnerId]                     NVARCHAR (1000) NULL,
    [AccOwnerName]                   NVARCHAR (1000) NULL,
    [AccName]                        NVARCHAR (1000) NULL,
    [AccOutletType]                  NVARCHAR (1000) NULL,
    [AccBillingStreet]               NVARCHAR (1000) NULL,
    [AccBillingCity]                 NVARCHAR (1000) NULL,
    [AccBillingState]                NVARCHAR (1000) NULL,
    [AccBillingPostcode]             NVARCHAR (1000) NULL,
    [AccBillingCountry]              NVARCHAR (1000) NULL,
    [AccLandline]                    NVARCHAR (1000) NULL,
    [AccFax]                         NVARCHAR (1000) NULL,
    [AccWebsite]                     NVARCHAR (1000) NULL,
    [AccEmail]                       NVARCHAR (1000) NULL,
    [AccFirmSegment]                 NVARCHAR (1000) NULL,
    [AccAuthStatus]                  NVARCHAR (1000) NULL,
    [AccPlatformsUsed]               NVARCHAR (1000) NULL,
    [AccVerifiedBy]                  NVARCHAR (1000) NULL,
    [AccExistingCompanyRelationship] NVARCHAR (1000) NULL,
    [AccPriorityClient]              NVARCHAR (1000) NULL,
    [AccCalculatedPriority]          NVARCHAR (1000) NULL,
    [AccKeyAccount]                  NVARCHAR (1000) NULL,
    [AccRegionCode]                  NVARCHAR (1000) NULL,
    [AccIsLocked]                    NVARCHAR (1000) NULL,
    [WF_PRIMARY_BUSINESS]            VARCHAR (MAX)   NULL,
    [MX_PRIMARY_BUSINESS]            VARCHAR (MAX)   NULL,
    [RecordTypeName]                 VARCHAR (50)    NULL,
    [AccParentSalesforceId]          VARCHAR (20)    NULL
);

