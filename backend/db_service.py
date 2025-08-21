# backend/services/db_service.py
import mysql.connector
from mysql.connector import Error

def get_connection():
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",  
            database="licea_completa"
        )
        return conn
    except Error as e:
        print(f"Error al conectar a MySQL: {e}")
        return None
