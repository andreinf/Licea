import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import "./auth.css";
import { loginUser } from "../../api/auth";

const Login = () => {
  const [correo, setCorreo] = useState("");
  const [contrasena, setContrasena] = useState("");
  const [error, setError] = useState("");
  const navigate = useNavigate(); 

  const handleLogin = async (e) => {
    e.preventDefault();
    setError("");
    try {
      const response = await loginUser(correo, contrasena);
      if (response.message === "Login exitoso") {
        navigate("/menu"); 
      } else {
        setError(response.message);
      }
    } catch (err) {
      setError("Error en login");
      console.error(err);
    }
  };

  return (

    <div className="auth-container">
      <div className="form-box">
        <h2>Login</h2>
        {error && <div className="error-message">{error}</div>}
        <form onSubmit={handleLogin}>
          <input 
            type="email"
            placeholder="Correo"
            value={correo}
            onChange={(e) => setCorreo(e.target.value)}
            required
          />
          <input 
            type="password"
            placeholder="Contraseña"
            value={contrasena}
            onChange={(e) => setContrasena(e.target.value)}
            required
          />
          <button type="submit">Iniciar sesión</button>
        </form>
        <button 
          type="button"
          className="auth-link"
          onClick={() => navigate("/register")} 
        >
          ¿No tienes cuenta? Regístrate
        </button>
        <p>Si necesitas ayuda para Iniciar session, o perdiste tu contraseña
           Contactese con nuestro equipo</p>
      </div>
    </div>
  );
};

export default Login;
