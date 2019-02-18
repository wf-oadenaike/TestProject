CREATE TABLE [CADIS_PROC].[DI_VTRXML_RESULTS] (
    [CADIS_BATCH_ID]                                INT           NOT NULL,
    [CADIS_MSG_ID]                                  INT           NOT NULL,
    [CADIS_PARENT_ID]                               INT           NOT NULL,
    [CADIS_ROW_ID]                                  INT           NOT NULL,
    [FUND_SHORT_NAME Populated?]                    BIT           NULL,
    [QUANTITY Populated?]                           BIT           NULL,
    [SECURITY_NAME Populated?]                      BIT           NULL,
    [SECURITY_SHORTNAME Populated?]                 BIT           NULL,
    [SECURITY_ISO_CCY Populated?]                   BIT           NULL,
    [ISSUE_COUNTRY_ISO Populated?]                  BIT           NULL,
    [UNIQUE_BLOOMBERG_ID Populated?]                BIT           NULL,
    [CUSIP Polulated?]                              BIT           NULL,
    [All Tests Passed?]                             BIT           NULL,
    [CADIS_SYSTEM_CHANGEDBY]                        NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]                         DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                          DATETIME      DEFAULT (getdate()) NULL,
    [Component_InstrumentId for Warrent Populated?] BIT           NULL,
    PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC)
);

