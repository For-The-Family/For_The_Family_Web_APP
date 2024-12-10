# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

from . import play_areas_bp

# Route definitions for play_areas
@play_areas_bp.route('/')
def index():
    return render_template('index.html')

#@play_areas_bp.route('/<int:id>')
#def details(id):
#    #fetch and display details for each specific restaurant
#    return render_template('play_areas/details.html', id=id)