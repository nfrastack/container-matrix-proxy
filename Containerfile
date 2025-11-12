# SPDX-FileCopyrightText: © 2025 Nfrastack <code@nfrastack.com>
#
# SPDX-License-Identifier: MIT

ARG \
    BASE_IMAGE

FROM ${BASE_IMAGE}

LABEL \
        org.opencontainers.image.title="Matrix Proxy" \
        org.opencontainers.image.description="Proxy to your Matrix HomeserverAntivirus Scanner" \
        org.opencontainers.image.url="https://hub.docker.com/r/nfrastack/matrix-proxy" \
        org.opencontainers.image.documentation="https://github.com/nfrastack/container-matrix-proxy/blob/main/README.md" \
        org.opencontainers.image.source="https://github.com/nfrastack/container-matrix-proxy.git" \
        org.opencontainers.image.authors="Nfrastack <code@nfrastack.com>" \
        org.opencontainers.image.vendor="Nfrastack <https://www.nfrastack.com>" \
        org.opencontainers.image.licenses="MIT"

COPY CHANGELOG.md /usr/src/container/CHANGELOG.md
COPY LICENSE /usr/src/container/LICENSE
COPY README.md /usr/src/container/README.md

ENV NGINX_SITE_ENABLED=matrix-proxy \
    NGINX_WORKER_PROCESSES=1 \
    NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE \
    IMAGE_NAME="nfrastack/matrix-proxy" \
    IMAGE_REPO_URL="https://github.com/nfrastack/container-matrix-proxy/"

RUN source /container/base/functions/container/build && \
    container_build_log image && \
    sed -i "s|{{NGINX_CLIENT_BODY_BUFFER_SIZE}}|32k|g" /etc/nginx/nginx.conf && \
    package update && \
    package upgrade && \
    package cleanup

COPY rootfs /

