CREATE TABLE [Sales.BP].[WoodfordAccount] (
    [Id]                        INT              IDENTITY (1, 1) NOT NULL,
    [AccSalesforceId]           CHAR (18)        NULL,
    [AccName]                   NVARCHAR (100)   NOT NULL,
    [AccMatrixOutletId]         CHAR (5)         NULL,
    [AccSivId]                  NVARCHAR (100)   NULL,
    [AccParentSivId]            NVARCHAR (100)   NULL,
    [AccFcaId]                  INT              NOT NULL,
    [AccPostcode]               NVARCHAR (20)    NOT NULL,
    [AccLandline]               NVARCHAR (100)   NULL,
    [AccFax]                    NVARCHAR (100)   NULL,
    [AccWebsite]                NVARCHAR (100)   NULL,
    [AccFirmSegment]            NVARCHAR (100)   NULL,
    [AccAuthStatus]             NVARCHAR (100)   NULL,
    [AccPlatformsUsed]          NVARCHAR (1000)  NULL,
    [AccOutletType]             NVARCHAR (100)   NULL,
    [AccVerifiedBy]             NVARCHAR (100)   NULL,
    [AccIsExistingRel]          BIT              DEFAULT ('0') NOT NULL,
    [AccIsPriorityClient]       BIT              DEFAULT ('0') NOT NULL,
    [AccIsLocked]               BIT              DEFAULT ('0') NOT NULL,
    [AccOwnerId]                NVARCHAR (100)   NULL,
    [AccOwnerName]              NVARCHAR (100)   NULL,
    [WoodfordLastUpdate]        DATETIME         NULL,
    [MatrixLastUpdate]          DATETIME         NULL,
    [StartDateTime]             DATETIME         DEFAULT (getdate()) NOT NULL,
    [EndDateTime]               DATETIME         DEFAULT ('2099-12-31T00:00:00') NOT NULL,
    [IsActive]                  BIT              DEFAULT ('1') NOT NULL,
    [AccCalculatedPriority]     DECIMAL (19, 2)  NULL,
    [AccIsKeyAccount]           BIT              DEFAULT ('0') NOT NULL,
    [RegionId]                  INT              NULL,
    [AccSalesforceId_15]        AS               (left([AccSalesforceId],(15)) collate SQL_Latin1_General_CP1_CS_AS) PERSISTED,
    [IsConfirmRequired]         BIT              DEFAULT ('0') NOT NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NULL,
    [MX_PRIMARY_BUSINESS]       VARCHAR (MAX)    NULL,
    [WF_PRIMARY_BUSINESS]       VARCHAR (MAX)    NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         DEFAULT (getdate()) NULL,
    [RefreshID]                 INT              NULL,
    CONSTRAINT [pk_acc_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [fk_AccountRegionId] FOREIGN KEY ([RegionId]) REFERENCES [Sales.BP].[Region] ([RegionId]),
    CONSTRAINT [uc_acc_AccFcaIdPostcode] UNIQUE NONCLUSTERED ([AccFcaId] ASC, [AccPostcode] ASC, [EndDateTime] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IXAccSalesforceId_15]
    ON [Sales.BP].[WoodfordAccount]([AccSalesforceId_15] ASC);


GO
CREATE NONCLUSTERED INDEX [IXAccSalesforceId]
    ON [Sales.BP].[WoodfordAccount]([AccSalesforceId] ASC);

