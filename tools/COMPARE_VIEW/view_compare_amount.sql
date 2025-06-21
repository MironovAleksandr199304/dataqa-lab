CREATE OR REPLACE VIEW QA_COMPARE_AMOUNT AS
--#######
--представление показывает валидность значений из отчетов с эталонным значением p.etalon_value для полей
--которые так или иначе рассчитываются в процедурах обновления данных
--#######

--######добавил WITH чтобы условно говоря объявить переменные для переиспользования. легче будет потом править.
WITH param_value AS(
	SELECT 15000 AS etalon_value,	
	TO_DATE('03.03.2025','dd.mm.yyyy') AS variable_date
	FROM DUAL
)
	SELECT 
		CASE 
			WHEN ROUND(col1) = p.etalon_value THEN 'Статус проверки: пройдено'
			ELSE 'Статус проверки: не пройдено'
		END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6  THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			WHEN tn IS NOT NULL THEN 'tn: ' || TO_CHAR(tn)
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl1' AS REPORT_NAME
	FROM
	tabl1
	JOIN param_value p ON 1=1
	WHERE fid = 't1' AND TRUNC(dat1) = p.variable_date
UNION ALL
	SELECT CASE
			WHEN ROUND(col1) = p.etalon_value THEN 'Статус проверки: пройдено'
			ELSE 'Статус проверки: не пройдено'
		END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6  THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			WHEN TO_CHAR(tn) IS NOT NULL THEN 'tn: ' || TO_CHAR(tn)
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl2' AS REPORT_NAME
		FROM tabl2
		JOIN param_value p ON 1=1
	WHERE fid = 't1' AND TRUNC(dat1) = p.variable_date
UNION ALL
	SELECT CASE
			WHEN ROUND(col1) = p.etalon_value THEN 'Статус проверки: пройдено'
			ELSE 'Статус проверки: не пройдено'
		END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6  THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			WHEN TO_CHAR(tn) IS NOT NULL THEN 'tn: ' || TO_CHAR(tn)
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl3' AS REPORT_NAME
	FROM tabl3
	JOIN param_value p ON 1=1
	WHERE fid = 't1' AND TRUNC(dat1) = p.variable_date
UNION ALL
	SELECT CASE
			WHEN ROUND(col1) = p.etalon_value THEN 'Статус проверки: пройдено'
			ELSE 'Статус проверки: не пройдено'
		END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6 THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			WHEN TO_CHAR(tn) IS NOT NULL THEN 'tn: ' || TO_CHAR(tn)
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl4' AS REPORT_NAME
	FROM tabl4
	JOIN param_value p ON 1=1
	WHERE tn = 9999999 AND TRUNC(dat1) = p.variable_date
UNION ALL
	SELECT CASE
			WHEN ROUND(op) = p.etalon_value AND ROUND(cvv) = p.etalon_value THEN 'Статус проверки: пройдено'
			ELSE 'Статус проверки: не пройдено'
		END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6  THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl5' AS REPORT_NAME
		FROM tabl5
		JOIN param_value p ON 1=1
		WHERE fid = 'tabl5' AND TRUNC(dat1) = p.variable_date
UNION ALL
	SELECT CASE
		 WHEN ROUND(op) = p.etalon_value THEN 'Статус проверки: пройдено'
		 ELSE 'Статус проверки: не пройдено'
	 END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6 THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			WHEN TO_CHAR(roww) IS NOT NULL THEN 'roww: ' || TO_CHAR(roww)
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl6' AS REPORT_NAME
	FROM tabl6
	JOIN param_value p ON 1=1
	WHERE roww = '9999999' AND TRUNC(dat1) = p.variable_date
UNION ALL
	SELECT CASE
		 WHEN ROUND(op) = p.etalon_value THEN 'Статус проверки: пройдено'
		 ELSE 'Статус проверки: не пройдено'
	 END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6 THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl7' AS REPORT_NAME
	FROM tabl7
	JOIN param_value p ON 1=1
	WHERE fid = 'tabl7' AND TRUNC(dat2) = p.variable_date
UNION ALL
	SELECT CASE
		WHEN ROUND(op) = p.etalon_value THEN 'Статус проверки: пройдено'
		ELSE 'Статус проверки: не пройдено'
	END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6 THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl8' AS REPORT_NAME
	FROM tabl8
	JOIN param_value p ON 1=1
	WHERE fid = 'tabl8' AND TRUNC(dat2) = p.variable_date
UNION ALL
	SELECT CASE
		WHEN ROUND(ll) = p.etalon_value AND ROUND(pqaz) = p.etalon_value AND ROUND(col1) = pqaz * ll THEN 'Статус проверки: пройдено'
		ELSE 'Статус проверки: не пройдено'
	END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6 THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl9' AS REPORT_NAME
	FROM tabl9
	JOIN param_value p ON 1=1
	WHERE fid = 'tabl9' AND TRUNC(dat2) = p.variable_date
UNION ALL
	SELECT CASE
		WHEN ROUND(pqaz) = p.etalon_value OR ROUND(pqaz) = 5000 AND --#по pqaz два условия, тк берется из двух источников
																			 --#можно было бы один источник заполнить, но заполнил два.
		ROUND(col1) = pqaz * ll THEN 'Статус проверки: пройдено'
		ELSE 'Статус проверки: не пройдено'
	END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6 THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			WHEN voz IS NOT NULL THEN 'voz: ' || voz
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl10' AS REPORT_NAME
	FROM tabl10
	JOIN param_value p ON 1=1
	WHERE fid = 'P1' AND TRUNC(dat2) = p.variable_date
