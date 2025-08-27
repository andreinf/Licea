# backend/controllers/auth_controller.py
from services.db_service import get_connection
import bcrypt

def login(correo, contrasena):
    conn = get_connection()
    if not conn:
        print("❌ No se pudo conectar a la base de datos")
        return None

    try:
        cur = conn.cursor(dictionary=True)
        cur.execute("SELECT id_usuario, contraseña FROM Usuario WHERE correo = %s", (correo,))
        user = cur.fetchone()

        if user:
            print("🔑 Usuario encontrado:", user['id_usuario'])
            if bcrypt.checkpw(contrasena.encode('utf-8'), user['contraseña'].encode('utf-8')):
                # Actualizar última sesión
                cur.execute("UPDATE Usuario SET ultima_sesion = NOW() WHERE id_usuario = %s", (user['id_usuario'],))
                conn.commit()
                print("✅ Contraseña correcta, login exitoso")
                cur.close()
                conn.close()
                return {"id_usuario": user['id_usuario']}
            else:
                print("⚠️ Contraseña incorrecta")
        else:
            print("⚠️ Usuario no encontrado")

        cur.close()
        conn.close()
        return None

    except Exception as e:
        print("Error en login:", e)
        if conn:
            conn.close()
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
        print("❌ No se pudo conectar a la base de datos")
        return {"error": "No se pudo conectar a la base de datos"}

    try:
        cur = conn.cursor(dictionary=True)

        # Verificar si el correo ya existe
        cur.execute("SELECT id_usuario FROM Usuario WHERE correo = %s", (correo,))
        if cur.fetchone():
            cur.close()
            conn.close()
            return {"error": "El correo ya está registrado"}

        # Verificar si la identificación ya existe
        if identificacion:
            cur.execute("SELECT id_usuario FROM Usuario WHERE identificacion = %s", (identificacion,))
            if cur.fetchone():
                cur.close()
                conn.close()
                return {"error": "La identificación ya está registrada"}

        # Hashear contraseña
        hashed = bcrypt.hashpw(contrasena.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

        # Insertar nuevo usuario
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
        print("✅ Usuario registrado con éxito:", user_id)
        cur.close()
        conn.close()
        return {"id_usuario": user_id}

    except Exception as e:
        print("Error en registro:", e)
        if conn:
            conn.close()
        return {"error": "Error interno en el registro"}
