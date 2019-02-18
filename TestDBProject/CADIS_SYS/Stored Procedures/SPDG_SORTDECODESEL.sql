CREATE PROCEDURE [CADIS_SYS].[SPDG_SORTDECODESEL]
(
    @ObjectName NVARCHAR(200),
    @KeyName NVARCHAR(200),
    @return NVARCHAR(200) OUT
)
AS
SET NOCOUNT ON;
DECLARE @IsNumeric INT = 0;
DECLARE @IsDate INT = 0;
DECLARE @SqlQuery NVARCHAR(2000);
DECLARE @IsCastSuccess BIT;
DECLARE @maxValue NVARCHAR(MAX);
DECLARE @SqlQueryMaxValue NVARCHAR(2000);
SELECT @SqlQuery = N'SELECT @IsNumeric = (SELECT min(ISNUMERIC(' + @KeyName + N'))  from ' + @ObjectName + N')';
EXECUTE sp_executesql @SqlQuery,
                      N'@IsNumeric int OUTPUT',
                      @IsNumeric = @IsNumeric OUTPUT;
SELECT @SqlQuery = N'SELECT @IsDate = (SELECT min(ISDATE(' + @KeyName + N'))  from ' + @ObjectName + N')';
EXECUTE sp_executesql @SqlQuery,
                      N'@IsDate int OUTPUT',
                      @IsDate = @IsDate OUTPUT;
IF (@IsNumeric = 1)
BEGIN
    SELECT @SqlQuery
        = N'SELECT @IsNumeric = (SELECT max( CASE WHEN floor(' + @KeyName + N')= CEILING(' + @KeyName
          + N') THEN 2 ELSE 3 END ) from ' + @ObjectName + N')';
    EXECUTE sp_executesql @SqlQuery,
                          N'@IsNumeric int OUTPUT',
                          @IsNumeric = @IsNumeric OUTPUT;
    SELECT @SqlQueryMaxValue = N'SELECT @maxValue = (SELECT max(' + @KeyName + N')  from ' + @ObjectName + N')';
    EXECUTE sp_executesql @SqlQueryMaxValue,
                          N'@maxValue nvarchar(max) OUTPUT',
                          @maxValue = @maxValue OUTPUT;
    IF (@IsNumeric = 2)
    BEGIN
        SELECT @IsCastSuccess = TRY_CAST(@maxValue AS BIGINT);
        IF (@IsCastSuccess IS NOT NULL)
        BEGIN
            SET @return = 'convert(BIGINT,' + @KeyName + ')';
        END;
        ELSE
        BEGIN
            SET @return = @KeyName;
        END;
    END;
    IF (@IsNumeric = 3)
    BEGIN
        SELECT @IsCastSuccess = TRY_CAST(@maxValue AS FLOAT);
        IF (@IsCastSuccess = 1)
        BEGIN
            SET @return = 'convert(float,' + @KeyName + ')';
        END;
        ELSE
        BEGIN
            SET @return = @KeyName;
        END;
    END;
END;
ELSE IF (@IsDate = 1)
BEGIN
    SET @return = 'convert(datetime,' + @KeyName + ')';
END;
ELSE
BEGIN
    SET @return = @KeyName;
END;
