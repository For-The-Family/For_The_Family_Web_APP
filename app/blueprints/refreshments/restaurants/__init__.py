# Imports
from flask import Blueprint

# blueprint definition for restaurants
restaurants_bp = Blueprint(
    'restaurants', __name__,
    template_folder='../../templates/refreshments/restaurants',
    static_folder='static'
)

from . import routes