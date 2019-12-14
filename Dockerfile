FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt full-upgrade -y \
    && apt install -y sudo wget gosu openssh-client \
    && wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb \
    && apt install -y ./chrome-remote-desktop_current_amd64.deb \
    && rm -f ./chrome-remote-desktop_current_amd64.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash -G chrome-remote-desktop user

CMD service chrome-remote-desktop start
