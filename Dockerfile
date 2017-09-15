FROM debian:stable-slim
MAINTAINER james.mclean@gmail.com

RUN apt-get update \
    && apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install bind9 wget python2.7 \
    && rm -rf /var/lib/apt/lists/*

# Install the dnsbh script
COPY dnsbh/dnsbh.py /usr/bin/dnsbh.py
RUN chmod 755 /usr/bin/dnsbh.py
CMD ["/usr/bin/dnsbh.py"]

# Run the script to download the lists

# Install the cronjob

EXPOSE 53/udp 53/tcp

CMD ["/usr/sbin/named"]
