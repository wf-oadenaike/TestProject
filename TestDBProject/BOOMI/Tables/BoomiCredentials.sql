CREATE TABLE [BOOMI].[BoomiCredentials] (
    [BoomiJobName] VARCHAR (150) NOT NULL,
    [Username]     VARCHAR (50)  NOT NULL,
    [Password]     VARCHAR (100) NOT NULL,
    [ENV]          VARCHAR (5)   NOT NULL,
    CONSTRAINT [PK_Creds] PRIMARY KEY NONCLUSTERED ([BoomiJobName] ASC, [ENV] ASC)
);

