CREATE TABLE raw_games (
    app_id TEXT PRIMARY KEY,
    data JSONB
);

CREATE TABLE games (
    appid INT PRIMARY KEY,
    name TEXT,
    release_date TEXT,
    required_age INT,
    price NUMERIC,
    dlc_count INT,
    about_the_game TEXT,
    short_description TEXT,
    reviews TEXT,
    header_image TEXT,
    website TEXT,
    support_url TEXT,
    support_email TEXT,
    windows BOOLEAN,
    mac BOOLEAN,
    linux BOOLEAN,
    metacritic_score INT,
    metacritic_url TEXT,
    achievements INT,
    recommendations INT,
    notes TEXT,
    user_score INT,
    score_rank TEXT,
    positive INT,
    negative INT,
    estimated_owners TEXT,
    average_playtime_forever INT,
    average_playtime_2weeks INT,
    median_playtime_forever INT,
    median_playtime_2weeks INT,
    peak_ccu INT
);