from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    """Main endpoint returning a welcome message."""
    return jsonify({
        "message": "Salary Finance Deduction Service is running!",
        "version": "1.0.0"
    })

@app.route('/health')
def health_check():
    """Health check endpoint for Kubernetes probes."""
    return jsonify({"status": "UP"}), 200

if __name__ == '__main__':
    # Running on 0.0.0.0 makes it accessible from outside the container.
    # Port 8080 is a common choice for custom applications.
    app.run(host='0.0.0.0', port=8080) #test
