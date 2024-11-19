# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

# blueprint definition for refreshments
refreshments_bp = Blueprint(
    'refreshments_bp', __name__,
    template_folder='templates',
    static_folder='static'
)

# Route definitions for refreshments
@refreshments_bp.route('/')
def index():
    return render_template('refreshments/index.html')

@refreshments_bp.route('/<int:id>')
def details(id):
    #fetch and display details for each specific restaurant
    return render_template('refreshments/details.html', id=id)