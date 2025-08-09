# Minimal PyTorch CPU Dockerfile
FROM python:3.11-slim

# Install uv
RUN pip install uv

# Set working directory
WORKDIR /app

# Copy project files and lockfile
COPY pyproject.toml uv.lock ./
RUN uv sync

# Copy scripts
COPY sanity_check.py train_mnist.py ./

# Keep container running for VSCode connection
CMD ["tail", "-f", "/dev/null"]