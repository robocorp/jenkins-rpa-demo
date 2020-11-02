FROM jenkins/jenkins:2.249.2
MAINTAINER jyri.ilama@gmail.com
USER root

RUN apt-get update && \
    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get -y install docker-ce

# install jenkins plugins
COPY ./jenkins-plugins /usr/share/jenkins/plugins
RUN while read i ; \
                do /usr/local/bin/install-plugins.sh $i ; \
        done < /usr/share/jenkins/plugins

#Update the username and password
ENV JENKINS_USER admin
ENV JENKINS_PASS RoboCorpRules2020!

#id_rsa.pub file will be saved at /root/.ssh/
RUN ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''

# allows to skip Jenkins setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Jenkins runs all groovy files from init.groovy.d dir
# use this for creating default admin user
COPY scripts/*.groovy /usr/share/jenkins/ref/init.groovy.d/

VOLUME /var/jenkins_home
