FROM oberthur/jenkins-slave-base:1.6.0_1.24

ENV COMPOSE_VERSION 1.2

RUN curl -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

USER jenkins-slave