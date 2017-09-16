FROM debian:stable-slim
MAINTAINER james.mclean@gmail.com

RUN apt-get update \
    && apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install dnsutils bind9 wget python2.7 \
    && rm -rf /var/lib/apt/lists/*

# Install the run script
COPY run.sh /usr/sbin/run.sh
RUN chmod 755 /usr/sbin/run.sh

# Install the dnsbh script
COPY dnsbh/dnsbh.py /usr/bin/dnsbh.py
RUN chmod 755 /usr/bin/dnsbh.py

# Add our Bind config
COPY dnsbh/named.conf.options /etc/bind/named.conf.options

# Run the script to download the blacklists
#CMD ["/usr/bin/dnsbh.py"]

# Install the cronjob

EXPOSE 53/udp 53/tcp
ENTRYPOINT ["/usr/sbin/run.sh"]
CMD ["/usr/sbin/named"]
