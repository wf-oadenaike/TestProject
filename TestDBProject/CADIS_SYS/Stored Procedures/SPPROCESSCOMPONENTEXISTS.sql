CREATE PROCEDURE [CADIS_SYS].[SPPROCESSCOMPONENTEXISTS]
	@ProcessId	   INT,  
	@ComponentType INT,
	@XmlRoute	   NVARCHAR(MAX),
	@SearchTerm    NVARCHAR(250),
	@SearchAsText  BIT,
	@StrictComparison BIT
AS
/*********************************************************************************************************************************************
	Purpose:	Performs search in Process XML definition and checks if SearchTerm value is already in use
*********************************************************************************************************************************************/
DECLARE @sqlXMLSearch	   NVARCHAR(MAX),
		@sql			   NVARCHAR(MAX),
		@sqlProcessIdCheck NVARCHAR(MAX)
IF @SearchAsText = 1 
	SET @sqlXMLSearch = 'CadisXml/Content' + @XmlRoute + '/*//text()[contains(lower-case(.), "' + @SearchTerm + '")]'
ELSE IF @SearchAsText = 0
	SET @sqlXMLSearch = 'CadisXml/Content' + @XmlRoute + '/text()[contains(lower-case(.), "' + @SearchTerm + '")]'
SET @sqlProcessIdCheck = CASE WHEN @ProcessId > 0 THEN 'AND CP.IDENTIFIER != ' + CAST(@ProcessId AS NVARCHAR) ELSE '' END
-- XML exist works as like, for some cases there is strict comparison requirement
IF @StrictComparison = 1
	SET @sqlProcessIdCheck = @sqlProcessIdCheck + 'AND LOWER(CP.DEFINITION.value(''(CadisXml/Content' + @XmlRoute +')[1]'', ''NVARCHAR(250)'')) = ''' + @SearchTerm + ''''
SET @sql = 'WITH SEARCH_RESULT AS (SELECT TOP 1 CP.IDENTIFIER FROM CADIS_SYS.CO_PROCESS CP INNER JOIN CADIS_SYS.CO_COMPONENT CO ON CO.ID = CP.PROCESSTYPE
			WHERE CP.PROCESSTYPE = ''' + CAST(@ComponentType AS NVARCHAR) + ''' AND CP.OBSOLETE = 0 AND CP.DEFINITION.exist(''' + @sqlXMLSearch + ''') = 1 ' +
			@sqlProcessIdCheck + ') SELECT COUNT(1) FROM SEARCH_RESULT'
EXEC sp_executesql @sql
SET QUOTED_IDENTIFIER OFF 
