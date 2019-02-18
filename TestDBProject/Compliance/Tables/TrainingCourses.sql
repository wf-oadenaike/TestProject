CREATE TABLE [Compliance].[TrainingCourses] (
    [TrainingCourseId]               INT              IDENTITY (1, 1) NOT NULL,
    [TrainingTitle]                  VARCHAR (128)    NOT NULL,
    [TrainingTypeId]                 SMALLINT         NOT NULL,
    [AttestationRequiredYesNo]       BIT              CONSTRAINT [DF_TC_AR] DEFAULT ((0)) NOT NULL,
    [AnnualTrainingYesNo]            BIT              CONSTRAINT [DF_TC_AT] DEFAULT ((0)) NOT NULL,
    [AttendanceApproverPersonId]     SMALLINT         NULL,
    [AttestationText]                VARCHAR (MAX)    NULL,
    [IsActive]                       BIT              NULL,
    [JoinGUID]                       UNIQUEIDENTIFIER NULL,
    [TrainingCourseCreationDate]     DATETIME         CONSTRAINT [DF_TC_CDT] DEFAULT (getdate()) NOT NULL,
    [TrainingCourseLastModifiedDate] DATETIME         CONSTRAINT [DF_TC_LMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]          DATETIME         CONSTRAINT [DF_TC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]           DATETIME         CONSTRAINT [DF_TC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]         NVARCHAR (50)    CONSTRAINT [DF_TC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]          INT              CONSTRAINT [DF_TC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]         ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]      DATETIME         CONSTRAINT [DF_TC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKTrainingCourses] PRIMARY KEY CLUSTERED ([TrainingCourseId] ASC),
    CONSTRAINT [TrainingCoursesAttendanceApproverPersonId] FOREIGN KEY ([AttendanceApproverPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [TrainingCoursesTrainingTypeId] FOREIGN KEY ([TrainingTypeId]) REFERENCES [Compliance].[TrainingTypes] ([TrainingTypeId])
);

