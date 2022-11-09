from flask import render_template, flash, redirect, url_for
from app import app 
from app.forms import SearchForm
from app.orm import Analysis

@app.route('/')
@app.route('/index')
@login_required
def index():
	user = {'username': 'bangsplat'}
	stats=[]
	return render_template('index.html',title='Home',user=user,stats=stats)

@app.route('/search', methods=['GET','POST'])
def search():
	form = SearchForm()
	if form.validate_on_submit():
		stats = Analysis.query.filter_by(playerid=form.playerid.data).all() #takes in playerid field from user
		for row in stats:
			if row.RC27 is None:
				row.setRC27()
		return render_template('search.html',title='Results',form=form, stats=stats) #if valid, present results
	return render_template('search.html',title='Search',form=form)
