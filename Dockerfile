# FROM phusion/baseimage
FROM ubuntu
MAINTAINER Nakul Chawla <nakulchawla09@gmail.com> Cody Bales

ARG USER_ID
ARG GROUP_ID

ENV HOME /dash

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} dash
RUN useradd -u ${USER_ID} -g dash -s /bin/bash -m -d /dash dash

RUN mkdir /dash/.dashcore
RUN chown dash:dash -R /dash

COPY ./dash/depends/x86_64-pc-linux-gnu/bin/dashd /usr/local/bin
COPY ./dash/depends/x86_64-pc-linux-gnu/bin/dash-cli /usr/local/bin
COPY ./dash/depends/x86_64-pc-linux-gnu/bin/dash-tx /usr/local/bin
COPY dash.conf /dash/.dashcore

RUN chmod a+x /usr/local/bin/*

# For some reason, docker.io (0.9.1~dfsg1-2) pkg in Ubuntu 14.04 has permission
# denied issues when executing /bin/bash from trusted builds.  Building locally
# works fine (strange).  Using the upstream docker (0.11.1) pkg from
# http://get.docker.io/ubuntu works fine also and seems simpler.
USER dash

VOLUME ["/dash"]

EXPOSE 9998 9999 19998 19999 19994 19995

WORKDIR /dash

# CMD ["dash_oneshot"]
