CREATE PROCEDURE [CADIS_SYS].[SPDM_UPDATE_INPUTS]
(
	@MatchPointId int,
	@Name nvarchar(260)
)	
AS
BEGIN
	-- update inputs if name has changed
	SET NOCOUNT OFF
	declare	@srcid	int
	declare	@src	nvarchar(50)
	declare	csr
	cursor
	FOR	SELECT	SOURCEID,LONGNAME
		FROM	CADIS_SYS.DM_SOURCE
		WHERE	MATCHPOINTID = @MatchPointId
		AND	OBSOLETE = 0
	open 	csr
	fetch 	next 
	from 	csr
	into 	@srcid, @src
	while (@@fetch_status=0)
	begin		
		EXEC	CADIS_SYS.SPCO_PROCESSINPUTUPD
				@InputId = @srcid ,
				@ProcessName = @Name ,
				@InputName = @src
		fetch 	next 
		from 	csr
		into 	@srcid, @src
	end
	close 		csr
	deallocate 	csr
END
