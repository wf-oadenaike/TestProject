
CREATE Proc [dbo].[USP_Matrix_ContactException](@AccountOwnerId varchar(18))
-------------------------------------------------------------------------------------- 
-- NAME:			[dbo].[USP_Matrix_ContactException]
-- 
-- NOTE:			Update contact exception data for Boomi to update into salesforce
-- 
-- AUTHOR:			VIPUL KHATRI
-- DATE:			03/07/2018
-------------------------------------------------------------------------------------- 
-- HISTORY:			
-- 03/07/2018	V. KHATRI	DAP-2124 - Update contact exception data for Boomi to update into salesforce
-- 24/08/2018	R. DIXON	DAP-1753 - Include ContactAccountId in Datafields to be exported.
-- 23/10/2018	R. WALKER	DAP-2386 - Investigate why some Exception Overrides aren't persisting

AS

BEGIN TRY

	BEGIN TRAN

	INSERT INTO [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT_EXCEPTION] (CntSalesforceId,
	CntAccountSalesforceId,
	CntAccountSivId,
	Old_CntAccountSivId,
	CntSalutation,
	Old_CntSalutation,
	CntOwnerId,
	Old_CntOwnerId,
	CntFirstName,
	Old_CntFirstName,
	CntLastName,
	Old_CntLastName,
	CntLandline,
	Old_CntLandline,
	CntMobile,
	Old_CntMobile,
	CntEmail,
	Old_CntEmail,
	ActiveStatus,
	Old_ActiveStatus
	)


     -- SF
     SELECT MX.sf_SfContactId   AS CntSalesforceId,
            MX.sf_sfaccountid   AS CntAccountSalesforceId,
			MX.[ContactAccountId] AS CntAccountSivId,
			SF.[ContactAccountId] AS Old_CntAccountSivId,
            MX.[Salutation]     AS CntSalutation,
            SF.[Salutation]     AS Old_CntSalutation,
            MX.[ContactOwnerId] AS CntOwnerId,
            SF.[ContactOwnerId] AS Old_CntOwnerId,
            MX.[FirstName]      AS CntFirstName,
            SF.[FirstName]      AS Old_CntFirstName,
            MX.[LastName]       AS CntLastName,
            SF.[LastName]       AS Old_CntLastName,
            MX.[Phone]          AS CntLandline,
            SF.[Phone]          AS Old_CntLandline,
            MX.[Mobile]         AS CntMobile,
            SF.[Mobile]         AS Old_CntMobile,
            MX.[EmailAddress]   AS CntEmail,
            SF.[EmailAddress]   AS Old_CntEmail,
            MX.[ActiveStatus]   AS ActiveStatus,
            SF.[ActiveStatus]   AS Old_ActiveStatus
     FROM (
          SELECT sf_SfContactId,
                 sf_sfaccountid,
                 [Salutation],
                 [ContactOwnerId],
                 [FirstName],
                 [LastName],
                 [Phone],
                 [Mobile],
                 [EmailAddress],
                 [ActiveStatus],
				 [ContactAccountId]
          FROM (
               SELECT sf_SfContactId,
                      sf_sfaccountid,
                      DataField,
					  case when overrideChoice = 'Override' then OverrideValue
							when overrideChoice = 'Matrix' then MX_Value
					  end as MX_Value
               FROM [Sales.BP].ContactOverride CO
			   	INNER	JOIN [Sales.BP].[SfAccountVw] SFA
				ON	SFA.SfAccountId = CO.sf_sfAccountId 
               WHERE OverrideStatus = 'Fixed'
			   and OverrideChoice != 'salesforce'
			   AND	SFA.AccountOwnerId = @AccountOwnerId --'00520000006d8SLAAY' -- configurable ContactOwnerId

          ) src
          PIVOT
          (
          MIN(MX_Value) FOR DataField IN (
          [Salutation],
          [ContactOwnerId],
          [FirstName],
          [LastName],
          [Phone],
          [Mobile],
          [EmailAddress],
          [ActiveStatus],
		  [ContactAccountId])
          ) piv
     ) MX
     INNER JOIN (
          SELECT sf_SfContactId,
                 sf_sfaccountid,
                 [Salutation],
                 [ContactOwnerId],
                 [FirstName],
                 [LastName],
                 [Phone],
                 [Mobile],
                 [EmailAddress],
                 [ActiveStatus],
				 [ContactAccountId]
          FROM (
               SELECT sf_SfContactId,
                      sf_sfaccountid,
                      DataField,
                      sf_Value
				FROM [Sales.BP].ContactOverride CO
			   	INNER	JOIN [Sales.BP].[SfAccountVw] SFA
				ON	SFA.SfAccountId = CO.sf_sfAccountId 
               WHERE OverrideStatus = 'Fixed'
			   and OverrideChoice != 'salesforce'
			   AND	SFA.AccountOwnerId = @AccountOwnerId -- '00520000006d8SLAAY' -- configurable ContactOwnerId

          ) src
          PIVOT
          (
          MIN(sf_Value) FOR DataField IN (
          [Salutation],
          [ContactOwnerId],
          [FirstName],
          [LastName],
          [Phone],
          [Mobile],
          [EmailAddress],
          [ActiveStatus],
		  [ContactAccountId])
          ) piv
     ) SF
          ON MX.sf_SfContactId = SF.sf_SfContactId
          AND MX.sf_sfaccountid = SF.sf_sfaccountid

			   
	-- update Matrixid when lastname updated to salesforce entry
	INSERT INTO [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT_EXCEPTION] (CntSalesforceId,
																		CntAccountSalesforceId,
																		CntMatrixId,
																		Old_CntMatrixId)
	select	sf_SfContactId   AS CntSalesforceId,
            sf_sfaccountid   AS CntAccountSalesforceId,
			' '				 AS CntMatrixId,
			NULL				AS Old_CntMatrixId
	FROM [Sales.BP].ContactOverride AO
	INNER	JOIN [Sales.BP].[SfAccountVw] SFA
	ON	SFA.SfAccountId = AO.sf_sfAccountId 
    WHERE OverrideStatus = 'Fixed'
	and AO.OverrideChoice != 'Matrix'
	and DataField = 'LastName'
	and SFA.AccountOwnerId  = @AccountOwnerId

-- Missing logic for Movers. The CntAccountSalesforceId will need to be looked up from the SIV on the Mx Account Extract
UPDATE ex
SET CntAccountSalesforceId = vw.AccSalesforceId
FROM [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT_EXCEPTION] ex
INNER JOIN [Staging].[MxAccountExtract] vw
ON vw.AccSIVId = ex.CntAccountSivId
WHERE ex.ExportStatus = 'WAIT' 
	AND ex.CntAccountSivId IS NOT NULL
	AND vw.AccSalesforceId IS NOT NULL -- bit of defensive cover as a NULL value will cause a problem with the update


     COMMIT TRAN -- Transaction Success!

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
          ROLLBACK TRAN --RollBack in case of Error

		-- Write errors to table: dbo.LogProcErrors
		EXECUTE dbo.usp_LogProcErrors

END CATCH


