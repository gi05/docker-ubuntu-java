FROM oberthur/jenkins-slave-base:1.5.0_1.23

ENV GRADLE_VERSION 2.3
ENV GRADLE_HOME /usr/share/gradle

RUN curl -L https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-all.zip > /usr/share/gradle-$GRADLE_VERSION-all.zip \
    && unzip -d /usr/share/ /usr/share/gradle-$GRADLE_VERSION-all.zip \
    && ln -s /usr/share/gradle-$GRADLE_VERSION /usr/share/gradle \
    && rm /usr/share/gradle-$GRADLE_VERSION-all.zip \
    && ln -s /usr/share/gradle/bin/gradle /usr/bin/gradle
