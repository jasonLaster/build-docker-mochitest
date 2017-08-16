FROM ubuntu:trusty

# Install Firefox build dependencies.
# Packages are from https://dxr.mozilla.org/mozilla-central/source/python/mozboot/mozboot/debian.py
RUN apt-get update -qq \
 && apt-get upgrade -qqy \
 && apt-get install -qqy \
  autoconf2.13 \
  build-essential \
  ccache \
  python-dev \
  python-pip \
  python-setuptools \
  unzip \
  uuid \
  zip \
  libasound2-dev \
  libcurl4-openssl-dev \
  libdbus-1-dev \
  libdbus-glib-1-dev \
  libgconf2-dev \
  libgtk-3-dev \
  libgtk2.0-dev \
  libiw-dev \
  libnotify-dev \
  libpulse-dev \
  libx11-xcb-dev \
  libxt-dev \
  mesa-common-dev \
  python-dbus \
  xvfb \
  wget \
  yasm \
  git \
  curl \
  apt-transport-https \
  ocaml \
  libelf-dev \
  python-software-properties \
  && easy_install -U mercurial \
  && wget -O bootstrap.py https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py \
  && python bootstrap.py --no-interactive --application-choice=browser \
  && curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - \
  && apt-get install -yqq yarn nodejs \
  && rm -rf /var/lib/apt/lists/*

ENV SHELL /bin/bash

# RUN hg clone https://hg.mozilla.org/mozilla-central/ firefox
ADD firefox /firefox
WORKDIR /firefox

RUN echo " \
    ac_add_options --enable-artifact-builds\n \
    mk_add_options MOZ_OBJDIR=./objdir-frontend\n \
" > .mozconfig

RUN echo "source /root/.cargo/env" >>  .bash_profile
RUN source .bash_profile

RUN ./mach bootstrap --application-choice browser_artifact_mode --no-interactive \
  && ./mach configure \
  && ./mach clobber python \
  && ./mach clobber
