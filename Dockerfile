# Use an official Python base image
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the application code into the container
COPY app.py .

# Install Flask
RUN pip install flask

# Expose the port your app runs on
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]