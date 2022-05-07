from flask import Flask,jsonify,request
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///switches.db'
app.config['SECRET_KEY'] = "trojon"
db = SQLAlchemy(app)

class Switch_status(db.Model):
    id = db.Column(db.Integer,primary_key = True)
    switch1 = db.Column(db.Boolean, nullable = False)
    switch2 = db.Column(db.Boolean, nullable = False)
    switch3 = db.Column(db.Boolean, nullable = False)
    def __repr__(self):
        return f"switch1:{self.switch1}, switch2:{self.switch2}, switch3:{self.switch3}"


app.debug=True
@app.route('/')
def home():
    status = Switch_status.query.one()
    st = {
        'switch1':status.switch1,
        'switch2':status.switch2,
        'switch3':status.switch3,
    }
    return jsonify({"data":st})

@app.route('/getdata', methods=['POST'])
def data():
    # print(request.form.get('switch1'))
    d = request.json['switch']
    try:
        status = Switch_status.query.one()
        if(d == "switch1"):
            status.switch1 = not status.switch1
            db.session.commit()
        elif(d == "switch2"):
            status.switch2 = not status.switch2
            db.session.commit()
        elif(d == "switch3"):
            status.switch3 = not status.switch3
            db.session.commit()
        print(status)
    except:
        print("ERror")
    st = {
        'switch1':status.switch1,
        'switch2':status.switch2,
        'switch3':status.switch3,
    }
    return jsonify({"data":st})

if __name__ == "__main__":
    app.run(host='0.0.0.0')
