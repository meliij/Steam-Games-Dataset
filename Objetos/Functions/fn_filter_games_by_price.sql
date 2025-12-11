CREATE OR REPLACE FUNCTION fn_filter_games_by_price(
	p_min_price NUMERIC,
	p_max_price NUMERIC,
	p_min_reviews INT,
	p_order_by TEXT
)
RETURNS TABLE(
	appid INT,
	name TEXT,
	price NUMERIC,
	total_reviews INT
) AS $$
BEGIN
	RETURN QUERY
	SELECT
		g.appid,
		g.name,
		g.price,
		(d.positive + d.negative) AS total_reviews
	FROM games g
	LEFT JOIN detalhes d ON d.id_game = g.appid
	WHERE g.price >= p_min_price
	  AND g.price <= p_max_price
	  AND (d.positive + d.negative) >= p_min_reviews
	ORDER BY
		CASE WHEN p_order_by = 'price' THEN g.price END ASC,
		CASE WHEN p_order_by = 'reviews' THEN (d.positive + d.negative) END DESC;
END;
$$ LANGUAGE plpgsql;