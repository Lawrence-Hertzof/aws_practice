from flask import Flask
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World from Flask!'


@app.route('/update_or_create_file')
def update_or_create_file():
    with open('/app/storage/test.txt', 'a') as f:  # Writing to the mounted volume path
        f.write(f"Updated at: {datetime.now()}\n|\n|\n")
    return 'File created or updated!'


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
