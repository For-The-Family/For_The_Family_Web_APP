# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for
from . import kindergartens_bp

# Route definitions for front_page
@kindergartens_bp.route('/')
def index():
    return render_template('play_areas/kindergartens/index.html')

