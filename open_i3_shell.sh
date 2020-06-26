#!/bin/bash
# This script opens a new shell into an existing I3 container.

if $(sudo docker container ls | grep -q i3); then 
	sudo docker exec -it --user I3 i3 bash
fi