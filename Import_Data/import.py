import psycopg2
import ijson

conn = psycopg2.connect(
    dbname="Steam Games Dataset",
    user="postgres",
    password="M23h21m31120105!",
    host="localhost",
    port="5432"
)

cur = conn.cursor()

json_file = "games.json"  # coloque aqui o caminho do seu JSON

with open(json_file, "rb") as f:

    # lẽ chaves e objetos do JSON gigante
    for appid, game in ijson.kvitems(f, ""):
        game["appid"] = int(appid)

        # Inserção simples — você pode adaptar as colunas existentes
        cur.execute("""
            INSERT INTO games (
                appid, name, release_date, required_age, price, dlc_count,
                about_the_game, short_description, reviews, header_image,
                website, support_url, support_email, windows, mac, linux,
                metacritic_score, metacritic_url, achievements, recommendations,
                notes, user_score, score_rank, positive, negative,
                estimated_owners, average_playtime_forever,
                average_playtime_2weeks, median_playtime_forever,
                median_playtime_2weeks, peak_ccu
            )
            VALUES (
                %(appid)s, %(name)s, %(release_date)s, %(required_age)s, %(price)s, %(dlc_count)s,
                %(about_the_game)s, %(short_description)s, %(reviews)s, %(header_image)s,
                %(website)s, %(support_url)s, %(support_email)s, %(windows)s, %(mac)s, %(linux)s,
                %(metacritic_score)s, %(metacritic_url)s, %(achievements)s, %(recommendations)s,
                %(notes)s, %(user_score)s, %(score_rank)s, %(positive)s, %(negative)s,
                %(estimated_owners)s, %(average_playtime_forever)s,
                %(average_playtime_2weeks)s, %(median_playtime_forever)s,
                %(median_playtime_2weeks)s, %(peak_ccu)s
            )
        """, game)

conn.commit()
cur.close()
conn.close()

print("Importação concluída!")
