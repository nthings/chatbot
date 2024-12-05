FROM python:3.11-slim
WORKDIR /app

# Copy files
COPY . /app

# OS Dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

# Python Dependencies
RUN pip3 install streamlit setuptools && \
    pip3 install -r requirements.txt

# Expose port
EXPOSE 8501

# Healthcheck
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

# Run Streamlit
ENTRYPOINT ["streamlit", "run", "main.py", "--server.port=8501", "--server.address=0.0.0.0"]