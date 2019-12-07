# billyball1517/chrome-remote-desktop

# Introduction

I created this to use "Chrome Remote Desktop" on .rpm based distros (RHEL, CentOS, Fedora, Suse, etc.)
 
The container uses the uses the lxde desktop, creates a dummy "user" account, and mounts the dummy user /home folder to the specified local user /home folder.

To run GUI apps through Chrome Remote Desktop, I reccomend to use X11 forwarding once you are in the remote session. Simply execute "ssh -Y localuser@172.17.0.1" (replacing localuser with your specfied user) to accomplish this. Obviously ssh needs to be running (with X11 forwarding enabled) on the host to accomplish this.

Perfect? No. Better than frigging around with port forwarding/tunnelling VNC over ssh? Yes.

# Steps

1. You need to know the UID and /home folder for the local user first. For example if we wanted to find this out for user "localuser", we would execute:

grep "localuser" /etc/passwd

And you would get an output similar to:

localuser\:x:9001:9001::/home/localuser:/bin/bash

From this we know that the UID is "9001", and the /home folder is "/home/localuser"

2. docker run -d --name=crd_session --restart=always -e LOCAL_USER_ID=<localuseruid> -v /home/<localuser>:/home/user billyball1517/chrome-remote-desktop

3. docker exec -it crd_session /bin/bash

4. within the container, switch to the created user with "su - user"

5. Set up remote desktop from https://remotedesktop.google.com/headless (Make sure the long command is executed as "user" not "root")

6. Exit container
