# Local PyTorch with Docker

## Goal

The purpose of this repo is to enable the user to quickly run PyTorch code on their local Windows machine on CPU using Docker.

## Getting Started

1. **Quick (re)build:** `./rebuild.sh` (does steps 2-5 automatically). If successful you end up with a running container with PyTorch installed

   OR manually:

2. Generate lockfile: `uv lock`
3. `docker build --no-cache -t pytorch-cpu .`
4. `docker run -d pytorch-cpu`
5. Sanity check by running:

   ```bash
   # Using the built-in sanity check script
   docker exec -it <container_id> uv run python sanity_check.py
   ```

6. Train a simple neural network:

   ```bash
   # Train CNN on MNIST dataset
   docker exec -it <container_id> uv run python train_mnist.py
   ```

   replace <container_id> with your container ID which you can find by running `docker ps`
9. Stop the container with, `docker stop <container_id>`. Or find the ID dynamically with `docker stop $(docker ps -q --filter ancestor=pytorch-cpu)`

Note: This simple setup has no user management, no optimizations, no verification - just the absolute minimum to get PyTorch running in a container that VSCode can connect to.

## VSCode Integration

**Dev Containers extension**:

- `.devcontainer/devcontainer.json` configures the remote connection
- VSCode attaches to running container
- Full IntelliSense, debugging, terminal access inside container
- Extensions (Python, PyTorch snippets) installed in container
