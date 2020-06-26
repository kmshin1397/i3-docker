#!/bin/bash
# This script stops and removes any running I3 Docker container.

if $(sudo docker container ls | grep -q i3); then 
	echo "Closing I3 container"
	sudo docker stop i3 && sudo docker rm i3
	exit;
fi