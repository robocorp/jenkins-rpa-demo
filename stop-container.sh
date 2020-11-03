#!/bin/bash -e

echo
echo Stopping and removing container.. Continue?
read -p "(yes / no): " stop

if [ $stop == "yes" ]; then
    
    docker stop robodemo
    docker rm robodemo
    echo.
    echo Container stopped

else
    echo User cancelled
fi