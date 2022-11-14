from flask import render_template, flash, redirect, url_for
from app import app, db
from app.forms import SearchForm, RegistrationForm, FavoriteForm
from app.orm import Analysis, User
from flask_login import current_user, login_user, logout_user

@app.route('/', methods=['GET'])
@app.route('/index', methods=['GET'])
@login_required
def index():
	user = current_user.username
	favorites = Favorite.query.filter(Favorite.user == user).all()
	return render_template('index.html',title='Home',favorites=favorites)

@app.route('/search', methods=['GET','POST'])
@login_required
def search():
	form = SearchForm()
	form2 = FavoriteForm()
	if form.validate_on_submit():
		stats = Analysis.query.filter_by(playerid=form.playerid.data).all() #takes in playerid field from user
		# When new rows are added to analysis table on DB, update below for loop for that paricular row --------
		for row in stats: 
			if row.RC27 is None:
				row.setRC27()
		# ------------------------------------------------------------------------------------------------------
		return render_template('search.html',title='Results',form=form, stats=stats) #if valid, present results
	return render_template('search.html',title='Search',form=form)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('index'))
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(username=form.username.data).first()
        if user is None or not user.check_password(form.password.data):
            flash('Invalid username or password')
            return redirect(url_for('login'))
        login_user(user, remember=form.remember_me.data)
        return redirect(url_for('index'))
    return render_template('login.html', title='Sign In', form=form)

@app.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('index'))

@app.route('/register', methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('index'))
    form = RegistrationForm()
    if form.validate_on_submit():
        user = User(username=form.username.data, email=form.email.data)
        user.set_password(form.password.data)
        db.session.add(user)
        db.session.commit()
        flash('Congratulations, you are now a registered user!')
        return redirect(url_for('login'))
    return render_template('register.html', title='Register', form=form)
