#!/bin/bash

# Create key
gpg2 --gen-key --batch /home/admin/gpg-params.txt
GPGKEY=$(gpg2 --list-keys --fingerprint | head -n4 | tail -n1 | tr -d ' ' | sed 's/^Keyfingerprint=//')

# Wait for keyserver to start and send the key
sleep 1
gpg2 --send-keys $GPGKEY

# Share your key id with users to notify that you're ready
mkdir /home/admin/shared/user-keys
echo "$GPGKEY" > /home/admin/shared/admin-keyid.txt

# Sign user keys as they appear
inotifywait -m /home/admin/shared/user-keys -e create -e moved_to --format "%f" |
    while read FILE; do
        echo "Signing $FILE"
        gpg2 --recv-keys "$FILE"
        gpg2 --sign-key "$FILE"
        gpg2 --send-keys "$FILE"
    done
