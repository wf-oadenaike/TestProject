
CREATE  proc runsql @rsql nvarchar(1000)  with execute as 'rdsadmin'
as
print @rsql
exec ( @rsql  )