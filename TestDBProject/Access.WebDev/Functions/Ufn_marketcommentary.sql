
CREATE FUNCTION [Access.WebDev].[Ufn_marketcommentary] 
--select * from  [Access.WebDev].[ufn_MarketCommentary](null) 
(@CommentaryDate DATE = NULL) 
returns @Output TABLE ( 
  [commentaryid]        [INT] NULL, 
  [commentarydate]      [DATETIME] NULL, 
  [AsAtDate]			[DATETIME] NULL, 
  [AsofDate]			[DATETIME] NULL, 
  [weifcod]             [DECIMAL](19, 5) NULL, 
  [benchmarkcod]        [DECIMAL](19, 5) NULL, 
  [wimiffcod]           [DECIMAL](19, 5) NULL, 
  [wimiffbenchmarkcod]  [DECIMAL](19, 5) NULL, 
  [wpctcod]             [DECIMAL](19, 5) NULL, 
  [sharepriceclose]     [DECIMAL](19, 5) NULL, 
  [navclose]            [DECIMAL](19, 5) NULL, 
  [commentary]          [NVARCHAR](max) NULL, 
  [contrib1namewimeif]  [NVARCHAR](255) NULL, 
  [contrib1valuewimeif] [DECIMAL](19, 5) NULL, 
  [contrib1namewimiff]  [NVARCHAR](255) NULL, 
  [contrib1valuewimiff] [DECIMAL](19, 5) NULL, 
  [contrib2namewimeif]  [NVARCHAR](255) NULL, 
  [contrib2valuewimeif] [DECIMAL](19, 5) NULL, 
  [contrib2namewimiff]  [NVARCHAR](255) NULL, 
  [contrib2valuewimiff] [DECIMAL](19, 5) NULL, 
  [contrib3namewimeif]  [NVARCHAR](255) NULL, 
  [contrib3valuewimeif] [DECIMAL](19, 5) NULL, 
  [contrib3namewimiff]  [NVARCHAR](255) NULL, 
  [contrib3valuewimiff] [DECIMAL](19, 5) NULL, 
  [contrib4namewimeif]  [NVARCHAR](255) NULL, 
  [contrib4valuewimeif] [DECIMAL](19, 5) NULL, 
  [contrib4namewimiff]  [NVARCHAR](255) NULL, 
  [contrib4valuewimiff] [DECIMAL](19, 5) NULL, 
  [contrib5namewimeif]  [NVARCHAR](255) NULL, 
  [contrib5valuewimeif] [DECIMAL](19, 5) NULL, 
  [contrib5namewimiff]  [NVARCHAR](255) NULL, 
  [contrib5valuewimiff] [DECIMAL](19, 5) NULL, 
  [laggard1namewimeif]  [NVARCHAR](255) NULL, 
  [laggard1valuewimeif] [DECIMAL](19, 5) NULL, 
  [laggard1namewimiff]  [NVARCHAR](255) NULL, 
  [laggard1valuewimiff] [DECIMAL](19, 5) NULL, 
  [laggard2namewimeif]  [NVARCHAR](255) NULL, 
  [laggard2valuewimeif] [DECIMAL](19, 5) NULL, 
  [laggard2namewimiff]  [NVARCHAR](255) NULL, 
  [laggard2valuewimiff] [DECIMAL](19, 5) NULL, 
  [laggard3namewimeif]  [NVARCHAR](255) NULL, 
  [laggard3valuewimeif] [DECIMAL](19, 5) NULL, 
  [laggard3namewimiff]  [NVARCHAR](255) NULL, 
  [laggard3valuewimiff] [DECIMAL](19, 5) NULL, 
  [laggard4namewimeif]  [NVARCHAR](255) NULL, 
  [laggard4valuewimeif] [DECIMAL](19, 5) NULL, 
  [laggard4namewimiff]  [NVARCHAR](255) NULL, 
  [laggard4valuewimiff] [DECIMAL](19, 5) NULL, 
  [laggard5namewimeif]  [NVARCHAR](255) NULL, 
  [laggard5valuewimeif] [DECIMAL](19, 5) NULL, 
  [laggard5namewimiff]  [NVARCHAR](255) NULL, 
  [laggard5valuewimiff] [DECIMAL](19, 5) NULL ) 
