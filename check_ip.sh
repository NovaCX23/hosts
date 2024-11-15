#!/bin/bash

# Verifică validitatea unei adrese IP folosind regex
function check_ip_validity() {
    local ip=$1
    if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "$ip este o adresă IP validă."
    else
        echo "$ip nu este o adresă IP validă."
    fi
}

# Citește fiecare linie din /etc/hosts și verifică IP-urile
while read -r line; do
    ip=$(echo $line | awk '{print $1}')
    if [[ $ip != "" && $ip != "#" ]]; then
        check_ip_validity $ip
    fi
done < /etc/hosts
