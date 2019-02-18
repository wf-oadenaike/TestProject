CREATE PROCEDURE CADIS_SYS.SPAUTH_SEARCH
	@Groups bit,
	@Users bit,
	@SearchTerm nvarchar(1000)
AS
CREATE TABLE #Results (NAME NVARCHAR(1000), USERTYPE INT)
IF @Users=1
BEGIN
	INSERT #Results (NAME, USERTYPE)
	SELECT name, 0 FROM dbo.sysusers 
	WHERE issqluser = 1 AND hasdbaccess = 1
	AND name LIKE '%' + @SearchTerm + '%'
END
IF @Groups=1
BEGIN
	INSERT #Results (NAME, USERTYPE)
	SELECT name, 1 FROM dbo.sysusers 
	WHERE issqlrole = 1 and gid < 16384
	AND name LIKE '%' + @SearchTerm + '%'
END
SELECT * FROM #Results ORDER BY NAME, USERTYPE
DROP TABLE #Results
