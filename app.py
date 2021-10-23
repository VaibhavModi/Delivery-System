# Pip install waitress

from flask import Flask, render_template, request, make_response
#from waitress import serve
import mysql.connector
from werkzeug.utils import redirect
from datetime import datetime


app = Flask(__name__)
app.url_map.strict_slashes = False

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="root",
  database="delivery"
)

mycursor = mydb.cursor(buffered=True)
# mycursor.execute("CREATE DATABASE deliverysystem")
mycursor.execute("SHOW tables")

userdata={'logintype':'','user_name':'', 'user_CID':'', 'user_DID':''}
result = {'viewtype':'', 'addtocart':''}

mycursor.execute("select customerID from customer order by customerID DESC limit 1")
cid = mycursor.fetchall()
mycursor.execute("select shopID from shops order by shopID DESC limit 1")
sid = mycursor.fetchall()
mycursor.execute("select OID from orderitems order by OID DESC limit 1")
oid = mycursor.fetchall()
mycursor.execute("select productid from products order by productid DESC limit 1")
pid = mycursor.fetchall()
mycursor.execute("select deliveryid from delivery order by deliveryid DESC limit 1")
did = mycursor.fetchall()
mycursor.execute("select paymentid from payment order by paymentid DESC limit 1")
paymentid = mycursor.fetchall()
mycursor.execute("select fid from feedback order by fid DESC limit 1")
fid = mycursor.fetchall()
key = {'cid':cid[0][0],'sid':cid[0][0], 'oid':oid[0][0], 'pid': pid[0][0],'did': did[0][0], 'paymentid':paymentid[0][0],'fid': fid[0][0]}

@app.route("/")
@app.route('/home', methods=['GET', 'POST'])
def home():
    title = 'Home'
    if request.method =='POST':
        if 'logoutbtn' in request.form:
            userdata['logintype']=''
            userdata['user_name']=''
            return render_template('index.html', title=title, logintype=userdata['logintype'],user_name=userdata['user_name'])
    return render_template('index.html', title=title, logintype=userdata['logintype'],user_name=userdata['user_name'])

# @app.route('/projects')
# def projects():
#     title = 'Projects'
#     return render_template('projects.html',title=title)

# @app.route('/blogs', methods=['GET', 'POST'])
# def second():
#     title = "Blogs"
#     return render_template('blogs.html', title=title)

@app.route('/contact', methods=['GET', 'POST'])
def contact():
    return render_template('contact.html', user_name=userdata['user_name'])

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method =='POST':
        result = request.form
        if result['customertype']=='customer':
            mycursor.execute("select customerID from custlogin where username='{}' AND password='{}'".format(result['username'],result['password']))
            authentication = mycursor.fetchall() 
            if not authentication:
                print('Not authenticated')
                userdata['user_name']=''
                userdata['user_CID']=''
                return render_template('login.html',failed='Login Failed')
            else:
                mycursor.execute("select name,customerID from customer where customerID='{}'".format(authentication[0][0]))
                user_name = mycursor.fetchall()
                userdata['user_name'] = user_name[0][0]
                userdata['logintype'] = result['customertype']
                userdata['user_CID'] = user_name[0][1]
                return render_template('index.html', logintype=userdata['logintype'], user_name=userdata['user_name'])
        
        if result['customertype']=='shop':
            mycursor.execute("select shopID from shopslogin where username='{}' AND password='{}'".format(result['username'],result['password']))
            authentication = mycursor.fetchall() 
            if not authentication:
                print('Not authenticated')
                userdata['user_name']=''
                userdata['user_CID']=''
                return render_template('login.html',failed='Login Failed')
            else:
                mycursor.execute("select name,shopID from shops where shopID='{}'".format(authentication[0][0]))
                user_name = mycursor.fetchall()
                userdata['user_name'] = user_name[0][0]
                userdata['logintype'] = result['customertype']
                userdata['user_CID'] = user_name[0][1]
                return render_template('index.html', logintype=userdata['logintype'], user_name=userdata['user_name'])
                
        if result['customertype']=='deliverybot':
            mycursor.execute("select botID from botlogin where username='{}' AND password='{}'".format(result['username'],result['password']))
            authentication = mycursor.fetchall() 
            if not authentication:
                print('Not authenticated')
                userdata['user_name']=''
                userdata['user_CID']=''
                return render_template('login.html',failed='Login Failed')
            else:
                userdata['user_name'] = authentication[0][0]
                userdata['logintype'] = result['customertype']
                userdata['user_CID'] = authentication[0][0]
                return render_template('index.html', logintype=userdata['logintype'], user_name=userdata['user_name'])
    return render_template('login.html') 

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        result = request.form
        if result['accounttype']=='customer':
            increment = key['cid'].split('-')
            key['cid'] = increment[0] + '-' + str(int(increment[1])+1)
        
            print(key['cid'],result['name'],result['street'],result['city'],result['zip'])
            result = request.form
            mycursor.execute("insert into customer values('{}','{}','{}','{}','{}')".format(key['cid'],result['name'],result['street'],result['city'],result['zip']))
            mydb.commit()
            mycursor.execute("insert into phone_customer values('{}','{}')".format(result['phone'],key['cid']))
            mydb.commit()
            mycursor.execute("insert into custlogin values('{}','{}','{}')".format(key['cid'],result['username'],result['password']))
            mydb.commit()
            return redirect('/login') 

        if result['accounttype']=='shop':
            increment = key['sid'].split('-')
            key['sid'] = increment[0] + '-' + str(int(increment[1])+1)
            print(key['sid'],result['name'],result['street'],result['city'],result['zip'])
            result = request.form
            mycursor.execute("insert into shops values('{}','{}','{}','{}','{}')".format(key['sid'],result['name'],result['street'],result['city'],result['zip']))
            mydb.commit()
            mycursor.execute("insert into shopslogin values('{}','{}','{}')".format(key['sid'],result['username'],result['password']))
            mydb.commit()
            return redirect('/login')
        
        if result['accounttype']=='deliverybot':
            return redirect('/login')
    return render_template('register.html')

