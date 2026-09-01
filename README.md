# Terraform on Azure: Complete Infrastructure Provisioning Blueprint

Production-grade Infrastructure as Code (IaC) repository provisioning an enterprise Microsoft Azure foundation using HashiCorp Terraform and Azure Blob Storage remote state locking.

Companion to the guide: [Terraform on Azure: 5 Complete Steps to Provision Infrastructure](https://devstackhub.tech/terraform-on-azure-iac-guide/)

---

## 🏗️ Architecture Components

* **Remote State Backend:** Azure Blob Storage with automated lease locking.
* **Network Infrastructure:** Virtual Network (VNet) with isolated web subnet tier.
* **Security Controls:** Network Security Group (NSG) restricting traffic to ports 80 (HTTP) and 443 (HTTPS).
* **Automation:** GitHub Actions workflow executing formatting checks, validation, and auto-deployments.

---

## 🚀 Getting Started

### 1. Prerequisites
* Azure CLI installed (`az login`)
* Terraform CLI (`>= 1.7.0`)
* Active Azure Subscription

### 2. Bootstrap Remote State
Run the bootstrap script to create the remote state storage account:
```bash
chmod +x bootstrap/setup-remote-state.sh
./bootstrap/setup-remote-state.sh
```

### 3. Initialize & Deploy
```
# Initialize provider plugins and remote state
terraform init

# Validate syntax
terraform validate

# Review proposed changes
terraform plan -out=production.tfplan

# Apply changes
terraform apply production.tfplan
```

🔐 GitHub Actions Secrets Setup
To run automated pipelines via GitHub Actions, add these repository secrets (Settings > Secrets and variables > Actions):

AZURE_CLIENT_ID

AZURE_CLIENT_SECRET

AZURE_SUBSCRIPTION_ID

AZURE_TENANT_ID
