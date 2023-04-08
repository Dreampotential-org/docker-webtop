FROM ghcr.io/linuxserver/baseimage-kasmvnc:fedora37

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

RUN \
  echo "**** install packages ****" && \
  dnf install -y --setopt=install_weak_deps=False --best \
    chromium \
    icewm \
    st && \
  echo "**** application tweaks ****" && \
  mv \
    /usr/bin/chromium-browser \
    /usr/bin/chromium-real && \
  ln -s \
    /usr/bin/st-fedora \
    /usr/bin/x-terminal-emulator && \
  rm /usr/bin/xterm && \
  ln -s \
    /usr/bin/st-fedora \
    /usr/bin/xterm && \
  echo "**** cleanup ****" && \
  dnf autoremove -y && \
  dnf clean all && \
  rm -rf \
    /config/.cache \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config
