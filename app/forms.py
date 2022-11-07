from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField
from wtforms.validators import DataRequired

class SearchForm(FlaskForm):
	playerid = StringField('Player', validators=[DataRequired()])
	# password = PasswordField('Password', validators=[DataRequired()])
	# yearid = StringField('Year', validators=[DataRequired()])
	remember_me = BooleanField('Remember Me')
	submit = SubmitField('Search')
