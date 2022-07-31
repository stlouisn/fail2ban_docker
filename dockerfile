FROM stlouisn/ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

COPY rootfs /

RUN \

    # Create transmission group
    groupadd \
        --system \
        --gid 10000 \
        transmission && \

    # Create transmission user
    useradd \
        --system \
        --no-create-home \
        --shell /sbin/nologin \
        --comment transmission \
        --gid 10000 \
        --uid 10000 \
        transmission && \

    # Update apt-cache
    apt-get update && \

    # Install transmission-client
    apt-get install -y --no-install-recommends \
        transmission-cli \
        transmission-daemon && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

VOLUME /config

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
