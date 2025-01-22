# Use Python 3.10 as the base image
FROM python:3.10-slim

# Set environment variables for non-interactive installs
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory
WORKDIR /workspace

# Install additional dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install python packages
# COPY requirements.txt /workspace/requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt
# Install pytorch
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir numpy

# Create necessary directories
RUN mkdir -p /workspace/data /workspace/saved_models

# Download and prepare the CIFAR-10 dataset
RUN wget -c --quiet https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz -O /workspace/data/cifar-10-python.tar.gz \
    && tar -xzf /workspace/data/cifar-10-python.tar.gz -C /workspace/data \
    && rm /workspace/data/cifar-10-python.tar.gz

# Copy start_training script
COPY start_training.sh /workspace/start_training.sh
RUN chmod +x /workspace/start_training.sh

# Copy the training script
COPY main.py /workspace/main.py

# Set the entrypoint for the container
# ENTRYPOINT ["/workspace/start_training.sh"]

# Set the container to run continuously
CMD ["tail", "-f", "/dev/null"]