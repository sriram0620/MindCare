FROM python:3.9-slim

# Install system dependencies for Python and MySQL
RUN apt-get update && apt-get install -y \
    python3-dev \
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
CMD ["gunicorn", "your_project_name.wsgi:application", "--bind", "0.0.0.0:8000"]
