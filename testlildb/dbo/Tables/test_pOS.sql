CREATE TABLE [dbo].[test_pOS] (
    [SOURCE]                    VARCHAR (50)    NOT NULL,
    [POSITION_TYPE]             VARCHAR (50)    NOT NULL,
    [EDM_SEC_ID]                INT             NOT NULL,
    [FUND_SHORT_NAME]           VARCHAR (15)    NOT NULL,
    [LONG_SHORT_IND]            VARCHAR (8)     NOT NULL,
    [POSITION_DATE]             DATETIME        NOT NULL,
    [QUANTITY]                  NUMERIC (20, 6) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        NULL
);


GO
CREATE NONCLUSTERED INDEX [Index_pos_date]
    ON [dbo].[test_pOS]([FUND_SHORT_NAME] ASC)
    INCLUDE([POSITION_DATE], [QUANTITY]);

