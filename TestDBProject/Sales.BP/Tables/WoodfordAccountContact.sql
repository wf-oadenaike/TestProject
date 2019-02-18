CREATE TABLE [Sales.BP].[WoodfordAccountContact] (
    [AccountId]         INT      NOT NULL,
    [ContactId]         INT      NOT NULL,
    [IsConfirmRequired] BIT      CONSTRAINT [c_wac_IsConfirmRequired] DEFAULT ('0') NOT NULL,
    [IsReviewed]        BIT      CONSTRAINT [c_wac_IsReviewed] DEFAULT ('0') NOT NULL,
    [StartDateTime]     DATETIME CONSTRAINT [c_wac_StartDateTime] DEFAULT (getdate()) NOT NULL,
    [EndDateTime]       DATETIME CONSTRAINT [c_wac_EndDateTime] DEFAULT ('2099-12-31T00:00:00') NOT NULL,
    [IsActive]          BIT      CONSTRAINT [c_wac_IsActiveDefault] DEFAULT ('1') NOT NULL,
    CONSTRAINT [pk_wac] PRIMARY KEY CLUSTERED ([AccountId] ASC, [ContactId] ASC, [EndDateTime] ASC, [IsActive] ASC),
    CONSTRAINT [fk_wac_accountid] FOREIGN KEY ([AccountId]) REFERENCES [Sales.BP].[WoodfordAccount] ([Id]),
    CONSTRAINT [fk_wac_contactid] FOREIGN KEY ([ContactId]) REFERENCES [Sales.BP].[WoodfordContact] ([Id])
);

