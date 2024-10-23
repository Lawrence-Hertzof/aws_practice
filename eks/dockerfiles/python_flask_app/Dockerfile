# Use an official Python runtime as a parent image
FROM python:3.10

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install only needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Expose the port Flask will run on
EXPOSE 80

# Set environment variables
ENV FLASK_APP=app.py

# Command to run the Flask application
CMD ["python3", "app.py"]
