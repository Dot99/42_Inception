FROM debian:bullseye

RUN apt update -y && apt-get install -y \
	curl \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ENV CADVISOR_VERSION=v0.49.2
ENV ARCH=amd64

RUN curl -Lo /usr/bin/cadvisor "https://github.com/google/cadvisor/releases/download/${CADVISOR_VERSION}/cadvisor-${CADVISOR_VERSION}-linux-${ARCH}" && \
    chmod +x /usr/bin/cadvisor

EXPOSE 8080

CMD ["/usr/bin/cadvisor"]