﻿CREATE VIEW "CADIS"."VW_T_PKGD_FILE_UPLOADED"
AS
SELECT * FROM T_PKGD_FILE
WHERE [STATUS] = 'UPLOADED'
