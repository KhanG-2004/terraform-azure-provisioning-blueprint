#!/usr/bin/env bash
set -euo pipefail

# Configuration Variables
RESOURCE_GROUP_NAME="tf-state-rg"
LOCATION="eastus"
STORAGE_ACCOUNT_NAME="devstacktfstate2026"
CONTAINER_NAME="tfstate"

echo "Creating Resource Group: ${RESOURCE_GROUP_NAME}..."
az group create --name "${RESOURCE_GROUP_NAME}" --location "${LOCATION}"

echo "Creating Encrypted Storage Account: ${STORAGE_ACCOUNT_NAME}..."
az storage account create \
  --name "${STORAGE_ACCOUNT_NAME}" \
  --resource-group "${RESOURCE_GROUP_NAME}" \
  --location "${LOCATION}" \
  --sku Standard_LRS \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false

echo "Creating Private Storage Container: ${CONTAINER_NAME}..."
az storage container create \
  --name "${CONTAINER_NAME}" \
  --account-name "${STORAGE_ACCOUNT_NAME}" \
  --auth-mode login

echo "Azure Blob Storage remote backend configured successfully."
