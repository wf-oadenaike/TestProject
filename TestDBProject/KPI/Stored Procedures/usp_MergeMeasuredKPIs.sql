
CREATE PROCEDURE [KPI].[usp_MergeMeasuredKPIs]
AS
-------------------------------------------------------------------------------------- 
-- Name:			[KPI].[usp_MergeMeasuredKPIs]
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			27/08/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on;
	SET DATEFORMAT dmy;

	BEGIN TRANSACTION

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[KPI].[usp_MergeMeasuredKPIs]';

	SET DateFormat dmy;

	MERGE INTO [KPI].[MeasuredKPIs] mk
	USING (SELECT kmd.[KPIIDBK], ISNULL(kmd.[IsPercentage],0) as [IsPercentage], ISNULL( rf.RefreshFrequencyId, -1) as [RefreshFrequencyId]
		     , kmd.[KPIName], kmd.[KPIDescription], kmd.[TargetValue], kmd.[IsActive]
		     , CASE kmd.[ValueDirection] WHEN 'U' THEN '<' WHEN 'D' THEN '>' ELSE '<' END as [Operator], kmd.[AggrFunction]
		FROM [Staging.KPI].[KPIMetaData] kmd
		LEFT OUTER JOIN [KPI].[RefreshFrequency] rf
		ON kmd.[Frequency] = rf.[FrequencyName]
		) Src
	ON mk.KPIBK = Src.KPIIDBK
	WHEN NOT MATCHED
		THEN INSERT ([KPIName], [KPIDescription], [KPIBK], [TargetValue], [IsActive], [Operator], [IsPercentage], [RefreshFrequencyId], [AggrFunction])
		     VALUES (Src.[KPIName], Src.[KPIDescription], Src.[KPIIDBK], Src.[TargetValue], Src.[IsActive], Src.[Operator], Src.[IsPercentage], Src.[RefreshFrequencyId], Src.[AggrFunction])
	WHEN MATCHED AND (mk.KPIName <> Src.KPIName
			OR (mk.KPIDescription IS NULL AND Src.KPIDescription IS NOT NULL)
			OR (mk.KPIDescription IS NOT NULL AND Src.KPIDescription IS NULL)
			OR mk.KPIDescription <> Src.KPIDescription
			OR (mk.TargetValue IS NULL AND Src.TargetValue IS NOT NULL)
			OR (mk.TargetValue IS NOT NULL AND Src.TargetValue IS NULL)
			OR mk.TargetValue <> Src.TargetValue
			OR mk.IsActive <> Src.IsActive
			OR mk.Operator <> Src.Operator
			OR mk.IsPercentage <> Src.IsPercentage
			OR mk.RefreshFrequencyId <> Src.RefreshFrequencyId
			OR mk.AggrFunction <> Src.AggrFunction)
			THEN UPDATE SET mk.KPIName = Src.KPIName
					, mk.KPIDescription = Src.KPIDescription
					, mk.TargetValue = Src.TargetValue
					, mk.IsActive = Src.IsActive
					, mk.Operator = Src.Operator
					, mk.IsPercentage = Src.IsPercentage
					, mk.RefreshFrequencyId = Src.RefreshFrequencyId
					, mk.AggrFunction = Src.AggrFunction
	;

	SET @InsertRowCount = @@ROWCOUNT;

	SELECT @ProcessRowCount AS ProcessRowCount
		, @InsertRowCount AS InsertRowCount
		, @UpdateRowCount AS UpdateRowCount
		, @DeleteRowCount AS DeleteRowCount
		;

	COMMIT;

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
		ROLLBACK;
		 
		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		Return @ErrorNumber;
END CATCH
