FROM python:3.8-slim-buster

# Install system dependencies
RUN apt update -y && apt install -y --no-install-recommends \
    gcc \
    build-essential \
    libzstd-dev \
    awscli \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

# Upgrade pip first
RUN pip install --upgrade pip

# Install Python dependencies
RUN pip install -r requirements.txt
RUN pip install --upgrade accelerate
RUN pip uninstall -y transformers accelerate
RUN pip install transformers accelerate

CMD ["python3", "app.py"]
