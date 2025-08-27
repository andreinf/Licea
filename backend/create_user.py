import bcrypt
import mysql.connector

# Conexión a MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="licea_completa"
)

cur = conn.cursor()

# Datos del usuario
nombre = "Andres Felipe"
correo = "andress@example.com"
contrasena = "123456"

# Verificar si el usuario ya existe
cur.execute("SELECT id_usuario FROM Usuario WHERE correo = %s", (correo,))
if cur.fetchone():
    print("⚠️ El usuario ya existe")
else:
    hashed = bcrypt.hashpw(contrasena.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
    query = "INSERT INTO Usuario (nombre_completo, correo, contraseña) VALUES (%s, %s, %s)"
    cur.execute(query, (nombre, correo, hashed))
    conn.commit()
    print("✅ Usuario creado con éxito")

cur.close()
conn.close()
