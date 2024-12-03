# app/blueprints/front_page/__init__.py

from flask import Blueprint

# Initialize the blueprint
front_page_bp = Blueprint(
    'front_page', __name__,
    template_folder='../../templates',  # Adjust path if needed
    static_folder='static'
)

# Import routes
from . import routes
