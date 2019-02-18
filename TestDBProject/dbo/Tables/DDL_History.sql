CREATE TABLE [dbo].[DDL_History] (
    [obj_name]         NVARCHAR (256) NULL,
    [obj_id]           INT            NULL,
    [database_name]    NVARCHAR (256) NULL,
    [start_time]       DATETIME       NULL,
    [event_class]      INT            NULL,
    [event_subclass]   INT            NULL,
    [object_type]      INT            NULL,
    [server_name]      NVARCHAR (256) NULL,
    [login_name]       NVARCHAR (256) NULL,
    [user_name]        NVARCHAR (256) NULL,
    [application_name] NVARCHAR (256) NULL,
    [ddl_operation]    NVARCHAR (40)  NULL
);

