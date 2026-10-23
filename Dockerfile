FROM nginx:1.31.8@sha256:6e67f8eaac94fc456588d4ff6c470d984841f5b5dc4279863d5cbe6ec5a60def

# To be passed from Github Actions
ARG GIT_VERSION_TAG=unspecified
ARG GIT_COMMIT_MESSAGE=unspecified
ARG GIT_VERSION_HASH=unspecified

# Copy repo contents to image
COPY ./docker-entrypoint.d/. /docker-entrypoint.d/
COPY ./nginx/. /etc/nginx/
COPY ./saphnet-entrypoint.sh /

# Ensure necessary directories are created before the image is run
RUN mkdir -p /var/cache/nginx/client_temp /var/lib/nginx/cache/public /var/lib/nginx/cache/private

# Write any Git-related info
RUN printf "%s\n" "$GIT_VERSION_TAG" > GIT_VERSION_TAG.txt
RUN printf "%s\n" "$GIT_COMMIT_MESSAGE" > GIT_COMMIT_MESSAGE.txt
RUN printf "%s\n" "$GIT_VERSION_HASH" > GIT_VERSION_HASH.txt

# Final ports, final setup
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/saphnet-entrypoint.sh"]
