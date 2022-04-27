from flask import Flask,jsonify,request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
app.debug=True
@app.route('/')
def home():
    data = {'data':'hi'}
    return jsonify(data)

@app.route('/getdata', methods=['POST'])
def data():
    print(request.form.get('switch1'))

if __name__ == "__main__":
    app.run(host='0.0.0.0')
