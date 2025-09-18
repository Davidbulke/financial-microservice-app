# Use an official lightweight Python image.
FROM python:3.9-slim

# Set the working directory in the container.
WORKDIR /app

# Copy the dependencies file to the working directory.
COPY requirements.txt .

# Install any dependencies.
RUN pip install --no-cache-dir -r requirements.txt

# Copy the content of the local src directory to the working directory.
COPY . .

# Expose the port the app runs on.
EXPOSE 8080

# Command to run the application using Gunicorn, a production-ready WSGI server.
# The Jenkins pipeline will build an image from this file.
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
