CREATE PROCEDURE [Reporting].[usp_ComplianceMonitoringGetCalendarView]
	@MonitoringDate DATE = NULL
AS
	SET NOCOUNT ON
	IF @MonitoringDate IS NULL
	SET @MonitoringDate = CONVERT(DATE, GETDATE())

	DECLARE @Months TABLE ([Month] VARCHAR(31) NOT NULL)
	INSERT INTO @Months ([Month])
	SELECT 'January'  UNION ALL
	SELECT 'February'  UNION ALL
	SELECT 'March'  UNION ALL
	SELECT 'April'  UNION ALL
	SELECT 'May'  UNION ALL
	SELECT 'June'  UNION ALL
	SELECT 'July'  UNION ALL
	SELECT 'August'  UNION ALL
	SELECT 'September'  UNION ALL
	SELECT 'October'  UNION ALL
	SELECT 'November'  UNION ALL
	SELECT 'December'

	DECLARE @data TABLE ( [Month] VARCHAR(31) NOT NULL, [MonitoringCategoryId] INT NOT NULL,  [MonitoringType] VARCHAR(128) NOT NULL, [CategoryName] VARCHAR(255) NOT NULL, [IsMonitored] BIT NOT NULL DEFAULT 0, Frequency VARCHAR(31), StartDate DATE NULL, EndDate DATE NULL)

 
	--Annual first as the easiest
	INSERT INTO @Data ([Month],[MonitoringCategoryId], [MonitoringType], [CategoryName], Frequency)
	SELECT FrequencyStartMonth, [MonitoringCategoryId], [MonitoringType], [CategoryName], MonitoringFrequency
	FROM [Compliance].[MonitoringCategories]
	WHERE MonitoringFrequency = 'Annually'
  
	--Next easiest
	INSERT INTO @Data ([Month],[MonitoringCategoryId], [MonitoringType], [CategoryName], Frequency)
	SELECT [Month], [MonitoringCategoryId], [MonitoringType], [CategoryName], MonitoringFrequency
	FROM [Compliance].[MonitoringCategories] c 
	CROSS APPLY @Months
	WHERE MonitoringFrequency = 'Monthly'

	--The rest
	INSERT INTO @Data ([Month],[MonitoringCategoryId], [MonitoringType], [CategoryName], Frequency)
	SELECT 
		[Month], [MonitoringCategoryId], [MonitoringType], [CategoryName], MonitoringFrequency
	FROM 
		[Compliance].[MonitoringCategories] c 
	CROSS APPLY 
		@Months
	WHERE 
		MonitoringFrequency IN ('Semi-Annually', 'Quarterly', 'Tri-Annually')
		AND FrequencyMonths LIKE '%'+ [Month] + '%'
  
	UPDATE 
		data
	SET 
		StartDate = PeriodStartDate,
		EndDate = PeriodEndDate
	FROM 
		@Data data
	-- Use the last day available for every month to ensure we have the correct period
	CROSS APPLY

		[Compliance].[GetMonitoringReportingPeriodDates_uf] (MonitoringCategoryId, CONVERT(DATE, convert(varchar(2),(datediff(d, convert(date,'1-' + [Month] + '-' + convert(varchar(4),year(@MonitoringDate))), dateadd(m, 1, convert(date,'1-' + [Month] + '-' + convert(varchar(4),year(@MonitoringDate))))))) + ' ' + [Month] + ' ' + CONVERT(VARCHAR(4), YEAR(@MonitoringDate)))) AS rpd_uf

	UPDATE 
		data
		SET 
		IsMonitored = 1
		FROM 
		@Data data
	WHERE

		EXISTS (SELECT TOP 1 1 FROM [Compliance].[MonitoringCategoryNotes] c
		WHERE (not c.OccurrenceDate is null)
		AND (CONVERT(DATE,c.OccurrenceDate) <= @MonitoringDate
		AND c.MonitoringCategoryId = data.MonitoringCategoryId
		AND c.OccurrenceDate > data.StartDate 
		AND c.OccurrenceDate < data.EndDate))

or

		EXISTS (SELECT TOP 1 1 FROM [Compliance].[MonitoringCategoryNotes] c
		WHERE (c.OccurrenceDate is null)
		AND (CONVERT(DATE,[CategoryNoteCreationDate]) <= @MonitoringDate
		AND c.MonitoringCategoryId = data.MonitoringCategoryId
		AND c.CategoryNoteCreationDate > data.StartDate 
		AND c.CategoryNoteCreationDate < data.EndDate))

	SELECT * FROM @Data
