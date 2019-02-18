﻿CREATE TABLE [Investment].[FinPromsRegisterChecklist] (
    [FinPromRegisterId]                     INT              NOT NULL,
    [CapitalAtRiskStatedClearly]            BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_CapitalAtRiskStatedClearly] DEFAULT ((0)) NOT NULL,
    [YieldFigureQuoted]                     BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_YieldFigureQuoted] DEFAULT ((0)) NOT NULL,
    [BalanceLongShortTermProjects]          BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_BalanceLongShortTermProjects] DEFAULT ((0)) NOT NULL,
    [SufficientInfoOnCharges]               BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_SufficientInfoOnCharges] DEFAULT ((0)) NOT NULL,
    [MustStateFCA]                          BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_MustStateFCA] DEFAULT ((0)) NOT NULL,
    [NoReferenceToGuaranteed]               BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_NoReferenceToGuaranteed] DEFAULT ((0)) NOT NULL,
    [FinPromIdentifiableAsPromotion]        BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_FinPromIdentifiableAsPromotion] DEFAULT ((0)) NOT NULL,
    [CanOnlyBeFactualReferences]            BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_CanOnlyBeFactualReferences] DEFAULT ((0)) NOT NULL,
    [ContainsNameOfFirm]                    BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_ContainsNameOfFirm] DEFAULT ((0)) NOT NULL,
    [AccurateAndBalanced]                   BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_AccurateAndBalanced] DEFAULT ((0)) NOT NULL,
    [FontSizeUsed]                          BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_FontSizeUsed] DEFAULT ((0)) NOT NULL,
    [RelevantRisks]                         BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_RelevantRisks] DEFAULT ((0)) NOT NULL,
    [SufficientForAverageMember]            BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_SufficientForAverageMember] DEFAULT ((0)) NOT NULL,
    [DoesNotDisguise]                       BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_DoesNotDisguise] DEFAULT ((0)) NOT NULL,
    [InfoNotIndicateFCA]                    BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_InfoNotIndicateFCA] DEFAULT ((0)) NOT NULL,
    [ComparisonsMeaningful]                 BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_ComparisonsMeaningful] DEFAULT ((0)) NOT NULL,
    [TaxRefStateDependsOn]                  BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_TaxRefStateDependsOn] DEFAULT ((0)) NOT NULL,
    [BenchQuotedSourcedESMA]                BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_BenchQuotedSourcedESMA] DEFAULT ((0)) NOT NULL,
    [InfoMustBeConsistent]                  BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_InfoMustBeConsistent] DEFAULT ((0)) NOT NULL,
    [PPNotProminentFeature]                 BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_PPNotProminentFeature] DEFAULT ((0)) NOT NULL,
    [PPMustCover]                           BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_PPMustCover] DEFAULT ((0)) NOT NULL,
    [IncludeRefPeriod]                      BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_IncludeRefPeriod] DEFAULT ((0)) NOT NULL,
    [MustProminentlyStatePP]                BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_MustProminentlyStatePP] DEFAULT ((0)) NOT NULL,
    [StateCurrencyAndWarning]               BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_StateCurrencyAndWarning] DEFAULT ((0)) NOT NULL,
    [StateEffectOfFees]                     BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_StateEffectOfFees] DEFAULT ((0)) NOT NULL,
    [MustIncludeStandardPerfTable]          BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_MustIncludeStandardPerfTable] DEFAULT ((0)) NOT NULL,
    [StandardPerfTableNoLessProminent]      BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_StandardPerfTableNoLessProminent] DEFAULT ((0)) NOT NULL,
    [CarveOutsForProspectusKID]             BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_CarveOutsForProspectusKID] DEFAULT ((0)) NOT NULL,
    [SimulatedPPAndFuturePerf]              BIT              CONSTRAINT [DF_FinPromsRegisterChecklist_SimulatedPPAndFuturePerf] DEFAULT ((0)) NOT NULL,
    [JoinGUID]                              UNIQUEIDENTIFIER NOT NULL,
    [FinPromsChecklistCreationDatetime]     DATETIME         CONSTRAINT [DF_FPRC_FPRCCDT] DEFAULT (getdate()) NOT NULL,
    [FinPromsChecklistLastModifiedDatetime] DATETIME         CONSTRAINT [DF_FPRC_FPRCLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                 DATETIME         CONSTRAINT [DF_FPRC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                  DATETIME         CONSTRAINT [DF_FPRC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                NVARCHAR (50)    CONSTRAINT [DF_FPRC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                 INT              CONSTRAINT [DF_FPRC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]             DATETIME         CONSTRAINT [DF_FPRC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_FinPromsRegisterChecklist] PRIMARY KEY CLUSTERED ([FinPromRegisterId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_FinPromsRegisterChecklist_FinPromsRegister] FOREIGN KEY ([FinPromRegisterId]) REFERENCES [Investment].[FinPromsRegister] ([FinPromRegisterId])
);
