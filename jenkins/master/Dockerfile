FROM oberthur/docker-ubuntu-java:8.45.14

MAINTAINER Dawid Malinowski <d.malinowski@oberthur.com>

RUN wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add - && \
	sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' && \
	apt-get update && \
	apt-get install -y jenkins=1.596.2

# clean all cache to clean space
RUN rm -rf /var/lib/apt/lists/* && \
    apt-get clean

USER jenkins

ENTRYPOINT ["java","-Djava.awt.headless=true","-DJENKINS_HOME=/var/lib/jenkins", \
"-jar","/usr/share/jenkins/jenkins.war","--logfile=/var/log/jenkins/jenkins.log", \
"--webroot=/var/cache/jenkins/war","--httpPort=8080"]

CMD ["--prefix=/jenkins"]