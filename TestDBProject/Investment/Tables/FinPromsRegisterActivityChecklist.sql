﻿CREATE TABLE [Investment].[FinPromsRegisterActivityChecklist] (
    [FinPromRegisterId]                                     INT              NOT NULL,
    [ResultofLegalOrCompliance]                             VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_ResultofLegalOrCompliance] DEFAULT ('UNKNOWN') NOT NULL,
    [AllChannelsExamined]                                   VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_AllChannelsExamined] DEFAULT ('UNKNOWN') NOT NULL,
    [ResultOfSpecificClient]                                VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_ResultOfSpecificClient] DEFAULT ('UNKNOWN') NOT NULL,
    [ExpectCompetitorsToDo]                                 VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_ExpectCompetitorsToDo] DEFAULT ('UNKNOWN') NOT NULL,
    [StoryboardCompletedApproved]                           VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_StoryboardCompletedApproved] DEFAULT ('UNKNOWN') NOT NULL,
    [ExecuteDifferently]                                    VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_ExecuteDifferently] DEFAULT ('UNKNOWN') NOT NULL,
    [ActivityTransformational]                              VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_ActivityTransformational] DEFAULT ('UNKNOWN') NOT NULL,
    [ActivityConsistent]                                    VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_ActivityConsistent] DEFAULT ('UNKNOWN') NOT NULL,
    [ValueOutweighsCost]                                    VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_ValueOutweighsCost] DEFAULT ('UNKNOWN') NOT NULL,
    [DoOneOrMoreOfThree]                                    VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_DoOneOrMoreOfThree] DEFAULT ('UNKNOWN') NOT NULL,
    [ActivityFurthersConversation]                          VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_ActivityFurthersConversation] DEFAULT ('UNKNOWN') NOT NULL,
    [TailoredLanguagePatterns]                              VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_TailoredLanguagePatterns] DEFAULT ('UNKNOWN') NOT NULL,
    [TailoredRespondingSentiment]                           VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_TailoredRespondingSentiment] DEFAULT ('UNKNOWN') NOT NULL,
    [AllCommMethodsEvaluated]                               VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_AllCommMethodsEvaluated] DEFAULT ('UNKNOWN') NOT NULL,
    [StoryboardCompletedApproved2]                          VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_StoryboardCompletedApproved2] DEFAULT ('UNKNOWN') NOT NULL,
    [OptimalTimeToExecute]                                  VARCHAR (10)     CONSTRAINT [DF_FinPromsRegisterActivityChecklist_OptimalTimeToExecute] DEFAULT ('UNKNOWN') NOT NULL,
    [JoinGUID]                                              UNIQUEIDENTIFIER NOT NULL,
    [FinPromsRegisterActivityChecklistCreationDatetime]     DATETIME         CONSTRAINT [DF_FPRAC_FPRACCDT] DEFAULT (getdate()) NOT NULL,
    [FinPromsRegisterActivityChecklistLastModifiedDatetime] DATETIME         CONSTRAINT [DF_FPRAC_FPRACLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                                 DATETIME         CONSTRAINT [DF_FPRAC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                                  DATETIME         CONSTRAINT [DF_FPRAC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                                NVARCHAR (50)    CONSTRAINT [DF_FPRAC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                                 INT              CONSTRAINT [DF_FPRAC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                                ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                             DATETIME         CONSTRAINT [DF_FPRAC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_FinPromsRegisterActivityChecklist] PRIMARY KEY CLUSTERED ([FinPromRegisterId] ASC),
    CONSTRAINT [FK_FinPromsRegisterActivityChecklist_FinPromsRegister] FOREIGN KEY ([FinPromRegisterId]) REFERENCES [Investment].[FinPromsRegister] ([FinPromRegisterId])
);

