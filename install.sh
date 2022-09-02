#!/bin/bash
RG="n8ps"
PASSWD="2022Simplon!"
FQDN="n8nlsn"
LOCAL="francecentral"
VNET="vnet"
BASTION="bastion"
POSGRES="posgr8kn"
BDD="n81sd"
VM="vm11k"
SIZE="Standard_DS1_v2"
ADMIN="nicolas"
OFFER="UbuntuServer"
PUBLISHER="Canonical"
SKU="'18.04-LTS'"
VERSION="latest"

echo "---
- hosts: localhost
  vars:
    rg: $RG
    passwd: $PASSWD
    fqdn: $FQDN
    local: $LOCAL
    vnet: $VNET
    bastion: $BASTION
    posgres: $POSGRES
    bdd: $BDD
    vm: $VM
    size: $SIZE
    admin: $ADMIN
    offer: $OFFER
    publisher: $PUBLISHER
    sku: $SKU
    version: $VERSION
  connection: local
  tasks:
  - import_tasks: reseau.yml
  - import_tasks: machines.yml"> brief4_groupe1.yml

cat cloud-init-base > cloud-init.yml

echo "
  - echo 'docker run -it --rm --name n8n -p 80:5678 -e DB_TYPE=postgresdb -e DB_POSTGRESDB_DATABASE=$BDD -e DB_POSTGRESDB_HOST=$POSGRES.postgres.database.azure.com -e DB_POSTGRESDB_PORT=5432 -e DB_POSTGRESDB_USER=$ADMIN@$POSGRES -e DB_POSTGRESDB_SCHEMA=public -e DB_POSTGRESDB_PASSWORD=$PASSWD -e GENERIC_TIMEZONE=\"Europe/Paris\" -e TZ=\"Europe/Paris\" -v /var/lib/n8n:/home/node/.n8n n8nio/n8n n8n start' > /tmp/log
  - docker run --rm --name n8n -p 80:5678 -e DB_TYPE=postgresdb -e DB_POSTGRESDB_DATABASE=$BDD -e DB_POSTGRESDB_HOST=$POSGRES.postgres.database.azure.com -e DB_POSTGRESDB_PORT=5432 -e DB_POSTGRESDB_USER=$ADMIN@$POSGRES -e DB_POSTGRESDB_SCHEMA=public -e 'DB_POSTGRESDB_PASSWORD=$PASSWD' -e GENERIC_TIMEZONE=\"Europe/Paris\" -e TZ=\"Europe/Paris\" -v /var/lib/n8n:/home/node/.n8n n8nio/n8n
  - n8n start">> cloud-init.yml

  ansible-playbook brief4_groupe1.yml
