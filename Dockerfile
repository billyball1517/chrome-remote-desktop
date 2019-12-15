FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV USER_ID=${LOCAL_USER_ID:-9001}

RUN apt update \
    && apt full-upgrade -y \
    && apt install -y sudo wget openssh-client \
    && wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb \
    && apt install -y ./chrome-remote-desktop_current_amd64.deb \
    && rm -f ./chrome-remote-desktop_current_amd64.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash -G chrome-remote-desktop user

CMD /usr/sbin/service chrome-remote-desktop start \
    && /usr/bin/tail -f /dev/null
