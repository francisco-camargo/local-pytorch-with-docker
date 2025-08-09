# Local PyTorch with Docker

## Goal

The purpose of this repo is to enable the user to run PyTorch code on their local Windows machine using CPU via Docker.

## What's Included in the Container

- Python 3.11 base image
- PyTorch CPU version + torchvision
- numpy, tqdm for utilities
- All dependencies pre-installed with uv

## Prerequisites
- Docker Desktop installed on Windows
- WSL2 or Git Bash for running shell scripts
- `uv` installed on your host machine

## Quick Start

### Build and Run Docker Image
1. **Quick (re)build:** `./rebuild.sh`
   - Automatically handles lockfile generation, image building, and container startup
   - Runs sanity check to verify installation
   - Provides container ID for further commands

   OR manually:

2. Generate lockfile: `uv lock`
3. Build image: `docker build --no-cache -t pytorch-cpu .`
4. Start container: `docker run -d pytorch-cpu`
5. Verify installation:
   ```bash
   docker exec -it <container_id> uv run python sanity_check.py
   ```

### Try It Out
```bash
# Train a simple CNN on MNIST (takes ~5 minutes on CPU)
docker exec -it <container_id> uv run python train_mnist.py
```

### Useful Docker Commands

```bash
# Find your container ID
docker ps

# Get interactive shell
docker exec -it <container_id> bash

# Stop container
docker stop <container_id>
```
