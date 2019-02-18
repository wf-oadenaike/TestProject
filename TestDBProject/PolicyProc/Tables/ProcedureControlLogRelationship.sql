CREATE TABLE [PolicyProc].[ProcedureControlLogRelationship] (
    [ProcedureId]               INT              NOT NULL,
    [PolicyId]                  INT              NULL,
    [ControlLogRegisterId]      INT              NOT NULL,
    [IsActive]                  BIT              CONSTRAINT [DF_PCLR_IA] DEFAULT ((1)) NOT NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NOT NULL,
    [CreationDatetime]          DATETIME         CONSTRAINT [DF_PCLR_PORCDT] DEFAULT (getdate()) NOT NULL,
    [LastModifiedDatetime]      DATETIME         CONSTRAINT [DF_PCLR_PORLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_PCLR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_PCLR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_PCLR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_PCLR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_PCLR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKProcedureControlLogRelationship] PRIMARY KEY CLUSTERED ([ProcedureId] ASC, [ControlLogRegisterId] ASC),
    CONSTRAINT [ProcedureControlLogRegisterRelationshipPolicyId] FOREIGN KEY ([PolicyId]) REFERENCES [PolicyProc].[PolicyRegister] ([PolicyId]),
    CONSTRAINT [ProcedureControlLogRegisterRelationshipProcedureId] FOREIGN KEY ([ProcedureId]) REFERENCES [PolicyProc].[ProcedureRegister] ([ProcedureId]),
    CONSTRAINT [ProcedureControlLogRelationshipControlLogRegisterId] FOREIGN KEY ([ControlLogRegisterId]) REFERENCES [Audit].[ControlLogRegister] ([ControlLogRegisterId])
);

