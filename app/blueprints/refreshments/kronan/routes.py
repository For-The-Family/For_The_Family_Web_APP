# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

# blueprint definition for kronan
kronan_bp = Blueprint(
    'kronan_bp', __name__,
    template_folder='templates',
    static_folder='static'
)

# Route definitions for kronan
@kronan_bp.route('/')
def index():
    return render_template('kronan/index.html')

@kronan_bp.route('/<int:id>')
def details(id):
    #fetch and display details for each specific restaurant
    return render_template('kronan/details.html', id=id)