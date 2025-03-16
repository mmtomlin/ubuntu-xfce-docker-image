#!/bin/bash

# Image name
IMAGE_NAME="ubuntu-xfce"

echo "Building Docker image ${IMAGE_NAME}..."

# Build the image
docker build --platform linux/amd64 -t ${IMAGE_NAME} .

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Build successful!"
    
    # Save the image to a tar file
    SAVE_PATH="${IMAGE_NAME}.tar"
    echo "Saving image to ${SAVE_PATH}..."
    docker save ${IMAGE_NAME} -o ${SAVE_PATH}
    
    echo "Done! Image saved to ${SAVE_PATH}"
else
    echo "Build failed!"
    exit 1
fi