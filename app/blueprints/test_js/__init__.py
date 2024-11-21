# app/blueprints/test_js/__init__.py

from flask import Blueprint

# Initialize the blueprint
test_js_bp = Blueprint(
    'test_js', __name__,
    template_folder='../templates',  # Adjust path if needed
    static_folder='static'
)

# Import routes (make sure routes.py exists)
from . import routes

