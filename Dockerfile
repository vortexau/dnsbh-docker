FROM debian:stable-slim
MAINTAINER james.mclean@gmail.com

RUN apt-get update \
    && apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install dnsutils bind9 wget python2.7 cron \
    && rm -rf /var/lib/apt/lists/*

# Install the run script
COPY run.sh /usr/sbin/run.sh
RUN chmod 755 /usr/sbin/run.sh

# Install the dnsbh script
COPY dnsbh/dnsbh.py /usr/bin/dnsbh.py
RUN chmod 755 /usr/bin/dnsbh.py

# Install the crontask for 3am
RUN echo "* 3 * * * /usr/bin/dnsbh.py" >> /etc/crontab
RUN echo "* 4 * * * /usr/sbin/rndc reconfig" >> /etc/crontab

# Add our Bind config
COPY dnsbh/named.conf.options /etc/bind/named.conf.options
# Add the blacklists
COPY dnsbh/blockeddns.hosts /etc/bind/blockeddns.hosts

RUN echo "include \"/etc/bind/blockeddns.zones\";" >> /etc/bind/named.conf

EXPOSE 53/udp 53/tcp
ENTRYPOINT ["/usr/sbin/run.sh"]
CMD ["/usr/sbin/named"]
