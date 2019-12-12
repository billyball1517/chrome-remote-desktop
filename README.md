# billyball1517/chrome-remote-desktop

# Introduction
 
The container creates a dummy "user" account, and mounts the dummy user /home folder to the specified local user /home folder.

The first part is configuring the container with correct permissions, the second part is setting up desktop forwarding.

*NOTE: For this to work, the host must support ssh with X11 forwarding. Also, GNOME Desktop will not work.*

# Steps

======
PART 1
======

You need to know the UID and /home folder for the local user first. For example, if we wanted to find this out for user "localuser", we would execute:

`grep "localuser" /etc/passwd`

And you would get an output similar to:

`localuser:x:1001:1001::/home/localuser:/bin/bash`

From this we know that the UID is "1001", and the /home folder is "/home/localuser"

My recommended command to start the container is :

`docker run -d --name=crd_session --restart=always -e LOCAL_USER_ID=<localuseruid> -v /home/<localuser>:/home/user billyball1517/chrome-remote-desktop`
 
So in our example we would run:

`docker run -d --name=crd_session --restart=always -e LOCAL_USER_ID=1001 -v /home/localuser:/home/user billyball1517/chrome-remote-desktop`

======
PART 2
======


Unfortunately, Google makes it difficult to integrate Chrome Remote Desktop into scripts, so we need to enter a shell in the container to configure the session.

`docker exec -it crd_session /bin/bash`

Then switch the the "dummy" user. (Chrome remote desktop won't run as root)

`su - user`

Set up remote desktop with the instructions from https://remotedesktop.google.com/headless. You don't have to install anything, just skip through to the part where it gives you a code. Then copy and paste the code into the container terminal.

Exit container

`Ctrl+D, Ctrl+D`

Congratulations, you now have a remote desktop connection that will persist across reboots!

If anyone has a better idea of how to script the headless setup part, please let me know. :)
