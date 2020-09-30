#!/bin/bash

# if you are using a VPN, you will need the --network host option
# You probably also need to restart docker after using VPN by
# sudo systemctl restart docker
docker build --network host -t jiakuny/gasnetex:latest .

if [ "$1" == "push" ]
then
  docker push jiakuny/gasnetex:latest
fi