FROM oberthur/docker-ubuntu-java:jdk8_8.40.26

MAINTAINER Dawid Malinowski <d.malinowski@oberthur.com>

ENV HOME /opt/jenkins-slave
ENV _JAVA_OPTIONS=-Duser.home=/opt/jenkins-slave
ENV DOCKER_VERSION 1.6.0
ENV SWARM_VERSION 1.24

WORKDIR /opt/jenkins-slave

RUN mkdir -p /opt/jenkins-slave \
    && curl -o /opt/jenkins-slave/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$SWARM_VERSION/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar \
    && echo '#!/bin/bash -x\n\njava -jar /opt/jenkins-slave/swarm-client-SWARM_VERSION-jar-with-dependencies.jar -username $JENKINS_USERNAME -password $JENKINS_PASSWORD -mode normal -name $JENKINS_SLAVE_NAME -executors $JENKINS_EXEC_NR -master $JENKINS_URL -fsroot $JENKINS_FS_ROOT -labels "$JENKINS_SLAVE_LABELS"' > /usr/bin/swarm_slave.sh \
    && chmod +x /usr/bin/swarm_slave.sh

# Make sure the package repository is up to date.
RUN apt-get update && apt-get install -y apt-transport-https \
    && echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
    && apt-get update \
    && apt-get install -y lxc-docker=$DOCKER_VERSION git

# clean all cache to clean space
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get -y autoremove

# add user jenkins-slave
RUN groupadd -g 998 998 \
    && useradd -u 500 jenkins-slave -U -s /bin/false \
    && usermod -G 998 jenkins-slave \
    && usermod -G 999 jenkins-slave \
    && chown -R jenkins-slave:jenkins-slave /opt/

ENTRYPOINT ["/usr/bin/swarm_slave.sh"]
