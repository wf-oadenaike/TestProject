



CREATE FUNCTION [dbo].[XIRR]
(
    @Sample MyXirrTable READONLY,
    @Rate DECIMAL(38, 9) =0.1,
	@FundType VARCHAR(15),
@KnownName VARCHAR(256)
)
RETURNS DECIMAL(38, 9)
AS
BEGIN
    DECLARE @LastRate DECIMAL(38, 9),
        @RateStep DECIMAL(38, 9) = 0.1,
        @Residual DECIMAL(38, 9) = 10,
        @LastResidual DECIMAL(38, 9) = 1,
        @i TINYINT = 0

    IF @Rate IS NULL
        SET @Rate = 0.1

    SET @LastRate = @Rate

    WHILE @i < 100 AND ABS((@LastResidual - @Residual) / nullif((@LastResidual),0)) > 0.00000001
        BEGIN
            SELECT  @LastResidual = @Residual,
                @Residual = 0

            SELECT  @Residual = @Residual + theValue / POWER(1 + @Rate, theDelta / 365.0E )
            FROM    (
                    SELECT  theValue,
                        DATEDIFF(DAY, MIN(theDate) OVER (), theDate) AS theDelta
                    FROM    @Sample
					WHERE 
					  Fund = @FundType
				AND  KnownName = @KnownName
					
                ) AS d

            SET @LastRate = @Rate

            If @Residual >= 0
                SET @Rate += @RateStep
            ELSE
                SELECT  @RateStep /= 2,
                    @Rate -= @RateStep

            SET @i += 1
        END

    RETURN  @LastRate
END
