# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

from . import refreshments_bp

# Route definitions for refreshments
@refreshments_bp.route('/')
def index():
    return render_template('refreshments/index.html')
