FROM oberthur/docker-ubuntu:16.04-20170829

MAINTAINER Dawid Malinowski <d.malinowski@oberthur.com>

# Java Version
ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=131 \
    JAVA_VERSION_BUILD=11 \
    JAVA_PACKAGE=openjdk-8-jdk \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Add label
LABEL TYPE="JAVA"

# Download and unarchive Java
RUN apt-get update && apt-get install -y ${JAVA_PACKAGE}=${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}-2ubuntu1.16.04.3 \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

# Add user app
RUN groupadd -g 499 app \
    && useradd -u 499 app -g app -s /bin/false -M -d /opt/app \
    && mkdir -p /opt/app/logs/archives \
    && chown -R app:app /opt/app \

# clean up
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && rm -fr /tmp/* /var/tmp/*

# cleaning docs
ONBUILD RUN rm -rf /usr/share/doc/* \
  && rm -rf /usr/share/doc/*/copyright \
  && rm -rf /usr/share/man/* \
  && rm -rf /usr/share/info/*
