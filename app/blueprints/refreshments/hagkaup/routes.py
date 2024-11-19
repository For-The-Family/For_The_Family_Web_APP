# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

# blueprint definition for hagkaup
hagkaup_bp = Blueprint(
    'hagkaup_bp', __name__,
    template_folder='templates',
    static_folder='static'
)

# Route definitions for hagkaup
@hagkaup_bp.route('/')
def index():
    return render_template('hagkaup/index.html')

@hagkaup_bp.route('/<int:id>')
def details(id):
    #fetch and display details for each specific restaurant
    return render_template('hagkaup/details.html', id=id)