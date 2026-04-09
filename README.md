# Azure Terraform Foundation

## Overview
This repository demonstrates foundational Azure infrastructure provisioning using Terraform. It creates a complete, production-ready environment including:
- Resource Group with comprehensive tagging
- Virtual Network with public and private subnets
- Network Security Group with secure SSH and HTTP access rules
- Linux Virtual Machine (Ubuntu 22.04 LTS) with public IP access
- Proper resource isolation and security best practices

This project serves as a learning foundation for Azure cloud infrastructure and Infrastructure-as-Code (IaC) principles.

---

## Azure Resource Mapping
| Terraform Resource | Azure Service | Purpose |
|--------------------|----------------|---------|
| `azurerm_resource_group` | Resource Group | Logical container for all Azure resources |
| `azurerm_virtual_network` | Virtual Network (VNet) | Isolated network for Azure resources |
| `azurerm_subnet` | Subnet | Segmented network within the VNet |
| `azurerm_network_security_group` | Network Security Group (NSG) | Firewall rules for network traffic |
| `azurerm_linux_virtual_machine` | Virtual Machine (VM) | Linux compute instance |
| `azurerm_public_ip` | Public IP Address | Internet-accessible IP for the VM |
| `azurerm_storage_account` | Storage Account | Blob storage equivalent to S3 |
| `azurerm_user_assigned_identity` | Managed Identity | Secure, passwordless access to Azure resources |
| `azurerm_monitor_metric_alert` | Azure Monitor Alert | Infrastructure monitoring and alerting |

---

## AWS vs Azure Fundamentals

| AWS | Azure | Key Concept |
|-----|-------|-----------|
| VPC | Virtual Network (VNet) | Isolated network environment |
| Subnet | Subnet | Segmented network within VNet |
| EC2 Instance | Virtual Machine (VM) | Compute instance |
| S3 | Storage Account / Blob Storage | Object storage service |
| IAM Role | Managed Identity | Secure, passwordless access to Azure resources |
| Security Group | Network Security Group (NSG) | Firewall rules for network traffic |
| CloudWatch | Azure Monitor | Infrastructure monitoring and logging |
| CloudWatch Alarms | Azure Monitor Alerts | Metric-based alerting |
| Route 53 | Azure DNS | Domain name resolution |
| EKS | AKS | Managed Kubernetes service |

---

## Architecture Diagram

```
+----------------+
| Resource Group |
+----------------+
         |
         v
+----------------+
|   Virtual      |
|   Network      |
|   (VNet)       |
+----------------+
         |
   +-----+-----+
   |           |
   v           v
+-------+   +---------+
| Public|   | Private |
|Subnet |   | Subnet  |
+-------+   +---------+
   |
   v
+----------------+
| Network Security |
| Group (NSG)    |
+----------------+
   |
   v
+----------------+     +------------------+
| Linux Virtual  |<--->| Managed Identity |
| Machine (VM)   |     +------------------+
+----------------+            |
   |                          v
   v                   +------------------+
+----------------+     | Storage Account  |
| Public IP      |     | + Blob Container |
+----------------+     +------------------+
                              |
                              v
                       +------------------+
                       | Azure Monitor    |
                       | Alert (CPU >80%) |
                       +------------------+
```

---

## Module Structure

This project uses Terraform modules for reusable, maintainable infrastructure:

```
modules/
├── virtual_machine/     # Linux VM with networking and managed identity
│   ├── main.tf          # VM, public IP, NIC, and NSG association
│   ├── variables.tf     # Input variables
│   └── outputs.tf       # Output values
├── storage_account/     # Storage Account + Blob Container
│   ├── main.tf          # Storage account and container resources
│   ├── variables.tf     # Input variables
│   └── outputs.tf       # Output values
├── managed_identity/    # Managed Identity (user-assigned)
│   ├── main.tf          # Identity resource
│   ├── variables.tf     # Input variables
│   └── outputs.tf       # Output values
└── monitor_alert/       # Azure Monitor Alert
    ├── main.tf          # Metric alert resource
    ├── variables.tf     # Input variables
    └── outputs.tf       # Output values
```

### Module Details

#### Virtual Machine Module
- Provisions a Linux VM (Ubuntu 22.04 LTS) with configurable size and availability zone
- Creates a static Standard SKU public IP address
- Configures a network interface attached to the specified subnet
- Associates the NIC with a Network Security Group
- Attaches a User Assigned Managed Identity for passwordless Azure resource access
- Supports configurable OS disk type, size, and VM image

#### Storage Account Module
- Creates a Standard LRS storage account
- Enforces TLS 1.2 minimum
- Disables public access
- Creates a private blob container

#### Managed Identity Module
- Creates a user-assigned managed identity
- Assigns Storage Blob Data Contributor role to the VM
- Enables passwordless access to Azure resources

#### Monitor Alert Module
- Creates a metric alert for VM CPU usage
- Configurable threshold, window size, and evaluation frequency
- Auto-mitigation enabled

---

## Security Implementation
- **Network Security Group (NSG) Rules:**
  - SSH (port 22) access restricted to your specific IP address
  - HTTP (port 80) access allowed from anywhere for web services
- **VM Security:**
  - Ubuntu 22.04 LTS (Jammy Jellyfish) with latest security patches
  - SSH key authentication (no password authentication)
- **Resource Tagging:**
  - All resources tagged with Environment, Project, and ManagedBy for governance and cost tracking
- **Network Isolation:**
  - Public subnet for internet-facing resources
  - Private subnet for internal resources (currently unused but provisioned)
