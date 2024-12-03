# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

from . import restaurants_bp

# Route definitions for restaurants
@restaurants_bp.route('/')
def index():
    return render_template('restaurants/index.html')
