CREATE PROC [CADIS].[SPDG_Audit_SelByName]
	@Name nvarchar(200),
	@StartDate datetime,
	@EndDate datetime
AS
DECLARE @ID int
SELECT @ID=IDENTIFIER FROM CADIS_SYS.DG_FUNCTION WHERE NAME = @Name
DECLARE @SQL nvarchar(1000)
SET @SQL = 'EXEC CADIS_PROC.SPDG_FUNCTION' + CONVERT(nvarchar, @ID) + '_AUDITSEL ''' + CONVERT(nvarchar, @StartDate, 120) + ''',''' + CONVERT(nvarchar, @EndDate, 120) + ''''
EXEC (@SQL)
