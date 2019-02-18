
CREATE Proc [dbo].USP_Salesforce_PostcodeOverrideRevert
-------------------------------------------------------------------------------------- 
-- NAME:			[dbo].[USP_Salesforce_PostcodeOverrideRevert]
-- 
-- NOTE:			Reverses as overrides done in T_SALESFORCE_POSTCODE_OVERRIDE. The postcode mapping process will be used for these entries instead.
-- 
-- AUTHOR:			VIPUL KHATRI
-- DATE:			01/06/2018
-------------------------------------------------------------------------------------- e
-- HISTORY:			
-- 16-04-2018		VIPUL KHATRI			DAP-2068      -- Initial version

AS

BEGIN TRY

	-- START TRANSACTION
	BEGIN TRANSACTION

	update o
	set [Revert] = 0,
	    AccountOwnerid = OriginalAccountOwnerId,
		OverrideStatus = 'Raised' 
	from T_SALESFORCE_POSTCODE_OVERRIDE o
	where [Revert] = 1

	COMMIT TRAN -- Transaction Success!

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN --RollBack in case of Error

		-- Write errors to table: dbo.LogProcErrors
		EXECUTE dbo.usp_LogProcErrors

END CATCH