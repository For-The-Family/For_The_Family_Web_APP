# Imports
from flask import Blueprint, request, jsonify, render_template
import psycopg

from . import test_js_bp

def get_db_connection():
    conn = psycopg.connect(
        dbname='FTF_SQL',
        user='website_reader',
        password='Parlor-Ellipse-Grappling-Rival-Daylight-Backtalk7',
        host='153.92.134.127',
        port='5432'
    )
    return conn

# Route to render the index page
@test_js_bp.route('/')
def index():
    return render_template('test_js/index.html')

# Route to handle search queries
@test_js_bp.route('test_js/all', methods=['GET'])
def get_all_kindergartens():
    query = """SELECT k.*, 
                      ARRAY_AGG(DISTINCT a.activity_name) AS activities,
                      ARRAY_AGG(DISTINCT f.facility_name) AS facilities
               FROM kindergartens k
                JOIN kindergarten_activities ka ON k.id = ka.kindergarten_id
                JOIN activities a ON ka.activity_id = a.id
               JOIN kindergarten_facilities kf ON k.id = kf.kindergarten_id
               JOIN facilities f ON kf.facility_id = f.id
               GROUP BY k.id"""
    try:
        # Connect to the database
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(query)
                columns = [desc[0] for desc in cur.description]  # Fetch column names
                results = cur.fetchall()
                # Format the results into a list of dictionaries
                response = [dict(zip(columns, row)) for row in results]
        return jsonify(response)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Route to fetch details of a specific kindergarten
@test_js_bp.route('test_js/<int:kindergarten_id>', methods=['GET'])
def kindergarten_details(kindergarten_id):
    query = """SELECT k.*, 
                      ARRAY_AGG(DISTINCT a.activity_name) AS activities,
                      ARRAY_AGG(DISTINCT f.facility_name) AS facilities
               FROM kindergartens k
                JOIN kindergarten_activities ka ON k.id = ka.kindergarten_id
                JOIN activities a ON ka.activity_id = a.id
               JOIN kindergarten_facilities kf ON k.id = kf.kindergarten_id
               JOIN facilities f ON kf.facility_id = f.id
               WHERE k.id = %s
               GROUP BY k.id"""
    try:
        # Connect to the database
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(query, (kindergarten_id,))
                row = cur.fetchone()
                if row:
                    columns = [desc[0] for desc in cur.description]  # Fetch column names
                    response = dict(zip(columns, row))
                    return jsonify(response)
                else:
                    return jsonify({"error": "Kindergarten not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500
