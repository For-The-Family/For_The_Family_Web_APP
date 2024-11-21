# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

from . import test_js_bp

# Route for java script testing
@test_js_bp.route('/')
def index():
    return render_template('test_js/index.html')

