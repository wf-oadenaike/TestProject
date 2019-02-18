CREATE FUNCTION ufn_DetectTCAException
	(@Country varchar(5)
	,@B1NETPCTCST decimal(24,10) 
	,@B2NETPCTCST decimal(24,10)
	,@B3NETPCTCST decimal(24,10) = NULL)
RETURNS @ExceptionDetails TABLE
	(
	 Benchmark	varchar(20)
	,Message	varchar(20)
	)
AS
BEGIN

DECLARE @tempbenchmarks TABLE
	(BenchmarkField varchar(20)
	,BenchmarkValue decimal(24,10))

IF @Country <> 'US'
	BEGIN
	INSERT INTO @tempbenchmarks (BenchmarkField, BenchmarkValue)
		VALUES ('B1NETPCTCST',@B1NETPCTCST)
	IF @B3NETPCTCST IS NOT NULL
		INSERT INTO @tempbenchmarks (BenchmarkField, BenchmarkValue)
			VALUES ('B3NETPCTCST',@B3NETPCTCST)
	END
ELSE
	INSERT INTO @tempbenchmarks (BenchmarkField, BenchmarkValue)
		VALUES ('B2NETPCTCST',@B2NETPCTCST)



INSERT INTO  @ExceptionDetails (Benchmark, Message)
SELECT COALESCE(ETLower.BenchmarkName, ETUpper.BenchmarkName) 
		,COALESCE(ETLower.LowerExceptionMessage, ETUpper.UpperExceptionMessage)
		FROM 
		@tempbenchmarks A
		LEFT OUTER JOIN dbo.T_TCA_Exceptions_BenchmarkData ETLower
			ON A.BenchmarkField = ETLower.BenchmarkField
			AND A.BenchmarkValue <= ETLower.LowerThreshold 
		LEFT OUTER JOIN dbo.T_TCA_Exceptions_BenchmarkData ETUpper
			ON A.BenchmarkField = ETUpper.BenchmarkField
			AND A.BenchmarkValue >= ETUpper.UpperThreshold 
		WHERE ETUpper.BenchmarkName IS NOT NULL OR ETLower.BenchmarkName IS NOT NULL

RETURN

END;
