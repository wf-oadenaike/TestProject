﻿CREATE TABLE [dbo].[T_MASTER_BBAIM_TRADE] (
    [TraderAccountName]                     VARCHAR (50)   NOT NULL,
    [TransactionNumber]                     VARCHAR (50)   NOT NULL,
    [CADIS_BATCH_ID]                        INT            NOT NULL,
    [CADIS_MSG_ID]                          INT            CONSTRAINT [DF__T_MASTER___CADIS__45F75E86] DEFAULT ((1)) NULL,
    [CADIS_PARENT_ID]                       INT            NULL,
    [CADIS_ROW_ID]                          INT            NULL,
    [BloombergFirmID]                       NVARCHAR (MAX) NULL,
    [SecurityIdentifierFlag]                NVARCHAR (MAX) NULL,
    [SecurityIdentifier]                    NVARCHAR (MAX) NULL,
    [SecurityCurrencyISOCode]               NVARCHAR (MAX) NULL,
    [SecurityProductKey]                    NVARCHAR (MAX) NULL,
    [BloombergIdentifier]                   NVARCHAR (MAX) NULL,
    [Ticker]                                NVARCHAR (MAX) NULL,
    [BloombergReferenceNumber]              NVARCHAR (MAX) NULL,
    [CouponStrikePrice]                     NVARCHAR (MAX) NULL,
    [MaturityDateExpirationDate]            NVARCHAR (MAX) NULL,
    [SeriesExchangeCode]                    NVARCHAR (MAX) NULL,
    [BuySellCoverShortFlag]                 NVARCHAR (MAX) NULL,
    [RecordType]                            NVARCHAR (MAX) NULL,
    [TradeDate]                             NVARCHAR (MAX) NULL,
    [AsOfTradeDate]                         NVARCHAR (MAX) NULL,
    [SettlementDate]                        NVARCHAR (MAX) NULL,
    [Price]                                 NVARCHAR (MAX) NULL,
    [Yield]                                 NVARCHAR (MAX) NULL,
    [DiscountRate]                          NVARCHAR (MAX) NULL,
    [TradeAmount]                           NVARCHAR (MAX) NULL,
    [CustomerAccountCounterparty]           NVARCHAR (MAX) NULL,
    [AccountCounterpartyShortName]          NVARCHAR (MAX) NULL,
    [SettlementLocationIndicator]           NVARCHAR (MAX) NULL,
    [GeneralLedgerAccount]                  NVARCHAR (MAX) NULL,
    [ProductSubFlag]                        NVARCHAR (MAX) NULL,
    [PrincipalLoanAmount]                   NVARCHAR (MAX) NULL,
    [AccruedInterestRepoInterest]           NVARCHAR (MAX) NULL,
    [NumberOfDaysAccrued]                   NVARCHAR (MAX) NULL,
    [ShortNote1]                            NVARCHAR (MAX) NULL,
    [ShortNote2]                            NVARCHAR (MAX) NULL,
    [ShortNote3]                            NVARCHAR (MAX) NULL,
    [ShortNote4]                            NVARCHAR (MAX) NULL,
    [LongNote1]                             NVARCHAR (MAX) NULL,
    [LongNote2]                             NVARCHAR (MAX) NULL,
    [LongNote3]                             NVARCHAR (MAX) NULL,
    [LongNote4]                             NVARCHAR (MAX) NULL,
    [SalespersonName]                       NVARCHAR (MAX) NULL,
    [LastLogin]                             NVARCHAR (MAX) NULL,
    [SalespersonLogin]                      NVARCHAR (MAX) NULL,
    [ConcessionStipulationVarianceRepoRate] NVARCHAR (MAX) NULL,
    [PrepaymentSpeedAndTypeContractSize]    NVARCHAR (MAX) NULL,
    [SettlementCurrencyISOCode]             NVARCHAR (MAX) NULL,
    [SettlementCurrencyRate]                NVARCHAR (MAX) NULL,
    [CancelDueToCorrection]                 NVARCHAR (MAX) NULL,
    [TransactionCost1_Type]                 NVARCHAR (MAX) NULL,
    [TransactionCost1_Currency]             NVARCHAR (MAX) NULL,
    [TransactionCost1_Code]                 NVARCHAR (MAX) NULL,
    [TransactionCost1_Cost]                 NVARCHAR (MAX) NULL,
    [TransactionCost1_EffectOnFinalMoney]   NVARCHAR (MAX) NULL,
    [TransactionCost1_CurrencyRate]         NVARCHAR (MAX) NULL,
    [TransactionCost2_Type]                 NVARCHAR (MAX) NULL,
    [TransactionCost2_Currency]             NVARCHAR (MAX) NULL,
    [TransactionCost2_Code]                 NVARCHAR (MAX) NULL,
    [TransactionCost2_Cost]                 NVARCHAR (MAX) NULL,
    [TransactionCost2_EffectOnFinalMoney]   NVARCHAR (MAX) NULL,
    [TransactionCost2_CurrencyRate]         NVARCHAR (MAX) NULL,
    [TransactionCost3_Type]                 NVARCHAR (MAX) NULL,
    [TransactionCost3_Currency]             NVARCHAR (MAX) NULL,
    [TransactionCost3_Code]                 NVARCHAR (MAX) NULL,
    [TransactionCost3_Cost]                 NVARCHAR (MAX) NULL,
    [TransactionCost3_EffectOnFinalMoney]   NVARCHAR (MAX) NULL,
    [TransactionCost3_CurrencyRate]         NVARCHAR (MAX) NULL,
    [TransactionCost4_Type]                 NVARCHAR (MAX) NULL,
    [TransactionCost4_Currency]             NVARCHAR (MAX) NULL,
    [TransactionCost4_Code]                 NVARCHAR (MAX) NULL,
    [TransactionCost4_Cost]                 NVARCHAR (MAX) NULL,
    [TransactionCost4_EffectOnFinalMoney]   NVARCHAR (MAX) NULL,
    [TransactionCost4_CurrencyRate]         NVARCHAR (MAX) NULL,
    [TransactionCost5_Type]                 NVARCHAR (MAX) NULL,
    [TransactionCost5_Currency]             NVARCHAR (MAX) NULL,
    [TransactionCost5_Code]                 NVARCHAR (MAX) NULL,
    [TransactionCost5_Cost]                 NVARCHAR (MAX) NULL,
    [TransactionCost5_EffectOnFinalMoney]   NVARCHAR (MAX) NULL,
    [TransactionCost5_CurrencyRate]         NVARCHAR (MAX) NULL,
    [PutCallIndicator]                      NVARCHAR (MAX) NULL,
    [NameOfUserWhoAuthorizedTrade]          NVARCHAR (MAX) NULL,
    [ContractSize]                          NVARCHAR (MAX) NULL,
    [InUnitsFlag]                           NVARCHAR (MAX) NULL,
    [UniqueBloombergID]                     NVARCHAR (MAX) NULL,
    [ExtendedPrecisionPrice]                NVARCHAR (MAX) NULL,
    [SystemDate]                            NVARCHAR (MAX) NULL,
    [FXStrategyCode]                        NVARCHAR (MAX) NULL,
    [TraderAccountNumber]                   NVARCHAR (MAX) NULL,
    [TransactionType]                       NVARCHAR (MAX) NULL,
    [CorrectionAsOriginal]                  NVARCHAR (MAX) NULL,
    [InterestAtMaturity]                    NVARCHAR (MAX) NULL,
    [OrderType]                             NVARCHAR (MAX) NULL,
    [LimitPrice]                            NVARCHAR (MAX) NULL,
    [EnteredTicketUserId]                   NVARCHAR (MAX) NULL,
    [AllocatedTicketUserId]                 NVARCHAR (MAX) NULL,
    [NAVEstimated]                          NVARCHAR (MAX) NULL,
    [CostAdded]                             NVARCHAR (MAX) NULL,
    [EntryOfMutualFundSharesWasBySellAll]   NVARCHAR (MAX) NULL,
    [CorrectedActualNAV]                    NVARCHAR (MAX) NULL,
    [CutTrade]                              NVARCHAR (MAX) NULL,
    [OptionsDelta]                          NVARCHAR (MAX) NULL,
    [OMSOrderNumber]                        NVARCHAR (MAX) NULL,
    [CancelDueToMatch]                      NVARCHAR (MAX) NULL,
    [TransactionNumberOfOriginTrans]        NVARCHAR (MAX) NULL,
    [MasterTicketNumber]                    NVARCHAR (MAX) NULL,
    [SecondaryTransactionTicketNumber]      NVARCHAR (MAX) NULL,
    [BuySellBackReferenceTicketNumber]      NVARCHAR (MAX) NULL,
    [OMSOrderType]                          NVARCHAR (MAX) NULL,
    [TotalTradeAmount]                      NVARCHAR (MAX) NULL,
    [MasterAccount]                         NVARCHAR (MAX) NULL,
    [MasterAccountName]                     NVARCHAR (MAX) NULL,
    [ElectronicExecutionFlag]               NVARCHAR (MAX) NULL,
    [MatchDate]                             NVARCHAR (MAX) NULL,
    [IsDirtyPrice]                          NVARCHAR (MAX) NULL,
    [TaxLots1_ID]                           NVARCHAR (MAX) NULL,
    [TaxLots1_Price]                        NVARCHAR (MAX) NULL,
    [TaxLots1_Amt]                          NVARCHAR (MAX) NULL,
    [TaxLots2_ID]                           NVARCHAR (MAX) NULL,
    [TaxLots2_Price]                        NVARCHAR (MAX) NULL,
    [TaxLots2_Amt]                          NVARCHAR (MAX) NULL,
    [TaxLots3_ID]                           NVARCHAR (MAX) NULL,
    [TaxLots3_Price]                        NVARCHAR (MAX) NULL,
    [TaxLots3_Amt]                          NVARCHAR (MAX) NULL,
    [TaxLots4_ID]                           NVARCHAR (MAX) NULL,
    [TaxLots4_Price]                        NVARCHAR (MAX) NULL,
    [TaxLots4_Amt]                          NVARCHAR (MAX) NULL,
    [TaxLots5_ID]                           NVARCHAR (MAX) NULL,
    [TaxLots5_Price]                        NVARCHAR (MAX) NULL,
    [TaxLots5_Amt]                          NVARCHAR (MAX) NULL,
    [TaxLots6_ID]                           NVARCHAR (MAX) NULL,
    [TaxLots6_Price]                        NVARCHAR (MAX) NULL,
    [TaxLots6_Amt]                          NVARCHAR (MAX) NULL,
    [TaxLots7_ID]                           NVARCHAR (MAX) NULL,
    [TaxLots7_Price]                        NVARCHAR (MAX) NULL,
    [TaxLots7_Amt]                          NVARCHAR (MAX) NULL,
    [TaxLots8_ID]                           NVARCHAR (MAX) NULL,
    [TaxLots8_Price]                        NVARCHAR (MAX) NULL,
    [TaxLots8_Amt]                          NVARCHAR (MAX) NULL,
    [TaxLots9_ID]                           NVARCHAR (MAX) NULL,
    [TaxLots9_Price]                        NVARCHAR (MAX) NULL,
    [TaxLots9_Amt]                          NVARCHAR (MAX) NULL,
    [TaxLots10_ID]                          NVARCHAR (MAX) NULL,
    [TaxLots10_Price]                       NVARCHAR (MAX) NULL,
    [TaxLots10_Amt]                         NVARCHAR (MAX) NULL,
    [OriginalTktId]                         NVARCHAR (MAX) NULL,
    [CTMMatchStatus]                        NVARCHAR (MAX) NULL,
    [SecurityPrice]                         NVARCHAR (MAX) NULL,
    [LocalExchange]                         NVARCHAR (MAX) NULL,
    [SettlementAmount]                      NVARCHAR (MAX) NULL,
    [DirtyPrice]                            NVARCHAR (MAX) NULL,
    [MarketSpotDate]                        NVARCHAR (MAX) NULL,
    [ISOCodeOf1stCurrency]                  NVARCHAR (MAX) NULL,
    [ISOCodeOf2ndCurrency]                  NVARCHAR (MAX) NULL,
    [MarketRate]                            NVARCHAR (MAX) NULL,
    [FixingDateTime]                        NVARCHAR (MAX) NULL,
    [FixingRate]                            NVARCHAR (MAX) NULL,
    [OptionType]                            NVARCHAR (MAX) NULL,
    [OrigTkt]                               NVARCHAR (MAX) NULL,
    [OrigOrder]                             NVARCHAR (MAX) NULL,
    [FundCcyPrincipal]                      NVARCHAR (MAX) NULL,
    [FundCcyTotalCommission]                NVARCHAR (MAX) NULL,
    [RedemptionCcyPrincipal]                NVARCHAR (MAX) NULL,
    [RedemptionTotalCommission]             NVARCHAR (MAX) NULL,
    [SettlementCcyPrincipal]                NVARCHAR (MAX) NULL,
    [SettlementCcyTotalCommission]          NVARCHAR (MAX) NULL,
    [PrimaryExchangeCode]                   NVARCHAR (MAX) NULL,
    [CancelDate]                            NVARCHAR (MAX) NULL,
    [ExternalTradeID]                       NVARCHAR (MAX) NULL,
    [SettlementCcyPrice]                    NVARCHAR (MAX) NULL,
    [FunctionName]                          NVARCHAR (MAX) NULL,
    [EnteredTicketUserName]                 NVARCHAR (MAX) NULL,
    [AllocatedTicketUserName]               NVARCHAR (MAX) NULL,
    [OMReasonCode]                          NVARCHAR (MAX) NULL,
    [DividendCurrency]                      NVARCHAR (MAX) NULL,
    [DividendExDate]                        NVARCHAR (MAX) NULL,
    [DividendPayDate]                       NVARCHAR (MAX) NULL,
    [DividendPerShareLastNet]               NVARCHAR (MAX) NULL,
    [DividendPerShareLastGross]             NVARCHAR (MAX) NULL,
    [TerminationDate]                       NVARCHAR (MAX) NULL,
    [TerminationMoney]                      NVARCHAR (MAX) NULL,
    [EarlyCloseoutFlag]                     NVARCHAR (MAX) NULL,
    [RepoRollover]                          NVARCHAR (MAX) NULL,
    [DayCount]                              NVARCHAR (MAX) NULL,
    [RepoOriginalBloombergReferenceNumber]  NVARCHAR (MAX) NULL,
    [MortgageBradyIndexBondFactor]          NVARCHAR (MAX) NULL,
    [SecurityIsPenceQuoted]                 NVARCHAR (MAX) NULL,
    [StepOutBroker]                         NVARCHAR (MAX) NULL,
    [RepoTransactionType]                   NVARCHAR (MAX) NULL,
    [FunctionName2]                         NVARCHAR (MAX) NULL,
    [FunctionName3]                         NVARCHAR (MAX) NULL,
    [FunctionName4]                         NVARCHAR (MAX) NULL,
    [EnteredByCurrency]                     VARCHAR (6)    NULL,
    [CADIS_SYSTEM_INSERTED]                 DATETIME       CONSTRAINT [DF__T_MASTER___CADIS__46EB82BF] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                  DATETIME       CONSTRAINT [DF__T_MASTER___CADIS__47DFA6F8] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                NVARCHAR (50)  CONSTRAINT [DF__T_MASTER___CADIS__48D3CB31] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                 INT            CONSTRAINT [DF__T_MASTER___CADIS__49C7EF6A] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED]             DATETIME       CONSTRAINT [DF__T_MASTER___CADIS__4ABC13A3] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__T_MASTER__D7DD2CD2DB862375] PRIMARY KEY CLUSTERED ([TraderAccountName] ASC, [TransactionNumber] ASC) WITH (FILLFACTOR = 90)
);
