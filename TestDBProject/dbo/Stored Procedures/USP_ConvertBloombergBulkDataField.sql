

CREATE PROCEDURE [dbo].[USP_ConvertBloombergBulkDataField]
	@iInputTable	varchar(100),
	@iUniqueIDField	varchar(100),
	@iDataField		varchar(100)

/*
	C A D I S
	==========================================================
	Name	:	USP_ConvertBloombergBulkDataField
	Summary	:	Copies and converts Bloomberg instrument 
				bulk data from input table
				into normalised bulk data table
	Author	:	David Suter
				(rewrite of original code by David Winson)
	==========================================================
	Parameters:

	@iInputTable :		the input table to be processed
	@iUniqueIDField	:	the input table primary key column 
	@iDataField	:		the input table column to be processed

	==========================================================
	Revision History
	
	Date			Name	Description
	--------------	------	----------------------------------
	02/07/2004		DW		Created (based on original code by Oliver Kunz)
	23/09/2004		DW		Modified to allow input table to be changed and return data as resultset
	12/11/2009		DS		Complete rewrite to handle bulk data with > 3 columns per row in bulk fields
	07/06/2010		CT		Column array in #InmtArray changed to be varchar(max)
*/

AS
BEGIN

	SET NOCOUNT ON

	DECLARE	@SQLError	int,		--temp storage for @@Error
			@TSQL		varchar(500)
	
	SELECT 	@SQLError = 0

	-- Create Temp Tables

	CREATE TABLE #InmtArray (
		UniqueID	varchar(50) 	NOT NULL,
		array		varchar(max)	NOT NULL,
		no_of_rows	int				NOT NULL	DEFAULT(0),
		no_of_cols	int				NOT NULL	DEFAULT(0),
		pos1		int				NOT NULL	DEFAULT(0),
		pos2		int				NOT NULL	DEFAULT(0),
		pos3		int				NOT NULL	DEFAULT(0))

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	ALTER TABLE #InmtArray
		ADD CONSTRAINT PK_BBB_InmtArray
			PRIMARY KEY CLUSTERED (UniqueID) WITH FILLFACTOR = 100

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	CREATE TABLE #BBBArrayDetail (
		UniqueID	varchar(50) 		NOT NULL,
		NBR			int	IDENTITY(1,1)	NOT NULL,
		value_txt	varchar(500)		NULL
		)

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	ALTER TABLE #BBBArrayDetail
		ADD CONSTRAINT PK_BBB_ArrayDetail 
			PRIMARY KEY CLUSTERED (UniqueID, NBR) WITH FILLFACTOR = 100

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	CREATE TABLE #DetailRow (
		UniqueID	varchar(50) 	NOT NULL,
		row_no		int				NOT NULL,
		col_no		int				NOT NULL,
		datatype	varchar(100)	NULL,
		value_txt	varchar(500)	NULL,
		value_date	datetime		NULL,
		value_num	numeric(28,6)	NULL)

	SELECT	@SQLError=@@Error
	IF @SQLError <> 0 GOTO ErrHnd

	ALTER TABLE #DetailRow
		ADD CONSTRAINT PK_BBB_DetailRow
			PRIMARY KEY CLUSTERED (UniqueID, row_no, col_no) WITH FILLFACTOR = 100

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	-- Fetch the data we want to process

	SELECT	@TSQL = 'INSERT #InmtArray (UniqueID, array) '
		+ 'SELECT ' + @iUniqueIDField + ', ' + @iDataField + ' '
		+ 'FROM ' + @iInputTable + ' '
		+ 'WHERE DATALENGTH(' + @iDataField + ') > 1'

	EXEC (@TSQL)

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	-- Discard empty or bad data

	UPDATE	#InmtArray
	SET	pos1 = CHARINDEX(';2;', array)

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	DELETE	#InmtArray WHERE pos1 <> 1

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	-- Parse header rows

	UPDATE	#InmtArray
	SET	pos1 = CHARINDEX(';', array, 2)

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd
	
	UPDATE	#InmtArray
	SET	pos2 = CHARINDEX(';', array, pos1 + 1)

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	UPDATE	#InmtArray
	SET	pos3 = CHARINDEX(';', array, pos2 + 1)

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	UPDATE	#InmtArray
	SET	no_of_rows = CASE	
				WHEN ISNUMERIC(CONVERT(int, SUBSTRING(array, pos1 + 1, pos2 - pos1 - 1))) = 1
				THEN CONVERT(int, SUBSTRING(array, pos1 + 1, pos2 - pos1 - 1))
				ELSE 0 END,
		no_of_cols = CASE
				WHEN ISNUMERIC(CONVERT(int, SUBSTRING(array, pos2 + 1, pos3 - pos2 - 1))) = 1
				THEN CONVERT(int, SUBSTRING(array, pos2 + 1, pos3 - pos2 - 1))
				ELSE 0 END

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	DELETE	#InmtArray
	WHERE	no_of_rows < 1
	OR	no_of_cols < 1
	-- OR	no_of_cols > 3  /* no more 3 column limit */

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	-- strip off header to leave just row/col values (must leave starting delimiter)

	UPDATE #InmtArray
	SET array = SUBSTRING(array, pos3, DATALENGTH(array) - pos3)

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	-- must add final delimiter as terminator flag

	UPDATE #InmtArray
	SET array = CASE WHEN RIGHT(CONVERT(VARCHAR(MAX), array) ,1) = ';' THEN array ELSE CONVERT(VARCHAR(MAX), array) + ';' END

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 GOTO ErrHnd

	-- Parse data rows

	INSERT INTO #BBBArrayDetail 
		(UniqueID, value_txt)
	SELECT	a.UniqueID, 
			col_value = CASE
							WHEN CONVERT(VARCHAR(MAX), a.array) <> ';'
								THEN SUBSTRING(a.array, t.NBR + 1, CHARINDEX(';', a.array, t.NBR + 1) -t.NBR - 1)
							ELSE NULL
						END
	FROM #InmtArray a
        INNER JOIN [dbo].[BB_BulkData_Tally] t
				ON (t.NBR < DATALENGTH(a.array) OR CONVERT(VARCHAR(MAX), a.array) = ';')
				AND SUBSTRING(a.array, t.NBR, 1) = ';'
	ORDER BY a.UniqueID, t.NBR /* must order to associate type / value pairs correctly */

	SELECT	@SQLError = @@Error
	IF @SQLError <> 0 
	BEGIN
		print ('Error on Datafield: ' + @iDataField)
		GOTO ErrHnd
	END

	INSERT INTO #DetailRow 
			(
			UniqueID,
			row_no,
			col_no,
			datatype,
			value_txt,
			value_date,
			value_num
			)
	SELECT	DT.UniqueID AS UniqueID,
			CONVERT(INT, (DT.NBR - START.NBR) / (A.no_of_cols * 2)) + 1 AS row_no,
			(
			DT.NBR
				- (
					(CONVERT(INT, (DT.NBR - START.NBR) / (A.no_of_cols * 2)))	/* prev row no */
					* (A.no_of_cols * 2) + START.NBR							/* should now be at first DataType in current row */
				  ) 
			) / 2 + 1 as col_no,
			DT.value_txt AS datatype,
			CASE  
				WHEN DT.value_txt in ('5','6','7') and ISDATE(DV.value_txt) = 1
					THEN NULL
				WHEN DT.value_txt in ('2','3','12','13') and ISNUMERIC(DV.value_txt) = 1 AND DV.value_txt <> '.'
					THEN NULL		
					ELSE DV.value_txt
				END AS value_txt,
			CASE  
				WHEN DT.value_txt in ('5','6','7') and ISDATE(DV.value_txt) = 1
					THEN CONVERT(datetime, DV.value_txt) 
					ELSE NULL 
				END AS value_date,
			CASE  
				WHEN DT.value_txt in ('2','3','12','13') and ISNUMERIC(DV.value_txt) = 1 AND DV.value_txt <> '.'
					THEN CONVERT(decimal(28,6), DV.value_txt) 
					ELSE NULL 
				END AS value_num
	FROM	#BBBArrayDetail DT
		INNER JOIN #BBBArrayDetail DV
				ON (DV.UniqueID = DT.UniqueID
				AND DV.NBR = DT.NBR + 1
				AND DV.NBR % 2 = 0)
		INNER JOIN #InmtArray A
				ON (A.UniqueID = DT.UniqueID)
		INNER JOIN (SELECT UniqueID, MIN(NBR) as NBR FROM #BBBArrayDetail GROUP BY UniqueID) START
				ON (START.UniqueID = A.UniqueID)
	ORDER BY UniqueID, row_no, col_no

	SELECT @SQLError = @@Error
	if @SQLError <> 0 goto ErrHnd

	-- Return data
	SELECT	* FROM #DetailRow
	
	SELECT @SQLError = 0

ErrHnd:
	DROP TABLE #InmtArray
	DROP TABLE #DetailRow
	DROP TABLE #BBBArrayDetail

	RETURN @SQLError

END



