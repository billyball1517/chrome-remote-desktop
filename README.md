# billyball1517/chrome-remote-desktop

docker run -d --name=crd_session --restart=always -e LOCAL_USER_ID=<localuseruid> -v /home/<localuser>:/home/user billyball1517/chrome-remote-desktop
docker exec -it crd_session /bin/bash
Set up remote desktop from https://remotedesktop.google.com/headless 
Exit container
