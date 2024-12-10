# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for
import psycopg  # Ensure psycopg library is installed
from . import kindergartens_bp

# Route definitions for front_page
@kindergartens_bp.route('/')
def index():
    return render_template('index.html')
# Connection Function
# zeh connecty boyyyy
def get_db_connection():
    conn = psycopg.connect(
        dbname='FTF_SQL',
        user='website_reader',
        password='Parlor-Ellipse-Grappling-Rival-Daylight-Backtalk7',
        host='153.92.134.127',
        port='5432'
    )
    return conn


# Route to handle search queries
@kindergartens_bp.route('/search', methods=['GET'])
def search():
    pattern = request.args.get('q', '')
    query = """SELECT id, name, city, street_address, opening_hours 
               FROM kindergartens 
               WHERE name ILIKE %s OR city ILIKE %s OR street_address ILIKE %s"""
    try:
        # Connect to the database
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(query, (f"%{pattern}%", f"%{pattern}%", f"%{pattern}%"))
                results = cur.fetchall()
                # Format the results into a list of dictionaries
                response = [
                    {
                        "id": row[0],
                        "name": row[1],
                        "city": row[2],
                        "street_address": row[3],
                        "opening_hours": row[4]
                    }
                    for row in results
                ]
        return jsonify(response)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Route to fetch details of a specific kindergarten
@kindergartens_bp.route('/<int:kindergarten_id>', methods=['GET'])
def kindergarten_details(kindergarten_id):
    query = """SELECT k.name, k.city, k.street_address, k.postal_code, 
                      k.opening_hours, k.minimum_age, k.image_path,
                      ARRAY_AGG(DISTINCT a.activity_name) AS activities,
                      ARRAY_AGG(DISTINCT f.facility_name) AS facilities
               FROM kindergartens k
               LEFT JOIN kindergarten_activities ka ON k.id = ka.kindergarten_id
               LEFT JOIN activities a ON ka.activity_id = a.id
               LEFT JOIN kindergarten_facilities kf ON k.id = kf.kindergarten_id
               LEFT JOIN facilities f ON kf.facility_id = f.id
               WHERE k.id = %s
               GROUP BY k.id"""
    try:
        # Connect to the database
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(query, (kindergarten_id,))
                row = cur.fetchone()
                if row:
                    response = {
                        "name": row[0],
                        "city": row[1],
                        "street_address": row[2],
                        "postal_code": row[3],
                        "opening_hours": row[4],
                        "minimum_age": row[5],
                        "image_path": row[6],
                        "activities": row[7],
                        "facilities": row[8]
                    }
                    return jsonify(response)
                else:
                    return jsonify({"error": "Kindergarten not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500

