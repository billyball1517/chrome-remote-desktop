# billyball1517/chrome-remote-desktop

# 

1. docker run -d --name=crd_session --restart=always -e LOCAL_USER_ID=<localuseruid> -v /home/<localuser>:/home/user billyball1517/chrome-remote-desktop

2. docker exec -it crd_session /bin/bash

3. Set up remote desktop from https://remotedesktop.google.com/headless 

4. Exit container
