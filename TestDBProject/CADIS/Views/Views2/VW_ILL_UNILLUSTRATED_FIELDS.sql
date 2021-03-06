﻿CREATE VIEW CADIS.VW_ILL_UNILLUSTRATED_FIELDS
--WITH ENCRYPTION--cadisbuild
AS
  SELECT ILT.NAME AS TEMPLATE_NAME, ILL.NAME AS ILLUSTRATOR_NAME,  IFLDS.ILLFIELDNAME AS UNILLUSTRATED_NAME
  FROM
  [CADIS_SYS].[IL_ILLUSTRATORFIELDS] IFLDS
  JOIN CADIS_SYS.VW_ALL_PROCESSES ILL ON ILL.IDENTIFIER = IFLDS.ILLUSTRATORID AND ILL.COMPONENTID=6
  JOIN CADIS_SYS.VW_ALL_PROCESSES ILT ON ILT.IDENTIFIER = IFLDS.TEMPLATEID AND ILT.COMPONENTID=7
  WHERE IFLDS.TEMPLATEFIELDNAME IS NULL
