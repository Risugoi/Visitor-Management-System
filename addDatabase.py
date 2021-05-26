import sqlite3

def addDatabase(date, fName, lName, address, cNum, temp, symp1, symp2, symp3, symp4, symp5):

    if(symp1=='null'):
        symp1 = 0
    else: 
        symp1 = 1

    if(symp2=='null'):
        symp2 = 0
    else: 
        symp2 = 1

    if(symp3=='null'):
        symp3 = 0
    else: 
        symp3 = 1

    if(symp4=='null'):
        symp4 = 0
    else: 
        symp4 = 1

    if(symp5[:-1]=='null'):
        symp5 = 0
    else: 
        symp5 = 1
    
    #print(date)
    #print(fName)
    conn = sqlite3.connect('VMSDatabase.db')
    conn.execute('''CREATE TABLE IF NOT EXISTS Visitors(Date, Firstname, Lastname, Address, ContactNumber, Temperature, Symptoms1, Symptoms2, Symptoms3, Symptoms4, Symptoms5)''')
    conn.execute("INSERT INTO Visitors (Date, Firstname, Lastname, Address, ContactNumber, Temperature, Symptoms1, Symptoms2, Symptoms3, Symptoms4, Symptoms5) VALUES (?,?,?,?,?,?,?,?,?,?,?)",(date, fName, lName, address, cNum, temp, symp1, symp2, symp3, symp4, symp5))
    conn.commit()
    print('Inserted')
    conn.close()