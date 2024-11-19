# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

# blueprint definition for bonus
bonus_bp = Blueprint(
    'bonus_bp', __name__,
    template_folder='templates',
    static_folder='static'
)

# Route definitions for bonus
@bonus_bp.route('/')
def index():
    return render_template('bonus/index.html')

@bonus_bp.route('/<int:id>')
def details(id):
    #fetch and display details for each specific restaurant
    return render_template('bonus/details.html', id=id)