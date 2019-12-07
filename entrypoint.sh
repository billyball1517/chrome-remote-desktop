#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

echo "Creating user with UID : $USER_ID"
useradd -m -s /bin/bash -u $USER_ID -o -G chrome-remote-desktop user
echo "#!/bin/bash" > /home/user/.chrome-remote-desktop-session
echo "/usr/bin/startlxde" >> /home/user/.chrome-remote-desktop-session

exec /usr/sbin/gosu root "$@"

