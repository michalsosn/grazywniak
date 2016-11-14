FROM ubuntu:16.04

RUN apt-get update 

# SSH server to run thunderbird remotely with X forwarding
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
EXPOSE 22

# Create user
RUN useradd -m "user"
RUN echo "user:password" | chpasswd

# Setup GPG
RUN apt-get install -y gnupg2 thunderbird enigmail
COPY gpg.conf /home/user/.gnupg/gpg.conf
COPY gpg-agent.conf /home/user/.gnupg/gpg-agent.conf
COPY init-gpg.sh /home/user/init-gpg.sh
RUN chown user:user /home/user/.gnupg /home/user/.gnupg/gpg.conf /home/user/.gnupg/gpg-agent.conf /home/user/init-gpg.sh
RUN chmod +x /home/user/init-gpg.sh

RUN mkdir /home/user/shared
RUN chown user:user /home/user/shared

CMD ["bash", "-c", "su - user -c /home/user/init-gpg.sh; /usr/sbin/sshd -D"]
