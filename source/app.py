# app.py
import time

from flask import Flask, jsonify, request
import os
import psycopg2
from psycopg2.extras import RealDictCursor
from prometheus_flask_exporter import PrometheusMetrics, NO_PREFIX, Histogram

app = Flask(__name__)
metrics = PrometheusMetrics(app)
hist = Histogram('db_query_duration_seconds', 'DB query duration histogram')

def get_db_connection():
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        port=os.getenv('DB_PORT', '5432'),
        dbname=os.getenv('DB_NAME', 'testdb'),
        user=os.getenv('DB_USER', 'postgres'),
        password=os.getenv('DB_PASSWORD', 'postgres')
    )
    return conn

@app.route('/users')
def get_users():
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            with hist.time():
                cur.execute('SELECT id, name, email FROM users')
            users = cur.fetchall()
            return jsonify([dict(user) for user in users])
    finally:
        conn.close()

@app.route('/health')
def health_check():
    return jsonify({"status": "healthy"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
