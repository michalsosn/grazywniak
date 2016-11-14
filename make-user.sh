docker run --rm \
  -e MAIL_USER="$1@domain.com" \
  -e MAIL_PASS="$2" \
  -ti tvial/docker-mailserver:latest \
  /bin/sh -c 'echo "$MAIL_USER|$(doveadm pw -s SHA512-CRYPT -u $MAIL_USER -p $MAIL_PASS)"' >> config/postfix-accounts.cf
