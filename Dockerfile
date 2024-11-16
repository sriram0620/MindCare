# Base image
FROM python:3.9-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-dev \
    default-libmysqlclient-dev \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libffi-dev \
    libmysqlclient-dev

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app/

# Create and activate virtual environment, then install dependencies
RUN python -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

# Environment variables
ENV PATH="/opt/venv/bin:$PATH"

# Expose port and start the application
EXPOSE 8000
CMD ["gunicorn", "your_project_name.wsgi:application", "--bind", "0.0.0.0:8000"]
