#!/bin/bash

# Check for input arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <kubeconfig_file> <new_server_ip> <username>"
    exit 1
fi

kubeconfig_file=$1
new_ip=$2
user=$3

# Copy the kubeconfig file to the current directory with a new name
sudo -u $user cp "$kubeconfig_file" ./jenkins/k3s.yaml

# Update the server field
sed -i "s|server: https://.*:6443|server: https://$new_ip:6443|g" ./jenkins/k3s.yaml

# echo "Updated 'server' field to https://$new_ip:6443 in ./jenkins/k3s.yaml