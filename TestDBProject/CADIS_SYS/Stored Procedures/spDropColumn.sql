CREATE PROCEDURE [CADIS_SYS].[spDropColumn]
(
	@Tab VARCHAR(128), -- fully qualified table name
	@Col VARCHAR(128),  -- column to be dropped
	@Print_Only BIT = 0 -- 0 = execute drop, 1 = only print drop sql 
)
AS
DECLARE @Name VARCHAR(128),
	@SQL VARCHAR(2000),
	@ID INT
IF (LEFT(@Col,1) = '[' OR LEFT(@Col,1) = '"')
	SELECT @Col = SUBSTRING(@Col,2,Len(@Col)-1)
IF (RIGHT(@Col,1) = ']' OR RIGHT(@Col,1) = '"')
	SELECT @Col = SUBSTRING(@Col,1,Len(@Col)-1)
IF EXISTS (SELECT * FROM syscolumns WHERE id=OBJECT_ID(@Tab) AND name=@Col)
BEGIN
	SELECT  @ID = OBJECT_ID(@Tab)
	-- drop any stats on column
        DECLARE STAT CURSOR
        FOR
	        SELECT  I.NAME
	        FROM    sysobjects obj
	        INNER JOIN sysindexes i
                	ON i.id = obj.id 
		INNER JOIN syscolumns cl
			ON cl.id = obj.id
			AND cl.name = index_col(@Tab,i.indid, 1) -- for stats should always be 1st column
	        WHERE   obj.id = @ID
		AND	cl.name = @Col
		AND	(INDEXPROPERTY(i.id, i.name, 'IsStatistics') = 1
		OR	INDEXPROPERTY(i.id, i.name, 'IsAutoStatistics') = 1)
	OPEN STAT;
	FETCH NEXT FROM STAT INTO @Name;
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		SELECT @SQL = 'DROP STATISTICS ' + @Tab + '.[' + @Name + '];';
		IF @Print_Only = 1
			PRINT @SQL;
		ELSE
			EXEC (@SQL);
		FETCH NEXT FROM STAT INTO @Name;
	END;
	CLOSE STAT;
	DEALLOCATE STAT;
	-- drop any column constraints
        DECLARE CONS CURSOR
        FOR
        	SELECT  OBJECT_NAME(con.constid)
	        FROM    sysobjects obj
		INNER JOIN syscolumns cl
			ON cl.id = obj.id
        	INNER JOIN sysconstraints con 
	                ON con.id = obj.id 
			AND con.colid = cl.colid 
	        WHERE   obj.id = @ID
		AND 	cl.name = @Col
	OPEN CONS;
	FETCH NEXT FROM CONS INTO @Name;
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		SELECT @SQL = 'ALTER TABLE ' + @Tab + ' DROP CONSTRAINT [' + @Name + '];';
		IF @Print_Only = 1
			PRINT @SQL;
		ELSE
			EXEC (@SQL);
		FETCH NEXT FROM CONS INTO @Name;
	END;
	CLOSE CONS;
	DEALLOCATE CONS;
	-- finally drop the column
        SELECT @SQL = 'ALTER TABLE ' + @Tab + ' DROP COLUMN [' + @Col + '];';
	IF @Print_Only = 1
		PRINT @SQL;
	ELSE
		EXEC (@SQL);
END
ELSE
BEGIN
	IF @Print_Only = 1
	        SELECT  'Column not found.';
END
