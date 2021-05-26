from flask import Flask, jsonify,request
from addDatabase import *
import time

app = Flask(__name__)
@app.route("/", methods=["GET","POST"])
def response():
    data = request.get_json()
    date = data['date']
    fName = data['fName'][1:-1]
    lName = data['lName'][1:-1]
    address = data['address'][1:-1]
    cNum = data['cNum'][1:-1]
    temp = data['temp'][1:-1]
    symp1 = data['symp1']
    symp2 = data['symp2']
    symp3 = data['symp3']
    symp4 = data['symp4']
    symp5 = data['symp5']

    #print('date: ' + date)
    #print('fName: ' + fName)
    #print('lName: ' + lName)
    #print('address: ' + address)
    #print('cNum: ' + cNum)
    #print('temp: ' + temp)
    #print('symp1: ' + symp1)
    #print('symp2: ' + symp2)
    #print('symp3: ' + symp3)
    #print('symp4: ' + symp4)
    #print('symp5: ' + symp5)

    addDatabase(date, fName, lName, address, cNum, temp, symp1, symp2, symp3, symp4, symp5)

    return 'Done'

if __name__ == '__main__':
    app.run(host='localhost', port='5000')
