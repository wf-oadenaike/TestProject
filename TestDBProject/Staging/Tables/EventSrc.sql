﻿CREATE TABLE [Staging].[EventSrc] (
    [Id]                        VARCHAR (50)    NULL,
    [WhoId]                     VARCHAR (50)    NULL,
    [WhatId]                    VARCHAR (50)    NULL,
    [Subject]                   NVARCHAR (1000) NULL,
    [Location]                  NVARCHAR (1000) NULL,
    [IsAllDayEvent]             NVARCHAR (1000) NULL,
    [ActivityDateTime]          VARCHAR (50)    NULL,
    [ActivityDate]              VARCHAR (50)    NULL,
    [DurationInMinutes]         VARCHAR (50)    NULL,
    [StartDateTime]             VARCHAR (50)    NULL,
    [EndDateTime]               VARCHAR (50)    NULL,
    [Description]               NVARCHAR (MAX)  NULL,
    [AccountId]                 VARCHAR (50)    NULL,
    [OwnerId]                   VARCHAR (50)    NULL,
    [CurrencyIsoCode]           VARCHAR (50)    NULL,
    [Type]                      NVARCHAR (1000) NULL,
    [IsPrivate]                 NVARCHAR (1000) NULL,
    [ShowAs]                    NVARCHAR (1000) NULL,
    [IsDeleted]                 VARCHAR (50)    NULL,
    [IsChild]                   VARCHAR (50)    NULL,
    [IsGroupEvent]              NVARCHAR (1000) NULL,
    [GroupEventType]            NVARCHAR (1000) NULL,
    [CreatedDate]               VARCHAR (50)    NULL,
    [CreatedById]               VARCHAR (50)    NULL,
    [LastModifiedDate]          VARCHAR (50)    NULL,
    [LastModifiedById]          VARCHAR (50)    NULL,
    [SystemModstamp]            VARCHAR (50)    NULL,
    [IsArchived]                VARCHAR (50)    NULL,
    [RecurrenceActivityId]      VARCHAR (50)    NULL,
    [IsRecurrence]              VARCHAR (50)    NULL,
    [RecurrenceStartDateTime]   VARCHAR (50)    NULL,
    [RecurrenceEndDateOnly]     VARCHAR (50)    NULL,
    [RecurrenceTimeZoneSidKey]  NVARCHAR (1000) NULL,
    [RecurrenceType]            NVARCHAR (1000) NULL,
    [RecurrenceInterval]        NVARCHAR (1000) NULL,
    [RecurrenceDayOfWeekMask]   VARCHAR (50)    NULL,
    [RecurrenceDayOfMonth]      VARCHAR (50)    NULL,
    [RecurrenceInstance]        NVARCHAR (1000) NULL,
    [RecurrenceMonthOfYear]     VARCHAR (50)    NULL,
    [ReminderDateTime]          VARCHAR (50)    NULL,
    [IsReminderSet]             NVARCHAR (1000) NULL,
    [Activity_Plan__c]          NVARCHAR (1000) NULL,
    [GLEQ__c]                   NVARCHAR (1000) NULL,
    [Plan_Activity_Type__c]     NVARCHAR (1000) NULL,
    [Plan_Name__c]              NVARCHAR (1000) NULL,
    [UKAC__c]                   NVARCHAR (1000) NULL,
    [UKEB__c]                   NVARCHAR (1000) NULL,
    [UKEI__c]                   NVARCHAR (1000) NULL,
    [Type_Reporting__c]         NVARCHAR (1000) NULL,
    [Has_Notes__c]              NVARCHAR (1000) NULL,
    [hasSendMessage__c]         NVARCHAR (1000) NULL,
    [REST__c]                   NVARCHAR (1000) NULL,
    [TSAL__c]                   NVARCHAR (1000) NULL,
    [Event_Record_Count__c]     NVARCHAR (1000) NULL,
    [Call_Summary__c]           NVARCHAR (1000) NULL,
    [Is_current_month__c]       NVARCHAR (1000) NULL,
    [Is_next_month__c]          NVARCHAR (1000) NULL,
    [Link_to_previous_event__c] NVARCHAR (1000) NULL,
    [Woodford_Attendees__c]     NVARCHAR (1000) NULL,
    [Is_before_next_month__c]   NVARCHAR (1000) NULL,
    [Requires_action__c]        NVARCHAR (1000) NULL
);

