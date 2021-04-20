FROM grafana/loki:2.2.1
# hadolint ignore=DL3002
USER root
# hadolint ignore=DL3018
RUN apk add --update --no-cache su-exec ca-certificates \
    && wget -O /usr/local/bin/logcli http://oss.help/builds/pub/logcli/1.0.0/logcli \
    && chmod 755 /usr/local/bin/logcli
COPY entrypoint.sh /usr/local/bin/
COPY confs/*.yaml /etc/loki/
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3100
HEALTHCHECK --interval=15s --timeout=3s --start-period=15s \
  CMD nc -z 127.0.0.1 3100
