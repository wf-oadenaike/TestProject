-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Staging].[uspUpdateSentiment]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update [Staging.Brandwatch].Sentiment set KPIIDBK = case when sentimentname='Positive' then (select 
	KPIBK from [KPI].[MeasuredKPIs] where [KPIDBBK]='BW_Pos_Sent_Count')
	when sentimentname='Negative' then (select 
	KPIBK from [KPI].[MeasuredKPIs] where [KPIDBBK]='BW_Neg_Sent_Count')
	when sentimentname='Neutral' then (select 
	KPIBK from [KPI].[MeasuredKPIs] where [KPIDBBK]='BW_Neu_Sent_Count')
	end 
	where KPIIDBK is null

	
	UPDATE Staging   
	Set UpdatedAt=FORMAT(Fact.LastUpdatedDateTime, 'yyyy-MM-ddTHH:mm:ss'),
	CreatedAt=FORMAT(Fact.LastUpdatedDateTime, 'yyyy-MM-ddTHH:mm:ss')
	from [Staging.Brandwatch].Sentiment Staging
	join [KPI].[MeasuredKPIs] k on k.kpibk=Staging.kpiidbk
	join [Fact].[KPIFact] Fact on Fact.KPIID=k.KPIID
	where Staging.UpdatedAt is null
	and MEasureValue=SentimentCount
	and MeasureDateID=KPIDAte


	UPDATE [Staging.Brandwatch].Sentiment set CreatedAt=FORMAT(GetDate(), 'yyyy-MM-ddTHH:mm:ss'),
	UpdatedAt=FORMAT(GetDate(), 'yyyy-MM-ddTHH:mm:ss')
	where UpdatedAt is null

	

END
