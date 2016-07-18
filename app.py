from flask import Flask, render_template, redirect, jsonify, request
from flaskext.mysql import MySQL
import random

mysql = MySQL()
app = Flask(__name__)

# Set up MySQL Connection Variables
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'ideas'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

# define connection variables
db = mysql.connect()
cursor = db.cursor()

currentWeek = 1

def generateString(length):
    return ''.join(random.choice('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz') for i in range(length))

def verify_user(userId, passKey):
    cursor.execute("SELECT * FROM `users` WHERE `longid`=%s AND `passkey`=%s", (userId, passKey))
    if cursor.rowcount > 0:
        success = True
        userNumId = cursor.fetchone()[0]
    else:
        success = False
        userNumId = None

    return {"success":success, "userNumId":userNumId}


@app.route("/week/<weekNum>/")
@app.route("/")
def vote_page(weekNum=currentWeek):
    cursor.execute("SELECT * FROM ideas WHERE week=%s", (weekNum,))
    rawItems = cursor.fetchall()
    items = []
    for item in rawItems:
        cursor.execute("SELECT itemid FROM `upvotes` WHERE `itemid`=%s", (item[0],))
        upvotes = cursor.rowcount
        cursor.execute("SELECT itemid FROM `downvotes` WHERE `itemid`=%s", (item[0],))
        downvotes = cursor.rowcount
        karma = upvotes - downvotes
        items.append({"id":item[3], "title":item[1], "text":item[2], "date":item[4], "karma":karma})

    return render_template("vote.html", week=weekNum, items=items, numItems=len(items))


@app.route("/api/ideas/current/", methods = ["GET"])
@app.route("/api/ideas/week/<weekNum>/", methods = ["GET"])
def get_ideas(weekNum=currentWeek):

    items = []

    userId = request.args.get("userId")
    passKey = request.args.get("passKey")

    cursor.execute("SELECT id, title, text, longid, unix_timestamp(date), week FROM `ideas` WHERE week=%s ORDER BY date DESC", (weekNum,))
    rawItems = cursor.fetchall()

    verifyuser = verify_user(userId, passKey)
    userNumId = verifyuser["userNumId"]

    if verifyuser["success"]:
        for item in rawItems:
            cursor.execute("SELECT * FROM `upvotes` WHERE `userid`=%s AND `itemid`=%s", (userNumId,item[0]))

            vote = "neutral"

            if cursor.rowcount > 0:
                vote = "upvoted"
            else:
                cursor.execute("SELECT * FROM `downvotes` WHERE `userid`=%s AND `itemid`=%s", (userNumId,item[0]))
                if cursor.rowcount > 0:
                    vote = "downvoted"

            cursor.execute("SELECT itemid FROM `upvotes` WHERE `itemid`=%s", (item[0],))
            upvotes = cursor.rowcount

            cursor.execute("SELECT itemid FROM `downvotes` WHERE `itemid`=%s", (item[0],))
            downvotes = cursor.rowcount

            karma = upvotes - downvotes

            items.append({"id":item[3], "title":item[1], "text":item[2], "date":item[4], "vote":vote, "karma":karma})

        return jsonify({"success":True, "error":"", "payload":{"items":items}})
    else:
        return jsonify({"success":False, "error":"Unable to verify user", "payload":{}})


@app.route("/api/user/", methods = ["POST"])
def create_user():
    success = False
    error = ""
    payload = {}

    userLongId = generateString(60)
    cursor.execute("SELECT `longid` FROM `users` WHERE `longid`=%s", (userLongId,))
    numRows = cursor.rowcount

    while numRows > 0:
        userLongId = generateString(60)
        cursor.execute("SELECT `longid` FROM users WHERE `longid`=%s", (userLongId,))
        numRows = cursor.rowcount

    passKey = generateString(15)
    cursor.execute("INSERT INTO `users` (`longid`, `passkey`) VALUES (%s, %s)", (userLongId,passKey))
    db.commit()

    success = True
    error = ""
    payload = {"userId":userLongId, "passKey":passKey}

    return jsonify({"success":success, "error":error, "payload":payload})



