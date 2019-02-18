

CREATE PROCEDURE [dbo].[USP_ConvertBloombergBulkData]
	@SourceTable	VARCHAR(100),
	@UniqueIDField	VARCHAR(100)

/*
	C A D I S
	==========================================================
	Name	:	USP_ConvertBloombergBulkData
	Summary	:	Copies and converts Bloomberg instrument 
				bulk data from input table
				into normalised bulk data table
	Author	:	David Suter
				(rewrite of original code by David Winson)
	==========================================================
	Parameters:

	@SourceTable :		the input table to be processed
	@UniqueIDField	:	the input table primary key column 

	==========================================================
	Revision History
	
	Date			Name	Description
	--------------	------	----------------------------------
	05/10/2004		DMW		Created
	14/03/2008		MF		Updated for SQL 2005
	01/05/2008		MF		Amend query to id bulk data cols to include
							varchar(4000), nvarchar(4000), varchar(max),
							nvarchar(max), text
	12/11/2009		DS		Amend to handle bulk data with > 3 columns per row in bulk field
*/

AS
BEGIN

	CREATE TABLE #BulkData (
		UniqueID	VARCHAR(50) 	NOT NULL,
		row_id		INT				NOT NULL,
		col_id		INT				NOT NULL,
		datatype	VARCHAR(2)		NULL,
		value_txt	VARCHAR(500)	NULL,
		value_date	DATETIME		NULL,
		value_num	NUMERIC(28,6)	NULL)

	-- Loop through text fields in source table

	DECLARE	@text_field VARCHAR(50)
	DECLARE text_fields CURSOR FOR
		SELECT c.name AS column_name
		FROM sys.columns AS c 
		JOIN sys.types AS t ON c.user_type_id = t.user_type_id
		WHERE c.object_id = OBJECT_ID(@SourceTable)
		AND ((t.name = 'varchar' and (c.max_length >= 4000 or c.max_length = -1))
		OR (t.name = 'nvarchar' and (c.max_length >= 4000 or c.max_length = -1))
		OR t.name = 'text')

	OPEN	text_fields

	FETCH NEXT FROM text_fields INTO @text_field

	WHILE @@FETCH_STATUS = 0
	BEGIN

		-- Parse bulk data field
		INSERT	#BulkData
		EXEC	USP_ConvertBloombergBulkDataField @SourceTable, @UniqueIDField, @text_field

		-- Update permanent table
		DELETE	B
		FROM	T_BPS_DVD_BULKDATA B
				INNER JOIN #BulkData T 
						ON B.UniqueID = T.UniqueID 
						AND B.FieldMnemonic = @text_field

		INSERT	T_BPS_DVD_BULKDATA (
			UniqueID,
			FieldMnemonic,
			RowID,
			ColID,
			Datatype,
			ValueText,
			ValueNumeric,
			ValueDate
			)
		SELECT	UniqueID,
			@text_field,
			row_id,
			col_id,
			CONVERT(int, datatype),
			value_txt,
			value_num,
			value_date
		FROM	#BulkData
		WHERE	datatype IS NOT NULL

		DELETE	#BulkData
		FETCH NEXT FROM text_fields INTO @text_field
	END

	CLOSE	text_fields
	DEALLOCATE text_fields

	DROP TABLE #BulkData
END


