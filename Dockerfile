FROM alpine:latest

MAINTAINER Nic Jackson jackson.nic@gmail.com

# add wget and tar
RUN apk add --update wget
RUN apk add --update tar

# consul-template
RUN wget --no-check-certificate https://github.com/hashicorp/consul-template/releases/download/v0.10.0/consul-template_0.10.0_linux_386.tar.gz; \
tar -xvzf consul-template_0.10.0_linux_386.tar.gz; \
mv consul-template_0.10.0_linux_386/consul-template /usr/bin/consul-template; \
rm consul-template_0.10.0_linux_386.tar.gz; \
rm -rf consul-template_0.10.0_linux_386; \
rm -rf consul-template_0.10.0_linux_386/consul-template

# skaware s6 daemon runner
RUN mkdir s6; \
wget --no-check-certificate  https://github.com/just-containers/skaware/releases/download/v1.16.1/s6-2.2.2.0-linux-amd64-bin.tar.gz; \
tar -xvzf s6-2.2.2.0-linux-amd64-bin.tar.gz --directory /s6 --strip-components=1; \
mv /s6/usr/bin/* /usr/bin; \
rm s6-2.2.2.0-linux-amd64-bin.tar.gz; \
rm -rf s6

RUN chmod -R 755 /usr/bin

ENTRYPOINT ["/usr/bin/s6-svscan","/etc/s6"]
CMD []
