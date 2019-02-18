

-- ============================================================
-- Author:      Eli Leiba
-- Create date: 01-2018
-- Description: a view and a scalar UDF to generate a random
-- 8 characters password
-- Source https://www.mssqltips.com/sqlservertip/5303/simple-sql-server-function-to-generate-random-8-character-password/
-- Changes :
-- Modified to include delay before returning the result [Desmond]
-- ============================================================
CREATE FUNCTION [dbo].[GenPass](@seconds int) 
returns VARCHAR(8)
as BEGIN 

DECLARE @endTime datetime2(0) = DATEADD(SECOND, @seconds, GETDATE())
DECLARE @Result VARCHAR(8)

   WHILE (GETDATE() < @endTime) 
      BEGIN SET @endTime = @endTime 
         DECLARE @BinaryData VARBINARY(8)
         DECLARE @CharacterData VARCHAR(8)
       
         SELECT @BinaryData = randval
         FROM vRandom
       
         Set @CharacterData=cast ('' as xml).value ('xs:base64Binary(sql:variable("@BinaryData"))',
                         'varchar (max)')
         
         SET @Result = @CharacterData


      END

RETURN @Result     -- Return the result of the function

END

