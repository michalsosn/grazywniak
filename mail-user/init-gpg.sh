#!/bin/bash

# Create key
gpg2 --gen-key --batch /home/user/setup/gpg-params.txt
GPGKEY=$(gpg2 --list-keys --fingerprint | head -n4 | tail -n1 | tr -d ' ' | sed 's/^Keyfingerprint=//')

# Wait for admin to initialize
echo "Waiting for admin"
while [ ! -f /home/user/shared/admin-keyid.txt ]
do
  sleep 1
done

# Trust the admin
ADMIN_KEYID=$(cat /home/user/shared/admin-keyid.txt)
gpg2 --recv-keys $ADMIN_KEYID
echo "password" | gpg2 --batch --passphrase-fd 0 --pinentry-mode loopback --quick-sign-key "$ADMIN_KEYID"
gpg2 --send-keys $ADMIN_KEYID
echo "$ADMIN_KEYID:5:" | gpg2 --import-ownertrust

# Share your key with the admin to get it signed
gpg2 --send-keys $GPGKEY
touch "/home/user/shared/user-keys/$GPGKEY"
