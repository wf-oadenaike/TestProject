CREATE ROLE [API_WebSite_Role]
    AUTHORIZATION [rdsadmin];


GO
ALTER ROLE [API_WebSite_Role] ADD MEMBER [API_WebSite_User];

