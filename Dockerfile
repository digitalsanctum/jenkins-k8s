FROM jenkins/jenkins:2.235.2

USER root

# install default plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN xargs /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

# add 
RUN addgroup -g 639 cicd; \
    adduser -h /var/jenkins_home -u 639 -G cicd -D -s /bin/bash jenkins

USER jenkins
