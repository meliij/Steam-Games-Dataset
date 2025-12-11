CREATE OR REPLACE FUNCTION fn_similarity(gameA INT, gameB INT)
RETURNS NUMERIC AS $$
DECLARE
	shared_tags INT := 0;
	shared_genres INT := 0;
	shared_categories INT := 0;
	total_tags INT := 0;
	total_genres INT := 0;
	total_categories INT := 0;
	score NUMERIC := 0;
BEGIN
	SELECT COUNT(*) INTO shared_tags
	FROM tags_game tg1
	JOIN tags_game tg2 ON tg1.id_tag = tg2.id_tag
	WHERE tg1.id_game = gameA AND tg2.id_game = gameB;

	SELECT COUNT(*) INTO total_tags
	FROM (
		SELECT id_tag FROM tags_game WHERE id_game = gameA
		UNION
		SELECT id_tag FROM tags_game WHERE id_game = gameB
	) AS t(id_tag);

	SELECT COUNT(*) INTO shared_genres
	FROM genres_game gg1
	JOIN genres_game gg2 ON gg1.id_genre = gg2.id_genre
	WHERE gg1.id_game = gameA AND gg2.id_game = gameB;

	SELECT COUNT(*) INTO total_genres
	FROM (
		SELECT id_genre FROM genres_game WHERE id_game = gameA
		UNION
		SELECT id_genre FROM genres_game WHERE id_game = gameB
	) AS g(id_genre);

	SELECT COUNT(*) INTO shared_categories
	FROM categories_game cg1
	JOIN categories_game cg2 ON cg1.id_category = cg2.id_category
	WHERE cg1.id_game = gameA AND cg2.id_game = gameB;

	SELECT COUNT(*) INTO total_categories
	FROM (
		SELECT id_category FROM categories_game WHERE id_game = gameA
		UNION
		SELECT id_category FROM categories_game WHERE id_game = gameB
	) AS c(id_category);
	score :=
		  0.5 * CASE WHEN total_tags = 0 THEN 0 ELSE shared_tags::NUMERIC / total_tags END
		+ 0.3 * CASE WHEN total_genres = 0 THEN 0 ELSE shared_genres::NUMERIC / total_genres END
		+ 0.2 * CASE WHEN total_categories = 0 THEN 0 ELSE shared_categories::NUMERIC / total_categories END;

	RETURN score;
END;
$$ LANGUAGE plpgsql;