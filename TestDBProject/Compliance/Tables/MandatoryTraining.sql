CREATE TABLE [Compliance].[MandatoryTraining] (
    [MandatoryTrainingId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [LearningId]          VARCHAR (25)  NULL,
    [EmployeeName]        VARCHAR (255) NULL,
    [StartDate]           DATE          NULL,
    [TrainingName]        VARCHAR (MAX) NULL,
    [ProposedDate]        DATE          NULL,
    [AttestationDate]     DATE          NULL,
    [AttestationRequired] VARCHAR (5)   NULL,
    [AttestationComplete] VARCHAR (5)   NULL,
    [EmploymentStatus]    VARCHAR (25)  NULL,
    [EmploymentType]      VARCHAR (25)  NULL,
    [ExpiryDate]          DATE          NULL,
    [HRUserStatus]        VARCHAR (25)  NULL,
    [TrainingStatus]      VARCHAR (55)  NULL,
    [DateApproved]        DATE          NULL,
    [ManagerName]         VARCHAR (50)  NULL,
    [AttendanceApprover]  VARCHAR (50)  NULL,
    [Required]            VARCHAR (3)   NOT NULL,
    CONSTRAINT [PKMandatoryTraining] PRIMARY KEY CLUSTERED ([MandatoryTrainingId] ASC)
);

