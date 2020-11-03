#!/bin/bash -e

echo
echo Building docker image...
docker build -t robodemo .

echo
echo Ready to start.. Continue?
read -p "(yes / no): " update

if [ $update == "yes" ]; then
    docker run -p 8080:8080 --env JAVA_OPTS=-Dhudson.model.DirectoryBrowserSupport.CSP= -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --detach --name robodemo robodemo
    echo
    echo Docker is now running open your browser: http://localhost:8080
    echo Login with admin / RoboCorpRules2020!
else
    echo User cancelled
fi