from flask import Flask, request, jsonify
from flask_mysqldb import MySQL


app = Flask(__name__)

app.config["MYSQL_HOST"]="database"
app.config["MYSQL_USER"]="prueba"
app.config["MYSQL_PASSWORD"]="prueba"
app.config["MYSQL_DB"]="prueba_docker"

mysql = MySQL(app)



@app.route("/", methods = ['GET'])
def get_data():
    """
    Get all data
    """
    try:
        # Creamos una conexion
        conexion = mysql.connection.cursor()
        conexion.execute('SELECT * FROM user')
        users = conexion.fetchall()
        results = []
        for user in users:
            results.append({
                "id": user[0],
                "username": user[1]
            })
        conexion.close()
        return jsonify(results)
    except Exception as e:
        return f"Error {str(e)}"


@app.route("/<int:id>",  methods= ["GET"])
def get_one_by_id(id):
    """
    Get data by id
    """
    try:
        # Creamos una conexion
        conexion = mysql.connection.cursor()
        conexion.execute(f'SELECT * FROM user WHERE id_user = {id}')
        user = conexion.fetchone()
        conexion.close()
        if user is None:
            return jsonify({"message": "User not found"}), 404
        return jsonify({
            "id": user[0],
            "username": user[1]
        })
    except Exception as e:
        return f"Error {str(e)}"


@app.route("/", methods = ["POST"])
def create_data():
    """
    Create data
    """
    data = request.json
    return jsonify(data),201


@app.route("/<int:id>", methods=["PATCH", "PUT"])
def modify_data(id):
    """
    Modifies exististing data
    """
    data = request.json
    return jsonify(data),203


@app.route("/<int:id>", methods=["DELETE"])
def delete_data(id):
    '''
    Delete an item from the database
    '''
    return f"Delete an item from the database by id = ${id}"

if __name__ == "__main__":
    app.run(host = "0.0.0.0", port = 5001, debug = True)
