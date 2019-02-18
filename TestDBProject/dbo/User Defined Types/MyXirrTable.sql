CREATE TYPE [dbo].[MyXirrTable] AS TABLE (
    [theValue]  DECIMAL (38, 9) NOT NULL,
    [theDate]   DATETIME        NOT NULL,
    [FUND]      VARCHAR (250)   NULL,
    [KNOWNNAME] VARCHAR (250)   NULL);

