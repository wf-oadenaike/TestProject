﻿CREATE TABLE [Compliance].[TrainingRegister] (
    [TrainingRegisterId]            INT              IDENTITY (1, 1) NOT NULL,
    [TraineePersonId]               SMALLINT         NOT NULL,
    [ProposedDate]                  DATE             NULL,
    [ExpiryDate]                    DATE             NULL,
    [TrainingCourseId]              INT              NOT NULL,
    [TrainingStatusId]              SMALLINT         NOT NULL,
    [ApprovalDate]                  DATE             NULL,
    [ManagerPersonId]               SMALLINT         NULL,
    [TrainerPersonId]               SMALLINT         NULL,
    [Notes]                         VARCHAR (MAX)    NULL,
    [ManagerComments]               VARCHAR (MAX)    NULL,
    [TrainerComments]               VARCHAR (MAX)    NULL,
    [EstimatedCost]                 DECIMAL (19, 2)  NULL,
    [TrainingProvider]              VARCHAR (128)    NULL,
    [OptAttendanceApproverPersonId] SMALLINT         NULL,
    [WorkFlowLink]                  VARCHAR (2000)   NULL,
    [DocumentationFolderLink]       VARCHAR (2000)   NULL,
    [JoinGUID]                      UNIQUEIDENTIFIER NOT NULL,
    [TrainingCreationDate]          DATETIME         CONSTRAINT [DF_TR_CDT] DEFAULT (getdate()) NOT NULL,
    [TrainingLastModifiedDate]      DATETIME         CONSTRAINT [DF_TR_LMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]         DATETIME         CONSTRAINT [DF_TR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]          DATETIME         CONSTRAINT [DF_TR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]        NVARCHAR (50)    CONSTRAINT [DF_TR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]         INT              CONSTRAINT [DF_TR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]        ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]     DATETIME         CONSTRAINT [DF_TR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKTrainingRegister] PRIMARY KEY CLUSTERED ([TrainingRegisterId] ASC),
    CONSTRAINT [TrainingRegisterManagerPersonId] FOREIGN KEY ([ManagerPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [TrainingRegisterOptAttendanceApproverPersonId] FOREIGN KEY ([OptAttendanceApproverPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [TrainingRegisterTraineePersonId] FOREIGN KEY ([TraineePersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [TrainingRegisterTrainerPersonId] FOREIGN KEY ([TrainerPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [TrainingRegisterTrainingCourseId] FOREIGN KEY ([TrainingCourseId]) REFERENCES [Compliance].[TrainingCourses] ([TrainingCourseId]),
    CONSTRAINT [TrainingRegisterTrainingStatusId] FOREIGN KEY ([TrainingStatusId]) REFERENCES [Compliance].[TrainingStatuses] ([TrainingStatusId])
);

