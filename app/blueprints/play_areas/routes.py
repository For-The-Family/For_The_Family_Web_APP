# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

# blueprint definition for play_areas
play_areas_bp = Blueprint(
    'play_areas_bp', __name__,
    template_folder='templates/play_areas',
    static_folder='static'
)

# Route definitions for play_areas
@play_areas_bp.route('/')
def index():
    return render_template('play_areas/index.html')

#@play_areas_bp.route('/<int:id>')
#def details(id):
#    #fetch and display details for each specific restaurant
#    return render_template('play_areas/details.html', id=id)