@app.route('/shops', methods=['GET', 'POST'])
def shops():
    viewtype = 'Shops'
    if request.method == 'POST':
        result = request.form
        if 'viewtype' in result:
            if result['viewtype']=='product':
                viewtype = 'Products'
                mycursor.execute("select * from products")
                allproducts = mycursor.fetchall()
                return render_template('products.html', viewtype = viewtype, user_name=userdata['user_name'],allproducts=allproducts)
        if 'addtocart' in result:
            increment = key['oid'].split('-')
            key['oid'] = increment[0] + '-' + str(int(increment[1])+1)
            mycursor.execute("select * from products where productid = '{}'".format(result['addtocart']))
            product = mycursor.fetchall()[0]
            mycursor.execute("insert into orderitems values('{}','{}','{}','{}','{}','{}','{}')".format(key['oid'],userdata['user_CID'],result['addtocart'],product[1],result['productquantity'],datetime.now().strftime("%Y/%m/%d %H:%M:%S"),'pending'))
            mydb.commit()
            
            quantity = int(product[2])-int(result['productquantity'])
            mycursor.execute("update products set quantity = '{}' where productid='{}'".format(quantity,result['addtocart']))
            mydb.commit()
            mycursor.execute("select * from products")
            allproducts = mycursor.fetchall()
            return render_template('products.html', viewtype = 'Products', user_name=userdata['user_name'],allproducts=allproducts)
        if 'shopsproduct' in result:
            mycursor.execute("select * from products natural inner join product_shops where ShopID = '{}'".format(result['shopsproduct']))
            allproducts = mycursor.fetchall()
            return render_template('products.html', viewtype = viewtype, user_name=userdata['user_name'],allproducts=allproducts)
    mycursor.execute("select * from shops")
    allshops = mycursor.fetchall()
    return render_template('shops.html',viewtype = viewtype, user_name=userdata['user_name'],allshops=allshops)

@app.route('/products', methods=['GET', 'POST'])
def products():
    return render_template('products.html',viewtype = 'Products', user_name=userdata['user_name'])

@app.route('/checkout', methods=['GET', 'POST'])
def checkout():
    mycursor.execute("select * from orderitems inner join products on orderitems.productID = products.productID where customerID ='{}' and paymentstatus='{}'".format(userdata['user_CID'],'pending'))
    orderitems = mycursor.fetchall()
    count=0
    for i in orderitems:
        count = count + int(i[10]) * int(i[4])
    if request.method == 'POST':
        increment = key['paymentid'].split('-')
        key['paymentid'] = increment[0] + '-' + str(int(increment[1])+1)
        increment = key['did'].split('-')
        key['did'] = increment[0] + '-' + str(int(increment[1])+1)
        result = request.form
        if 'payment' in result:
            for i in range(len(orderitems)):
                mycursor.execute("update orderitems set paymentstatus='completed' where OID ='{}'".format(orderitems[i][0]))
                mydb.commit()
            mycursor.execute("insert into payment values('{}','{}','{}','{}')".format(key['paymentid'],userdata['user_CID'],count,result['cardno']))
            mydb.commit()
            mycursor.execute("select * from products natural inner join shops where productid = '{}'".format(orderitems[0][2]))
            orderitems = mycursor.fetchall()[0]
            mycursor.execute("insert into delivery values('{}','{}','{}','{}','{}')".format(key['did'],datetime.now().strftime("%H:%M:%S"),'shop',userdata['user_CID'],orderitems[7] ))
            mydb.commit()
            # mycursor.execute("insert into orderitems_delivery values('{}','{}','{}','{}','{}','{}','{}','{}')".format(key['oid'],key['did'],userdata['user_CID'], orderitems[0][0], datetime.now().strftime("%H:%M:%S"),'shop',userdata['user_CID'],orderitems[7] ))
            # mydb.commit()
        return redirect('/home')
    return render_template('checkout.html', user_name=userdata['user_name'], user_CID=userdata['user_CID'],orderitems=orderitems, count=count)

