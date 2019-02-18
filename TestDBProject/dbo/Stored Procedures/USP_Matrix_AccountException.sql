
CREATE Proc [dbo].USP_Matrix_AccountException(@AccountOwnerid varchar(18))
-------------------------------------------------------------------------------------- 
-- NAME:			[dbo].[USP_Matrix_AccountException]
-- 
-- NOTE:			Update Account exception data for Boomi to update into salesforce
-- 
-- AUTHOR:			VIPUL KHATRI
-- DATE:			03/07/2018
-------------------------------------------------------------------------------------- 
-- HISTORY:			
-- 03-07-2018		VIPUL KHATRI			DAP-2124 - Update Account exception data for Boomi to update into salesforce


AS

BEGIN TRY


	BEGIN TRAN

	INSERT INTO [dbo].[T_MATRIX_PROCESS_SALESFORCE_ACCOUNT_EXCEPTION] (AccSalesForceID,
		AccName,
		Old_AccName,
		AccOwnerId,
		Old_AccOwnerId,
		AccBillingStreet,
		Old_AccBillingStreet,
		AccBillingCity,
		Old_AccBillingCity,
		AccBillingPostcode,
		Old_AccBillingPostcode,
		AccBillingCountry,
		Old_AccBillingCountry,
		AccLandline,
		Old_AccLandline,
		ActiveStatus,
		Old_ActiveStatus)

     -- SF
     SELECT MX.sf_sfaccountid    AS AccSalesForceID,
            MX.[AccountName]     AS AccName,
            SF.[AccountName]     AS Old_AccName,
            MX.[AccountownerId]  AS AccOwnerId,
            SF.[AccountownerId]  AS Old_AccOwnerId,
            MX.[BillingStreet]   AS AccBillingStreet,
            SF.[BillingStreet]   AS Old_AccBillingStreet,
            MX.[BillingCity]     AS AccBillingCity,
            SF.[BillingCity]     AS Old_AccBillingCity,
            MX.[BillingPostcode] AS AccBillingPostcode,
            SF.[BillingPostcode] AS Old_AccBillingPostcode,
            MX.[BillingCountry]  AS AccBillingCountry,
            SF.[BillingCountry]  AS Old_AccBillingCountry,
            MX.[Phone]           AS AccLandline,
            SF.[Phone]           AS Old_AccLandline,
            MX.[ActiveStatus]    AS ActiveStatus,
            SF.[ActiveStatus]    AS Old_ActiveStatus
     FROM (
          SELECT sf_sfaccountid,
                 [AccountName],
                 [AccountownerId],
                 [BillingStreet],
                 [BillingCity],
                 [BillingPostcode],
                 [BillingCountry],
                 [Phone],
                 [ActiveStatus]
          FROM (
               SELECT sf_sfaccountid,
                      DataField,
                      case when overrideChoice = 'Override' then OverrideValue
							when overrideChoice = 'Matrix' then MX_Value
					  end as MX_Value
               FROM [Sales.BP].AccountOverride AO
			   INNER	JOIN [Sales.BP].[SfAccountVw] SFA
			   ON	AO.sf_SfAccountId = SFA.sfAccountId 
               WHERE AO.OverrideStatus = 'fixed'
			   and AO.OverrideChoice != 'Salesforce'
			   and SFA.AccountOwnerId = @AccountOwnerid -- '00520000006d8SLAAY' -- Configurable parameter
			   union
			   select  SfAccountId		as sf_sfaccountid,
					  'AccountOwnerId'	as DataField,
					   AccountOwnerId
			    from [dbo].T_SALESFORCE_POSTCODE_OVERRIDE
			   where OverrideStatus = 'fixed'
			   and SfAccountId not in (select sf_sfaccountid from [Sales.BP].AccountOverride where OverrideStatus = 'fixed' AND DataField = 'AccountOwnerid')
          ) src
          PIVOT
          (
          MIN(MX_Value) FOR DataField IN (
          [AccountName],
          [AccountownerId],
          [BillingStreet],
          [BillingCity],
          [BillingPostcode],
          [BillingCountry],
          [Phone],
          [ActiveStatus])
          ) piv
     ) MX
     INNER JOIN (
          SELECT sf_sfaccountid,
                 [AccountName],
                 [AccountownerId],
                 [BillingStreet],
                 [BillingCity],
                 [BillingPostcode],
                 [BillingCountry],
                 [Phone],
                 [ActiveStatus]
          FROM (
               SELECT sf_sfaccountid,
                      DataField,
                      sf_Value
               FROM [Sales.BP].AccountOverride AO
			   INNER	JOIN [Sales.BP].[SfAccountVw] SFA
			   ON	AO.sf_SfAccountId = SFA.sfAccountId 
               WHERE AO.OverrideStatus = 'fixed'
			   and AO.OverrideChoice != 'Salesforce'
			   and SFA.AccountOwnerId = @AccountOwnerid --'00520000006d8SLAAY' -- Configurable parameter
			   union
			   select  SfAccountId		as sf_sfaccountid,
					  'AccountOwnerId'	as DataField,
					   OriginalAccountOwnerId
			    from [dbo].T_SALESFORCE_POSTCODE_OVERRIDE
			   where OverrideStatus = 'fixed'
			   and SfAccountId not in (select sf_sfaccountid from [Sales.BP].AccountOverride where OverrideStatus = 'fixed' AND DataField = 'AccountOwnerid')
          ) src
          PIVOT
          (
          MIN(sf_Value) FOR DataField IN (
          [AccountName],
          [AccountownerId],
          [BillingStreet],
          [BillingCity],
          [BillingPostcode],
          [BillingCountry],
          [Phone],
          [ActiveStatus])
          ) piv
     ) SF
          ON MX.sf_sfaccountid = SF.sf_sfaccountid


    -- update outlet id when billingstreet, BillingCity and BillingPostcode updated to
	INSERT INTO [dbo].[T_MATRIX_PROCESS_SALESFORCE_ACCOUNT_EXCEPTION] 
				(AccSalesForceID,
				 AccMatrixOutletId,
				Old_AccMatrixOutletId)

	SELECT BS.sf_sfaccountid,
						' ' as AccMatrixOutletId,
						null as Old_AccMatrixOutletId
				from 
			   (
				   SELECT sf_sfaccountid
				   FROM [Sales.BP].AccountOverride AO
				   INNER	JOIN [Sales.BP].[SfAccountVw] SFA
					ON	AO.sf_SfAccountId = SFA.sfAccountId 
				   WHERE AO.OverrideStatus = 'fixed'
				   and AO.OverrideChoice != 'Matrix'
				   and DataField = 'BillingStreet'
				   and SFA.AccountOwnerId = @AccountOwnerid
				) BS
			   inner join 
			   (
			   	SELECT sf_sfaccountid
				   FROM [Sales.BP].AccountOverride AO
				   INNER	JOIN [Sales.BP].[SfAccountVw] SFA
					ON	AO.sf_SfAccountId = SFA.sfAccountId 
				   WHERE AO.OverrideStatus = 'fixed'
				   and AO.OverrideChoice != 'Matrix'
				   and DataField = 'BillingPostcode'
				   and SFA.AccountOwnerId = @AccountOwnerid
			   ) BP 
			   	on BS.sf_SfAccountId = BP.sf_SfAccountId


     COMMIT TRAN -- Transaction Success!

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
          ROLLBACK TRAN --RollBack in case of Error

		-- Write errors to table: dbo.LogProcErrors
		EXECUTE dbo.usp_LogProcErrors

END CATCH