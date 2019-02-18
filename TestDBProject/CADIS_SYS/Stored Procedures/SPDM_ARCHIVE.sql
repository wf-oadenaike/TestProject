CREATE  PROCEDURE "CADIS_SYS"."SPDM_ARCHIVE" @RunId INT, @AuditDuration INT, @ArchiveDuration INT, @TimePeriod INT   
--WITH ENCRYPTION
AS
declare @auditview varchar(50), @Audittable  varchar(50)
--declare @ArchiveTableName varchar(50), @ArchiveTable varchar(50), @QualifiedArchiveTableName varchar(50), @Year int
declare @return int, @proc sysname, @errmsg varchar(1024), @Desc varchar(1024)
declare @AuditDate varchar(50), @ArchiveDate varchar(50)
declare @mpids varchar(20), @SQL varchar(8000), @longname varchar(260)
--Initialise variables
set @return = 0
if @TimePeriod = 0
	Begin
		set @AuditDate = '''' + convert(varchar,dateadd(m,0-@AuditDuration, getdate()),113) + ''''
		set @ArchiveDate = '''' + convert(varchar,dateadd(m,0-@ArchiveDuration, getdate()),113) + ''''	
	End
else
	Begin
		set @AuditDate = '''' + convert(varchar,dateadd(d,0-@AuditDuration, getdate()),113) + ''''
		set @ArchiveDate = '''' + convert(varchar,dateadd(d,0-@ArchiveDuration, getdate()),113) + ''''		
	End
-- log start
exec cadis_sys.spLogInfo @RunId, 'Starting DataMatcher Archive process'
-- process all matchpoints
declare	csr_mp
	cursor for
		select 	[NAME], convert(varchar,IDENTIFIER) 
		from	CADIS_SYS.DM_MATCHPOINT
		where	OBSOLETE = 0
