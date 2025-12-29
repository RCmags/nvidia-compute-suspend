#!/bin/bash

#---- DESCRIPTION -----------------------------------------
# This script kills all nvidia GPU compute processes 
# to prevent crashes when suspending an eGPU. 

# Place at: 
# /usr/local/bin/nvidia-compute-suspend.sh

# Then run:
# sudo chmod +x /usr/local/bin/nvidia-compute-suspend.sh
#----------------------------------------------------------

# Ensure video card is connected
# NOTE: driver must be checked BEFORE listing GPUs
check_driver_exists() {
    !(command -v nvidia-smi &> /dev/null) # get exit code
}

check_gpu_exists() {
    !(nvidia-smi -L &> /dev/null) # get exit code
}

if check_driver_exists && check_gpu_exists; then
    echo "Nvidia GPU NOT detected. Exiting"
    exit 0
fi

# Processes using the GPU
pids=$(nvidia-smi --query-compute-apps=pid --format=csv,noheader)

# Stop everything to clear VRAM
if [ -n "$pids" ]; then
    echo "Killing compute processes:"
    echo $(nvidia-smi --query-compute-apps=name --format=csv,noheader) # print names
    
    echo "$pids" | xargs -r kill -SIGKILL   # Kill immediately
fi

