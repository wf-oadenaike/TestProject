CREATE PROCEDURE [Finance].[usp_ValidateSourceDataIntegrity]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Finance.usp_ValidateSourceDataIntegrity
-- 
-- Note:			
-- 
-- Author:			K Wu
-- Date:			07/08/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 
DECLARE @errorTable TABLE(
    Error varchar(512) NOT NULL
);

-- First check if columns in data have moved
INSERT INTO @errorTable
SELECT TOP 1 'ELT source data contains rows that have shifted' FROM [Staging].[GL_LLP]
WHERE [PnL/BS] NOT IN ('BS','P&L', '#n/a')


SELECT * FROM @errorTable
