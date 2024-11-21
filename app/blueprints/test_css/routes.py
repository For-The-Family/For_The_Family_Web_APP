# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

from . import test_css_bp

# Route for java script testing
@test_css_bp.route('/')
def index():
    return render_template('test_css/index.html')

