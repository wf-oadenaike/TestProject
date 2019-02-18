﻿CREATE TABLE [dbo].[T_MASTER_COMPLIANCE_RULE_SUMMARY] (
    [CADIS_RUN_ID]                                                 INT           NULL,
    [CADIS_ROW_ID]                                                 INT           NULL,
    [RULESUMMARY_VERSION]                                          VARCHAR (50)  NULL,
    [RULESUMMARY_DATE]                                             VARCHAR (50)  NOT NULL,
    [RULE_RULECURNCY]                                              VARCHAR (50)  NULL,
    [RULE_RULEEXPR]                                                VARCHAR (50)  NULL,
    [RULE_RULEID]                                                  VARCHAR (50)  NOT NULL,
    [RULE_RULESTATE]                                               VARCHAR (50)  NULL,
    [RULE_RULETYPE]                                                VARCHAR (50)  NULL,
    [RULE_RULEWGTTYPE]                                             VARCHAR (50)  NULL,
    [RULE_RULECODE]                                                VARCHAR (50)  NULL,
    [RULE_RULENAME]                                                VARCHAR (50)  NULL,
    [RULE_RULEDESC]                                                VARCHAR (50)  NULL,
    [RULE_RULENOTE]                                                VARCHAR (50)  NULL,
    [MAXIMUM_MAXVAL]                                               VARCHAR (50)  NULL,
    [MINIMUM_MINVAL]                                               VARCHAR (50)  NULL,
    [CONDITIONSNEEDED_CADIS_ROW_ID]                                VARCHAR (50)  NULL,
    [CONDITIONSNEEDED_CONDITIONSNEEDEDVAL]                         VARCHAR (50)  NULL,
    [NANR_NANRVAL]                                                 VARCHAR (50)  NULL,
    [USGOVTHIGHEST_USGOVTHIGHESTVAL]                               VARCHAR (50)  NULL,
    [MONEYMKTS_INCLMONEYMKTS]                                      VARCHAR (50)  NULL,
    [SEVERITY_SEVERITYVAL]                                         VARCHAR (50)  NULL,
    [OVERRIDEUSERGRP_OVERRIDEUSERGRPNAME]                          VARCHAR (50)  NULL,
    [OVERRIDEUSERGRP_OVERRIDEUSERGRPTYPE]                          VARCHAR (50)  NULL,
    [ALERT_ALERTTYPE]                                              VARCHAR (50)  NULL,
    [POSTMSGTARGET_POSTMSGTARGETNAME]                              VARCHAR (50)  NULL,
    [POSTMSGTARGET_POSTMSGTARGETTYPE]                              VARCHAR (50)  NULL,
    [PRETRADE_PRETRADECHECK]                                       VARCHAR (50)  NULL,
    [POSTTRADE_POSTTRADECHECK]                                     VARCHAR (50)  NULL,
    [ENDOFDAY_ENDOFDAYCHECK]                                       VARCHAR (50)  NULL,
    [OPENORDERS_INCLOPENORDERS]                                    VARCHAR (50)  NULL,
    [CASH_TRADEDATECASH]                                           VARCHAR (50)  NULL,
    [MARGINCASH_MARGINCASH]                                        VARCHAR (50)  NULL,
    [RATINGSDEFAULT_RATINGSDEFVAL]                                 VARCHAR (50)  NULL,
    [ACCOUNT_ACCOUNTVAL]                                           VARCHAR (50)  NULL,
    [INCLUDESWAPTOMATURITY_INCLUDESWAPTOMATURITYVAL]               VARCHAR (50)  NULL,
    [INCLUDEFXOPTIONUNTILEXP_INCLUDEFXOPTIONUNTILEXPVAL]           VARCHAR (50)  NULL,
    [EXCLUDEFX2LEG_EXCLUDEFX2LEGVAL]                               VARCHAR (50)  NULL,
    [EXCLUDEFXATMATURITY_EXCLUDEFXATMATURITYVAL]                   VARCHAR (50)  NULL,
    [CPLMCALCULATEDON_CPLMCALCULATEDONVAL]                         VARCHAR (50)  NULL,
    [USEABSLIMITSCPLM_USEABSLIMITSCPLMVAL]                         VARCHAR (50)  NULL,
    [PRICING_PRICINGVAL]                                           VARCHAR (50)  NULL,
    [TSPLLOOKTHROUGH_TSPLLOOKTHROUGHVAL]                           VARCHAR (50)  NULL,
    [SINGLEVIOLATIONFORBASKET_SINGLEVIOLATIONFORBASKETVAL]         VARCHAR (50)  NULL,
    [VIOLATIONWORSE_VIOLATIONWORSEVAL]                             VARCHAR (50)  NULL,
    [REPORTINGTOLERANCE_RPTTOLERANCEVAL]                           VARCHAR (50)  NULL,
    [VIOLATIONSTORAGE_VIOLATIONSTORAGEVAL]                         VARCHAR (50)  NULL,
    [MARKETVALUE_DENOMMKTVAL]                                      VARCHAR (50)  NULL,
    [MARKETVALUE_MKTVAL]                                           VARCHAR (50)  NULL,
    [MARKETVALUE_NUMERMKTVAL]                                      VARCHAR (50)  NULL,
    [FUTURESVALUATION_FUTURESVALDENOM]                             VARCHAR (50)  NULL,
    [FUTURESVALUATION_FUTURESVALNUMER]                             VARCHAR (50)  NULL,
    [OPTIONVALUATION_OPTIONVALDENOM]                               VARCHAR (50)  NULL,
    [OPTIONVALUATION_OPTIONVALNUMER]                               VARCHAR (50)  NULL,
    [SWAPSVALUATION_SWAPSVALDENOM]                                 VARCHAR (50)  NULL,
    [SWAPSVALUATION_SWAPSVALNUMER]                                 VARCHAR (50)  NULL,
    [DERIVATIVESVALUATION_DERVVALDENOM]                            VARCHAR (50)  NULL,
    [DERIVATIVESVALUATION_DERVVALNUMER]                            VARCHAR (50)  NULL,
    [CONVERTIBLESVALUATION_CONVVALNUMER]                           VARCHAR (50)  NULL,
    [INTERESTRATEFUTURESVALUATION_IRFVALNUMER]                     VARCHAR (50)  NULL,
    [EXPIRATIONRANGE1_MONTHS]                                      VARCHAR (50)  NULL,
    [EXPIRATIONRANGE1_OP]                                          VARCHAR (50)  NULL,
    [NETIFEXPIRATIONDIFF1_OP]                                      VARCHAR (50)  NULL,
    [NETIFEXPIRATIONDIFF1_DAYS]                                    VARCHAR (50)  NULL,
    [EXPIRATIONRANGE2_MONTH1]                                      VARCHAR (50)  NULL,
    [EXPIRATIONRANGE2_MONTH2]                                      VARCHAR (50)  NULL,
    [EXPIRATIONRANGE2_OP1]                                         VARCHAR (50)  NULL,
    [EXPIRATIONRANGE2_OP2]                                         VARCHAR (50)  NULL,
    [NETIFEXPIRATIONDIFF2_OP]                                      VARCHAR (50)  NULL,
    [NETIFEXPIRATIONDIFF2_DAYS]                                    VARCHAR (50)  NULL,
    [EXPIRATIONRANGE3_MONTHS]                                      VARCHAR (50)  NULL,
    [EXPIRATIONRANGE3_OP]                                          VARCHAR (50)  NULL,
    [NETIFEXPIRATIONDIFF3_OP]                                      VARCHAR (50)  NULL,
    [NETIFEXPIRATIONDIFF3_DAYS]                                    VARCHAR (50)  NULL,
    [LOOKTHROUGHTOUNDERLYINGATTRS_LOOKTHROUGHTOUNDERLYINGATTRSVAL] VARCHAR (50)  NULL,
    [NUMOFCONTRACTS_NUMOFCONTRACTSVAL]                             VARCHAR (50)  NULL,
    [SECREPOEDIN_INCLSECREPOEDIN]                                  VARCHAR (50)  NULL,
    [SECREPOEDOUT_INCLSECREPOEDOUT]                                VARCHAR (50)  NULL,
    [PLEDGEDCOLLAT_INCLPLEDGEDCOLLAT]                              VARCHAR (50)  NULL,
    [REPOVALUATION_REPOVAL]                                        VARCHAR (50)  NULL,
    [CADIS_SYSTEM_INSERTED]                                        DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                                         DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                                       NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                                        INT           DEFAULT ((1)) NULL,
    PRIMARY KEY CLUSTERED ([RULESUMMARY_DATE] ASC, [RULE_RULEID] ASC) WITH (FILLFACTOR = 90)
);
