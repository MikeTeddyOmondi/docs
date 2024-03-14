FROM squidfunk/mkdocs-material as build
WORKDIR /app
COPY /docs ./docs
COPY ./mkdocs.yml ./
RUN mkdocs build 

FROM lipanski/docker-static-website:2.1.0 as release
COPY --from=build /app/site .
