SELECT * 

,(SELECT TOP 1 t.aadt FROM [Crdb].[dbo].[TRAFFIC] t
WHERE s.NBR_RTE_12=t.nbr_rte AND s.BLM>t.tr_beg_log_mle AND s.BLM<t.tr_end_log_mle AND t.aadt IS NOT NULL) AS AADT

,(SELECT top 1 h.[incidentID] FROM [Crdb].[dbo].[obs] h
WHERE s.rout=h.rout AND abs(s.BLM-h.BLM)<1 AND Abs(DATEDIFF(MINUTE, s.dt, h.[start_time]))<60) AS [incidentID]

,[C1] AS caused_NSC_C1

FROM [crdb].[dbo].[cr] s
ORDER BY [start_time]