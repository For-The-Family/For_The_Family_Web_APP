# app/blueprints/test_sql/__init__.py

from flask import Blueprint

# Initialize the blueprint
test_sql_bp = Blueprint(
    'test_sql', __name__,
    template_folder='../templates',  # Adjust path if needed
    static_folder='static'
)

# Import routes (make sure routes.py exists)
from . import routes

