from DML.import_ import import_games
from DDL.create_tables_ import create_tables

if __name__ == "__main__":
    try:
        create_tables()
    except Exception as e:
        print(f"Erro ao criar tabelas: {e}")
        
    import_games()