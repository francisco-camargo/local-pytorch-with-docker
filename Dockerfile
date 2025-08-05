# Minimal PyTorch CPU Dockerfile
FROM python:3.11-slim

# Install uv
RUN pip install uv

# Set working directory
WORKDIR /app

# Copy project file and install dependencies
COPY pyproject.toml ./
RUN uv sync

# Keep container running for VSCode connection
CMD ["tail", "-f", "/dev/null"]