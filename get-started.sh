#!/bin/bash -e

echo
echo Building docker image...
docker build -t robodemo .

echo
echo Ready to start.. Continue?
read -p "(yes / no): " update

if [ $update == "yes" ]; then
    docker run -p 8080:8080 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --detach --name robodemo robodemo
    echo
    echo Jenkins is now running!
    echo Open your browser to: http://localhost:8080
    echo Login with admin / RoboCorpRules2020!
else
    echo User cancelled
fi
