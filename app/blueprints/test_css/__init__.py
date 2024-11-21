# app/blueprints/test_css/__init__.py

from flask import Blueprint

# Initialize the blueprint
test_css_bp = Blueprint(
    'test_css', __name__,
    template_folder='../templates',  # Adjust path if needed
    static_folder='static'
)

# Import routes (make sure routes.py exists)
from . import routes

