from flask import Flask, request, jsonify


app = Flask(__name__)

@app.route("/", methods = ['GET'])
def get_data():
    return "returns all data from the database"


@app.route("/<int:id>",  methods= ["GET"])
def get_one_by_id(id):
    return f"return a data from the database by id = ${id}"


@app.route("/", methods = ["POST"])
def create_data():
    data = request.json
    return jsonify(data),201


@app.route("/<int:id>", methods=["PATCH", "PUT"])
def modify_data(id):
    data = request.json
    return jsonify(data),203


@app.route("/<int:id>", methods=["DELETE"])
def delete_data(id):
    return f"Delete an item from the database by id = ${id}"

if __name__ == "__main__":
    app.run(host = "0.0.0.0", port = 5001, debug = True)
