﻿CREATE TABLE [KPI].[KPIRiskCategoryRelationship] (
    [KPIId]                     SMALLINT      NOT NULL,
    [RiskSubCategoryId]         SMALLINT      NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_KRCR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_KRCR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_KRCR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_KRCR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_KRCR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKKPIRiskCategoryRelationship] PRIMARY KEY CLUSTERED ([KPIId] ASC, [RiskSubCategoryId] ASC),
    CONSTRAINT [KPIRiskCategoryRelationshipKPIId] FOREIGN KEY ([KPIId]) REFERENCES [KPI].[MeasuredKPIs-old] ([KPIId]),
    CONSTRAINT [KPIRiskCategoryRelationshipSubCategoryId] FOREIGN KEY ([RiskSubCategoryId]) REFERENCES [Risk].[SubCategories] ([SubCategoryId])
);


GO
ALTER TABLE [KPI].[KPIRiskCategoryRelationship] NOCHECK CONSTRAINT [KPIRiskCategoryRelationshipKPIId];

