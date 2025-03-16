#!/bin/bash

# Image name and tag
IMAGE_NAME="tastywaffle/ubuntu-xfce"
TAG="latest"

echo "Building Docker image ${IMAGE_NAME}:${TAG}..."

# Build the image
docker build --platform linux/amd64 -t ${IMAGE_NAME}:${TAG} .

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Build successful!"
    
    echo "Pushing image to Docker Hub..."
    docker push ${IMAGE_NAME}:${TAG}
    
    echo "Done! Image pushed to Docker Hub"
else
    echo "Build failed!"
    exit 1
fi