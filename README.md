# billyball1517/chrome-remote-desktop

# Introduction

I created this to use "Chrome Remote Desktop" on .rpm based distros (RHEL, CentOS, Fedora, Suse, etc.)
 
The container uses the uses the lxde desktop, creates a dummy "user" account, and mounts the dummy user /home folder to the specified local user /home folder.

To run GUI apps through Chrome Remote Desktop, I recommend to use X11 forwarding once you are in the remote session. Simply execute "ssh -Y localuser@172.17.0.1" (replacing localuser with your specified user) to accomplish this. Obviously ssh needs to be running (with X11 forwarding enabled) on the host to accomplish this.

Perfect? No. Better than frigging around with port forwarding/tunnelling VNC over ssh? Yes.

# Steps

You need to know the UID and /home folder for the local user first. For example, if we wanted to find this out for user "localuser", we would execute:

`grep "localuser" /etc/passwd`

And you would get an output similar to:

`localuser:x:9001:9001::/home/localuser:/bin/bash`

From this we know that the UID is "9001", and the /home folder is "/home/localuser"

My recommended command to start the container is :

`docker run -d --name=crd_session --restart=always -e LOCAL_USER_ID=<localuseruid> -v /home/<localuser>:/home/user billyball1517/chrome-remote-desktop`
 
So in our example we would run:

`docker run -d --name=crd_session --restart=always -e LOCAL_USER_ID=9001 -v /home/localuser:/home/user billyball1517/chrome-remote-desktop`

Unfortunately, google makes it difficult to integrate Chrome Remote Desktop into scripts, so we need to enter a shell in the container to configure the session.

`docker exec -it crd_session /bin/bash`

within the container, switch to the "dummy" user

`su - user`

Set up remote desktop with the instructions from https://remotedesktop.google.com/headless. You don't have to install anything, just skip through to the part where it gives you a code. (Make sure the long command is executed as "user" not "root")

Exit container

`Ctrl+D, Ctrl+D`

Congratulations, you now have a remote desktop connection that will persist across reboots!

If anyone has a better idea of how to script the headless setup part, please let me know. :)
