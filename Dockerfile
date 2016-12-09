FROM oberthur/docker-ubuntu:16.04

MAINTAINER Dawid Malinowski <d.malinowski@oberthur.com>

# Java Version
ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=112 \
    JAVA_VERSION_BUILD=15 \
    JAVA_PACKAGE=jdk \
    JAVA_HOME=/opt/jdk \
    PATH=${PATH}:/opt/jdk/bin

# Add label
LABEL TYPE="JAVA"

# Download and unarchive Java
RUN curl -kLOH "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    && gunzip ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    && tar -xf ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar -C /opt \
    && rm ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar \
    && ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk \
    && mkdir -p /opt/jdk/jre/lib/security \
    # Download Java Cryptography Extension
    && curl -s -k -L -C - -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION_MAJOR}/jce_policy-${JAVA_VERSION_MAJOR}.zip > /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip \
    && apt-get update && apt-get install unzip \
    && unzip -d /tmp/ /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip \
    && yes |cp -v /tmp/UnlimitedJCEPolicyJDK${JAVA_VERSION_MAJOR}/*.jar /opt/jdk/jre/lib/security/ \
    && rm -fr /tmp/* \
    && apt-get purge unzip \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

# Add user app
RUN groupadd -g 499 app \
    && useradd -u 499 app -g app -s /bin/false -M -d /opt/app \
    && mkdir -p /opt/app/logs/archives \
    && chown -R app:app /opt/app   
    
