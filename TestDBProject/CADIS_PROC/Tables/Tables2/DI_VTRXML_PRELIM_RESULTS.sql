﻿CREATE TABLE [CADIS_PROC].[DI_VTRXML_PRELIM_RESULTS] (
    [CADIS_BATCH_ID]                                        INT            NOT NULL,
    [CADIS_MSG_ID]                                          INT            NOT NULL,
    [CADIS_PARENT_ID]                                       INT            NOT NULL,
    [CADIS_ROW_ID]                                          INT            NOT NULL,
    [FUND_SHORT_NAME Populated?]                            BIT            NULL,
    [QUANTITY Populated?]                                   BIT            NULL,
    [SECURITY_NAME Populated?]                              BIT            NULL,
    [SECURITY_SHORTNAME Populated?]                         BIT            NULL,
    [SECURITY_ISO_CCY Populated?]                           BIT            NULL,
    [ISSUE_COUNTRY_ISO Populated?]                          BIT            NULL,
    [UNIQUE_BLOOMBERG_ID Populated?]                        BIT            NULL,
    [CUSIP Polulated?]                                      BIT            NULL,
    [All Tests Passed?]                                     BIT            NULL,
    [CADIS_SYSTEM_CHANGEDBY]                                NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]                                 DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                                  DATETIME       DEFAULT (getdate()) NULL,
    [FUND_SHORT_NAME Populated?__RULEID]                    INT            DEFAULT ((0)) NOT NULL,
    [QUANTITY Populated?__RULEID]                           INT            DEFAULT ((0)) NOT NULL,
    [SECURITY_NAME Populated?__RULEID]                      INT            DEFAULT ((0)) NOT NULL,
    [SECURITY_SHORTNAME Populated?__RULEID]                 INT            DEFAULT ((0)) NOT NULL,
    [SECURITY_ISO_CCY Populated?__RULEID]                   INT            DEFAULT ((0)) NOT NULL,
    [ISSUE_COUNTRY_ISO Populated?__RULEID]                  INT            DEFAULT ((0)) NOT NULL,
    [UNIQUE_BLOOMBERG_ID Populated?__RULEID]                INT            DEFAULT ((0)) NOT NULL,
    [CUSIP Polulated?__RULEID]                              INT            DEFAULT ((0)) NOT NULL,
    [All Tests Passed?__RULEID]                             INT            DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_ROWKEY]                                   NVARCHAR (MAX) NOT NULL,
    [POS EXISTS]                                            BIT            DEFAULT ((0)) NOT NULL,
    [Component_InstrumentId for Warrent Populated?]         BIT            NULL,
    [Component_InstrumentId for Warrent Populated?__RULEID] INT            DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC)
);
