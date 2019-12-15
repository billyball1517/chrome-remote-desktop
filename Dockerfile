FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt full-upgrade -y \
    && apt install -y sudo wget openssh-client \
    && wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb \
    && apt install -y ./chrome-remote-desktop_current_amd64.deb \
    && rm -f ./chrome-remote-desktop_current_amd64.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash -G chrome-remote-desktop user

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD /usr/bin/tail -f /dev/null
