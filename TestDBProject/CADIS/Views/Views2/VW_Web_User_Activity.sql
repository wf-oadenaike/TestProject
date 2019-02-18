CREATE VIEW "CADIS"."VW_Web_User_Activity"
AS
Select username,max(inserteddate) LastLogin from cadis_SYS.CO_WEBUSERACTIVITY
where activity = 'User logged in'
group by username
