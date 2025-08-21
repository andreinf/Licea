// frontend/src/api/auth.js
const API_URL = "http://127.0.0.1:5000/auth";

export const loginUser = async (correo, contrasena) => {
  try {
    const response = await fetch(`${API_URL}/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ correo, contrasena }),
    });
    return await response.json();
  } catch (error) {
    console.error("Error en login:", error);
    return { message: "Error de conexión" };
  }
};

export const registerUser = async (formData) => {
  try {
    const response = await fetch(`${API_URL}/register`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(formData),
    });

    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.message || "Error en el registro");
    }

    return response.json();
  } catch (error) {
    console.error("Error en registerUser:", error);
    throw error;
  }
};
