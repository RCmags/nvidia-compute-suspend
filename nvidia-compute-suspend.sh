#!/bin/bash

# Ensure Nvidia GPU is present
nvidia-smi -L &> /dev/null
if [ $? -eq 0 ]; then
    
    # Processes using the GPU
    pids=$(nvidia-smi --query-compute-apps=pid --format=csv,noheader)
    
    if [ -n "$pids" ]; then
       # print names
       echo "Killing:"
       echo $(nvidia-smi --query-compute-apps=name --format=csv,noheader) 
       
       # Stop processes immediately
       echo "$pids" | xargs -r kill -SIGKILL
       sleep 1  # Wait to prevent anything weird
    else
       echo "No processes to kill"
    fi
    
else
    echo "No nvidia GPU detected"
fi