@app.route('/custcourier', methods=['GET', 'POST'])
def custcourier():
    mycursor.execute("select * from customer".format())
    customers = mycursor.fetchall()
    if request.method == 'POST':
        return render_template('checkout.html', user_name=userdata['user_name'])
    return render_template('custcourier.html', user_name=userdata['user_name'], customers=customers)

@app.route('/history', methods=['GET', 'POST'])
def history():
    mycursor.execute("select * from orderitems".format())
    orders = mycursor.fetchall()
    if request.method == 'POST':
        result = request.form
        if 'orderfeedback' in result:
            mycursor.execute("select * from orderitems".format())
            orders = mycursor.fetchall()
            return render_template('feedback.html', user_name=userdata['user_name'], orderid=result['orderfeedback'])

        if 'send' in result:
            increment = key['fid'].split('-')
            key['fid'] = increment[0] + '-' + str(int(increment[1])+1)
            mycursor.execute("insert into feedback values('{}','{}','{}')".format(key['fid'],orders[0][0],result['message']))
            mydb.commit()
    return render_template('history.html', user_name=userdata['user_name'], orders=orders)

@app.route('/shopshistory', methods=['GET', 'POST'])
def shopshistory():
    mycursor.execute("select * from product_shops natural inner join orderitems where shopID='{}'".format(userdata['user_CID']))
    shopsproduct = mycursor.fetchall()
    if request.method == 'POST':

        result = request.form
        if 'orderdetails' in result:
            mycursor.execute("select * from orderitems_delivery where OID='{}'".format(result['orderdetails']))
            delivery = mycursor.fetchall()
            mycursor.execute("select source, destination from delivery where deliveryid='{}'".format(delivery[0][1]))
            deliverylocation = mycursor.fetchall()
            mycursor.execute("select trackingid from delivery_schedule where deliveryid='{}'".format(delivery[0][1]))
            tracking = mycursor.fetchall()
            return render_template('tracking.html', user_name=userdata['user_name'], user_DID=userdata['user_DID'], editable=0,tracking=tracking[0][0],delivery=delivery[0][1],deliverylocation=deliverylocation)
    return render_template('shopshistory.html', user_name=userdata['user_name'], user_CID=userdata['user_CID'],shopsproduct=shopsproduct)

@app.route('/shopsproduct', methods=['GET', 'POST'])
def shopsproduct():
    mycursor.execute("select * from products natural inner join shops where shops.shopID='{}'".format(userdata['user_CID']))
    shopsproduct = mycursor.fetchall()
    if request.method == 'POST':
        result = request.form
        if 'update' in result:
            mycursor.execute("update products set quantity = '{}', price='{}' where productid='{}'".format(result['quantity'],result['price'],result['update']))
            mydb.commit()
            mycursor.execute("select * from products natural inner join shops where shops.shopID='{}'".format(userdata['user_CID']))
            shopsproduct = mycursor.fetchall()
            return render_template('shopsproduct.html',logintype=userdata['logintype'], user_name=userdata['user_name'],shopsproduct=shopsproduct)
        if 'delete' in result:
            mycursor.execute("delete from products where productId='{}'".format(result['delete']))
            mydb.commit()
        if 'addproduct' in result:
            increment = key['pid'].split('-')
            key['pid'] = increment[0] + '-' + str(int(increment[1])+1)
            mycursor.execute("insert into products values('{}','{}','{}','{}')".format(key['pid'], result['name'],result['quantity'],result['price']))
            mydb.commit()
            return redirect('/shopsproduct')
    return render_template('shopsproduct.html',logintype=userdata['logintype'], user_name=userdata['user_name'],shopsproduct=shopsproduct)

@app.route('/botschedule', methods=['GET', 'POST'])
def botschedule():
    mycursor.execute("select trackingid from delivery_schedule where botid='{}'".format(userdata['user_CID']))
    tracking = mycursor.fetchall()
    mycursor.execute("select status from tracking where trackingid='{}'".format(tracking[0][0]))
    trackingstatus = mycursor.fetchall()
    mycursor.execute("select deliveryid,source, destination from delivery_schedule natural inner join delivery where trackingID='{}'".format(tracking[0][0]))
    deliverylocation = mycursor.fetchall()
    delivery = deliverylocation[0][0]
    if request.method == 'POST':
        
        result = request.form
        if 'updatetracking' in result:
            return render_template('tracking.html', user_name=userdata['user_name'], user_DID=userdata['user_DID'], editable=1,deliverylocation=[[deliverylocation[0][1],deliverylocation[0][2]]],delivery=delivery)
    return render_template('botschedule.html', user_name=userdata['user_name'], user_CID=userdata['user_CID'],trackingstatus=trackingstatus,tracking=tracking,deliverylocation=deliverylocation )

if __name__ == '__main__':
    #serve(app, host="0.0.0.0", port=8080)
    app.run(debug=True)
