# Imports
from flask import Blueprint

# blueprint definition for refreshments
refreshments_bp = Blueprint(
    'refreshments', __name__,
    template_folder='../../templates/refreshments',
    static_folder='static'
)

from . import routes