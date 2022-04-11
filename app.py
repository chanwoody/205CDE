from flask import Flask, render_template, flash, redirect, url_for, session, logging, request
import pymysql
from wtforms import Form, StringField, TextAreaField, PasswordField, validators
from passlib.hash import sha256_crypt
from functools import wraps

app = Flask(__name__)
app.secret_key = 'Flask APP'

db = pymysql.connect (host="localhost", user="admin", password="admin",database="205CDE")

@app.route('/')
def index():
    
	return render_template('home.html')


@app.route('/about')
def about():
	return render_template('about.html')

@app.route('/products')
def products():

	cursor = db.cursor(pymysql.cursors.DictCursor)

	cursor.execute("SELECT * FROM products ")
	result = cursor.fetchall()

	cursor.close()
		
	return render_template('products.html', products = result)

@app.route('/product/<id>/')
def product(id):
	cursor = db.cursor(pymysql.cursors.DictCursor)

	cursor.execute("SELECT * FROM products INNER JOIN shop ON products.shopid = shop.id INNER JOIN users ON products.userid = users.id WHERE products.id= %s order by products.id",(id))
	result = cursor.fetchall()

	cursor.close()
		
	return render_template('product.html', products = result)

class RegisterForm(Form):
	name = StringField('Full Name', [validators.length(min=1, max=50)])
	username = StringField('UserName', [validators.length(min=4, max=25)])
	email = StringField('Email', [validators.length(min=6, max=50)])
	password = PasswordField('Password', [validators.DataRequired(), validators.EqualTo('confirm', message = 'Passwords do not match')])
	confirm = PasswordField('Confirm Password')

@app.route('/register', methods = ['GET',"POST"])
def register():
	form = RegisterForm(request.form)
	if request.method == "POST" and form.validate():
		name = form.name.data
		email = form.email.data
		username = form.username.data
		password = sha256_crypt.hash(str(form.password.data))

		cursor = db.cursor()
		cursor.execute("INSERT INTO users(name, email, username, password) VALUES (%s, %s, %s, %s)", (name, email, username, password))

		db.commit()

		
		flash('You are now registered and can login', 'success')
		return redirect(url_for('login'))

		return render_template('/register.html')
	return render_template('/register.html', form = form)

@app.route('/login', methods=["GET", "POST"])
def login():
	if request.method == "POST":
		username = request.form['username']
		password_candidate = request.form['password']
		
		cursor = db.cursor()

		result = cursor.execute("SELECT * FROM users WHERE username = %s", (username))
		if result > 0:
			data = cursor.fetchone()
			password = data[4]
			
			if sha256_crypt.verify(password_candidate, password):
				#app.logger.info('PASSWORD MATCHED')
				session['logged_in'] = True
				session['username'] = username
				session['userid'] = data[0]

				flash('You are now logged in', 'success')
				return redirect(url_for('dashboard'))	
			else:
				#app.logger.info('PASSWORD NOT MATCHED')
				error = 'Invalid login'
				return render_template('login.html', error = error)
			cursor.close()	
		else:
			#app.logger.info('NO USER')
			error = 'Username not found'
			return render_template('login.html', error = error)
			
	return render_template('login.html')

def is_logged_in(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if 'logged_in' in session:
			return f(*args, **kwargs)
		else:
			flash('Unauthorized, Please login', 'danger')
			return redirect(url_for('login'))
	return wrap

@app.route('/logout')
def logout():
	session.clear()
	flash('You are now logged out','success')
	return redirect(url_for('login'))

@app.route('/dashboard', methods=["GET", "POST"])
@is_logged_in
def dashboard():
	
	cursor = db.cursor(pymysql.cursors.DictCursor)

	cursor.execute("SELECT * FROM products INNER JOIN shop ON products.shopid=shop.id INNER JOIN users ON products.userid = users.id order by products.id")
	result = cursor.fetchall()
		
	return render_template('dashboard.html', products = result)

@app.route('/add_product', methods=['POST'])
def add_product():
    cursor = db.cursor(pymysql.cursors.DictCursor)
    if request.method == 'POST':
        product_name = request.form['product_name']
        introduce = request.form['introduce']
        price = request.form['price']
        userid = request.form['userid']
        shopid = request.form['shopid']

        cursor.execute("INSERT INTO products (product_name, introduce, price, userid, shopid) VALUES (%s,%s,%s,%s,%s)", (product_name, introduce, price, userid, shopid))
        db.commit()
        flash('Product Added Successfully','success')
        return redirect(url_for('dashboard'))
    
@app.route('/edit/<id>', methods = ['POST', 'GET'])
def get_product(id):
    cursor = db.cursor(pymysql.cursors.DictCursor)
  
    cursor.execute('SELECT * FROM products WHERE id = %s', (id))
    result = cursor.fetchall()
    cursor.close()
    print(result[0])
    return render_template('edit.html', products = result[0])

@app.route('/update/<id>', methods=['GET','POST'])
def update_product(id):
    if request.method == 'POST':
        product_name = request.form['product_name']
        introduce = request.form['introduce']
        price = request.form['price']
        shopid = request.form ['shopid']
        
        cursor = db.cursor(pymysql.cursors.DictCursor)
        cursor.execute("UPDATE products SET product_name = %s,introduce = %s,price = %s ,shopid = %s WHERE id = %s ", (product_name, introduce, price, shopid,id))
        flash('Products Updated Successfully','success')
        db.commit()
        return redirect(url_for('dashboard'))

@app.route('/delete/<string:id>', methods = ['GET','POST'])
def delete_product(id):
    
    cursor = db.cursor(pymysql.cursors.DictCursor)
  
    cursor.execute('DELETE FROM products WHERE id = {0}'.format(id))
    db.commit()
    flash('product Removed Successfully','success')
    return redirect(url_for('dashboard'))


if __name__== '__main__':
	app.run(debug=True)