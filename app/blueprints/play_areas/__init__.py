from flask import Blueprint

play_areas_bp = Blueprint(
    'play_areas', __name__,
    template_folder='../../templates',  # Adjust path if needed
    static_folder='static'
)

# Import the routes for this blueprint
from . import routes
