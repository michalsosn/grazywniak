FROM ubuntu:16.04

RUN apt-get update 

RUN apt-get install -y sks

RUN su debian-sks -c "/usr/sbin/sks build"
RUN echo "# Empty - Do not communicate with other keyservers." >/etc/sks/mailsync
RUN echo "# Empty - Do not communicate with other keyservers." >/etc/sks/membership
RUN echo "initstart=yes" > /etc/default/sks
RUN systemctl enable sks.service

EXPOSE 11371

CMD ["bash", "-c", "service sks start; sleep infinity"]
