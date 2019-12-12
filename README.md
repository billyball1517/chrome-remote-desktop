# billyball1517/chrome-remote-desktop

# Introduction
 
The container creates a dummy "user" account, and mounts the dummy user /home folder to the specified local user /home folder.

The first part is configuring the container with correct permissions, the second part is setting up desktop forwarding.

*NOTE: For this to work, the host must support ssh with X11 forwarding. Google it if you don't know what that means.*

# Steps

======
PART 1
\======

You need to know the UID and /home folder for the local user first. For example, if we wanted to find this out for user "localuser", we would execute:

`grep "localuser" /etc/passwd`

And you would get an output similar to:

`localuser:x:1001:1001::/home/localuser:/bin/bash`

From this we know that the UID is "1001", and the /home folder is "/home/localuser"

My recommended command to start the container is :

`docker run -d --name=crd_session --restart=always -e LOCAL_USER_ID=<localuseruid> -v /home/<localuser>:/home/user billyball1517/chrome-remote-desktop`
 
So in our example we would run (remembering to swap out the appropriate values):

`docker run -d --name=crd_session --restart=always -e LOCAL_USER_ID=1001 -v /home/localuser:/home/user billyball1517/chrome-remote-desktop`

======
PART 2
\======

Now is the time to note that GNOME dosn't support X11 forwarding, therefore if you use GNOME (or a derivitive like Pantheon or Cinnamon), you will need to install an additional desktop environment. LXDE is a good lightweight option.

`yum install -y lxde-common`

https://support.google.com/chrome/answer/1649523?co=GENIE.Platform%3DDesktop&hl=en

Look in /usr/share/xsessions/ for the .desktop file for your preferred desktop environment.
For example, LXDE has a file named `LXDE.desktop` with the following command: `Exec=/usr/bin/startlxde`

Create the session configuration file for localuser at `/home/localuser/.chrome-remote-desktop-session`

In our example (using LXDE and localuser) the file will look like this:

`#!/bin/bash`

`exec ssh -tY localuser@172.17.0.1 /usr/bin/startlxde`

For context, this command is telling the container where to get the desktop from. In the default docker coniguration, 172.17.0.1 will always be the host machine.

Finally, we need to do some one-time configuration within the container. Unfortunatly these steps can't be included in the build file.

`docker exec -it crd_session /bin/bash`

Then switch the the "dummy" user.

`su - user`

We need to generate and propogagate ssh keys so the conatiner can make a connection without authenticating every time. Just accept the defaults, and don't require a passphrase.

`ssh-keygen`
`ssh-copy-id localuser@172.17.0.1`

Answer yes to the fingerprint question, and enter the password for your local user.

Now, set up remote desktop with the instructions from https://remotedesktop.google.com/headless. You don't have to install anything, just skip through to the part where it gives you a code. Then copy and paste the code into the container terminal.

At this point it should spit out some text and say `Host ready to receive connections`. If it dosen't, you probably missed a step. To double check go to https://remotedesktop.google.com/access and see if you can access your desktop.

Exit container

`Ctrl+D, Ctrl+D`

Congratulations, you now have a remote desktop connection that will persist across reboots!

If anyone has a better idea of how to script the headless setup part, please let me know. :)
