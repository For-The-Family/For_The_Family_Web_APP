# app/blueprints/front_page/__init__.py

from flask import Blueprint

# Initialize the blueprint
front_page_bp = Blueprint(
    'front_page', __name__
)

# Import routes (make sure routes.py exists)
from . import routes
