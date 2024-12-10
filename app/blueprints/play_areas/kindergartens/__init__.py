from flask import Blueprint

kindergartens_bp = Blueprint(
    'kindergartens_bp', __name__,
    template_folder='../../templates/',  # Adjust path if needed
    static_folder='static'
)

# Import the routes for this blueprint
from . import routes

