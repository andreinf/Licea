from flask import Flask
from flask_mysqldb import MySQL
from flask_cors import CORS
from routes.auth_routes import auth_bp

app = Flask(__name__)


CORS(app, resources={r"/*": {"origins": "http://localhost:3000"}})


app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'        
app.config['MYSQL_PASSWORD'] = ''        
app.config['MYSQL_DB'] = 'licea_completa'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)


app.register_blueprint(auth_bp)

if __name__ == "__main__":
    app.run(debug=True)
