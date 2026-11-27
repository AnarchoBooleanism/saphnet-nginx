FROM nginx:1.31.10@sha256:a786635fd3c7b9a57ea089ab1c0713e510f3b548b65fe699ce3d59e4a926b37e

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
