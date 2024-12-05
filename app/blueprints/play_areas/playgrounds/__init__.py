# app/blueprints/playareas/playgrounds/__init__.py

from flask import Blueprint

# Initialize the blueprint
playgrounds_bp = Blueprint(
    'playgrounds', __name__,
    template_folder='../../templates',  # Adjust path if needed
    static_folder='static'
)

# Import routes (make sure routes.py exists)
from . import routes
