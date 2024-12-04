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
        query = "SELECT * FROM user WHERE id_user = %s"
        conexion.execute(query, (id,))
        user = conexion.fetchone()
        conexion.close()
        if user is None:
            return jsonify({"message": "User not found"}), 404
        return jsonify({
            "id_user": user[0],
            "username": user[1]
        })
    except Exception as e:
        return f"Error {str(e)}", 500


@app.route("/", methods = ["POST"])
def create_data():
    """
    Create data
    """
    data = request.json
    msg = validate_data(data)
    if msg:
        return jsonify({"message": msg}), 400

    try:
        # Crear conexion
        conexion = mysql.connection.cursor()
        query = "INSERT INTO user (username) VALUES (%s)"
        conexion.execute(query, (data["username"],))
        mysql.connection.commit()

        newId = conexion.lastrowid
        conexion.close()

        return jsonify({
            "message": "User added succesfully",
            "id_user": newId
        }),201
    except Exception as e:
        return jsonify({"err": f"Unexpected error: {str(e)}"}), 500


@app.route("/<int:id>", methods=["PATCH", "PUT"])
def modify_data(id):
    """
    Modifies exististing data
    """
    data = request.json
    msg = validate_data(data)
    if msg:
        return jsonify({"message": msg}), 400

    try:
        query = "UPDATE user SET username = %s WHERE id_user = %s"
        conexion = mysql.connection.cursor()
        conexion.execute(query, (data["username"], id))
        mysql.connection.commit()

        rowsModified = conexion.rowcount
        if rowsModified == 0:
            return jsonify({
                "message": "User not modified",
                "data": data
            }), 200

        conexion.close()
        return jsonify({"message": "User modified succesfully"}), 200
    except Exception as e:
        return jsonify({"err": f"Unexpected error: {str(e)}"}), 500



@app.route("/<int:id>", methods=["DELETE"])
def delete_data(id):
    '''
    Delete an item from the database
    '''
    get_one_by_id(id)
    try:
        query = "DELETE FROM user WHERE id_user = %s"
        conexion = mysql.connection.cursor()
        conexion.execute(query, (id,))
        mysql.connection.commit()

        conexion.close()
        return jsonify({"message": "User deleted succesfully"}), 200
    except Exception as e:
        return jsonify({"err": f"Unexpected error: {str(e)}"}), 500


def validate_data(data):
    if not data:
        return "No data provided"

    # Validar campos requeridos (ejemplo: username)
    required_fileds = ["username"]
    for field in required_fileds:
        if field not in data:
            return f"Field {field} is required"



if __name__ == "__main__":
    app.run(host = "0.0.0.0", port = 5001, debug = True)
