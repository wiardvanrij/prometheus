ARG ARCH="amd64"
ARG OS="linux"
FROM quay.io/prometheus/busybox-linux-amd64:latest
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com>"

ARG ARCH="amd64"
ARG OS="linux"
COPY prometheus        /bin/prometheus
COPY promtool          /bin/promtool
COPY documentation/examples/prometheus.yml  /etc/prometheus/prometheus.yml
COPY console_libraries/                     /usr/share/prometheus/console_libraries/
COPY consoles/                              /usr/share/prometheus/consoles/
COPY LICENSE                                /LICENSE
COPY NOTICE                                 /NOTICE
COPY npm_licenses.tar.bz2                   /npm_licenses.tar.bz2

WORKDIR /prometheus
RUN ln -s /usr/share/prometheus/console_libraries /usr/share/prometheus/consoles/ /etc/prometheus/ && \
    chown -R nobody:nobody /etc/prometheus /prometheus

USER       nobody
EXPOSE     9090
VOLUME     [ "/prometheus" ]
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", \
             "--web.console.libraries=/usr/share/prometheus/console_libraries", \
             "--web.console.templates=/usr/share/prometheus/consoles" ]
