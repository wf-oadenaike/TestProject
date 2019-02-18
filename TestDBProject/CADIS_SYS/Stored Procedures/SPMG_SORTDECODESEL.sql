CREATE PROCEDURE [CADIS_SYS].[SPMG_SORTDECODESEL]
 (
	@ObjectName nvarchar(200),
	@KeyName nvarchar(200),
	@return nvarchar(200) out
  )  
AS
SET NOCOUNT ON 
DECLARE @IsNumeric int = 0
DECLARE @IsDate int =0
DECLARE @SqlQuery nvarchar(2000)
SELECT @SqlQuery = N'SELECT @IsNumeric = (SELECT min(ISNUMERIC(' + @KeyName +'))  from '+ @ObjectName +')'
EXECUTE sp_executesql @SqlQuery, N'@IsNumeric int OUTPUT', @IsNumeric = @IsNumeric output;
SELECT @SqlQuery = N'SELECT @IsDate = (SELECT min(ISDATE(' + @KeyName +'))  from '+ @ObjectName +')'
EXECUTE sp_executesql @SqlQuery, N'@IsDate int OUTPUT', @IsDate = @IsDate output;
IF (@IsNumeric =1) BEGIN 
	SELECT @SqlQuery = N'SELECT @IsNumeric = (SELECT max( CASE WHEN floor('+@KeyName+')= CEILING('+@KeyName+') THEN 2 ELSE 3 END ) from '+@ObjectName+')'
	EXECUTE sp_executesql @SqlQuery, N'@IsNumeric int OUTPUT', @IsNumeric = @IsNumeric output;
	IF (@IsNumeric =2) BEGIN 
		SET @return='convert(int,'+@KeyName+')'
	END
	IF (@IsNumeric =3) BEGIN 
		SET @return='convert(float,'+@KeyName+')'
	END
END
ELSE IF (@IsDate =1) BEGIN
	SET @return='convert(datetime,'+@KeyName+')'
END	ELSE BEGIN
	SET @return= @KeyName 
END
