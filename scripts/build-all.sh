#!/bin/zsh

# Set the parent directory containing the docker-compose files
DOCKER_COMPOSE_PARENT_DIR=~/dev/onebeat-infrastructure/images

# Loop through all subdirectories in the parent directory
for dir in $(find $DOCKER_COMPOSE_PARENT_DIR -type d); do
  # Check if the directory contains a docker-compose file
  if [ -f "$dir/docker-compose.yml" ]; then
    # Copy the content of env.example to .env file in the same directory
    if [ -f "$dir/env.sample" ]; then
      touch "$dir/.env"
      cp "$dir/.env.sample" "$dir/.env"
    fi

    # Build the Docker images
    docker-compose -f $dir/docker-compose.yml build
  fi
done

zsh