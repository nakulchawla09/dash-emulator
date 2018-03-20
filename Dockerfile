# FROM phusion/baseimage
FROM ubuntu
MAINTAINER Holger Schinzel <holger@dash.org>

ARG USER_ID
ARG GROUP_ID

ENV HOME /dash
RUN apt-get update	
RUN apt-get dist-upgrade -y
RUN apt-get -y install python-software-properties
RUN apt-get -y install software-properties-common
RUN apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
RUN apt-get -y install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get -y install libdb4.8-dev libdb4.8++-dev

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} dash
RUN useradd -u ${USER_ID} -g dash -s /bin/bash -m -d /dash dash

RUN chown dash:dash -R /dash

COPY ./dashd /usr/local/bin
COPY ./dash-cli /usr/local/bin
COPY ./dash-tx /usr/local/bin

RUN chmod a+x /usr/local/bin/*

# For some reason, docker.io (0.9.1~dfsg1-2) pkg in Ubuntu 14.04 has permission
# denied issues when executing /bin/bash from trusted builds.  Building locally
# works fine (strange).  Using the upstream docker (0.11.1) pkg from
# http://get.docker.io/ubuntu works fine also and seems simpler.
USER dash

VOLUME ["/dash"]

EXPOSE 9998 9999 19998 19999

WORKDIR /dash

# CMD ["dash_oneshot"]
