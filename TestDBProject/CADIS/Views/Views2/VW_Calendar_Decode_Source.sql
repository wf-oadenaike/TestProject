CREATE VIEW "CADIS"."VW_Calendar_Decode_Source"
AS
select * from "Core"."Calendar" T1 where calendardate>getdate()-100 and calendardate<getdate()+100
