FROM alpine:latest

MAINTAINER Nic Jackson jackson.nic@gmail.com

# add wget and tar
RUN apk add --update wget
RUN apk add --update tar

# consul-template
RUN wget --no-check-certificate https://github.com/hashicorp/consul-template/releases/download/v0.10.0/consul-template_0.10.0_linux_386.tar.gz
RUN tar -xvzf consul-template_0.10.0_linux_386.tar.gz
RUN mv consul-template_0.10.0_linux_386/consul-template /usr/bin/consul-template

# skaware s6 daemon runner
RUN wget --no-check-certificate https://github.com/just-containers/skaware/releases/download/v1.16.1/s6-2.2.2.0-linux-amd64-bin.tar.gz
RUN tar -xvzf s6-2.2.2.0-linux-amd64-bin.tar.gz
RUN mv ./usr/bin/* /usr/bin

RUN chmod -R 755 /usr/bin

ENTRYPOINT ["/usr/bin/s6-svscan","/etc/s6"]
CMD []
