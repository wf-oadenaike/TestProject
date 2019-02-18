
CREATE PROCEDURE [CADIS_SYS].[SPPROCESSMONITOR_SELALLRUNNING]
       @PageNumber INT 
       ,@PageSize INT 
       ,@SortColumns NVARCHAR(500) 
As
DECLARE @FirstRowNum INT, @LastRowNum INT, @orderBySql NVARCHAR(MAX), @sql NVARCHAR(MAX)
set @FirstRowNum = ((@PageNumber -1) * @PageSize) + 1
set @LastRowNum = @PageNumber * @PageSize
IF @SortColumns IS NOT NULL BEGIN
	SET @orderBySql = N' ORDER BY ' + @SortColumns
END 
ELSE BEGIN
	--Have to have a default for paging
	SET @orderBySql = N' ORDER BY RUNTOKEN '
END
SET @SQL = N'
WITH FilteredPage AS  ( SELECT ROW_NUMBER() OVER (' + @orderBySql + ') AS RowNum, 
M.RUNTOKEN, M.PROCESSTYPE, PROCESSNAME=A.NAME, M.WORKFLOWDATA, M.CRC, M.UPDATED,
              M.[STATUS], M.RUNID, M.[TIMESTAMP], H.RUNSTART, H.RUNEND, H.RUNSUCCESSFUL, H.RETURNCODE, M.CMDLINE
FROM CADIS_SYS.CO_PROCESSMONITOR M
       JOIN CADIS_SYS.VW_ALL_PROCESSES A ON A.COMPONENTID=M.PROCESSTYPE AND A.GUID=M.GUID AND A.OBSOLETE=0
       LEFT JOIN CADIS_SYS.CO_PROCESSHISTORY H ON H.RUNID = M.RUNID
	   WHERE M.STATUS IN (9, 11, 12) AND M.PARENTTOKEN IS NULL ) SELECT * FROM FilteredPage WHERE RowNum >= @FirstRowNum AND RowNum <=@LastRowNum ORDER BY RowNum
	'
	EXEC sp_executesql @SQL , N' @FirstRowNum int, @LastRowNum int', @FirstRowNum=@FirstRowNum,  @LastRowNum= @LastRowNum
	