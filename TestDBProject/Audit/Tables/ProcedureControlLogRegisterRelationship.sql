CREATE TABLE [Audit].[ProcedureControlLogRegisterRelationship] (
    [PolicyThemeProcedureId] INT NOT NULL,
    [ControlLogRegisterId]   INT NOT NULL,
    [IsActive]               BIT CONSTRAINT [DF_PCLRR_IA] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PKProcedureControlLogRegisterRelationship] PRIMARY KEY CLUSTERED ([PolicyThemeProcedureId] ASC, [ControlLogRegisterId] ASC),
    CONSTRAINT [ProcedureControlLogRegisterRelationshipControlLogRegisterId] FOREIGN KEY ([ControlLogRegisterId]) REFERENCES [Audit].[ControlLogRegister] ([ControlLogRegisterId]),
    CONSTRAINT [ProcedureControlLogRegisterRelationshipPolicyThemeProcedureId] FOREIGN KEY ([PolicyThemeProcedureId]) REFERENCES [Organisation].[PolicyThemeProcedures] ([PolicyThemeProcedureId])
);

