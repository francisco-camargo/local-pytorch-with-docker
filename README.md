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

**What it does:**

- Uses Python 3.11 base image (has Python already)
- Installs uv
- Copies your pyproject.toml
- Installs dependencies with uv
- Keeps container running so VSCode can connect

**What you need:**

1. Dockerfile
2. `pyproject.toml` with just PyTorch CPU
3. `docker build -t pytorch-cpu .`
4. `docker run -d pytorch-cpu`
5. Sanity check by running
   ```bash
   docker exec -it <container_id> uv run python -c "import torch; print('PyTorch version:', torch.__version__); x = torch.tensor([1, 2, 3]); print('Tensor:', x); print('Sum:', x.sum().item())"
   ```

   replace <container_id> with your container ID which you can find by running `docker ps`
6. Stop the container with, `docker stop <container_id>`. Or find the ID dynamically with `docker stop $(docker ps -q --filter ancestor=pytorch-cpu)`

Note: This simple setup has no user management, no optimizations, no verification - just the absolute minimum to get PyTorch running in a container that VSCode can connect to.

## OpenTofu Infrastructure-as-Code

OpenTofu roadmap to get an EC2 instance running:

### Phase 1: Local Setup
1. **Install OpenTofu** on your Windows machine
    [Guide](https://opentofu.org/docs/intro/install/windows/). Not sure if adding it to PATH helped or not
    ```powershell
    winget install --exact --id=OpenTofu.Tofu
    ```
    restart the terminal, then it should run in bash and powershell.
    ```bash
    tofu -version
    ```
2. **Install AWS CLI** and configure credentials (`aws configure`)

### Phase 2: Infrastructure Definition
4. **Create main.tf** - define EC2 instance, security group, key pair
5. **Create variables.tf** - parameterize instance type, region, etc.
6. **Create outputs.tf** - export instance IP, connection details
7. **Create terraform.tfvars** - set your specific values

### Phase 3: AWS Prerequisites
8. **Generate SSH key pair** for connecting to instance
9. **Verify AWS credentials** have EC2 permissions
10. **Choose AWS region** and availability zone

### Phase 4: Deployment
11. **Initialize OpenTofu** (`tofu init`)
12. **Plan deployment** (`tofu plan`) - preview what will be created
13. **Apply configuration** (`tofu apply`) - create actual resources
14. **Test SSH connection** to your new instance

### Phase 5: Setup Development Environment
15. **SSH into instance** and install Docker
16. **Clone your PyTorch repo** on the instance
17. **Configure VSCode SSH** to connect to the instance
18. **Test your container** runs on the cloud instance

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