open csr_mp
fetch next from csr_mp into @longname, @mpids
while @@fetch_status = 0
begin
	set @Desc = 'Starting Archive of DataMatcher process: ' + @longname + ' (' + @mpids + ')'
	exec cadis_sys.spLogInfo @RunId, @desc
	set @audittable = 'CADIS_PROC.DM_MP' + @mpids + '_RESULT_AUDIT'
	--Check table exists
	if exists(select * from dbo.sysobjects where id = object_id(@audittable) and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	begin
		--Check for records that need archiving
		Set @SQL = '	
		DECLARE @Year as integer
		DECLARE @ArchiveTableName as varchar(50), @ArchiveTable as varchar(50), @QualifiedArchiveTableName as varchar(50) 
		if exists(select 1 from ' + @audittable + ' where AuditDate < ' + @AuditDate + ')
		'
		--Determine if need to archive or just delete.
		if @ArchiveDuration = 0 
		begin 
			--Delete as no archive being kept
			Set @SQL = @SQL + '
			delete from ' + @audittable + ' where AUDITDATE < ' + @AuditDate + '
			'
		end
		else
		begin
			--Populate archive table(s), creating if required
			Set @SQL = @SQL + '
			begin
				declare csr_archivename cursor for 
				select distinct datepart(yyyy, auditdate) from ' + @audittable + '
				where auditdate < ' + @AuditDate + '
				OPEN csr_archivename
				FETCH NEXT FROM csr_archivename into @Year
				WHILE @@FETCH_STATUS = 0
				begin
					Set @ArchiveTableName = ''DM_MP' + @mpids + '_RESULT_ARCHIVE_'' + convert(varchar, @Year)
		 			Set @QualifiedArchiveTableName = ''CADIS_PROC.'' + @ArchiveTableName
					if not exists(select * from dbo.sysobjects where id = object_id(@QualifiedArchiveTableName) 
					and OBJECTPROPERTY(id, N''IsUserTable'') = 1)
					begin
		 				CREATE TABLE CADIS_PROC.DM_TEMP_ARCHIVE
		 				([AUDITDATE] [datetime] NOT NULL ,
		 				[SOURCEID] [int] NOT NULL ,
		 				[SOURCEROWID] [int] NOT NULL ,
		 				[RESULTID] [int] NOT NULL,
		 				[CADISID] [int] NOT NULL,
		 				[PRIORITY] [tinyint] NOT NULL,
		 				[RULEID] [int] NOT NULL,
		 				[PROVISIONAL] [tinyint] NOT NULL,
		 				[INSERTED] [datetime] NOT NULL,
		 				[UPDATED] [datetime] NOT NULL,
		 				[CHANGEDBY] [nvarchar] (100) NOT NULL,
		 				[ARCHIVE_DATE] [datetime] NOT NULL )
		 			end 
		 			else
					begin
		 				EXEC sp_rename @QualifiedArchiveTableName, ''DM_TEMP_ARCHIVE''
		 			end
		 			INSERT INTO CADIS_PROC.DM_TEMP_ARCHIVE 
							(AUDITDATE, SOURCEID, SOURCEROWID, RESULTID, CADISID, 
								PRIORITY, RULEID, PROVISIONAL, INSERTED, UPDATED, CHANGEDBY, ARCHIVE_DATE)
			 			Select AUDITDATE, SOURCEID, SOURCEROWID, RESULTID, CADISID, PRIORITY, RULEID, PROVISIONAL, 
								INSERTED, UPDATED, CHANGEDBY, getdate() 
						from ' + @audittable + '
						where AUDITDATE < ' + @AuditDate + '
						and datepart(yyyy, AUDITDATE) = @Year
					EXEC sp_rename ''CADIS_PROC.DM_TEMP_ARCHIVE'', @ArchiveTableName
			'
		 	--Remove records moved into Archive from Audit
			Set @SQL = @SQL + '
		 			delete from ' + @audittable + '
					where AUDITDATE < ' + @AuditDate + '
					and datepart(yyyy, AUDITDATE) = @Year
					FETCH NEXT FROM csr_archivename into @Year
				end
		 		close csr_archivename
		 		DeAllocate csr_archivename
			end
			'
		end
		--Check if archive table needs deletions do here
		--exec cadis_sys.spLogInfo @RunId , 'Starting deletion from Archive for DataMatcher'
		Set @SQL = @SQL + '
			declare csr_Archive cursor for 
			select name from dbo.sysobjects where name like ''DM[_]MP' + @mpids + '[_]RESULT[_]ARCHIVE[_]%'' and OBJECTPROPERTY(id, N''IsUserTable'') = 1
			OPEN csr_Archive
			FETCH NEXT FROM csr_Archive into @ArchiveTable
			WHILE @@FETCH_STATUS = 0
			begin
				SET @QualifiedArchiveTableName = ''CADIS_PROC.'' + @ArchiveTable
			 	EXEC sp_rename @QualifiedArchiveTableName, ''DM_TEMP_ARCHIVE_DEL''
		 		delete from CADIS_PROC.DM_TEMP_ARCHIVE_DEL 
				where ARCHIVE_DATE < ' + @ArchiveDate + '
				EXEC sp_rename ''CADIS_PROC.DM_TEMP_ARCHIVE_DEL'', @ArchiveTable
			 	FETCH NEXT FROM csr_Archive into @ArchiveTable
			end
		 	close csr_Archive
	 		DeAllocate csr_Archive
		'
	--	Print(@SQL)
		Execute (@SQL)	
		/*****Check for errors*****/ select @return=@@error,@errmsg='Archiving for DM: ' + @longname if (@return<>0) goto TheEnd 
	end
	else
	begin
		set @Desc = 'Audit table (' + @audittable + ') does not exist for DataMatcher process: ' + @longname + ' (' + @mpids + ')'
		exec cadis_sys.spLogWarning @RunId, @Desc
	end
	set @Desc = 'Finished Archive of DataMatcher process: ' + @longname + ' (' + @mpids + ')'
	exec cadis_sys.spLogInfo @RunId, @Desc
	fetch next from csr_mp into @longname, @mpids
end
close csr_mp
DeAllocate csr_mp
DECLARE @compid int
SELECT @compid = ID FROM CADIS_SYS.CO_COMPONENT WHERE NAME = 'DataMatcherProcess'
exec CADIS_SYS.SPCO_ARCHIVE_LOG @compid, @RunId, @AuditDuration, @ArchiveDuration, @TimePeriod
SELECT @compid = ID FROM CADIS_SYS.CO_COMPONENT WHERE NAME = 'DataMatcherIdGenerator'
exec CADIS_SYS.SPCO_ARCHIVE_LOG @compid, @RunId, @AuditDuration, @ArchiveDuration, @TimePeriod
exec cadis_sys.spLogInfo @RunId, 'DataMatcher Archive Process completed successfully'
TheEnd:
if (@return <> 0)
begin
	select	@proc = name from sysobjects where id = @@PROCID
	set	@errmsg = 'Error occured in procedure ' + @proc + ',error = ' + str(@return) + ':(' + isnull(@errmsg,'') + ')'
	EXEC CADIS_SYS.SPLOGERROR @RunId, @errmsg
	raiserror (@errmsg, 16, 1)
end
return (@return)
