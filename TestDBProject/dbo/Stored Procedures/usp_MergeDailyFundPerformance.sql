


CREATE PROCEDURE dbo.usp_MergeDailyFundPerformance AS
-------------------------------------------------------------------------------------- 
-- Name: dbo.usp_MergeDailyFundPerformance
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu: 20/08/2018 JIRA: DAP-1668	 Merge Staging table to Main Daily Performance table
--
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @strProcedureName VARCHAR(100) = 'dbo.usp_MergeDailyFundPerformance';

BEGIN TRANSACTION





Merge  [dbo].[T_BBG_DAILY_FUND_PERFORMANCE] as tar
using (SELECT * FROM  [dbo].[T_BBG_DAILY_FUND_PERFORMANCE_IN] WHERE FUND IS NOT NULL) as src 
on (tar.Reportdate = src.Reportdate) AND (tar.fund = src.fund) AND tar.PortfolioGroup = src.PortfolioGroup

WHEN MATCHED AND
            (src.[EndWeightPort] <> tar.[EndWeightPort]  OR
		    src.[EndWeightBench] <> tar.[EndWeightBench] OR
			src.[EndWeight] <> tar.[EndWeight] OR
			 src.[RtnDayPort] <> tar.[RtnDayPort] OR
			 src.[RtnDayBench] <> tar.[RtnDayBench] OR
			 src.[RtnDay] <> tar.[RtnDay]  OR
			 src.[RtnWtdPort] <> tar.[RtnWtdPort] OR 
			 src.[RtnWtdBench] <> tar.[RtnWtdBench] OR 
			 src.[RtnWtd] <> tar.[RtnWtd] OR 
			 src.[RtnMtdPort] <> tar.[RtnMtdPort]   OR 
			 src.[RtnMtdBench] <> tar.[RtnMtdBench]   AND 
			 src.[RtnMtd] <> tar.[RtnMtd]  AND 
			 src.[RtnQtdPort] <> tar.[RtnQtdPort] AND 
			 src.[RtnQtdBench] <> tar.[RtnQtdBench] AND 
			 src.[RtnQtd] <> tar.[RtnQtd] AND 
			src.[RtnYtdPort] <> tar.[RtnYtdPort] AND 
			 src.[RtnYtdBench] <>tar.[RtnYtdBench] AND
			 src.[RtnYtd] <> tar.[RtnYtd])
THEN 			
UPDATE SET
			TAR.[EndWeightPort] = SRC.[EndWeightPort] ,
			TAR.[EndWeightBench] = SRC.[EndWeightBench] ,
			TAR.[EndWeight] = SRC.[EndWeight] ,
			TAR.[RtnDayPort] = SRC.[RtnDayPort],
			TAR.[RtnDayBench] = SRC.[RtnDayBench] ,
			TAR.[RtnDay] = SRC.[RtnDay] ,
			TAR.[RtnWtdPort] = SRC.[RtnWtdPort] , 
			TAR.[RtnWtdBench] = SRC.[RtnWtdBench] , 
			TAR.[RtnWtd] = SRC.[RtnWtd] , 
			TAR.[RtnMtdPort] = SRC.[RtnMtdPort]   , 
			TAR.[RtnMtdBench] = SRC.[RtnMtdBench]   , 
			TAR.[RtnMtd] = SRC.[RtnMtd]  , 
			TAR.[RtnQtdPort] = SRC.[RtnQtdPort], 
			TAR.[RtnQtdBench] = SRC.[RtnQtdBench] , 
			TAR.[RtnQtd] = SRC.[RtnQtd] , 
			TAR.[RtnYtdPort] = SRC.[RtnYtdPort] , 
			TAR.[RtnYtdBench] =SRC.[RtnYtdBench] ,
			TAR.[RtnYtd] = SRC.[RtnYtd],
			tar.EffectivedDate  = GetDate (),
			TAR.FLAG = 'U'



WHEN NOT MATCHED THEN
INSERT ([PortfolioGroup], [Fund], [Filler], [ReportDate], [EndWeightPort], [EndWeightBench], [EndWeight], [RtnDayPort], [RtnDayBench], [RtnDay], [RtnWtdPort], [RtnWtdBench], [RtnWtd], [RtnMtdPort], [RtnMtdBench], [RtnMtd], [RtnQtdPort], [RtnQtdBench], [RtnQtd], [RtnYtdPort], [RtnYtdBench], [RtnYtd], [EffectivedDate], flag, [FileName], [CADIS_SYSTEM_INSERTED], [CADIS_SYSTEM_UPDATED], [CADIS_SYSTEM_CHANGEDBY], [CADIS_SYSTEM_PRIORITY],  [CADIS_SYSTEM_LASTMODIFIED])
VALUES ([PortfolioGroup], [Fund], [Filler], [ReportDate], [EndWeightPort], [EndWeightBench], [EndWeight], [RtnDayPort], [RtnDayBench], [RtnDay], [RtnWtdPort], [RtnWtdBench], [RtnWtd], [RtnMtdPort], [RtnMtdBench], [RtnMtd], [RtnQtdPort], [RtnQtdBench], [RtnQtd], [RtnYtdPort], [RtnYtdBench], [RtnYtd], GETDATE(), 'N', [FileName],[CADIS_SYSTEM_INSERTED], [CADIS_SYSTEM_UPDATED], [CADIS_SYSTEM_CHANGEDBY], [CADIS_SYSTEM_PRIORITY],  [CADIS_SYSTEM_LASTMODIFIED]);



COMMIT TRANSACTION

END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;



-- Write errors to table: dbo.LogProcErrors

EXECUTE dbo.usp_LogProcErrors



/*

-- this secion can be enabled if you want the error to print on the screen

DECLARE
@ERROR_SEVERITY INT,
@ERROR_STATE INT,
@ERROR_NUMBER INT,
@ERROR_LINE INT,
@ERROR_MESSAGE NVARCHAR(4000);


SELECT
@ERROR_SEVERITY = ERROR_SEVERITY(),
@ERROR_STATE = ERROR_STATE(),
@ERROR_NUMBER = ERROR_NUMBER(),
@ERROR_LINE = ERROR_LINE(),
@ERROR_MESSAGE = @strProcedureName + ' - ' + ERROR_MESSAGE() ;

RAISERROR('Msg %d, Line %d, :%s',
@ERROR_SEVERITY,
@ERROR_STATE,
@ERROR_NUMBER,
@ERROR_LINE,
@ERROR_MESSAGE);
*/

END CATCH

