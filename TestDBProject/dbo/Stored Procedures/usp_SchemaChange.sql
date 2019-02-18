--EXEC sp_rename 'dbo.users', 'customers'
--GO 
--CREATE SYNONYM dbo.users FOR customers
--GO

--declare @sql varchar(8000), @table varchar(1000), @oldschema varchar(1000), @newschema varchar(1000)

--set @oldschema = 'Staging.Matrix.'
--set @newschema = 'Staging'

--while exists(select * from sys.tables where schema_name(schema_id) = @oldschema)
--begin
--select @table = name from sys.tables 
--where object_id in(select min(object_id) from sys.tables where schema_name(schema_id) = @oldschema)

--set @sql = 'alter schema ' + @newschema + ' transfer ' + @oldschema + '.' + @table

--Print(@sql)
--END
----PRINT	
CREATE PROCEDURE dbo.usp_SchemaChange

@oldschema VARCHAR(100),
@newschema VARCHAR(100)

AS	

declare @sql varchar(MAx),  @sql1 varchar(MAX)
--@oldschema varchar(1000), @newschema varchar(1000)
--set @oldschema = 'Olu_Staging'
--set @newschema = 'Olu'


SELECT 
	 'ALTER SCHEMA ' + @newschema + ' TRANSFER ' + '[' + s.Name + ']'  + '.' + o.Name  AS Schema_Change,
	 'CREATE SYNONYM  ' +  '[' + @oldschema +  + ']' + '.' + o.Name + ' FOR ' + @newschema + '.' +  o.Name  AS Create_Synonym
	 
FROM
      sys.Objects AS o 
INNER JOIN 
      sys.Schemas AS s on o.schema_id = s.schema_id 
WHERE 
      s.Name = @oldschema
      And (o.Type = 'U' Or o.Type = 'P' Or o.Type = 'V' OR  o.TYPE  = 'F')
PRINT @sql
--PRINT @sql1

--EXEC dbo.usp_SchemaChange 'Olu_Staging', 'Olu'


