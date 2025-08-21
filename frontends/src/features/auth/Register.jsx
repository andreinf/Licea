// frontend/src/components/auth/Register.jsx
import React, { useState } from 'react';
import { registerUser } from '../../api/auth';
import './auth.css';

const Register = () => {
  const [form, setForm] = useState({
    nombre: '',
    correo: '',
    contrasena: '',
    telefono: '',
    identificacion: '',
    fecha_nacimiento: '',
    genero: '',
    direccion: '',
    avatar_url: ''
  });
  const [mensaje, setMensaje] = useState('');

  const handleChange = e => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleRegister = async e => {
    e.preventDefault();
    try {
      const res = await registerUser(form);
      setMensaje(res.message);
    } catch (err) {
      setMensaje(err.message || 'Error en el registro');
    }
  };

  return (
    <div className="auth-container">
      <h2>Registro</h2>
      <form onSubmit={handleRegister}>
        <input name="nombre" type="text" placeholder="Nombre completo" onChange={handleChange} />
        <input name="correo" type="email" placeholder="Correo" onChange={handleChange} />
        <input name="contrasena" type="password" placeholder="Contraseña" onChange={handleChange} />
        <input name="telefono" type="text" placeholder="Teléfono" onChange={handleChange} />
        <input name="identificacion" type="text" placeholder="Identificación" onChange={handleChange} />
        <input name="fecha_nacimiento" type="date" placeholder="Fecha de nacimiento" onChange={handleChange} />
        <select name="genero" onChange={handleChange}>
          <option value="">Género</option>
          <option value="Masculino">Masculino</option>
          <option value="Femenino">Femenino</option>
          <option value="Otro">Otro</option>
        </select>
        <input name="direccion" type="text" placeholder="Dirección" onChange={handleChange} />
        <input name="avatar_url" type="text" placeholder="URL de avatar" onChange={handleChange} />
        <button type="submit">Registrarse</button>
      </form>
      {mensaje && <p>{mensaje}</p>}
    </div>
  );
};

export default Register;
