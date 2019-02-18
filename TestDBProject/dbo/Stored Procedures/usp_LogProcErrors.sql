
CREATE PROCEDURE usp_LogProcErrors
AS

	INSERT dbo.LogProcErrors
	(
	[ErrorNumber],
	[ErrorSeverity],
	[ErrorState],
	[ErrorProcedure],
	[ErrorLine],
	[ErrorMessage],
	[ErrorDate],
	[ErrorUser]
	)

    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() as ErrorState,
        ERROR_PROCEDURE() as ErrorProcedure,
        ERROR_LINE() as ErrorLine,
        ERROR_MESSAGE() as ErrorMessage,
		GETDATE() as ErrorDate,
		SYSTEM_USER as ErrorUser;
