# Use Python 3.10 or higher
FROM python:3.10-slim

# Install system dependencies including pkg-config and MariaDB libraries
RUN apt-get update && apt-get install -y \
    python3-dev \
    pkg-config \
    libmariadb-dev-compat \
    libmariadb-dev \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libffi-dev && \
    apt-get clean

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app/

# Create and activate virtual environment, then install dependencies
RUN python -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Set environment variables
ENV PATH="/opt/venv/bin:$PATH"

# Expose the default Django port
EXPOSE 8000

# Command to run the application
CMD ["gunicorn", "mindcare.wsgi:application", "--bind", "0.0.0.0:8000"]
