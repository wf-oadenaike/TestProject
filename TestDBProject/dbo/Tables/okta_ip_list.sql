CREATE TABLE [dbo].[okta_ip_list] (
    [ipaddress]       VARCHAR (50)  NULL,
    [w_or_b]          CHAR (1)      NULL,
    [lastupdateddate] DATETIME      DEFAULT (getdate()) NULL,
    [email]           VARCHAR (50)  NULL,
    [country]         VARCHAR (50)  NULL,
    [city]            VARCHAR (50)  NULL,
    [device]          VARCHAR (50)  NULL,
    [notes]           VARCHAR (500) NULL
);

