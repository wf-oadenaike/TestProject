CREATE PROCEDURE [KPI].[usp_UpdateManualMaturity]
AS
-------------------------------------------------------------------------------------- 
-- Name:			[KPI].[usp_UpdateManualMaturity]
-- 
-- Note:			
-- 
-- Author:			L Maher
-- Date:			13/10/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on;

	BEGIN TRANSACTION

	Declare	@strProcedureName		VARCHAR(100)	= '[KPI].[usp_UpdateManualMaturity]';

-- Unquoted Companies --
;WITH CTE_Source AS
(
	SELECT CASE WHEN sm.[Maturity stage] = 'Early Growth' THEN 1 
				WHEN sm.[Maturity stage] = 'Early Stage' THEN 2
				WHEN sm.[Maturity stage] = 'Mid\Large' THEN 3 
				ELSE -1 END AS CompanyMaturityId
			,COALESCE(lc.ListedCompanyId,ls1.ListedCompanyId,ls2.ListedCompanyId) AS ListedCompanyId
FROM Staging.STG_Maturity sm 
LEFT JOIN Unquoted.ListedCompanies lc ON LTRIM(RTRIM(sm.[Preferred Name])) = lc.ListedCompanyName
LEFT JOIN [dbo].[T_MASTER_SEC] tms ON LTRIM(RTRIM(sm.[Preferred Name])) = tms.[SECURITY_NAME]
LEFT JOIN [unquoted].[ListedSecurities] ls1 ON tms.[UNIQUE_BLOOMBERG_ID] = ls1.UniqueBloombergId
LEFT JOIN 
(SELECT DISTINCT
BloombergGlobalExchangeID
,SEDOL
FROM
[Unquoted].[ConfirmedTrades]
) sd ON sm.[Security Sedol] = sd.SEDOL
LEFT JOIN [unquoted].[ListedSecurities] ls2 ON sd.BloombergGlobalExchangeID = ls2.UniqueBloombergId
)
--SELECT * FROM CTE_Source
--ORDER BY ListedCompanyId
UPDATE Unquoted.ListedCompanies
SET WIMPCTCompanyMaturityId = S.CompanyMaturityId
FROM CTE_Source AS S INNER JOIN
Unquoted.ListedCompanies T 
ON (T.[ListedCompanyId] = S.[ListedCompanyId]) 
WHERE (S.[ListedCompanyId] IS NOT NULL); 

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Listed Companies -- 
;WITH CTE_Source AS
(
	SELECT CASE WHEN sm.[Maturity stage] = 'Early Growth' THEN 1 
				WHEN sm.[Maturity stage] = 'Early Stage' THEN 2
				WHEN sm.[Maturity stage] = 'Mid\Large' THEN 3 
				ELSE -1 END AS CompanyMaturityId
			,COALESCE(uc.UnquotedCompanyId,us1.UnquotedCompanyId,us2.UnquotedCompanyId) AS UnquotedCompanyId
FROM Staging.STG_Maturity sm 
LEFT JOIN Organisation.UnquotedCompanies uc ON LTRIM(RTRIM(sm.[Preferred Name])) = uc.UnquotedCompanyName
LEFT JOIN [dbo].[T_MASTER_SEC] tms ON LTRIM(RTRIM(sm.[Preferred Name])) = tms.[SECURITY_NAME]
LEFT JOIN [Organisation].[UnquotedSecurities] us1 ON tms.[UNIQUE_BLOOMBERG_ID] = us1.[BBGUniqueId/FOID]
LEFT JOIN 
(SELECT DISTINCT
BloombergGlobalExchangeID
,SEDOL
FROM
[Unquoted].[ConfirmedTrades]
) sd ON sm.[Security Sedol] = sd.SEDOL
LEFT JOIN [Organisation].[UnquotedSecurities] us2 ON sd.BloombergGlobalExchangeID = us2.[BBGUniqueId/FOID]
)
UPDATE Organisation.UnquotedCompanyAdditionalInfo
SET WIMPCTCompanyMaturityId = S.CompanyMaturityId
FROM CTE_Source S INNER JOIN
Organisation.UnquotedCompanyAdditionalInfo T
ON (T.UnquotedCompanyId = S.UnquotedCompanyId) 
WHERE (S.UnquotedCompanyId IS NOT NULL); 

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
