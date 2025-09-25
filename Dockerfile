FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC

# Cài tmate + tiện ích cơ bản
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    tmate openssh-client curl ca-certificates sudo git bash \
 && rm -rf /var/lib/apt/lists/*

# Tạo user developer
RUN useradd -m -s /bin/bash developer \
 && echo "developer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/developer \
 && chmod 0440 /etc/sudoers.d/developer

# Copy start script
COPY start-tmate.sh /usr/local/bin/start-tmate.sh
RUN chmod +x /usr/local/bin/start-tmate.sh

USER developer
WORKDIR /home/developer

CMD ["/usr/local/bin/start-tmate.sh"]
