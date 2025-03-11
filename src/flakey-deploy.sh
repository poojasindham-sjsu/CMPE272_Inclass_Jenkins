#!/bin/bash

echo "Starting deployment..."

# Simulate a deployment that fails randomly
if [ $((RANDOM % 2)) -eq 0 ]; then
    echo "Deployment failed! Retrying..."
    exit 1  # Non-zero exit code means failure
else
    echo "Deployment successful!"
    exit 0  # Zero exit code means success
fi
