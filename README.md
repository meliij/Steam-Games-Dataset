# Steam-Games-Dataset
Repositório dedicado ao controle de versionamento do Banco de Dados "[Steam Games Dataset](https://www.kaggle.com/datasets/fronkongames/steam-games-dataset)".

# Importando Os Dados
1. Crie uma database chamada "Steam Games Dataset" **<sup>*</sup>**
2. Rode os comandos presentes no arquivo ["CREATE_TABLES_FOR_IMPORT.sql"](/Import_Data/CREATE_TABLES_FOR_IMPORT.sql)
3. Baixe a base de dados em .zip [aqui](https://www.kaggle.com/datasets/fronkongames/steam-games-dataset)
4. Extraia o arquivo "games.json" para a pasta ["Import_Data"](/Import_Data)
5. Abra um terminal e rode `pip install psycopg2-binary ijson`
6. Então rode o script com `python import.py`
> [!NOTE]
> A importação pode demorar alguns minutos.

> [!CAUTION]
> **<sup>*</sup>** O nome da database pode ser qualquer um que desejar, mas então deverá ser alterado no arquivo "import.py" e qualquer outro arquivo que venha a mencionar a database posteriormente. 
