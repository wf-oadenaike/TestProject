﻿CREATE TABLE [dbo].[okta_syslog] (
    [CreatedDate]                                     DATETIME      DEFAULT (getdate()) NULL,
    [EventDate]                                       DATETIME      NULL,
    [Notified]                                        INT           DEFAULT ((0)) NULL,
    [severity]                                        VARCHAR (MAX) NULL,
    [event_type]                                      VARCHAR (MAX) NULL,
    [display_message]                                 VARCHAR (MAX) NULL,
    [uuid]                                            VARCHAR (500) NOT NULL,
    [version]                                         BIGINT        DEFAULT (NULL) NULL,
    [timestamp]                                       VARCHAR (50)  NULL,
    [outcome__result]                                 VARCHAR (MAX) NULL,
    [outcome__reason]                                 VARCHAR (MAX) NULL,
    [actor__id]                                       VARCHAR (MAX) NULL,
    [actor__type]                                     VARCHAR (MAX) NULL,
    [actor__display_name]                             VARCHAR (MAX) NULL,
    [actor__detailEntry]                              VARCHAR (MAX) NULL,
    [actor__alternate_id]                             VARCHAR (MAX) NULL,
    [authentication_context__authentication_step]     BIGINT        DEFAULT (NULL) NULL,
    [authentication_context__authentication_provider] VARCHAR (MAX) NULL,
    [authentication_context__credential_provider]     VARCHAR (MAX) NULL,
    [authentication_context__credential_type]         VARCHAR (MAX) NULL,
    [authentication_context__interface]               VARCHAR (MAX) NULL,
    [authentication_context__issuer]                  VARCHAR (MAX) NULL,
    [authentication_context__external_session_id]     VARCHAR (MAX) NULL,
    [client__zone]                                    VARCHAR (MAX) NULL,
    [client__id]                                      VARCHAR (MAX) NULL,
    [client__ip_address]                              VARCHAR (MAX) NULL,
    [client__device]                                  VARCHAR (MAX) NULL,
    [client__user_agent__raw_user_agent]              VARCHAR (MAX) NULL,
    [client__user_agent__os]                          VARCHAR (MAX) NULL,
    [client__user_agent__browser]                     VARCHAR (MAX) NULL,
    [client__geographical_context__country]           VARCHAR (MAX) NULL,
    [client__geographical_context__city]              VARCHAR (MAX) NULL,
    [client__geographical_context__postal_code]       VARCHAR (MAX) NULL,
    [client__geographical_context__geolocation__lon]  FLOAT (53)    NULL,
    [client__geographical_context__geolocation__lat]  FLOAT (53)    NULL,
    [securityContext__asNumber]                       VARCHAR (MAX) NULL,
    [securityContext__asOrg]                          VARCHAR (MAX) NULL,
    [securityContext__isp]                            VARCHAR (MAX) NULL,
    [securityContext__domain]                         VARCHAR (MAX) NULL,
    [securityContext__isProxy]                        VARCHAR (MAX) NULL,
    [transaction__id]                                 VARCHAR (MAX) NULL,
    [transaction__type]                               VARCHAR (MAX) NULL,
    [transaction__detail]                             VARCHAR (MAX) NULL,
    [debug_context__debug_data__request_uri]          VARCHAR (MAX) NULL,
    [debug_context__debug_data__loginResult]          VARCHAR (MAX) NULL,
    [request__ipChain]                                VARCHAR (MAX) NULL,
    [legacy_event_type]                               VARCHAR (MAX) NULL,
    [target0__id]                                     VARCHAR (MAX) NULL,
    [target0__detailEntry]                            VARCHAR (MAX) NULL,
    [target0__type]                                   VARCHAR (MAX) NULL,
    [target0__alternate_id]                           VARCHAR (MAX) NULL,
    [target0__display_name]                           VARCHAR (MAX) NULL,
    [target1__id]                                     VARCHAR (MAX) NULL,
    [target1__detailEntry]                            VARCHAR (MAX) NULL,
    [target1__type]                                   VARCHAR (MAX) NULL,
    [target1__alternate_id]                           VARCHAR (MAX) NULL,
    [target1__display_name]                           VARCHAR (MAX) NULL,
    [target2__id]                                     VARCHAR (MAX) NULL,
    [target2__detailEntry]                            VARCHAR (MAX) NULL,
    [target2__type]                                   VARCHAR (MAX) NULL,
    [target2__alternate_id]                           VARCHAR (MAX) NULL,
    [target2__display_name]                           VARCHAR (MAX) NULL,
    [target3__id]                                     VARCHAR (MAX) NULL,
    [target3__detailEntry]                            VARCHAR (MAX) NULL,
    [target3__type]                                   VARCHAR (MAX) NULL,
    [target3__alternate_id]                           VARCHAR (MAX) NULL,
    [target3__display_name]                           VARCHAR (MAX) NULL
);

