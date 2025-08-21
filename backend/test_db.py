# backend/test_db.py
from backend.db_service import get_connection

conn = get_connection()
if conn:
    conn.close()
