# Default
default:
  just --list

# Build docker image
build-image:
  docker build -t ranckosolutionsinc/docs:latest . 	 

# Push image to Docker Hub
push-image:
  docker push ranckosolutionsinc/docs:latest

# Run Docker Container
run-container:
  docker run -d -p 3500:3000 --restart always --name doc-snippets ranckosolutionsinc/docs:latest  

# Stop Docker Container
stop-container:
  docker stop doc-snippets
  
# Remove Docker Container
remove-container:
  docker rm doc-snippets
  
# Stop & Remove Docker Container
dispose-container:
  docker stop doc-snippets && docker rm doc-snippets

# Docker compose 
compose:
  docker compose up -d

# Docker compose down
compose-down:
  docker compose down


