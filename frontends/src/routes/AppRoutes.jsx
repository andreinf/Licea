// src/routes/AppRoutes.jsx
import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Login from '../features/auth/Login';
import Menu from '../features/menu/Menu';
import Register from '../features/auth/Register';


const AppRoutes = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Navigate to="/login" />} />
        <Route path="/login" element={<Login />} />
        <Route path="/menu" element={<Menu />} />
        <Route path="/register" element={<Register />} />
      </Routes>
    </Router>
  );
};

export default AppRoutes;
