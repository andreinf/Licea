# LICEA
Proyecto realizado por Andrés Infante, Miguel Rubiano, Brainer Gonzales orientado a un enfoque educativo buscando brindar una gran ayuda en esta area

# Guia para clonar el repositorio de LICEA

para las dependencias se necesita siempre despues de clonarlo usar los siguientes comando de entorno virtual

# **PASO PARA ENTORNO VIRTUAL(despues de clonar)**

## *Crear el entorno virtual*
`python -m venv venv`

## *Activar entorno virtual (Windows)*
`venv\Scripts\activate`

## *Activar entorno virtual (Linux/Mac)*
`source venv/bin/activate`


## **IMPORTANTE!!**
`pip install -r requirements.txt` = (instala las dependencias que estan en requirements.txt, sin estas no pueden ejecutar correctamente el proyecto)

depende de la sección que vayan a trabajar tienen que seleccionar primero la carpeta con `**cd backend / frontends**` dentro de la consola de **VS** y luego tengan en cuenta los siguiente comandos depende de lo que seleccionen.(les recomiendo bash)

## **BACKEND**
`source venv/Scripts/activate` = activa el venv para que el backend funcione junto con la BD
`python app.py` = enciende el servidor local

## **FRONTEND**
`npm start` = enciende el servidor

## **SUBIR REPO**
``` 
git add .
git commit -m "Mensaje descriptivo del cambio"
git push origin main
```

