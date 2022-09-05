#!/bin/bash

# Utilities
iteration="1"

resource_group="n8n_g1_${iteration}"

# Administration
admin_name="noa"
password="2022Simplon!"
fqdn="n8ng1${iteration}"
local="francecentral"

# Network Resources
vnet_name="vnet"
subnet_name="app_subnet"

# Virtual Machines Resources 
bastion_name="bastion"
psql_server_name="psql${iteration}"
database_name="n8ndb"
vm_app_name="vmapp"
vm_size="Standard_DS1_v2"

# VM App Configuration
image_offer="UbuntuServer"
image_publisher="Canonical"
image_sku="'18.04-LTS'"
image_version="latest"

# Actualisation du répertoire tmp
rm -rf ./tmp/*

echo "---
- hosts: localhost
  vars:
    resource_group: $resource_group
    password: $password
    fqdn: $fqdn
    local: $local
    vnet_name: $vnet_name
    subnet_name: $subnet_name
    bastion_name: $bastion_name
    psql_server_name: $psql_server_name
    database_name: $database_name
    vm_app_name: $vm_app_name
    vm_size: $vm_size
    admin_name: $admin_name
    image_offer: $image_offer
    image_publisher: $image_publisher
    image_sku: $image_sku
    image_version: $image_version
  connection: local
  tasks:
  - import_tasks: ../models/network_model.yml
  - import_tasks: ../models/vms_model.yml" > ./tmp/ansible_tmp.yml

# On génère un fichier cloud-init à partir d'un modèle 
cat ./models/cloud-init_model.yml > ./tmp/cloud-init_tmp.yml

# On y rajoute trois lignes à la fin
echo "
  - echo 'docker run -it --rm --name n8n -p 80:5678 -e DB_TYPE=postgresdb -e DB_POSTGRESDB_DATABASE=$database_name -e DB_POSTGRESDB_HOST=$psql_server_name.postgres.database.azure.com -e DB_POSTGRESDB_PORT=5432 -e DB_POSTGRESDB_USER=$admin_name@$psql_server_name -e DB_POSTGRESDB_SCHEMA=public -e DB_POSTGRESDB_PASSWORD=$password -e GENERIC_TIMEZONE=\"Europe/Paris\" -e TZ=\"Europe/Paris\" -v /var/lib/n8n:/home/node/.n8n n8nio/n8n n8n start' > /tmp/log
  - docker run --rm --name n8n -p 80:5678 -e DB_TYPE=postgresdb -e DB_POSTGRESDB_DATABASE=$database_name -e DB_POSTGRESDB_HOST=$psql_server_name.postgres.database.azure.com -e DB_POSTGRESDB_PORT=5432 -e DB_POSTGRESDB_USER=$admin_name@$psql_server_name -e DB_POSTGRESDB_SCHEMA=public -e 'DB_POSTGRESDB_PASSWORD=$password' -e GENERIC_TIMEZONE=\"Europe/Paris\" -e TZ=\"Europe/Paris\" -v /var/lib/n8n:/home/node/.n8n n8nio/n8n
  - n8n start" >> ./tmp/cloud-init_tmp.yml

ansible-playbook ./tmp/ansible_tmp.yml
