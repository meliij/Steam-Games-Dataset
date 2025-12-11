import psycopg2
from DML.config import DB_CONFIG
 
def create_views():
    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()
 
    cur.execute("""
        -- COLA O CODIGO AQUI POR FAVOR!
        """
    )

    conn.commit()
    cur.close()
    conn.close()
    print("Views criadas com sucesso.")
 
 