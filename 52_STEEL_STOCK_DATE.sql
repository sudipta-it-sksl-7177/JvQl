USE `erpdb`;

DROP PROCEDURE IF EXISTS  `SpSteelStockDate`;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SpSteelStockDate`(
	V_DATE	CHAR(10),
	V_JOB	CHAR(2)
	)
BEGIN
#	CALL SpSteelStockDate('2019/01/31','02');

DECLARE	V_PROJCD	CHAR(4);
DECLARE	V_FINYR		CHAR(4);
DECLARE	V_ST_DT		CHAR(10);
DECLARE	V_CD_RO		CHAR(2);
DECLARE	V_CD_IO		CHAR(2);
DECLARE	V_CD_RP		CHAR(2);
DECLARE	V_CD_IP		CHAR(2);
DECLARE	V_CD_RC		CHAR(2);
DECLARE	V_CD_IC		CHAR(2);
DECLARE	V_CD_RA		CHAR(2);

DECLARE	V_BIL_PROD	CHAR(8);
DECLARE	V_TMT_PROD_08	CHAR(8);
DECLARE	V_TMT_PROD_10	CHAR(8);
DECLARE	V_TMT_PROD_12	CHAR(8);
DECLARE	V_TMT_PROD_16	CHAR(8);
DECLARE	V_TMT_PROD_20	CHAR(8);
DECLARE	V_TMT_PROD_25	CHAR(8);
DECLARE	V_TMT_PROD_28	CHAR(8);
DECLARE	V_TMT_PROD_32	CHAR(8);
DECLARE	V_MR_PROD	CHAR(8);
DECLARE	V_MS_PROD	CHAR(8);
DECLARE	V_EC_PROD	CHAR(8);
DECLARE	V_SC_PROD	CHAR(8);
DECLARE	V_FOILCD	CHAR(8);
DECLARE	V_POWERCD	CHAR(8);

DECLARE	V_PARTY_C	CHAR(5);
DECLARE	V_PARTY_SP	CHAR(5);
DECLARE	V_PARTY_TR1	CHAR(5);
DECLARE	V_PARTY_TR2	CHAR(5);

DECLARE	V_TMT_GRP	CHAR(4);
DECLARE	V_MR_GRP	CHAR(4);
DECLARE	V_MS_GRP	CHAR(4);
DECLARE	V_EC_GRP	CHAR(4);
DECLARE	V_SC_GRP	CHAR(4);

SET	V_PROJCD='201';
SET	V_BIL_PROD='1001011';
SET	V_TMT_PROD_08='1002002';
SET	V_TMT_PROD_10='1002003';
SET	V_TMT_PROD_12='1002004';
SET	V_TMT_PROD_16='1002005';
SET	V_TMT_PROD_20='1002006';
SET	V_TMT_PROD_25='1002007';
SET	V_TMT_PROD_28='1002008';
SET	V_TMT_PROD_32='1002009';
SET	V_MR_PROD='1003001';
SET	V_MS_PROD='1004001';
SET	V_EC_PROD='1005001';
SET	V_SC_PROD='1006001';
SET	V_FOILCD='1001018';
SET	V_POWERCD='1001017';

SET	V_PARTY_C='M414';
SET	V_PARTY_SP='S1301';
SET	V_PARTY_TR1='S1307';
SET	V_PARTY_TR2='S1321';

SET	V_TMT_GRP='1002';
SET	V_MR_GRP='1003';
SET	V_MS_GRP='1004';
SET	V_EC_GRP='1005';
SET	V_SC_GRP='1006';

SET	V_CD_RO='RO';
SET	V_CD_IO='IO';
SET	V_CD_RP='RP';
SET	V_CD_IP='IP';
SET	V_CD_RC='RC';
SET	V_CD_IC='IC';
SET	V_CD_RA='RA';

DROP TEMPORARY TABLE IF EXISTS `TmpStock`;
CREATE TEMPORARY TABLE `TmpStock` (
  `JOB` char(2) NOT NULL default '',
  `BILETOP` decimal(14,4) NOT NULL default '0.0000',
  `TMT08OP` decimal(14,4) NOT NULL default '0.0000',
  `TMT10OP` decimal(14,4) NOT NULL default '0.0000',
  `TMT12OP` decimal(14,4) NOT NULL default '0.0000',
  `TMT16OP` decimal(14,4) NOT NULL default '0.0000',
  `TMT20OP` decimal(14,4) NOT NULL default '0.0000',
  `TMT25OP` decimal(14,4) NOT NULL default '0.0000',
  `TMT28OP` decimal(14,4) NOT NULL default '0.0000',
  `TMT32OP` decimal(14,4) NOT NULL default '0.0000',
  `MROP` decimal(14,4) NOT NULL default '0.0000',
  `MSOP` decimal(14,4) NOT NULL default '0.0000',
  `ECOP` decimal(14,4) NOT NULL default '0.0000',
  `SCOP` decimal(14,4) NOT NULL default '0.0000',
  `BILETCUR` decimal(14,4) NOT NULL default '0.0000',
  `TMT08CUR` decimal(14,4) NOT NULL default '0.0000',
  `TMT10CUR` decimal(14,4) NOT NULL default '0.0000',
  `TMT12CUR` decimal(14,4) NOT NULL default '0.0000',
  `TMT16CUR` decimal(14,4) NOT NULL default '0.0000',
  `TMT20CUR` decimal(14,4) NOT NULL default '0.0000',
  `TMT25CUR` decimal(14,4) NOT NULL default '0.0000',
  `TMT28CUR` decimal(14,4) NOT NULL default '0.0000',
  `TMT32CUR` decimal(14,4) NOT NULL default '0.0000',
  `MRCUR` decimal(14,4) NOT NULL default '0.0000',
  `MSCUR` decimal(14,4) NOT NULL default '0.0000',
  `ECCUR` decimal(14,4) NOT NULL default '0.0000',
  `SCCUR` decimal(14,4) NOT NULL default '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET	V_FINYR=
	CASE	
		WHEN SUBSTRING(V_DATE,6,2) IN ('01','02','03') THEN CONCAT(RIGHT(CAST((LEFT(V_DATE,4)-1) AS CHAR(4)),2),SUBSTRING(V_DATE,3,2))
		ELSE CONCAT(SUBSTRING(V_DATE,3,2),RIGHT(CAST((LEFT(V_DATE,4)+1) AS CHAR(4)),2))
	END;
SET	V_ST_DT=CONCAT('20',LEFT(V_FINYR,2),'/04/01');

TRUNCATE TABLE	TmpStock;
INSERT INTO	TmpStock
SELECT		JOB,
		IFNULL(SUM(CASE WHEN ITEMCD=V_BIL_PROD AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS BILETOP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_08 AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS TMT08OP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_10 AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS TMT10OP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_12 AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS TMT12OP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_16 AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS TMT16OP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_20 AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS TMT20OP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_25 AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS TMT25OP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_28 AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS TMT28OP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_32 AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS TMT32OP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_MR_PROD AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS MROP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_MS_PROD AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS MSOP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_EC_PROD AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS ECOP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_SC_PROD AND VOCHDT<V_DATE THEN (OPQTY+(RCQTY+PRQTY+RAPQTY)-(ISQTY+SLQTY+RAMQTY+RATQTY)) ELSE 0 END),0) AS SCOP,
		IFNULL(SUM(CASE WHEN ITEMCD=V_BIL_PROD AND VOCHDT=V_DATE THEN ISQTY ELSE 0 END),0) AS BILETCUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_08 AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS TMT08CUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_10 AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS TMT10CUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_12 AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS TMT12CUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_16 AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS TMT16CUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_20 AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS TMT20CUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_25 AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS TMT25CUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_28 AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS TMT28CUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_TMT_PROD_32 AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS TMT32CUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_MR_PROD AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS MRCUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_MS_PROD AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS MSCUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_EC_PROD AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS ECCUR,
		IFNULL(SUM(CASE WHEN ITEMCD=V_SC_PROD AND VOCHDT=V_DATE THEN PRQTY ELSE 0 END),0) AS SCCUR
FROM
(
SELECT		JOB,
		ITEMCD,SUBDATE(CAST(V_ST_DT AS DATETIME),1) AS VOCHDT,
		OPQTY,0 AS RCQTY,0 AS ISQTY,0 AS PRQTY,
		0 AS SLQTY,0 AS RAPQTY,0 AS RAMQTY,0 AS RATQTY
FROM		MITOPBAL
WHERE		FINYR=V_FINYR
AND		PROJCD=V_PROJCD
AND		LENGTH(TRIM(ITEMCD))=7
AND		LEFT(TRIM(ITEMCD),3)='100'
AND		ITEMCD<>V_POWERCD
UNION ALL
SELECT		CASE WHEN VOCHCD=V_CD_RO THEN '01' ELSE '02' END AS JOB,
		ITEMCD,VOCHDT,
		0 AS OPQTY,QTY AS RCQTY,0 AS ISQTY,0 AS PRQTY,
		0 AS SLQTY,0 AS RAPQTY,0 AS RAMQTY,0 AS RATQTY
FROM		MRECEIPT
WHERE		PROJCD=V_PROJCD
AND		ITEMCD IN (V_BIL_PROD,V_FOILCD)
AND		VOCHCD IN (V_CD_RO,V_CD_RC)
AND		VOCHDT BETWEEN V_ST_DT AND V_DATE
UNION ALL
SELECT		CASE WHEN VOCHCD=V_CD_IO THEN '01' ELSE '02' END AS JOB,
		ITEMCD,VOCHDT,
		0 AS OPQTY,0 AS RCQTY,QTY AS ISQTY,0 AS PRQTY,
		0 AS SLQTY,0 AS RAPQTY,0 AS RAMQTY,0 AS RATQTY
FROM		MISSUE
WHERE		PROJCD=V_PROJCD
AND		ITEMCD IN (V_BIL_PROD,V_FOILCD)
AND		VOCHCD IN (V_CD_IO,V_CD_IC)
AND		VOCHDT BETWEEN V_ST_DT AND V_DATE
UNION ALL
SELECT		CASE WHEN VOCHCD=V_CD_RP THEN '01' ELSE '02' END AS JOB,
		ITEMCD,VOCHDT,
		0 AS OPQTY,0 AS RCQTY,0 AS ISQTY,QTY AS PRQTY,
		0 AS SLQTY,0 AS RAPQTY,0 AS RAMQTY,0 AS RATQTY
FROM		MRECEIPT
WHERE		PROJCD=V_PROJCD
AND		LENGTH(TRIM(ITEMCD))=7
AND		LEFT(TRIM(ITEMCD),4) IN (V_TMT_GRP,V_MR_GRP,V_MS_GRP,V_EC_GRP,V_SC_GRP)
AND		VOCHCD IN (V_CD_RP,V_CD_RC)
AND		VOCHDT BETWEEN V_ST_DT AND V_DATE
UNION ALL
SELECT		CASE WHEN VOCHCD=V_CD_IP THEN '01' ELSE '02' END AS JOB,
		ITEMCD,VOCHDT,
		0 AS OPQTY,0 AS RCQTY,0 AS ISQTY,0 AS PRQTY,
		QTY AS SLQTY,0 AS RAPQTY,0 AS RAMQTY,0 AS RATQTY
FROM		MISSUE
WHERE		PROJCD=V_PROJCD
AND		LENGTH(TRIM(ITEMCD))=7
AND		LEFT(TRIM(ITEMCD),4) IN (V_TMT_GRP,V_MR_GRP,V_MS_GRP,V_EC_GRP,V_SC_GRP)
AND		VOCHCD IN (V_CD_IP,V_CD_IC)
AND		VOCHDT BETWEEN V_ST_DT AND V_DATE
UNION ALL
SELECT		CASE WHEN PARTY=V_PARTY_C THEN '02' ELSE '01' END AS JOB,
		ITEMCD,VOCHDT,
		0 AS OPQTY,0 AS RCQTY,0 AS ISQTY,0 AS PRQTY,
		0 AS SLQTY,QTY AS RAPQTY,0 AS RAMQTY,0 AS RATQTY
FROM		MRECEIPT
WHERE		PROJCD=V_PROJCD
AND		LENGTH(TRIM(ITEMCD))=7
AND		(LEFT(ITEMCD,4) IN (V_TMT_GRP)
		OR ITEMCD=V_BIL_PROD)
AND		VOCHCD=V_CD_RA
AND		PARTY NOT IN (V_PARTY_TR1,V_PARTY_TR2)
AND		QTY>0
AND		VOCHDT BETWEEN V_ST_DT AND V_DATE
UNION ALL
SELECT		CASE WHEN PARTY=V_PARTY_C THEN '02' ELSE '01' END AS JOB,
		ITEMCD,VOCHDT,
		0 AS OPQTY,0 AS RCQTY,0 AS ISQTY,0 AS PRQTY,
		0 AS SLQTY,0 AS RAPQTY,((-1)*QTY) AS RAMQTY,0 AS RATQTY
FROM		MRECEIPT
WHERE		PROJCD=V_PROJCD
AND		LENGTH(TRIM(ITEMCD))=7
AND		(LEFT(ITEMCD,4) IN (V_TMT_GRP)
		OR ITEMCD=V_BIL_PROD)
AND		VOCHCD=V_CD_RA
AND		PARTY NOT IN (V_PARTY_TR1,V_PARTY_TR2)
AND		QTY<0
AND		VOCHDT BETWEEN V_ST_DT AND V_DATE
UNION ALL
SELECT		'01' AS JOB,
		ITEMCD,VOCHDT,
		0 AS OPQTY,0 AS RCQTY,0 AS ISQTY,0 AS PRQTY,
		0 AS SLQTY,0 AS RAPQTY,0 AS RAMQTY,((-1)*QTY) AS RATQTY
FROM		MRECEIPT
WHERE		PROJCD=V_PROJCD
AND		LENGTH(TRIM(ITEMCD))=7
AND		LEFT(TRIM(ITEMCD),4) IN (V_TMT_GRP)
AND		VOCHCD=V_CD_RA
AND		PARTY IN (V_PARTY_TR1,V_PARTY_TR2)
AND		QTY<0
AND		VOCHDT BETWEEN V_ST_DT AND V_DATE
UNION ALL
SELECT		'01' AS JOB,
		ITEMCD,VOCHDT,
		0 AS OPQTY,0 AS RCQTY,QTY AS ISQTY,0 AS PRQTY,
		0 AS SLQTY,0 AS RAPQTY,0 AS RAMQTY,0 AS RATQTY
FROM		MISSUE
WHERE		PROJCD=V_PROJCD
AND		LENGTH(TRIM(ITEMCD))=7
AND		LEFT(TRIM(ITEMCD),4) IN (V_TMT_GRP)
AND		VOCHCD=V_CD_IO
AND		PARTY IN (V_PARTY_SP)
AND		UNIT IN ('GASI','TMPL')
AND		VOCHDT BETWEEN V_ST_DT AND V_DATE
)		STEEL_STOCK
GROUP BY	JOB;

SELECT * FROM TmpStock WHERE JOB=V_JOB;

DROP TEMPORARY TABLE IF EXISTS `TmpStock`;
    END $$
DELIMITER ;