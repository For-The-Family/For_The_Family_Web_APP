# Imports
from flask import Blueprint, request, jsonify, render_template, redirect, url_for
import psycopg

from . import test_sql_bp

# Route for java script testing
@test_sql_bp.route('/')
def index():
    return render_template('test_sql/index.html')

#zeh connecty boyyyy
def get_db_connection():
    conn = psycopg.connect(
        dbname='FTF_SQL',
        user='website_reader',
        password='Parlor-Ellipse-Grappling-Rival-Daylight-Backtalk7',
        host='153.92.134.127',
        port='5432'
    )
    return conn


#thingy thingy to search, attempt 4782
@test_sql_bp.route('/search', methods=['GET'])
def search():
    query = request.args.get('q', '')

    #sql query specifically
    sql_query = "SELECT name FROM kindergartens WHERE name ILIKE %s LIMIT 10"
    pattern = f"%{query}%"

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(sql_query, (pattern,))
    result = cursor.fetchall()
    conn.close()

    return jsonify([{"name": row[0]} for row in results])