- **Storage Security:**
  - Public access disabled on storage account
  - TLS 1.2 minimum enforced
  - HTTPS traffic only
  - Private blob container access
- **Managed Identity:**
  - User-assigned managed identity for secure, passwordless access to Azure resources
  - Storage Blob Data Contributor role assigned to VM
  - No credentials to manage or rotate

---

## Remote State Management
This implementation uses local state for simplicity, but for production use:
- **Azure Storage Backend:** Store state in Azure Blob Storage with state locking
- **State Locking:** Prevent concurrent modifications to infrastructure
- **State Security:** Encrypt state files and restrict access permissions

> _For production environments, configure remote state using Azure Storage Account with proper access controls._

---

## Tagging Strategy
All resources are tagged with:
- **Environment:** `dev` (can be changed to `prod`, `staging`, etc.)
- **Project:** `portfolio` (represents the project name)
- **ManagedBy:** `terraform` (indicates IaC management)

This supports:
- **Cost allocation and FinOps**
- **Resource ownership and accountability**
- **Automated governance and compliance**
- **Resource discovery and management**

---

## Getting Started

### Prerequisites
- Azure CLI authenticated (`az login`)
- Terraform v1.14.8 or later
- SSH key pair (for VM access)

### Configuration
1. Update `terraform.tfvars` with your values:
   - `resource_group_name`: Name for your resource group
   - `location`: Azure region (e.g., `northeurope`)
   - `vnet_name`: Name for your virtual network
   - `vnet_cidr`: CIDR block for your VNet (e.g., `10.0.0.0/16`)
   - `public_subnet_cidr`: CIDR for public subnet (e.g., `10.0.1.0/24`)
   - `private_subnet_cidr`: CIDR for private subnet (e.g., `10.0.2.0/24`)
   - `my_ip`: Your public IP address with `/32` suffix (e.g., `123.45.67.89/32`)
   - `storage_account_name`: Globally unique storage account name (3-24 chars, lowercase + numbers)
   - `container_name`: Name for the blob container (default: `data`)
   - `identity_name`: Name for the managed identity (default: `vm-identity`)
   - `threshold`: CPU alert threshold percentage (default: `80`)

2. Ensure your SSH public key is at `~/.ssh/azure_key.pub`

### Deployment
```bash
# Initialize Terraform
terraform init

# Review the execution plan
terraform plan

# Apply the configuration
terraform apply -auto-approve
```

## Post-Deployment Validation & Testing
This section documents the manual validation steps performed to ensure the Azure resources provisioned by Terraform are working as expected.

### 🐚 1. Azure VM 
- Connect to your VM: `ssh -i ~/.ssh/azure_key azureuser@<VM_PUBLIC_IP>`
- Verify resources in Azure Portal or with `az resource list --resource-group <RESOURCE_GROUP_NAME>`

### 🔎 2. Managed Identity Verification

The VM uses a System‑Assigned Managed Identity. To verify that the identity is active and issuing tokens:

**Retrieve an Azure AD token from inside the VM:**

```bash
curl -H "Metadata: true" \
  "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/"
```

A successful response returns a JSON payload containing:

- `access_token`
- `expires_in`
- `token_type`

This confirms the Managed Identity is active and functional.

### ✅ 3. Storage Access Test Using Managed Identity

To validate that the VM's Managed Identity has the correct RBAC permissions on the Storage Account:

**Request a Storage‑scoped token:**

```bash
TOKEN=$(curl -H "Metadata: true" \
  "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://storage.azure.com/" \
  | jq -r '.access_token')
```

**List containers in the Storage Account:**

```bash
curl -H "Authorization: Bearer $TOKEN" \
     -H "x-ms-version: 2020-10-02" \
     "https://<storage-account-name>.blob.core.windows.net/?comp=list"
```

A successful response returns XML similar to:

```xml
<EnumerationResults>
  <Containers>
    <Container>
      <Name>data</Name>
      ...
    </Container>
  </Containers>
</EnumerationResults>
```

This confirms:

- The Managed Identity is authenticated
- The Storage Account RBAC permissions are correct
- The VM can access Storage without keys or passwords

### ✅ 4. CPU Alert Test (Azure Monitor)

To validate the CPU > 80% for 5 minutes alert:

**Run a CPU spike script inside the VM:**

```bash
#!/bin/bash
for i in {1..4}; do
  while : ; do : ; done &
done
sleep 360
killall bash
```

This generates sustained CPU load for 6 minutes.

**Expected outcome:**

- Azure Monitor fires the alert
- Alert appears under **Monitor → Alerts** in the Azure Portal
- Status transitions from **Fired → Resolved** once CPU returns to normal

---

## Current Implementation (Completed)
- ✅ Resource Group with comprehensive tagging
- ✅ Virtual Network with public and private subnets
- ✅ Network Security Group with secure SSH and HTTP access rules
- ✅ Linux Virtual Machine (Ubuntu 22.04 LTS) with public IP access
- ✅ SSH key authentication and secure access
- ✅ Storage Account + Blob Container (public access disabled, TLS 1.2 enforced)
- ✅ Managed Identity (user-assigned with Storage Blob Data Contributor role)
- ✅ Azure Monitor Alert (CPU >80% for 5 minutes)

## Planned Enhancements (Next Steps)
- 🚧 **Remote State Management:** Azure Storage Account backend for production-grade state management
- 🚧 **Azure Key Vault:** Centralized secrets and key management
- 🚧 **AKS Cluster:** Managed Kubernetes for container workloads


---

## License
MIT License — see [LICENSE](LICENSE)
