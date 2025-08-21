# backend/routes/auth_routes.py
from flask import Blueprint, request, jsonify
from controllers.auth_controller import login as login_controller, register as register_controller

auth_bp = Blueprint("auth", __name__, url_prefix="/auth")

@auth_bp.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    correo = data.get("correo")
    contrasena = data.get("contrasena")
    
    if not correo or not contrasena:
        return jsonify({"message": "Faltan datos de login"}), 400

    user = login_controller(correo, contrasena)
    if user:
        return jsonify({"message": "Login exitoso", "user_id": user["id_usuario"]}), 200
    return jsonify({"message": "Correo o contraseña incorrectos"}), 401

@auth_bp.route("/register", methods=["POST"])
def register():
    data = request.get_json()
    nombre = data.get("nombre")
    correo = data.get("correo")
    contrasena = data.get("contrasena")
    telefono = data.get("telefono")
    identificacion = data.get("identificacion")
    fecha_nacimiento = data.get("fecha_nacimiento")
    genero = data.get("genero")
    direccion = data.get("direccion")
    avatar_url = data.get("avatar_url")

    if not nombre or not correo or not contrasena:
        return jsonify({"message": "Todos los campos obligatorios"}), 400
    if len(contrasena) < 6:
        return jsonify({"message": "La contraseña debe tener al menos 6 caracteres"}), 400

    result = register_controller(
        nombre, correo, contrasena, telefono, identificacion,
        fecha_nacimiento, genero, direccion, avatar_url
    )

    if "error" in result:
        return jsonify({"message": result["error"]}), 400

    return jsonify({"message": "Usuario registrado exitosamente", "user_id": result["id_usuario"]}), 201
