# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

# blueprint definition for restaurants
restaurants_bp = Blueprint(
    'restaurants_bp', __name__,
    template_folder='templates',
    static_folder='static'
)

# Route definitions for restaurants
@restaurants_bp.route('/')
def index():
    return render_template('restaurants/index.html')

@restaurants_bp.route('/<int:id>')
def details(id):
    #fetch and display details for each specific restaurant
    return render_template('restaurants/details.html', id=id)