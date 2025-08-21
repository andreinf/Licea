# backend/controllers/auth_controller.py
from services.db_service import get_connection
import bcrypt

def login(correo, contrasena):
    conn = get_connection()
    if not conn:
        return None
    try:
        cur = conn.cursor()
        cur.execute("SELECT id_usuario, contraseña FROM Usuario WHERE correo = %s", (correo,))
        user = cur.fetchone()  

        if user and bcrypt.checkpw(contrasena.encode('utf-8'), user[1].encode('utf-8')):
            
            cur.execute("UPDATE Usuario SET ultima_sesion = NOW() WHERE id_usuario = %s", (user[0],))
            conn.commit()
            cur.close()
            conn.close()
            return {"id_usuario": user[0]}
        
        cur.close()
        conn.close()
        return None
    except Exception as e:
        print("Error en login:", e)
        return None

def register(
    nombre,
    correo,
    contrasena,
    telefono=None,
    identificacion=None,
    fecha_nacimiento=None,
    genero=None,
    direccion=None,
    avatar_url=None,
    id_rol=1  
):
    conn = get_connection()
    if not conn:
        return {"error": "No se pudo conectar a la base de datos"}

    try:
        cur = conn.cursor()

        
        cur.execute("SELECT id_usuario FROM Usuario WHERE correo = %s", (correo,))
        if cur.fetchone():
            cur.close()
            conn.close()
            return {"error": "El correo ya está registrado"}

        
        if identificacion:
            cur.execute("SELECT id_usuario FROM Usuario WHERE identificacion = %s", (identificacion,))
            if cur.fetchone():
                cur.close()
                conn.close()
                return {"error": "La identificación ya está registrada"}

        
        hashed = bcrypt.hashpw(contrasena.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

        
        cur.execute("""
            INSERT INTO Usuario 
            (nombre_completo, correo, contraseña, telefono, identificacion, fecha_nacimiento,
             genero, direccion, avatar_url, estado, fecha_creacion, ultima_sesion, id_rol)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, 'Activo', CURRENT_TIMESTAMP(), NULL, %s)
        """, (
            nombre, correo, hashed, telefono, identificacion, fecha_nacimiento,
            genero, direccion, avatar_url, id_rol
        ))

        conn.commit()
        user_id = cur.lastrowid
        cur.close()
        conn.close()
        return {"id_usuario": user_id}

    except Exception as e:
        print("Error en registro:", e)
        return {"error": "Error interno en el registro"}