@app.route("/api/<itemId>/unvote/", methods = ["POST"])
def unvote(itemId):
    userId = request.form["userId"]
    passKey = request.form["passKey"]

    verifyuser = verify_user(userId, passKey)

    if verifyuser["success"]:
        success = True
        error = ""
        userNumId = verifyuser["userNumId"]

        cursor.execute("SELECT `id`, `longid` FROM `ideas` WHERE `longid`=%s", (itemId,))
        itemNumId = cursor.fetchone()[0]

        cursor.execute("DELETE FROM `upvotes` WHERE `userid`=%s AND `itemid`=%s", (userNumId, itemNumId))
        cursor.execute("DELETE FROM `downvotes` WHERE `userid`=%s AND `itemid`=%s", (userNumId, itemNumId))
        db.commit()
    else:
        success = False
        error = "Unable to verify user."

    return jsonify({"success":success, "error":error})



@app.route("/api/<itemId>/upvote/", methods = ["POST"])
def upvote(itemId):
    userId = request.form["userId"]
    passKey = request.form["passKey"]

    verifyuser = verify_user(userId, passKey)

    if verifyuser["success"]:
        success = True
        error = ""
        userNumId = verifyuser["userNumId"]

        cursor.execute("SELECT `id`, `longid` FROM `ideas` WHERE `longid`=%s", (itemId,))
        itemNumId = cursor.fetchone()[0]

        cursor.execute("DELETE FROM `upvotes` WHERE `userid`=%s AND `itemid`=%s", (userNumId, itemNumId))
        cursor.execute("DELETE FROM `downvotes` WHERE `userid`=%s AND `itemid`=%s", (userNumId, itemNumId))
        cursor.execute("INSERT INTO `upvotes` (`userid`, `itemid`) VALUES (%s, %s)", (userNumId, itemNumId))
        db.commit()
    else:
        success = False
        error = "Unable to verify user."

    return jsonify({"success":success, "error":error})



@app.route("/api/<itemId>/downvote/", methods = ["POST"])
def downvote(itemId):
    userId = request.form["userId"]
    passKey = request.form["passKey"]

    verifyuser = verify_user(userId, passKey)

    if verifyuser["success"]:
        success = True
        error = ""
        userNumId = verifyuser["userNumId"]

        cursor.execute("SELECT `id`, `longid` FROM `ideas` WHERE `longid`=%s", (itemId,))
        itemNumId = cursor.fetchone()[0]

        cursor.execute("DELETE FROM `upvotes` WHERE `userid`=%s AND `itemid`=%s", (userNumId, itemNumId))
        cursor.execute("DELETE FROM `downvotes` WHERE `userid`=%s AND `itemid`=%s", (userNumId, itemNumId))
        cursor.execute("INSERT INTO `downvotes` (`userid`, `itemid`) VALUES (%s, %s)", (userNumId, itemNumId))
        db.commit()
    else:
        success = False
        error = "Unable to verify user."

    return jsonify({"success":success, "error":error})




@app.route("/api/idea/", methods = ["POST"])
def create_idea():
    success = False
    error = ""
    payload = {}

    userId = request.form["userId"]
    passKey = request.form["passKey"]

    title = request.form["title"]
    text = request.form["text"]

    longId = generateString(20)
    cursor.execute("SELECT `longid` FROM `ideas` WHERE `longid`=%s", (longId,))
    numRows = cursor.rowcount

    while numRows > 0:
        longId = generateString(20)
        cursor.execute("SELECT `longid` FROM ideas WHERE `longid`=%s", (longId,))
        numRows = cursor.rowcount


    verifyuser = verify_user(userId, passKey)

    if verifyuser["success"]:
        success = True
        error = ""
        userNumId = verifyuser["userNumId"]
        if len(title) > 0 and len(text) > 0:
            cursor.execute("INSERT INTO `ideas` (`title`, `text`, `longid`, `week`) VALUES (%s, %s, %s, %s)", (title, text, longId, currentWeek))
            insertedId = cursor.lastrowid
            cursor.execute("INSERT INTO `upvotes` (`userid`, `itemid`) VALUES (%s, %s)", (userNumId, insertedId))
            db.commit()
        else:
            success = False
            error = "Invalid Submission"
    else:
        error = "Unable to verify user"


    return jsonify({"success":success, "error":error, "payload":payload})




if __name__ == "__main__":
    app.run()
