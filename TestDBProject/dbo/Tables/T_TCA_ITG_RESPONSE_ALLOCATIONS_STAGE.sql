﻿CREATE TABLE [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_STAGE] (
    [FILE_DATE]                            DATETIME         NULL,
    [ORDERID]                              INT              NULL,
    [DECISION_DATE_TIME]                   DATETIME         NULL,
    [ORDER_START_DATE_TIME]                DATETIME         NULL,
    [AUTHORIZATION_DATE_TIME]              DATETIME         NULL,
    [RELEASE_DATE_TIME]                    DATETIME         NULL,
    [TRADER_DATE_TIME]                     DATETIME         NULL,
    [BROKER_DATE_TIME]                     DATETIME         NULL,
    [TRADE_DATE_TIME]                      DATETIME         NULL,
    [ORDER_END_DATE_TIME]                  DATETIME         NULL,
    [DECISION_END_DATE_TIME]               DATETIME         NULL,
    [5DAY_WTD_AVG_SPREAD_BPS]              DECIMAL (24, 10) NULL,
    [BASEPRICE]                            DECIMAL (24, 10) NULL,
    [BROKER]                               VARCHAR (15)     NULL,
    [5DAY_WTD_AVG_SPREAD_GROUP]            VARCHAR (63)     NULL,
    [ACCOUNT]                              VARCHAR (15)     NULL,
    [COMMISSION_BPS]                       VARCHAR (255)    NULL,
    [COUNTRY]                              VARCHAR (7)      NULL,
    [CURRENCY]                             VARCHAR (7)      NULL,
    [DAYSTOCOMPLETION]                     INT              NULL,
    [FILLED_PERCENT_OF_DAILY_VOLUME]       DECIMAL (24, 10) NULL,
    [FILLED_PERCENT_OF_INTERVAL_VOLUME]    DECIMAL (24, 10) NULL,
    [INTERVALVOLUME]                       DECIMAL (24, 10) NULL,
    [MARKET_CAP_GROUP]                     VARCHAR (63)     NULL,
    [MARKET_CAP_GROUP_USD]                 DECIMAL (24, 10) NULL,
    [ORDER_PERCENT_OF_INTERVAL_VOLUME]     DECIMAL (24, 10) NULL,
    [ORDER_PERCENT_OF_MEDIAN_DAILY_VOLUME] DECIMAL (24, 10) NULL,
    [ORDER_DATE_VOLUME]                    DECIMAL (24, 10) NULL,
    [ORDERSHARES]                          DECIMAL (24, 10) NULL,
    [ORDER_VOLATILITY_BPS]                 DECIMAL (24, 10) NULL,
    [ORIG_PRICE]                           DECIMAL (24, 10) NULL,
    [PM_INSTRUCTIONS]                      VARCHAR (255)    NULL,
    [PM_ORDER_TYPE]                        VARCHAR (255)    NULL,
    [SECURITY_NAME]                        VARCHAR (255)    NULL,
    [SIDE]                                 VARCHAR (7)      NULL,
    [SPREADGROUP]                          VARCHAR (31)     NULL,
    [SPREAD_PERCENTILE]                    INT              NULL,
    [PERCENTSPREAD]                        DECIMAL (24, 10) NULL,
    [VOLATILITY_PERCENTILE]                INT              NULL,
    [VOLUME_PERCENTILE]                    INT              NULL,
    [SYMBOL]                               VARCHAR (31)     NULL,
    [TICKER]                               VARCHAR (15)     NULL,
    [TOTAL_COMMISSION_IN_BASE_CURRENCY]    VARCHAR (255)    NULL,
    [TOTAL_VALUE]                          DECIMAL (24, 10) NULL,
    [TRADE_DATE_VOLATILITY_BPS]            DECIMAL (24, 10) NULL,
    [TRADE_DATE_VOLUME]                    INT              NULL,
    [TRADE_DAYS]                           INT              NULL,
    [TRADE_SHARES]                         INT              NULL,
    [TRADER]                               VARCHAR (15)     NULL,
    [TRADINGDESK]                          VARCHAR (255)    NULL,
    [FEES]                                 DECIMAL (24, 10) NULL,
    [ORIGAUTHORIZATIONDATE]                DATETIME         NULL,
    [ORIGBROKERDATE]                       DATETIME         NULL,
    [ORIGDECISIONDATE]                     DATETIME         NULL,
    [ORIGDECISIONENDDATE]                  DATETIME         NULL,
    [ORIGORDERENDDATETIME]                 DATETIME         NULL,
    [ORIGORDERSTARTDATETIME]               DATETIME         NULL,
    [ORIGRELEASEDATE]                      DATETIME         NULL,
    [ORIGTRADEDATETIME]                    DATETIME         NULL,
    [ORIGTRADERDATE]                       DATETIME         NULL,
    [DIVIDEND]                             VARCHAR (200)    NULL,
    [DIVIDEND_CCY_CLIENT]                  VARCHAR (200)    NULL,
    [SPECIAL_DIVIDEND]                     VARCHAR (200)    NULL,
    [SPECIAL_DIVIDEND_CCY_CLIENT]          VARCHAR (200)    NULL,
    [EXCHANGE_FEE]                         DECIMAL (24, 10) NULL,
    [WITHOLDING_TAX]                       DECIMAL (24, 10) NULL,
    [TRANSFER_TAX]                         DECIMAL (24, 10) NULL,
    [STAMP_DUTY]                           DECIMAL (24, 10) NULL,
    [MISC_FEES]                            DECIMAL (24, 10) NULL,
    [AGGREGATED_TO]                        DECIMAL (24, 10) NULL,
    [AGGREGATED_FROM]                      DECIMAL (24, 10) NULL,
    [B1ADJBENCHPRICE]                      DECIMAL (24, 10) NULL,
    [B1ORIGBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B1ORIGCURRENCYISO]                    VARCHAR (7)      NULL,
    [B1BASEBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B1DLRPERSHRCST]                       DECIMAL (24, 10) NULL,
    [B1NETDLRPERSHRCST]                    DECIMAL (24, 10) NULL,
    [B1NETPCTCST]                          DECIMAL (24, 10) NULL,
    [B1TOTALDLRCOST]                       DECIMAL (24, 10) NULL,
    [B1NETREALDOLLAR]                      DECIMAL (24, 10) NULL,
    [B1NAME]                               VARCHAR (255)    NULL,
    [B1PRETRADECOST]                       DECIMAL (24, 10) NULL,
    [B1PTAMOMENTUMCMP]                     VARCHAR (200)    NULL,
    [B1PTASPRDCMP]                         VARCHAR (200)    NULL,
    [B1PTAVOLCMPBPS]                       VARCHAR (200)    NULL,
    [B1REALISEDCOSTBPS]                    DECIMAL (24, 10) NULL,
    [B2ADJBENCHPRICE]                      DECIMAL (24, 10) NULL,
    [B2ORIGBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B2ORIGCURRENCYISO]                    VARCHAR (7)      NULL,
    [B2BASEBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B2DLRPERSHRCST]                       DECIMAL (24, 10) NULL,
    [B2NETDLRPERSHRCST]                    DECIMAL (24, 10) NULL,
    [B2NETPCTCST]                          DECIMAL (24, 10) NULL,
    [B2TOTALDLRCOST]                       DECIMAL (24, 10) NULL,
    [B2NETREALDOLLAR]                      DECIMAL (24, 10) NULL,
    [B2NAME]                               VARCHAR (255)    NULL,
    [B2PRETRADECOST]                       DECIMAL (24, 10) NULL,
    [B2PTAMOMENTUMCMP]                     VARCHAR (200)    NULL,
    [B2PTASPRDCMP]                         VARCHAR (200)    NULL,
    [B2PTAVOLCMPBPS]                       VARCHAR (200)    NULL,
    [B2REALISEDCOSTBPS]                    DECIMAL (24, 10) NULL,
    [B3ADJBENCHPRICE]                      DECIMAL (24, 10) NULL,
    [B3ORIGBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B3ORIGCURRENCYISO]                    VARCHAR (7)      NULL,
    [B3BASEBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B3DLRPERSHRCST]                       DECIMAL (24, 10) NULL,
    [B3NETDLRPERSHRCST]                    DECIMAL (24, 10) NULL,
    [B3NETPCTCST]                          DECIMAL (24, 10) NULL,
    [B3TOTALDLRCOST]                       DECIMAL (24, 10) NULL,
    [B3NETREALDOLLAR]                      DECIMAL (24, 10) NULL,
    [B3NAME]                               VARCHAR (255)    NULL,
    [B3PRETRADECOST]                       DECIMAL (24, 10) NULL,
    [B3PTAMOMENTUMCMP]                     VARCHAR (200)    NULL,
    [B3PTASPRDCMP]                         VARCHAR (200)    NULL,
    [B3PTAVOLCMPBPS]                       VARCHAR (200)    NULL,
    [B3REALISEDCOSTBPS]                    DECIMAL (24, 10) NULL,
    [B4ADJBENCHPRICE]                      DECIMAL (24, 10) NULL,
    [B4ORIGBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B4ORIGCURRENCYISO]                    VARCHAR (7)      NULL,
    [B4BASEBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B4DLRPERSHRCST]                       DECIMAL (24, 10) NULL,
    [B4NETDLRPERSHRCST]                    DECIMAL (24, 10) NULL,
    [B4NETPCTCST]                          DECIMAL (24, 10) NULL,
    [B4TOTALDLRCOST]                       DECIMAL (24, 10) NULL,
    [B4NETREALDOLLAR]                      DECIMAL (24, 10) NULL,
    [B4NAME]                               VARCHAR (255)    NULL,
    [B4PRETRADECOST]                       DECIMAL (24, 10) NULL,
    [B4PTAMOMENTUMCMP]                     VARCHAR (200)    NULL,
    [B4PTASPRDCMP]                         VARCHAR (200)    NULL,
    [B4PTAVOLCMPBPS]                       VARCHAR (200)    NULL,
    [B4REALISEDCOSTBPS]                    DECIMAL (24, 10) NULL,
    [B5ADJBENCHPRICE]                      DECIMAL (24, 10) NULL,
    [B5ORIGBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B5ORIGCURRENCYISO]                    VARCHAR (7)      NULL,
    [B5BASEBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B5DLRPERSHRCST]                       DECIMAL (24, 10) NULL,
    [B5NETDLRPERSHRCST]                    DECIMAL (24, 10) NULL,
    [B5NETPCTCST]                          DECIMAL (24, 10) NULL,
    [B5TOTALDLRCOST]                       DECIMAL (24, 10) NULL,
    [B5NETREALDOLLAR]                      DECIMAL (24, 10) NULL,
    [B5NAME]                               VARCHAR (255)    NULL,
    [B5PRETRADECOST]                       DECIMAL (24, 10) NULL,
    [B5PTAMOMENTUMCMP]                     VARCHAR (200)    NULL,
    [B5PTASPRDCMP]                         VARCHAR (200)    NULL,
    [B5PTAVOLCMPBPS]                       VARCHAR (200)    NULL,
    [B5REALISEDCOSTBPS]                    DECIMAL (24, 10) NULL,
    [B6ADJBENCHPRICE]                      DECIMAL (24, 10) NULL,
    [B6ORIGBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B6ORIGCURRENCYISO]                    VARCHAR (7)      NULL,
    [B6BASEBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B6DLRPERSHRCST]                       DECIMAL (24, 10) NULL,
    [B6NETDLRPERSHRCST]                    DECIMAL (24, 10) NULL,
    [B6NETPCTCST]                          DECIMAL (24, 10) NULL,
    [B6TOTALDLRCOST]                       DECIMAL (24, 10) NULL,
    [B6NETREALDOLLAR]                      DECIMAL (24, 10) NULL,
    [B6NAME]                               VARCHAR (255)    NULL,
    [B6PRETRADECOST]                       DECIMAL (24, 10) NULL,
    [B6PTAMOMENTUMCMP]                     VARCHAR (200)    NULL,
    [B6PTASPRDCMP]                         VARCHAR (200)    NULL,
    [B6PTAVOLCMPBPS]                       VARCHAR (200)    NULL,
    [B6REALISEDCOSTBPS]                    DECIMAL (24, 10) NULL,
    [B7ADJBENCHPRICE]                      DECIMAL (24, 10) NULL,
    [B7ORIGBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B7ORIGCURRENCYISO]                    VARCHAR (7)      NULL,
    [B7BASEBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B7DLRPERSHRCST]                       DECIMAL (24, 10) NULL,
    [B7NETDLRPERSHRCST]                    DECIMAL (24, 10) NULL,
    [B7NETPCTCST]                          DECIMAL (24, 10) NULL,
    [B7TOTALDLRCOST]                       DECIMAL (24, 10) NULL,
    [B7NETREALDOLLAR]                      DECIMAL (24, 10) NULL,
    [B7NAME]                               VARCHAR (255)    NULL,
    [B7PRETRADECOST]                       DECIMAL (24, 10) NULL,
    [B7PTAMOMENTUMCMP]                     VARCHAR (200)    NULL,
    [B7PTASPRDCMP]                         VARCHAR (200)    NULL,
    [B7PTAVOLCMPBPS]                       VARCHAR (200)    NULL,
    [B7REALISEDCOSTBPS]                    DECIMAL (24, 10) NULL,
    [B8ADJBENCHPRICE]                      DECIMAL (24, 10) NULL,
    [B8ORIGBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B8ORIGCURRENCYISO]                    VARCHAR (7)      NULL,
    [B8BASEBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B8DLRPERSHRCST]                       DECIMAL (24, 10) NULL,
    [B8NETDLRPERSHRCST]                    DECIMAL (24, 10) NULL,
    [B8NETPCTCST]                          DECIMAL (24, 10) NULL,
    [B8TOTALDLRCOST]                       DECIMAL (24, 10) NULL,
    [B8NETREALDOLLAR]                      DECIMAL (24, 10) NULL,
    [B8NAME]                               VARCHAR (255)    NULL,
    [B8PRETRADECOST]                       DECIMAL (24, 10) NULL,
    [B8PTAMOMENTUMCMP]                     VARCHAR (200)    NULL,
    [B8PTASPRDCMP]                         VARCHAR (200)    NULL,
    [B8PTAVOLCMPBPS]                       VARCHAR (200)    NULL,
    [B8REALISEDCOSTBPS]                    DECIMAL (24, 10) NULL,
    [B9ADJBENCHPRICE]                      DECIMAL (24, 10) NULL,
    [B9ORIGBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B9ORIGCURRENCYISO]                    VARCHAR (7)      NULL,
    [B9BASEBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B9DLRPERSHRCST]                       DECIMAL (24, 10) NULL,
    [B9NETDLRPERSHRCST]                    DECIMAL (24, 10) NULL,
    [B9NETPCTCST]                          DECIMAL (24, 10) NULL,
    [B9TOTALDLRCOST]                       DECIMAL (24, 10) NULL,
    [B9NETREALDOLLAR]                      DECIMAL (24, 10) NULL,
    [B9NAME]                               VARCHAR (255)    NULL,
    [B9PRETRADECOST]                       DECIMAL (24, 10) NULL,
    [B9PTAMOMENTUMCMP]                     VARCHAR (200)    NULL,
    [B9PTASPRDCMP]                         VARCHAR (200)    NULL,
    [B9PTAVOLCMPBPS]                       VARCHAR (200)    NULL,
    [B9REALISEDCOSTBPS]                    DECIMAL (24, 10) NULL,
    [B10ADJBENCHPRICE]                     DECIMAL (24, 10) NULL,
    [B10ORIGBENCHPRICE]                    DECIMAL (24, 10) NULL,
    [B10ORIGCURRENCYISO]                   VARCHAR (7)      NULL,
    [B10BASEBENCHPRICE]                    DECIMAL (24, 10) NULL,
    [B10DLRPERSHRCST]                      DECIMAL (24, 10) NULL,
    [B10NETDLRPERSHRCST]                   DECIMAL (24, 10) NULL,
    [B10NETPCTCST]                         DECIMAL (24, 10) NULL,
    [B10TOTALDLRCOST]                      DECIMAL (24, 10) NULL,
    [B10NETREALDOLLAR]                     DECIMAL (24, 10) NULL,
    [B10NAME]                              VARCHAR (255)    NULL,
    [B10PRETRADECOST]                      DECIMAL (24, 10) NULL,
    [B10PTAMOMENTUMCMP]                    VARCHAR (200)    NULL,
    [B10PTASPRDCMP]                        VARCHAR (200)    NULL,
    [B10PTAVOLCMPBPS]                      VARCHAR (200)    NULL,
    [B10REALISEDCOSTBPS]                   DECIMAL (24, 10) NULL,
    [CADIS_SYSTEM_INSERTED]                DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                 DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]               NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL
);

