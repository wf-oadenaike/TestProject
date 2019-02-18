CREATE TABLE [Sales.BP].[WoodfordAccountAddress] (
    [AccountId]         INT      NOT NULL,
    [AddressId]         INT      NOT NULL,
    [IsConfirmRequired] BIT      CONSTRAINT [c_waa_IsConfirmRequired] DEFAULT ('0') NOT NULL,
    [IsReviewed]        BIT      CONSTRAINT [c_waa_IsReviewed] DEFAULT ('0') NOT NULL,
    [StartDateTime]     DATETIME CONSTRAINT [c_waa_StartDateTime] DEFAULT (getdate()) NOT NULL,
    [EndDateTime]       DATETIME CONSTRAINT [c_waa_EndDateTime] DEFAULT ('2099-12-31T00:00:00') NOT NULL,
    [IsActive]          BIT      CONSTRAINT [c_waa_IsActiveDefault] DEFAULT ('1') NOT NULL,
    CONSTRAINT [pk_waa] PRIMARY KEY CLUSTERED ([AccountId] ASC, [AddressId] ASC, [EndDateTime] ASC, [IsActive] ASC),
    CONSTRAINT [fk_waa_accountid] FOREIGN KEY ([AccountId]) REFERENCES [Sales.BP].[WoodfordAccount] ([Id]),
    CONSTRAINT [fk_waa_addressid] FOREIGN KEY ([AddressId]) REFERENCES [Sales.BP].[WoodfordAddress] ([Id])
);

