# Socks Shop Deployment with CI/CD Pipeline

This repository contains the infrastructure and deployment setup for the Socks Shop application using Terraform, Ansible, and Kubernetes. It includes a CI/CD pipeline built with GitHub Actions that automates the deployment process.

## Project Structure

```plaintext
.
├── infrastructure
│   ├── ansible.cfg
│   ├── ansible
│   │   └── playbooks
│   │       ├── setup_monitoring.yml
│   │       ├── deploy_socks_shop.yml
|   |       ├── deplo.yml
|   |       ├── inventory.ini
|   |       ├── security.yml
│   │       └── setup_logging.yml
│   ├── k8s-manifests
│   │   ├── issuer.yaml
│   │   ├── ingress.yaml
│   │   ├── servicemonitor.yaml
│   │   ├── alertmanager-config.yaml
│   │   └── network-policy.yaml
│   └── terraform
│       ├── main.tf
│       ├── kubeconfig_socks-shop-cluster
│       ├── outputs.tf
│       ├── provider.tf
│       └── terraform.tfvars
├── .gitignore
├── README.md 
└── .github
    └── workflows
        └── deploy.yml
```

### Key Files and Directories

- **`infrastructure/terraform/`**: Contains Terraform configuration files to set up the AWS infrastructure.
- **`infrastructure/ansible/playbooks/`**: Includes Ansible playbooks for setting up monitoring, deploying the application, and configuring security measures.
- **`infrastructure/k8s-manifests/`**: Kubernetes manifest files for additional resources like ingress, service monitor, and security policies.
- **`.github/workflows/deploy.yml`**: GitHub Actions workflow that automates the CI/CD pipeline.

## Prerequisites

Ensure you have the following installed:
- [Terraform](https://www.terraform.io/downloads)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- An AWS account with appropriate permissions configured in your environment.

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/socks_shop_deployment.git
cd socks_shop_deployment
```

### 2. Initialize and Apply Terraform Configuration

```bash
cd infrastructure/terraform/
terraform init
terraform apply -auto-approve
```

This will set up the necessary AWS infrastructure for the Socks Shop application.

### 3. Run Ansible Playbooks

Use Ansible to set up monitoring, deploy the application, and configure security:

```bash
ansible-playbook infrastructure/ansible/playbooks/setup_monitoring.yml
ansible-playbook infrastructure/ansible/playbooks/deploy_socks_shop.yml
ansible-playbook infrastructure/ansible/playbooks/setup_security.yml
```

### 4. Apply Kubernetes Manifests

Deploy additional Kubernetes resources:

```bash
cd infrastructure/k8s-manifests
kubectl apply -f issuer.yaml
kubectl apply -f ingress.yaml
kubectl apply -f servicemonitor.yaml
kubectl apply -f alertmanager-config.yaml
kubectl apply -f networkpolicy.yaml
```

## CI/CD Pipeline

### GitHub Actions Workflow

The CI/CD pipeline is defined in `.github/workflows/deploy.yml`. It will automatically trigger on pushes and pull requests to the `main` branch and execute the following steps:

1. **Checkout Code**: Retrieves the code from the repository.
2. **Terraform Setup and Apply**: Initializes and applies the Terraform configuration to provision infrastructure.
3. **Install Ansible**: Installs Ansible on the runner.
4. **Run Ansible Playbooks**: Executes the playbooks to set up monitoring, deploy the application, and configure security.
5. **Apply Kubernetes Manifests**: Deploys the Kubernetes resources.

### Monitoring and Logs

You can monitor the progress of each job in the pipeline under the "Actions" tab of your GitHub repository. Logs for each step will be available there.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```

### Summary

This `README.md` provides clear instructions on how to set up, deploy, and maintain the Socks Shop application using Terraform, Ansible, Kubernetes, and GitHub Actions for CI/CD. It also includes information on the project structure, prerequisites, and contribution guidelines.
