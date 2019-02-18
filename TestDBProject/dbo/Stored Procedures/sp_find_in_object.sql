

CREATE PROC dbo.sp_find_in_object (@Text VARCHAR(255) = NULL)
/******************************
** Desc: system proc - Search for a string in a DB object. WON'T return encrypted objects 
** Auth: R. Walker
** Date: 17/04/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** NA		   17/04/2018  R.Walker	Initial version of view
******************************/
AS

	--sp_find_in_object 'Benchmark'
 
IF @Text IS NULL
BEGIN
	PRINT 'No search string specified'
	RETURN;
END

SET @Text = '%' + @Text + '%'

SELECT 
    o.name, 
    o.id, 
    c.text,
    o.type
FROM 
    sysobjects o 
RIGHT JOIN syscomments c 
    ON o.id = c.id 
WHERE 
    c.text like @Text

