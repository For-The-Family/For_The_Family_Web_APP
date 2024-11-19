# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

# blueprint definition for kindergartens
kindergartens_bp = Blueprint(
    'kindergartens_bp', __name__,
    template_folder='templates',
    static_folder='static'
)

# Route definitions for kindergartens
@kindergartens_bp.route('/')
def index():
    return render_template('kindergartens/index.html')

@kindergartens_bp.route('/<int:id>')
def details(id):
    #fetch and display details for each specific restaurant
    return render_template('kindergartens/details.html', id=id)