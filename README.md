# Local PyTorch with Docker

## High-Level Architecture

**Container-First Development**: Everything runs inside Docker with CPU optimization, VSCode connects remotely via Dev Containers extension.

## Project Structure (Minimal)
```
pytorch-project/
├── .devcontainer/           # VSCode dev container config
├── Dockerfile              # Single stage, Ubuntu base + uv + CPU PyTorch
├── pyproject.toml          # uv project file with CPU PyTorch + essentials
├── src/                    # Your Python code
└── scripts/train.py        # Simple training script
```

## Container Strategy

**Single Dockerfile approach**:
- Start with Ubuntu base image (no CUDA needed)
- Install uv inside container
- Copy pyproject.toml and install CPU PyTorch with `uv sync`
- Optimize for CPU performance (OpenMP, MKL)
- Set up proper Python path and working directory
- No volume mounts for dependencies (everything baked in)

## VSCode Integration

**Dev Containers extension**:
- `.devcontainer/devcontainer.json` configures the remote connection
- VSCode attaches to running container
- Full IntelliSense, debugging, terminal access inside container
- Extensions (Python, PyTorch snippets) installed in container

## Dependencies (Minimal Set)

**CPU-optimized libraries**:
- PyTorch CPU version + torchvision
- numpy (with optimized BLAS)
- matplotlib (basics)
- tqdm (progress bars)
- tensorboard (simple logging)

**No Jupyter, no GPU libraries, no heavyweight frameworks initially**

## Development Workflow

1. **Build container** with all dependencies pre-installed
2. **Start container** (standard Docker, no GPU runtime needed)
3. **VSCode connects** via Dev Containers extension
4. **Code directly** in container environment
5. **Run training** with simple `python scripts/train.py`

## CPU Optimization

**Docker Configuration**:
- Standard Docker Desktop on Windows
- CPU resource allocation (cores/memory)
- No special runtime requirements
- Faster startup than GPU containers

## Minimal Neural Network

**Simple CNN example**:
- Basic PyTorch model (lightweight for CPU)
- MNIST dataset (smaller, faster on CPU)
- Reduced batch sizes for CPU efficiency
- CPU utilization monitoring
- Threading optimization for Windows containers

## Windows-Specific Considerations

**Docker Desktop**:
- WSL2 backend recommended
- Memory allocation for container
- File system performance (avoid bind mounts for dependencies)
- Port forwarding for any web interfaces

This approach gives you:
- **No GPU dependencies** (works on any Windows machine)
- **Fast container startup** (no CUDA runtime)
- **Full VSCode experience** with remote development
- **CPU-optimized PyTorch** for reasonable performance
- **Simple setup** on Windows Docker Desktop
- **Reproducible environment** across any CPU-based machine

The key advantage is simplicity - standard Docker setup with no special hardware requirements, while still maintaining professional development practices.

Would you like me to create the actual configuration files for this CPU-based setup?