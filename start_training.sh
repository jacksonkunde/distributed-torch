#!/bin/bash
set -e  # Exit on error

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO]: $@"
}

log "Starting distributed training setup..."

# Check required environment variables
if [ -z "$NODE_RANK" ] || [ -z "$MASTER_ADDR" ] || [ -z "$MASTER_PORT" ]; then
    log "Error: NODE_RANK, MASTER_ADDR, and MASTER_PORT must be set."
    exit 1
fi

# Default values for number of nodes and processes
NNODES=${NNODES:-1}
NPROC_PER_NODE=${NPROC_PER_NODE:-1}

# Log the setup
log "Node rank: $NODE_RANK"
log "Master address: $MASTER_ADDR"
log "Master port: $MASTER_PORT"
log "Number of nodes: $NNODES"
log "Processes per node: $NPROC_PER_NODE"

# Run the distributed training script
torchrun \
    --nproc_per_node=$NPROC_PER_NODE \
    --nnodes=$NNODES \
    --node_rank=$NODE_RANK \
    --master_addr=$MASTER_ADDR \
    --master_port=$MASTER_PORT \
    /workspace/main.py "$@"
