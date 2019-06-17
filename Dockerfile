FROM golang:1.12-stretch AS build-env

COPY . /source
WORKDIR /source
RUN go get github.com/aws/aws-sdk-go && \
	go get github.com/satori/go.uuid && \
	go get gopkg.in/mcuadros/go-syslog.v2 && \
	go build -o syslog-cloudwatch-bridge && \
	cp syslog-cloudwatch-bridge /syslog-cloudwatch-bridge && \
	rm -Rf /source

WORKDIR /

EXPOSE 514
EXPOSE 514/udp

CMD ["/syslog-cloudwatch-bridge"]
