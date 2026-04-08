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
| `azurerm_managed_disk` | Managed Disk | Persistent storage for VMs |
| `azurerm_monitor_alert` | Azure Monitor Alert | Infrastructure monitoring and alerting |

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
+----------------+
| Linux Virtual  |
| Machine (VM)   |
+----------------+
   |
   v
+----------------+
| Public IP      |
+----------------+
```

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

### Post-Deployment
- Connect to your VM: `ssh -i ~/.ssh/azure_key azureuser@<VM_PUBLIC_IP>`
- Verify resources in Azure Portal or with `az resource list --resource-group <RESOURCE_GROUP_NAME>`

---

## Learning Journey: Reflection

This repository represents my hands-on learning exercise for Day 5 of my cloud infrastructure journey, focusing on Azure fundamentals and Terraform implementation.

### Current Implementation (Completed)
- ✅ Resource Group with comprehensive tagging
- ✅ Virtual Network with public and private subnets
- ✅ Network Security Group with secure SSH and HTTP access rules
- ✅ Linux Virtual Machine (Ubuntu 22.04 LTS) with public IP access
- ✅ SSH key authentication and secure access

### Planned Enhancements (Next Steps)
- 🚧 **Storage Account + Blob Container:** S3 equivalent with public access disabled and TLS 1.2 enforcement
- 🚧 **Managed Identity:** System-assigned identity for secure, passwordless access to Azure resources
- 🚧 **Azure Monitor Alert:** CPU percentage alert on the VM (>80% for 5 minutes)
- 🚧 **Remote State Management:** Azure Storage Account backend for production-grade state management
- 🚧 **Azure Key Vault:** Centralized secrets and key management
- 🚧 **AKS Cluster:** Managed Kubernetes for container workloads

### Implementation Progress
This repository follows a progressive learning approach where each feature builds upon the previous one, mirroring real-world infrastructure development practices.

---

## License
MIT License — see [LICENSE](LICENSE)
