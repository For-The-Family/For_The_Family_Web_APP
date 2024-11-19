# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

# blueprint definition for playgrounds
playgrounds_bp = Blueprint(
    'playgrounds_bp', __name__,
    template_folder='templates',
    static_folder='static'
)

# Route definitions for playgrounds
@playgrounds_bp.route('/')
def index():
    return render_template('playgrounds/index.html')

@playgrounds_bp.route('/<int:id>')
def details(id):
    #fetch and display details for each specific restaurant
    return render_template('playgrounds/details.html', id=id)