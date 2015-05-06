FROM oberthur/jenkins-slave-base:1.6.0_1.22

# Make sure the package repository is up to date.
RUN apt-get install -y ansible python-pycurl bsdtar genisoimage && \
    echo "[local]\n127.0.0.1" > /etc/ansible/hosts

# clean all cache to clean space
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get -y autoremove

USER root
