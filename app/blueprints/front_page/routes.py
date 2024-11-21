# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for

from . import front_page_bp

# Route definitions for front_page
@front_page_bp.route('/')
def home():
    return render_template('index.html')

