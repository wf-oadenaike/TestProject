﻿CREATE TABLE [Audit].[ControlLogRegister] (
    [ControlLogRegisterId]                   INT              IDENTITY (1, 1) NOT NULL,
    [ControlDescription]                     NVARCHAR (MAX)   NOT NULL,
    [ControlLogCategoryId]                   SMALLINT         NOT NULL,
    [ControlLogFrequencyId]                  SMALLINT         NOT NULL,
    [AdhocFrequencyYesNo]                    BIT              CONSTRAINT [DF_CLR_AFYN] DEFAULT ((0)) NOT NULL,
    [EvidenceDescription]                    NVARCHAR (MAX)   NOT NULL,
    [OwnerRoleId]                            SMALLINT         NULL,
    [OwnerThirdPartyId]                      SMALLINT         NULL,
    [OriginalControlOwner]                   VARCHAR (128)    NULL,
    [JoinGUID]                               UNIQUEIDENTIFIER NULL,
    [ControlLogRegisterCreationDatetime]     DATETIME         CONSTRAINT [DF_CLR_CLRCD] DEFAULT (getdate()) NOT NULL,
    [ControlLogRegisterLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CLR_CLRLMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                  DATETIME         CONSTRAINT [DF_CLR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                   DATETIME         CONSTRAINT [DF_CLR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                 NVARCHAR (50)    CONSTRAINT [DF_CLR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                  INT              CONSTRAINT [DF_CLR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                 ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]              DATETIME         CONSTRAINT [DF_CLR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKControlLogRegister] PRIMARY KEY CLUSTERED ([ControlLogRegisterId] ASC),
    CONSTRAINT [ControlLogRegisterCategoryId] FOREIGN KEY ([ControlLogCategoryId]) REFERENCES [Audit].[ControlLogCategories] ([ControlLogCategoryId]),
    CONSTRAINT [ControlLogRegisterFrequencyId] FOREIGN KEY ([ControlLogFrequencyId]) REFERENCES [Audit].[ControlLogFrequency] ([ControlLogFrequencyId]),
    CONSTRAINT [ControlLogRegisterOwnerRoleId] FOREIGN KEY ([OwnerRoleId]) REFERENCES [Core].[Roles] ([RoleId]),
    CONSTRAINT [ControlLogRegisterOwnerThirdPartyId] FOREIGN KEY ([OwnerThirdPartyId]) REFERENCES [Core].[ThirdParties] ([ThirdPartyId])
);

