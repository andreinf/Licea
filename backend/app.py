from flask import Flask
from flask_mysqldb import MySQL
from flask_cors import CORS
from routes.auth_routes import auth_bp
from dotenv import load_dotenv
import os

app = Flask(__name__)


CORS(app, resources={r"/*": {"origins": "http://localhost:3000"}})


load_dotenv()

app.config['MYSQL_HOST'] = os.getenv("DB_HOST")
app.config['MYSQL_USER'] = os.getenv("DB_USER")
app.config['MYSQL_PASSWORD'] = os.getenv("DB_PASSWORD")
app.config['MYSQL_DB'] = os.getenv("DB_NAME")
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)


app.register_blueprint(auth_bp)

if __name__ == "__main__":
    app.run(debug=True)
