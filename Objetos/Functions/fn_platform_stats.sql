CREATE OR REPLACE FUNCTION fn_platform_stats(p_platform os_enum)
RETURNS TABLE (
	total_games INT,
	avg_price NUMERIC,
	total_reviews INT,
	user_score NUMERIC,
	free_games INT,
	paid_games INT
) AS $$
BEGIN
	RETURN QUERY
	SELECT 
		COUNT(*)::INT AS total_games,

		ROUND(AVG(g.price), 2) AS avg_price,

		SUM(d.positive + d.negative)::INT AS total_reviews,

		CASE 
			WHEN SUM(d.positive + d.negative) = 0 THEN 0
			ELSE ROUND((SUM(d.positive)::NUMERIC / SUM(d.positive + d.negative)) * 100, 2)
		END AS user_score,

		SUM(CASE WHEN g.price = 0 THEN 1 ELSE 0 END)::INT AS free_games,

		SUM(CASE WHEN g.price > 0 THEN 1 ELSE 0 END)::INT AS paid_games

	FROM operation_systems_games osg
	JOIN operation_systems os ON osg.id_so = os.id
	JOIN games g ON g.appid = osg.id_game
	LEFT JOIN detalhes d ON d.id_game = g.appid
	WHERE os.so_name = p_platform;
END;
$$ LANGUAGE plpgsql;