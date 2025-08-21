import MySQLdb
from dotenv import load_dotenv
import os

load_dotenv()  # Carga las variables del .env

def get_connection():
    return MySQLdb.connect(
        host=os.getenv("DB_HOST", "localhost"),
        user=os.getenv("DB_USER"),
        passwd=os.getenv("DB_PASS"),
        db=os.getenv("DB_NAME", "licea_completa")
    )
