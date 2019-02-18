CREATE PROCEDURE [Reporting].[usp_EDMDIPsEmailSent]
	@RunDate date = NULL
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Reporting].[usp_EDMDIPsEmailSent]
-- 
-- Note:			
-- 
-- Author:			K Wu
-- Date:			26/01/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		Checks to see if the DIPs email has been sent.
-- 
-------------------------------------------------------------------------------------- 

Set NoCount on
	
DECLARE @Sent BIT
SET @Sent = 0

IF @RunDate IS NULL
BEGIN
	SET @RunDate = CONVERT(DATE, GETDATE())
END

SELECT TOP 1 @Sent = 1 FROM [Audit].[EmailLog] WHERE ProcessId = 1 AND EmailSent = 1 AND CONVERT(DATE, CreatedDate) = @RunDate

SELECT @Sent AS [EmailSent]
