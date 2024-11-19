# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

# blueprint definition for gradeschools
gradeschools_bp = Blueprint(
    'gradeschools_bp', __name__,
    template_folder='templates',
    static_folder='static'
)

# Route definitions for gradeschools
@gradeschools_bp.route('/')
def index():
    return render_template('gradeschools/index.html')

@gradeschools_bp.route('/<int:id>')
def details(id):
    #fetch and display details for each specific restaurant
    return render_template('gradeschools/details.html', id=id)