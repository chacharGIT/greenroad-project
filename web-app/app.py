from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)

# Create PrometheusMetrics object
metrics = PrometheusMetrics(app)

# Define a route
@app.route('/')
def hello():
    return "Hello, World!"

if __name__ == '__main__':
    app.run(port=8080) 
