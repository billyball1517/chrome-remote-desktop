# billyball1517/chrome-remote-desktop

# Introduction

I created this to use "Chrome remote desktop" on .rpm based distros (RHEL, CentOS, Fedora, Suse, etc.)
 
The container uses the uses the lxde desktop, creates a dummy "user" account, and mounts the dummy user /home folder to the specified local user /home folder.

To run GUI apps remotely, I reccomend the use of X11 forwarding. Simply execute "ssh -Y localuser@172.17.0.1" (replacing localuser with your specfied user) once you are in the remote session.

Perfect? No. Better than frigging around with port forwarding/tunnelling VNC over ssh? Yes.

# Steps

1. docker run -d --name=crd_session --restart=always -e LOCAL_USER_ID=<localuseruid> -v /home/<localuser>:/home/user billyball1517/chrome-remote-desktop

2. docker exec -it crd_session /bin/bash

3. within the container, switch to the created user with "su - user"

4. Set up remote desktop from https://remotedesktop.google.com/headless (Make sure the long command is executed as "user" not "root")

5. Exit container
