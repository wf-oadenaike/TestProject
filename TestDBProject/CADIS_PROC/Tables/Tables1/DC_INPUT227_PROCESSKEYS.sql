CREATE TABLE [CADIS_PROC].[DC_INPUT227_PROCESSKEYS] (
    [Fund Short Name] VARCHAR (20) NOT NULL,
    [EDM_SEC_ID]      INT          NOT NULL,
    [Calendar Year]   INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([Fund Short Name] ASC, [EDM_SEC_ID] ASC, [Calendar Year] ASC) WITH (FILLFACTOR = 80)
);

