-- Sensitivity of Secondary Crash
-- @Author: Alireza Naimi <alienaimi@gmail.com>
 
PARAMETERS
[year]     integer = 2012
,[SpTRS]   integer = 1
,[TempTRS] integer = 60;
 
SELECT DISTINCT spatialTRS.spatialTRS, temporalTRS.temporalTRS,
COUNT(sf.[id]) AS NC,
 
SUM( iif(hour(sf.dt)>=06 AND hour(sf.dt)<10,1,0) ) AS NC_hAM,
SUM( iif(hour(sf.dt)>=10 AND hour(sf.dt)<15,1,0) ) AS NC_hMD,
SUM( iif(hour(sf.dt)>=15 AND hour(sf.dt)<19,1,0) ) AS NC_hPM,
SUM( iif(hour(sf.dt)>=19 OR  hour(sf.dt)<06,1,0) ) AS NC_hOP,
 
SUM( iif(hour(sf.dt)>=00 AND hour(sf.dt)<01,1,0) ) AS NC_h00,
SUM( iif(hour(sf.dt)>=01 AND hour(sf.dt)<02,1,0) ) AS NC_h01,
SUM( iif(hour(sf.dt)>=02 AND hour(sf.dt)<03,1,0) ) AS NC_h02,
SUM( iif(hour(sf.dt)>=03 AND hour(sf.dt)<04,1,0) ) AS NC_h03,
SUM( iif(hour(sf.dt)>=04 AND hour(sf.dt)<05,1,0) ) AS NC_h04,
SUM( iif(hour(sf.dt)>=05 AND hour(sf.dt)<06,1,0) ) AS NC_h05,
 
SUM( iif(hour(sf.dt)>=06 AND hour(sf.dt)<07,1,0) ) AS NC_h06,
SUM( iif(hour(sf.dt)>=07 AND hour(sf.dt)<08,1,0) ) AS NC_h07,
SUM( iif(hour(sf.dt)>=08 AND hour(sf.dt)<09,1,0) ) AS NC_h08,
SUM( iif(hour(sf.dt)>=09 AND hour(sf.dt)<10,1,0) ) AS NC_h09,
 
SUM( iif(hour(sf.dt)>=10 AND hour(sf.dt)<11,1,0) ) AS NC_h10,
SUM( iif(hour(sf.dt)>=11 AND hour(sf.dt)<12,1,0) ) AS NC_h11,
SUM( iif(hour(sf.dt)>=12 AND hour(sf.dt)<13,1,0) ) AS NC_h12,
SUM( iif(hour(sf.dt)>=13 AND hour(sf.dt)<14,1,0) ) AS NC_h13,
SUM( iif(hour(sf.dt)>=14 AND hour(sf.dt)<15,1,0) ) AS NC_h14,
 
SUM( iif(hour(sf.dt)>=15 AND hour(sf.dt)<16,1,0) ) AS NC_h15,
SUM( iif(hour(sf.dt)>=16 AND hour(sf.dt)<17,1,0) ) AS NC_h16,
SUM( iif(hour(sf.dt)>=17 AND hour(sf.dt)<18,1,0) ) AS NC_h17,
SUM( iif(hour(sf.dt)>=18 AND hour(sf.dt)<19,1,0) ) AS NC_h18,
SUM( iif(hour(sf.dt)>=19 AND hour(sf.dt)<20,1,0) ) AS NC_h19,
 
SUM( iif(hour(sf.dt)>=20 AND hour(sf.dt)<21,1,0) ) AS NC_h20,
SUM( iif(hour(sf.dt)>=21 AND hour(sf.dt)<22,1,0) ) AS NC_h21,
SUM( iif(hour(sf.dt)>=22 AND hour(sf.dt)<23,1,0) ) AS NC_h22,
SUM( iif(hour(sf.dt)>=23 AND hour(sf.dt)<24,1,0) ) AS NC_h23,
 
SUM( iif(sf.func_class=00,1,0) ) AS NC_f00,
SUM( iif(sf.func_class=01,1,0) ) AS NC_f01,
SUM( iif(sf.func_class=02,1,0) ) AS NC_f02,
SUM( iif(sf.func_class=03,1,0) ) AS NC_f03,
SUM( iif(sf.func_class=04,1,0) ) AS NC_f04,
SUM( iif(sf.func_class>=20 AND sf.func_class<=999,1,0) ) AS NC_f99
 
FROM
(SELECT * FROM cr AS s LEFT JOIN [Road_Seg] AS rs
ON (s.k_Road_Segment=rs.mslink)) AS sf,
cr as sl,
temporalTRS, spatialTRS
 
where
sf.[id]<>sl.[id]
AND sf.[id]    IS NOT NULL
AND sl.[id]    IS NOT NULL
AND sf.dirFlow IS NOT NULL
AND sl.dirFlow IS NOT NULL
AND sf.NBR_RTE_12  = sl.NBR_RTE_12
AND sf.DATEOFCRAS  = sl.DATEOFCRAS
AND sf.TIMEOFCRAS >= sl.TIMEOFCRAS
AND (sf.TIMEOFCRAS-sl.TIMEOFCRAS) <= temporalTRS.temporalTRS
 
AND abs(sf.BLM-sl.blm)<=spatialTRS.spatialTRS
AND (sf.dirFlow = sl.dirFlow)
AND IIF(sl.dirFlow=1, IIF(sl.YCOR>sf.YCOR, 1, -1), 1)=1
AND IIF(sl.dirFlow=2, IIF(sl.XCOR>sf.XCOR, 1, -1), 1)=1
AND IIF(sl.dirFlow=3, IIF(sl.YCOR<sf.YCOR, 1, -1), 1)=1
AND IIF(sl.dirFlow=4, IIF(sl.XCOR<sf.XCOR, 1, -1), 1)=1
 
GROUP BY temporalTRS.temporalTRS, spatialTRS.spatialTRS
 
ORDER BY temporalTRS.temporalTRS
;
