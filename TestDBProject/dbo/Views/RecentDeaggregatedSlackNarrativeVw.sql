
CREATE VIEW [dbo].[RecentDeaggregatedSlackNarrativeVw]
-------------------------------------------------------------------------------------- 
-- Name:			dbo.RecentDeaggregatedSlackNarrativeVw
-- 
-- Note:			Thisis  intended to be a temporary
--					solution until Manywho is capable of requesting a function.  Then
--					we will return only the data they want, rather than actualizing a huge
--					slice of data for them to consume.
--					
-- 
-- Author:			W.Stubbs
-- Date:			16/01/2018
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		This contains the actualized results of dbo.usp_RefreshRecentDeaggregatedSlackNarrative
-------------------------------------------------------------------------------------- 
AS

SELECT * FROM dbo.T_RecentDeaggregatedSlackNarrative
