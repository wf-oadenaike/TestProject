CREATE PROCEDURE "CADIS"."SP_RETAIN_ManyWhoStates_TwoWeeks"
	
AS
BEGIN
	-------------------------------------------------------------------------------------- 
-- Name:			[CADIS].[SP_RETAIN_ManyWhoStates_TwoWeeks]
-- 
-- Params:			
-- 
-------------------------------------------------------------------------------------- 
-- History:			

-- WHO				WHEN				WHY
-- D.Bacchus:			19/07/2017			JIRA: DAP-1230 Delete data older than two weeks in small transaction sets
--
-- 
-------------------------------------------------------------------------------------- 

DECLARE @Deleted_Rows_ManyWhoStates INT;
SET @Deleted_Rows_ManyWhoStates = 1;

WHILE (@Deleted_Rows_ManyWhoStates > 0)
  BEGIN

   BEGIN TRANSACTION

     DELETE TOP (10000)  [Staging.ManyWho].[ManyWhoStates]
     WHERE CreatedDate < DATEADD(DAY,-14,GETDATE())

     SET @Deleted_Rows_ManyWhoStates = @@ROWCOUNT;

   COMMIT TRANSACTION
  -- CHECKPOINT -- for simple recovery model
END

END
