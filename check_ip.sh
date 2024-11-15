#!/bin/bash

# Funcția care verifică validitatea unei adrese IP prin DNS
function check_ip_via_dns() {
    local hostname=$1
    local ip=$2
    local dns_server=$3

    # Folosește nslookup pentru a verifica asocierea DNS
    resolved_ip=$(nslookup $hostname $dns_server | grep "Address" | tail -n 1 | awk '{print $2}')

    if [[ $resolved_ip == $ip ]]; then
        echo "Asocierea $hostname ($ip) este validă pe serverul DNS $dns_server."
    else
        echo "Asocierea $hostname ($ip) nu este validă pe serverul DNS $dns_server."
    fi
}

# Citește fiecare linie din /etc/hosts și verifică IP-urile
while read -r line; do
    hostname=$(echo $line | awk '{print $2}')
    ip=$(echo $line | awk '{print $1}')
    if [[ $ip != "" && $ip != "#" && $hostname != "" ]]; then
        # Înlocuiește cu serverul DNS dorit (de exemplu, 8.8.8.8)
        dns_server="8.8.8.8"
        check_ip_via_dns $hostname $ip $dns_server
    fi
done < /etc/hosts
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
