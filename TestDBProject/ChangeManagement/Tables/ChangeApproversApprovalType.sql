CREATE TABLE [ChangeManagement].[ChangeApproversApprovalType] (
    [ChangeApproversApprovalTypeID]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ChangeApproversApprovalTypeName] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PKChangeApproversApprovalType] PRIMARY KEY CLUSTERED ([ChangeApproversApprovalTypeID] ASC)
);

