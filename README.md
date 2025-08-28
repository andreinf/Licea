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
dentro de la carpeta de backend tienen que crear un archivo .env y dentro de este poner el siguiente codigo:
```
FLASK_APP=app.py
FLASK_ENV=development
SECRET_KEY=tu_clave_secreta_aqui

DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=licea_completa
DB_PORT=3306

FRONTEND_URL=http://localhost:3000
```

## **FRONTEND**
`npm start` = enciende el servidor

## **SUBIR REPO**
``` 
git add .
git commit -m "Mensaje descriptivo del cambio"
git push origin main
```

## DESCARGAR RAMAS PROYECTO
`git fetch --all` = actualiza las ramas que hay en el proyecto
`git branch -r` = con este ven las ramas
`git checkout nombre-de-la-rama` = cambia las ramas que vayan a utilizar
### PASOS PARA SUBIR A REPOSITORIO
```
git add .
git commit -m "Descripción de lo que hicieron"
git push origin nombre-de-la-rama
```


