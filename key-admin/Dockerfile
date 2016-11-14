FROM ubuntu:16.04

RUN apt-get update 

# Create admin user
RUN useradd -m "admin"
RUN echo "admin:password" | chpasswd

# Setup GPG
RUN apt-get install -y gnupg2 inotify-tools
COPY gpg-params.txt /home/admin/gpg-params.txt
COPY gpg.conf /home/admin/.gnupg/gpg.conf
COPY init-gpg-admin.sh /home/admin/init-gpg-admin.sh
RUN chown admin:admin /home/admin/.gnupg /home/admin/.gnupg/gpg.conf /home/admin/init-gpg-admin.sh
RUN chmod +x /home/admin/init-gpg-admin.sh

RUN mkdir /home/admin/shared
RUN chown admin:admin /home/admin/shared

USER admin
CMD ["/home/admin/init-gpg-admin.sh"]
