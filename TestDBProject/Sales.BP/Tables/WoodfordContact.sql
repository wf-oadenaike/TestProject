﻿CREATE TABLE [Sales.BP].[WoodfordContact] (
    [Id]                        INT              IDENTITY (1, 1) NOT NULL,
    [CntFcaId]                  CHAR (8)         NOT NULL,
    [CntSalesforceId]           CHAR (18)        NULL,
    [CntMatrixId]               CHAR (5)         NULL,
    [CntSivId]                  NVARCHAR (100)   NULL,
    [CntSalutation]             NVARCHAR (100)   NULL,
    [CntFirstName]              NVARCHAR (100)   NULL,
    [CntLastName]               NVARCHAR (100)   NOT NULL,
    [CntJobTitle]               NVARCHAR (100)   NULL,
    [CntLandline]               NVARCHAR (100)   NULL,
    [CntMobile]                 NVARCHAR (100)   NULL,
    [CntFax]                    NVARCHAR (100)   NULL,
    [CntEmail]                  NVARCHAR (100)   NULL,
    [CntIsCf1]                  BIT              CONSTRAINT [c_CntIsCf1] DEFAULT ('0') NOT NULL,
    [CntIsCf2]                  BIT              CONSTRAINT [c_CntIsCf2] DEFAULT ('0') NOT NULL,
    [CntIsCf3]                  BIT              CONSTRAINT [c_CntIsCf3] DEFAULT ('0') NOT NULL,
    [CntIsCf4]                  BIT              CONSTRAINT [c_CntIsCf4] DEFAULT ('0') NOT NULL,
    [CntIsCf10]                 BIT              CONSTRAINT [c_CntIsCf10] DEFAULT ('0') NOT NULL,
    [CntIsCf11]                 BIT              CONSTRAINT [c_CntIsCf11] DEFAULT ('0') NOT NULL,
    [CntIsCf30]                 BIT              CONSTRAINT [c_CntIsCf30] DEFAULT ('0') NOT NULL,
    [WoodfordLastUpdate]        DATETIME         NULL,
    [MatrixLastUpdate]          DATETIME         NULL,
    [IsConfirmRequired]         BIT              CONSTRAINT [c_IsConfirmRequiredDefault] DEFAULT ('0') NOT NULL,
    [IsReviewed]                BIT              CONSTRAINT [c_IsReviewed] DEFAULT ('0') NOT NULL,
    [StartDateTime]             DATETIME         CONSTRAINT [c_StartDateTime] DEFAULT (getdate()) NOT NULL,
    [EndDateTime]               DATETIME         CONSTRAINT [c_EndDateTime] DEFAULT ('2099-12-31T00:00:00') NOT NULL,
    [IsActive]                  BIT              CONSTRAINT [c_IsActiveDefault] DEFAULT ('1') NOT NULL,
    [ModifiedByPersonId]        SMALLINT         NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_WC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_WC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_WC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_WC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_WC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [pk_sc_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [WoodfordContactModifiedByPersonId] FOREIGN KEY ([ModifiedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [uc_sc_CntFcaId] UNIQUE NONCLUSTERED ([CntFcaId] ASC, [EndDateTime] ASC)
);