AS 
  --------------------------------------------------------------------------------------  
  -- Name:      [Investment].[ufn_MarketCommentary] 
  --  
  -- Params:       
  --  
  --------------------------------------------------------------------------------------  
  -- History:       
  -- WHO        WHEN        WHY 
  -- R.DIXON:    25/10/2017      Existing version 
  --R.DIXON:    25/10/2017      DAP-1406 amended to only return daily commentary 
  --OLU       04/10/2018           DAP-2325 Add AsAtDate and AsOfDate 
  --  
  --------------------------------------------------------------------------------------  
  BEGIN 
      IF @CommentaryDate IS NULL 
        SET @CommentaryDate = (SELECT Max(Cast(commentarydate AS DATE)) 
                               FROM   [Investment].[marketcommentary] 
                               WHERE  commentarytype = 'Daily'); 

      INSERT INTO @Output 
                  ([commentaryid], 
                   [commentarydate], 
				   [AsofDate],
                   [weifcod], 
                   [benchmarkcod], 
                   [wimiffcod], 
                   [wimiffbenchmarkcod], 
                   [wpctcod], 
                   [sharepriceclose], 
                   [navclose], 
                   [commentary], 
                   [contrib1namewimeif], 
                   [contrib1valuewimeif], 
                   [contrib1namewimiff], 
                   [contrib1valuewimiff], 
                   [contrib2namewimeif], 
                   [contrib2valuewimeif], 
                   [contrib2namewimiff], 
                   [contrib2valuewimiff], 
                   [contrib3namewimeif], 
                   [contrib3valuewimeif], 
                   [contrib3namewimiff], 
                   [contrib3valuewimiff], 
                   [contrib4namewimeif], 
                   [contrib4valuewimeif], 
                   [contrib4namewimiff], 
                   [contrib4valuewimiff], 
                   [contrib5namewimeif], 
                   [contrib5valuewimeif], 
                   [contrib5namewimiff], 
                   [contrib5valuewimiff], 
                   [laggard1namewimeif], 
                   [laggard1valuewimeif], 
                   [laggard1namewimiff], 
                   [laggard1valuewimiff], 
                   [laggard2namewimeif], 
                   [laggard2valuewimeif], 
                   [laggard2namewimiff], 
                   [laggard2valuewimiff], 
                   [laggard3namewimeif], 
                   [laggard3valuewimeif], 
                   [laggard3namewimiff], 
                   [laggard3valuewimiff], 
                   [laggard4namewimeif], 
                   [laggard4valuewimeif], 
                   [laggard4namewimiff], 
                   [laggard4valuewimiff], 
                   [laggard5namewimeif], 
                   [laggard5valuewimeif], 
                   [laggard5namewimiff], 
                   [laggard5valuewimiff], 
                   [AsAtDate]) 
      SELECT x.[commentaryid], 
             [commentarydate], 
			 [commentarydate],
             [weifcod], 
             [benchmarkcod], 
             [wimiffcod], 
             [wimiffbenchmarkcod], 
             [wpctcod], 
             [sharepriceclose], 
             [navclose], 
             [commentary], 
             ec1_EIF.[securityname]  AS [Contrib1NameWIMEIF], 
             ec1_EIF.[securityvalue] AS [Contrib1ValueWIMEIF], 
             ec1_IFF.[securityname]  AS [Contrib1NameWIMIFF], 
             ec1_IFF.[securityvalue] AS [Contrib1ValueWIMIFF], 
             ec2_EIF.[securityname]  AS [Contrib2NameWIMEIF], 
             ec2_EIF.[securityvalue] AS [Contrib2ValueWIMEIF], 
             ec2_IIF.[securityname]  AS [Contrib2NameWIMIFF], 
             ec2_IIF.[securityvalue] AS [Contrib2ValueWIMIFF], 
             ec3_EIF.[securityname]  AS [Contrib3NameWIMEIF], 
             ec3_EIF.[securityvalue] AS [Contrib3ValueWIMEIF], 
             ec3_IIF.[securityname]  AS [Contrib3NameWIMIFF], 
             ec3_IIF.[securityvalue] AS [Contrib3ValueWIMIFF], 
             ec4_EIF.[securityname]  AS [Contrib4NameWIMEIF], 
             ec4_EIF.[securityvalue] AS [Contrib4ValueWIMEIF], 
             ec4_IIF.[securityname]  AS [Contrib4NameWIMIFF], 
             ec4_IIF.[securityvalue] AS [Contrib4ValueWIMIFF], 
             ec5_EIF.[securityname]  AS [Contrib5NameWIMEIF], 
             ec5_EIF.[securityvalue] AS [Contrib5ValueWIMEIF], 
             ec5_IIF.[securityname]  AS [Contrib5NameWIMIFF], 
             ec5_IIF.[securityvalue] AS [Contrib5ValueWIMIFF], 
             el1_EIF.[securityname]  AS [Laggard1NameWIMEIF], 
             el1_EIF.[securityvalue] AS [Laggard1ValueWIMEIF], 
             el1_IFF.[securityname]  AS [Laggard1NameWIMIFF], 
             el1_IFF.[securityvalue] AS [Laggard1ValueWIMIFF], 
             el2_EIF.[securityname]  AS [Laggard2NameWIMEIF], 
             el2_EIF.[securityvalue] AS [Laggard2ValueWIMEIF], 
             el2_IFF.[securityname]  AS [Laggard2NameWIMIFF], 
             el2_IFF.[securityvalue] AS [Laggard2ValueWIMIFF], 
             el3_EIF.[securityname]  AS [Laggard3NameWIMEIF], 
             el3_EIF.[securityvalue] AS [Laggard3ValueWIMEIF], 
             el3_IFF.[securityname]  AS [Laggard3NameWIMIFF], 
             el3_IFF.[securityvalue] AS [Laggard3ValueWIMIFF], 
             el4_EIF.[securityname]  AS [Laggard4NameWIMEIF], 
             el4_EIF.[securityvalue] AS [Laggard4ValueWIMEIF], 
             el4_IFF.[securityname]  AS [Laggard4NameWIMIFF], 
             el4_IFF.[securityvalue] AS [Laggard4ValueWIMIFF], 
             el5_EIF.[securityname]  AS [Laggard5NameWIMEIF], 
             el5_EIF.[securityvalue] AS [Laggard5ValueWIMEIF], 
             el5_IFF.[securityname]  AS [Laggard5NameWIMIFF], 
             el5_IFF.[securityvalue] AS [Laggard5ValueWIMIFF], 
             Maxcd.latestupdatedate 
      FROM   [Investment].[marketcommentary] x 
             INNER JOIN (SELECT Max([commentarydate])     AS 
                                LatestCommentaryDate, 
                                Max(cadis_system_updated) AS [LatestUpdateDate] 
                         FROM   [Investment].[marketcommentary] 
                         WHERE  Cast([commentarydate] AS DATE) = @CommentaryDate 
                                AND commentarytype = 'Daily') Maxcd 
                     ON x.commentarydate = Maxcd.latestcommentarydate 
             LEFT JOIN [Investment].[marketcommentaryevents] ec1_EIF 
                    ON x.commentaryid = ec1_EIF.commentaryid 
                       AND ec1_EIF.rank = 1 
                       AND ec1_EIF.eventtype = 'Contributor' 
                       AND ec1_EIF.fund = 'WIMEIF' 
             LEFT JOIN [Investment].[marketcommentaryevents] ec1_IFF 
                    ON x.commentaryid = ec1_IFF.commentaryid 
                       AND ec1_IFF.rank = 1 
                       AND ec1_IFF.eventtype = 'Contributor' 
                       AND ec1_IFF.fund = 'WIMIFF' 
             LEFT JOIN [Investment].[marketcommentaryevents] ec2_EIF 
                    ON x.commentaryid = ec2_EIF.commentaryid 
                       AND ec2_EIF.rank = 2 
                       AND ec2_EIF.eventtype = 'Contributor' 
                       AND ec2_EIF.fund = 'WIMEIF' 
             LEFT JOIN [Investment].[marketcommentaryevents] ec2_IIF 
                    ON x.commentaryid = ec2_IIF.commentaryid 
                       AND ec2_IIF.rank = 2 
                       AND ec2_IIF.eventtype = 'Contributor' 
                       AND ec2_IIF.fund = 'WIMIFF' 
             LEFT JOIN [Investment].[marketcommentaryevents] ec3_EIF 
                    ON x.commentaryid = ec3_EIF.commentaryid 
                       AND ec3_EIF.rank = 3 
                       AND ec3_EIF.eventtype = 'Contributor' 
                       AND ec3_EIF.fund = 'WIMEIF' 
             LEFT JOIN [Investment].[marketcommentaryevents] ec3_IIF 
                    ON x.commentaryid = ec3_IIF.commentaryid 
                       AND ec3_IIF.rank = 3 
                       AND ec3_IIF.eventtype = 'Contributor' 
                       AND ec3_IIF.fund = 'WIMIFF' 
             LEFT JOIN [Investment].[marketcommentaryevents] ec4_EIF 
                    ON x.commentaryid = ec4_EIF.commentaryid 
                       AND ec4_EIF.rank = 4 
                       AND ec4_EIF.eventtype = 'Contributor' 
                       AND ec4_EIF.fund = 'WIMEIF' 
             LEFT JOIN [Investment].[marketcommentaryevents] ec4_IIF 
                    ON x.commentaryid = ec4_IIF.commentaryid 
                       AND ec4_IIF.rank = 4 
                       AND ec4_IIF.eventtype = 'Contributor' 
                       AND ec4_IIF.fund = 'WIMIFF' 
             LEFT JOIN [Investment].[marketcommentaryevents] ec5_EIF 
                    ON x.commentaryid = ec5_EIF.commentaryid 
                       AND ec5_EIF.rank = 5 
                       AND ec5_EIF.eventtype = 'Contributor' 
                       AND ec5_EIF.fund = 'WIMEIF' 
             LEFT JOIN [Investment].[marketcommentaryevents] ec5_IIF 
                    ON x.commentaryid = ec5_IIF.commentaryid 
                       AND ec5_IIF.rank = 5 
                       AND ec5_IIF.eventtype = 'Contributor' 
                       AND ec5_IIF.fund = 'WIMIFF' 
             LEFT JOIN [Investment].[marketcommentaryevents] el1_EIF 
                    ON x.commentaryid = el1_EIF.commentaryid 
                       AND el1_EIF.rank = 1 
                       AND el1_EIF.eventtype = 'Laggard' 
                       AND el1_EIF.fund = 'WIMEIF' 
             LEFT JOIN [Investment].[marketcommentaryevents] el1_IFF 
                    ON x.commentaryid = el1_IFF.commentaryid 
                       AND el1_IFF.rank = 1 
                       AND el1_IFF.eventtype = 'Laggard' 
                       AND el1_IFF.fund = 'WIMIFF' 
             LEFT JOIN [Investment].[marketcommentaryevents] el2_EIF 
                    ON x.commentaryid = el2_EIF.commentaryid 
                       AND el2_EIF.rank = 2 
                       AND el2_EIF.eventtype = 'Laggard' 
                       AND el2_EIF.fund = 'WIMEIF' 
             LEFT JOIN [Investment].[marketcommentaryevents] el2_IFF 
                    ON x.commentaryid = el2_IFF.commentaryid 
                       AND el2_IFF.rank = 2 
                       AND el2_IFF.eventtype = 'Laggard' 
                       AND el2_IFF.fund = 'WIMIFF' 
             LEFT JOIN [Investment].[marketcommentaryevents] el3_EIF 
                    ON x.commentaryid = el3_EIF.commentaryid 
                       AND el3_EIF.rank = 3 
                       AND el3_EIF.eventtype = 'Laggard' 
                       AND el3_EIF.fund = 'WIMEIF' 
             LEFT JOIN [Investment].[marketcommentaryevents] el3_IFF 
                    ON x.commentaryid = el3_IFF.commentaryid 
                       AND el3_IFF.rank = 3 
                       AND el3_IFF.eventtype = 'Laggard' 
                       AND el3_IFF.fund = 'WIMIFF' 
             LEFT JOIN [Investment].[marketcommentaryevents] el4_EIF 
                    ON x.commentaryid = el4_EIF.commentaryid 
                       AND el4_EIF.rank = 4 
                       AND el4_EIF.eventtype = 'Laggard' 
                       AND el4_EIF.fund = 'WIMEIF' 
             LEFT JOIN [Investment].[marketcommentaryevents] el4_IFF 
                    ON x.commentaryid = el4_IFF.commentaryid 
                       AND el4_IFF.rank = 4 
                       AND el4_IFF.eventtype = 'Laggard' 
                       AND el4_IFF.fund = 'WIMIFF' 
             LEFT JOIN [Investment].[marketcommentaryevents] el5_EIF 
                    ON x.commentaryid = el5_EIF.commentaryid 
                       AND el5_EIF.rank = 5 
                       AND el5_EIF.eventtype = 'Laggard' 
                       AND el5_EIF.fund = 'WIMEIF' 
             LEFT JOIN [Investment].[marketcommentaryevents] el5_IFF 
                    ON x.commentaryid = el5_IFF.commentaryid 
                       AND el5_IFF.rank = 5 
                       AND el5_IFF.eventtype = 'Laggard' 
                       AND el5_IFF.fund = 'WIMIFF' 
      WHERE  x.commentarytype = 'Daily' 

      RETURN 
  END 