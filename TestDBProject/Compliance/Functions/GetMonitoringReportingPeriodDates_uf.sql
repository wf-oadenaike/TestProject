CREATE FUNCTION [Compliance].[GetMonitoringReportingPeriodDates_uf](
    @MonitoringCategoryId INT,
	@RunDate DATE
)
RETURNS @MonitoringReportingPeriodDates TABLE 
(
    PeriodStartDate DATETIME NOT NULL,
    PeriodEndDate DATETIME NOT NULL
)
as     
begin

	Declare @MonitoringFrequency VARCHAR(128),
			@FrequencyStartMonth VARCHAR(128),
			@NextDate DATE,
			@PeriodStartDate DATETIME,
			@PeriodEndDate DATETIME;			

    IF @RunDate IS NULL
		SET @RunDate = GetDate();

	SELECT @MonitoringFrequency = MonitoringFrequency
		 , @FrequencyStartMonth = FrequencyStartMonth
	FROM [Compliance].[MonitoringCategories]
	WHERE MonitoringCategoryId = @MonitoringCategoryId;	
	
	IF @MonitoringFrequency = 'Monthly'
	    BEGIN
			SET @NextDate = DATEADD(Month,1,@RunDate)
			SET @PeriodStartDate = DATEADD(WEEK, DATEDIFF(WEEK, 0,DATEADD(DAY, 6 - DATEPART(DAY, @RunDate), @RunDate)), 0)
			SET @PeriodEndDate = DATEADD(s,-1,DATEADD(WEEK, DATEDIFF(WEEK, 0,DATEADD(DAY, 6 - DATEPART(DAY, @NextDate), @NextDate)), 0))
		END
	ELSE IF @MonitoringFrequency = 'Quarterly'
		BEGIN
			-- start month
			SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
			WHILE @NextDate < @RunDate
				SET @NextDate = DATEADD(Month,3,@NextDate)		
				
			SET @PeriodEndDate = DATEADD(s,-1,DATEADD(WEEK, DATEDIFF(WEEK, 0,DATEADD(DAY, 6 - DATEPART(DAY, @NextDate), @NextDate)), 0))
			SET @PeriodStartDate = DATEADD(Month,-3,@NextDate)
			SET @PeriodStartDate = DATEADD(WEEK, DATEDIFF(WEEK, 0,DATEADD(DAY, 6 - DATEPART(DAY, @PeriodStartDate), @PeriodStartDate)), 0)		
		END
	ELSE IF @MonitoringFrequency = 'Tri-Annually'
		BEGIN
			-- start month
			SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
			WHILE @NextDate < @RunDate
				SET @NextDate = DATEADD(Month,4,@NextDate)
			
			SET @PeriodEndDate = DATEADD(s,-1,DATEADD(WEEK, DATEDIFF(WEEK, 0,DATEADD(DAY, 6 - DATEPART(DAY, @NextDate), @NextDate)), 0))
			SET @PeriodStartDate = DATEADD(Month,-4,@NextDate)
			SET @PeriodStartDate = DATEADD(WEEK, DATEDIFF(WEEK, 0,DATEADD(DAY, 6 - DATEPART(DAY, @PeriodStartDate), @PeriodStartDate)), 0)			
			
		END
	ELSE IF @MonitoringFrequency = 'Semi-Annually'
		BEGIN
			-- start month
			SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
			WHILE @NextDate < @RunDate
				SET @NextDate = DATEADD(Month,6,@NextDate)
				
			SET @PeriodEndDate = DATEADD(s,-1,DATEADD(WEEK, DATEDIFF(WEEK, 0,DATEADD(DAY, 6 - DATEPART(DAY, @NextDate), @NextDate)), 0))
			SET @PeriodStartDate = DATEADD(Month,-6,@NextDate)
			SET @PeriodStartDate = DATEADD(WEEK, DATEDIFF(WEEK, 0,DATEADD(DAY, 6 - DATEPART(DAY, @PeriodStartDate), @PeriodStartDate)), 0)
			
		END
	ELSE IF @MonitoringFrequency = 'Annually'
		BEGIN
			-- start month
			SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
			IF @NextDate < @RunDate
				SET @NextDate = DATEADD(Year,1,@NextDate)
				
			SET @PeriodEndDate = DATEADD(s,-1,DATEADD(WEEK, DATEDIFF(WEEK, 0,DATEADD(DAY, 6 - DATEPART(DAY, @NextDate), @NextDate)), 0))
			SET @PeriodStartDate = DATEADD(Year,-1,@NextDate)
			SET @PeriodStartDate = DATEADD(WEEK, DATEDIFF(WEEK, 0,DATEADD(DAY, 6 - DATEPART(DAY, @PeriodStartDate), @PeriodStartDate)), 0)						
		END
    
	INSERT @MonitoringReportingPeriodDates
        SELECT @PeriodStartDate, @PeriodEndDate;
		
	RETURN
end
;
