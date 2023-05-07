FROM stlouisn/ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

#COPY rootfs /

RUN \

    # Create fail2ban group
    groupadd \
        --system \
        --gid 10000 \
        fail2ban && \

    # Create fail2ban user
    useradd \
        --system \
        --no-create-home \
        --shell /sbin/nologin \
        --comment fail2ban \
        --gid 10000 \
        --uid 10000 \
        fail2ban && \

    # Update apt-cache
    apt-get update && \

    # Install fail2ban
    apt-get install -y --no-install-recommends \
        fail2ban \
        whois && \

# sed replace/insert the following into /etc/fail2ban.conf
    #bantime = 3600
    #ignoreip = 127.0.0.0/8 10.0.0.0/8 172.27.0.0/16 192.168.0.0/16

    rm /etc/fail2ban/jail.d/defaults-debian.conf && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /usr/local/man \
        /usr/local/share/man \
        /usr/share/doc \
        /usr/share/doc-base \
        /usr/share/man \
        /var/cache \
        /var/lib/apt \
        /var/log/*

#VOLUME /config

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
