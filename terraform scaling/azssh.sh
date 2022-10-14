#!/bin/env bash

RG="$1"
VM="$2"

VMID=$(az vm list -g "$RG" --query "[?name == '$VM'].id" | jq -r '.[0]')
BAST=$(az network bastion list --only-show-errors -g "$RG" --query "[].name" | jq -r '.[0]')

az network bastion ssh --only-show-errors --target-resource-id "$VMID" --auth-type "ssh-key" --username adminuser --ssh-key "$HOME/.ssh/id_rsa.pub" --name "$BAST" --resource-group "$RG"
