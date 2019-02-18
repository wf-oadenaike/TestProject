


-------------------------------------------------------------------------------------- 

-- Oluwaseun Adenaike:  JIRA: DAP-1981 DATA -  Update Mappings Table

-------------------------------------------------------------------------------------- 


CREATE VIEW [Access.ManyWho].[CalendarVw]
as
SELECT [CalendarId]
      ,[CalendarDate]
	  ,[FullDateUK]
      ,[CalDayOfMonth]
      ,[CalDaySuffix]
      ,[CalDayName]
      ,[DayOfWeekInMonth]
      ,[DayOfWeekInYear]
      ,[DayOfQuarter]
      ,[CalDayOfYear]
      ,[CalWeekOfMonth]
      ,[CalWeekOfQuarter]
      ,[CalWeekOfYear]
      ,[CalMonth]
      ,[CalMonthName]
      ,[CalMonthOfQuarter]
      ,[CalQuarter]
      ,[CalQuarterName]
      , CAST([CalYear] as varchar) as [CalYear]
      ,[CalYearName]
      ,[CalMonthYear]
      ,[CalMMYYYY]
      ,[FirstDayOfMonth]
      ,[LastDayOfMonth]
      ,[FirstDayOfQuarter]
      ,[LastDayOfQuarter]
      ,[FirstDayOfYear]
      ,[LastDayOfYear]
      ,[IsWeekday]
      ,[FiscalDayOfYear]
      ,[FiscalWeekOfYear]
      ,[FiscalMonth]
      ,[FiscalQuarter]
      ,[FiscalQuarterName]
      ,[FiscalYear]
      ,[FiscalYearName]
      ,[FiscalMonthYear]
      ,[FiscalMMYYYY]
      ,[FiscalFirstDayOfMonth]
      ,[FiscalLastDayOfMonth]
      ,[FiscalFirstDayOfQuarter]
      ,[FiscalLastDayOfQuarter]
      ,[FiscalFirstDayOfYear]
      ,[FiscalLastDayOfYear]
      ,[FiscalYYYYMM]
      ,[CalYYYYMM]
	  , CONVERT(VARCHAR(10),CalendarDate,5) as FormattedDate
	  , CASE WHEN CAST([CalendarDate] as Date) = CAST(GetDate() as Date) THEN 'yes' ELSE 'no' END as [CurrentDay]
  FROM [Core].[Calendar]
  ;




