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
  docker stop doc-snippets && docker rm doc-snippets
  docker run -d -p 3500:3000 --restart always --name doc-snippets ranckosolutionsinc/docs:latest  

# Docker compose 
compose:
  docker compose up -d

# Docker compose down
compose-down:
  docker compose down


