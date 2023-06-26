# Use an official Python runtime as the base image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY app.py .

# Expose the port on which your Flask application runs (8080 in this case)
EXPOSE 8080

# Set the entrypoint command to run the Flask application
CMD ["python", "app.py"]