UNION ALL
	SELECT CASE
		WHEN ROUND(col1) = p.etalon_value THEN 'Статус проверки: пройдено'
		ELSE 'Статус проверки: не пройдено'
	END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6 THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			WHEN voz IS NOT NULL THEN 'voz: ' || voz
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl11' AS REPORT_NAME
	FROM tabl11
	JOIN param_value p ON 1=1
	WHERE fid = 'tabl11' AND TRUNC(dat2) = p.variable_date
UNION ALL
	SELECT CASE
		WHEN ROUND(col1) = ll * pqaz THEN 'Статус проверки: пройдено' --col1 = p.etalon_value
		ELSE 'Статус проверки: не пройдено'
	END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6 THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			WHEN voz IS NOT NULL THEN 'voz: ' || voz
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl12' AS REPORT_NAME
	FROM tabl12
	JOIN param_value p ON 1=1
	WHERE fid = 'tabl12' AND TRUNC(dat2) = p.variable_date
UNION ALL
	SELECT CASE
		WHEN ROUND(pat) = p.etalon_value AND ROUND(pac) = p.etalon_value AND ROUND(ll) = 7500/15 THEN 'Статус проверки: пройдено'  --#pac и pat рассчитываются
																																		--# как SUM(c.vr1) = 7500+7500
		ELSE 'Статус проверки: не пройдено'
	END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6 THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			WHEN voz IS NOT NULL THEN 'voz: ' || voz
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl13' AS REPORT_NAME
	FROM tabl13
	JOIN param_value p ON 1=1
	WHERE fid = 'tabl13' AND TRUNC(dat2) = p.variable_date
UNION ALL
	SELECT CASE
		WHEN ROUND(vol1) = p.etalon_value  THEN 'Статус проверки: пройдено'  	--##vol1 рассчитывается: (в нашем случае это 1000/2 * 3 в обоих случаях)
																						--##then coalesce(xr.r1, 1)/nvl(xr.u1,1)*np.cvv -- если покупаем то курс той валюты которую покупаем (из инструмента) и количество покупаемого
																			            --##when np.b1 IN ('X') then coalesce(xr1.r1, 1)/nvl(xr1.u1,1)*np.vl1 -- если продаем то курс той валюты которую покупаем
		ELSE 'Статус проверки: не пройдено'
	END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6 THEN 'fid: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl17' AS REPORT_NAME
	FROM tabl17
	JOIN param_value p ON 1=1
	WHERE fid = 'tabl17' AND TRUNC(dat2) = p.variable_date
  UNION ALL
	SELECT CASE
		WHEN vol = etalon_value  THEN 'Статус проверки: пройдено'  	--##vol1 рассчитывается при отборе из источника case when nvl(sc.ms,0)=0 then 0 else
																	--##t.am1 * round(t.price * round(sc.sp / sc.ms,5),2) as rve
                                                                    --##в случае с синтетикой получается 3750 * (2.5 * (8 / 10)) = 7500. в итоговую таблицу попадает 2 записи, sum(rve) = 15000
		ELSE 'Статус проверки: не пройдено'
	END AS COMPARE_STATUS,
		'fid: ' || REPORT_IDN AS REPORT_IDN,
		'Витрина: tabl18' AS REPORT_NAME
	FROM
    (SELECT SUM(ROUND(vol1)) as vol,
    fid as REPORT_IDN,
    p.etalon_value as etalon_value
      FROM tabl18
      JOIN param_value p ON 1=1
      WHERE fid = '99' AND TRUNC(dat2) = p.variable_date
      GROUP BY fid, p.etalon_value)
 UNION ALL
	SELECT CASE
		WHEN ROUND(vol1) = p.etalon_value  THEN 'Статус проверки: пройдено'  	--##vol1 рассчитывается: (в нашем случае это 1000/2 * 3 в обоих случаях(в отчет попадает 1 строка X,
																						--##1 строка Z))
																						--##WHEN segm IN ('SDF', 'VSDV', 'GRIKJ') AND np.b1 = 'X' THEN COALESCE(xr.r1, 1)/nvl(xr.u1,1)*np.cvv
																						--##если покупаем то курс той валюты которую покупаем (из инструмента) и количество покупаемого
																			            --##WHEN segm IN ('SZX', 'SE44', 'KD5') AND np.b1 = 'Z' THEN COALESCE(xr1.r1, 1)/nvl(xr1.u1,1)*np.vl1
																			            --##если продаем то курс той валюты которую покупаем (валюта в обмен на которую продаем) и сумму что получаем в обмен (vl1)
		ELSE 'Статус проверки: не пройдено'
	END AS COMPARE_STATUS,
		CASE
			WHEN fid IS NOT NULL AND LENGTH(fid) > 6 THEN 'FIRMID: ' || fid --##добавил сравнение по длине, потому что кое-где значения fid обрезаются
			ELSE 'Идентификатор не найден'
		END AS REPORT_IDN,
		'Витрина: tabl19' AS REPORT_NAME
	FROM tabl19
	JOIN param_value p ON 1=1
	WHERE fid = 'tabl19' AND TRUNC(dat2) = p.variable_date;