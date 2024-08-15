# Socks Shop Deployment

This project contains the necessary configuration and scripts to deploy the Socks Shop microservices application on AWS using Kubernetes, Terraform, Ansible, and various monitoring and logging tools.

## Prerequisites

- AWS account with appropriate permissions
- Terraform installed
- Ansible installed
- Kubectl installed and configured
- Helm installed
- Ansible Vault for managing secrets

## Infrastructure Setup

1. Navigate to the `infrastructure/terraform` directory.
2. Initialize Terraform: `terraform init`
3. Apply Terraform configuration: `terraform apply`

## Deploying the Application

1. Navigate to the `infrastructure/ansible` directory.
2. Run the playbook to deploy the application: `ansible-playbook playbooks/deploy.yml`

## Monitoring and Logging

1. Set up monitoring: `ansible-playbook playbooks/setup_monitoring.yml`
2. Set up logging: `ansible-playbook playbooks/setup_logging.yml`

## Security

1. Apply security configurations: `ansible-playbook playbooks/security.yml`

## CI/CD

Refer to the `ci-cd/` directory for Jenkins and GitLab CI/CD configurations.

## Accessing the Application

- The application will be accessible at `https://socks-shop.example.com`
- Monitor the application using Prometheus and Grafana at `http://<Prometheus URL>` and `http://<Grafana URL>`
- View logs using Kibana at `http://<Kibana URL>`

## Contributing

Please open issues and submit pull requests for any improvements.

## License

[MIT License](LICENSE)
