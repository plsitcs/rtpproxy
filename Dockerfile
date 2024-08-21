FROM ubuntu:20.04

RUN apt-get update \
  && apt-get -y install \
                dirmngr \
                runit \
                procps \
                parallel \
                rtpproxy \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/lib/rtpproxy-recording
RUN mkdir -p /var/spool/rtpproxy

ADD units /
RUN ln -s /etc/sv/* /etc/service
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

VOLUME /var/spool/rtpproxy
VOLUME /var/lib/rtpproxy-recording

EXPOSE 7890/udp

ENTRYPOINT ["/entrypoint.sh"]