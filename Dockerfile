FROM scratch

EXPOSE 514
EXPOSE 514/udp

COPY . /
CMD ["/syslog-cloudwatch-bridge"]
