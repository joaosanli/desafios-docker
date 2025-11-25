FROM python:3.11-slim

WORKDIR /app

RUN pip install --no-cache-dir flask

RUN cat > app.py << 'EOF'
import sqlite3
import os
from datetime import datetime
from flask import Flask, jsonify, request

app = Flask(__name__)

DB_FILE = '/data/app.db'
DB_DIR = '/data'


def get_db():
    if not os.path.exists(DB_DIR):
        os.makedirs(DB_DIR, exist_ok=True)
    
    conn = sqlite3.connect(DB_FILE)
    conn.row_factory = sqlite3.Row
    return conn


def init_db():
    conn = get_db()
    cur = conn.cursor()
    
    cur.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            email TEXT UNIQUE NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    
    cur.execute('SELECT COUNT(*) as cnt FROM users')
    if cur.fetchone()['cnt'] == 0:
        cur.execute('INSERT INTO users (name, email) VALUES (?, ?)', ('Alice', 'alice@example.com'))
        cur.execute('INSERT INTO users (name, email) VALUES (?, ?)', ('Bob', 'bob@example.com'))
        cur.execute('INSERT INTO users (name, email) VALUES (?, ?)', ('Carol', 'carol@example.com'))
    
    conn.commit()
    conn.close()


@app.route('/')
def home():
    return jsonify({'ok': True, 'service': 'db-app'})


@app.route('/users')
def list_users():
    conn = get_db()
    cur = conn.cursor()
    cur.execute('SELECT id, name, email, created_at FROM users')
    rows = cur.fetchall()
    conn.close()
    
    return jsonify({
        'users': [dict(r) for r in rows],
        'total': len(rows)
    })


@app.route('/users', methods=['POST'])
def add_user():
    data = request.get_json()
    
    try:
        conn = get_db()
        cur = conn.cursor()
        cur.execute('INSERT INTO users (name, email) VALUES (?, ?)', (data['name'], data['email']))
        conn.commit()
        uid = cur.lastrowid
        conn.close()
        
        return jsonify({'id': uid, 'created': True}), 201
    except sqlite3.IntegrityError:
        return jsonify({'error': 'Email already exists'}), 400
    except Exception as e:
        return jsonify({'error': str(e)}), 400


@app.route('/db-info')
def db_info():
    if os.path.exists(DB_FILE):
        size = os.path.getsize(DB_FILE)
        return jsonify({
            'exists': True,
            'path': DB_FILE,
            'size_bytes': size
        })
    return jsonify({'exists': False})


if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=5000)
EOF

EXPOSE 5000

CMD ["python", "app.py"]
