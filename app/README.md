# Node.js Docker App

## Build Docker Image
```bash
docker build -t node-hello:latest .


### deploy to kubernetes
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml


### check the status of application
kubectl get pods
kubectl get svc
kubectl get ingress

### find the Ingress IP
kubectl get svc -n ingress-nginx

###Test via curl
curl http://node.local

###Expected output
Hello World from Node.js in Kubernetes!


### Installing prametheous and granphana vi helm 

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update


### Install kube-prometheus-stack

helm install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring --create-namespace


### Check install

kubectl get pods -n monitoring
kubectl get svc -n monitoring

### Expose Grafana & Prometheus (Port Forward)


kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80

Access Grafana: http://localhost:3000

### default Credentials 

Username: admin
Password: prom-operator


### Prometheus Access


kubectl port-forward svc/monitoring-kube-prometheus-prometheus -n monitoring 9090:9090


Access Prometheus: http://localhost:9090



### Create Grafana Dashboard
### Once Prometheus starts scraping:

### Login to Grafana (localhost:3000)

### Add Prometheus data source

### Go to Configuration → Data Sources → Add Data Source

### Select Prometheus

### URL: http://monitoring-kube-prometheus-prometheus.monitoring.svc.cluster.local:9090

### Save & Test

### Import dashboard templates:

### Node Exporter Full (ID: 1860) → Node CPU & Memory usage

### Express / Custom App Metrics (we can create custom panels for:

### Request count (http_requests_total)

### Request latency (http_request_duration_seconds_bucket)

### after pushing to the master branch work flow:


Run test/lint

Build Docker image

Push it to Docker Hub

Deploy to Kubernetes

Rollback on failure



### Vulnerability Scanning with Trivy

### Install trivy

brew install aquasecurity/trivy/trivy
sudo apt install wget
wget https://github.com/aquasecurity/trivy/releases/latest/download/trivy_0.50.1_Linux-64bit.deb
sudo dpkg -i trivy_0.50.1_Linux-64bit.deb

trivy image node-hello:latest

### VPC & Networking Module

### Directory Structure

terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf          # For remote state (handled in a later step)
└── modules/
    └── vpc-network/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
### Initialize Terraform

cd terraform
terraform init

terraform plan  ### Preview changes

### Apply changes

terraform apply

###aws ec2 servers directory structure

terraform/
├── main.tf
├── variables.tf
├── outputs.tf
└── modules/
    └── servers/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf



### Final Deliverables steps

1. Git Repository Structure
Create the following directory structure in your repo:
your-project/
├── app/                        # Node.js source code & Dockerfile
│   ├── index.js
│   ├── package.json
│   └── Dockerfile
│
├── k8s/                        # Kubernetes YAMLs, Helm, setup scripts
│   ├── manifests/
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   ├── ingress.yaml
│   ├── ingress-nginx-install.sh
│   └── setup-cluster.sh
│
├── .github/
│   └── workflows/
│       └── ci-cd-pipeline.yml  # OR Jenkinsfile at root if using Jenkins
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend.tf
│   └── modules/
│       ├── vpc-network/
│       └── ec2-servers/
│
├── README.md                   # Documentation
├── architecture.png           # (Architecture Diagram)
└── security-report.md         # Security summary


2. Each Directory in Detail

app/
index.js: Express-based Hello World app

Dockerfile: Multi-stage build, non-root user, healthcheck

package.json: Include prom-client for metrics


k8s/
manifests/: Kubernetes deployment, service, and ingress YAML

setup-cluster.sh: KIND or k3d cluster creation

ingress-nginx-install.sh: Script to install Ingress Controller using Helm


.github/workflows/ or Jenkinsfile
CI/CD Pipeline to:

Lint & test Node.js app

Build & push Docker image

Deploy to K8s using kubectl set image

Rollback on failure

Use ci-cd-pipeline.yml if using GitHub Actions.

📁 terraform/
main.tf: High-level resources using modules

variables.tf, outputs.tf, backend.tf

modules/:

vpc-network/: Reusable networking module


ec2-servers/: EC2 and Bastion module


### Architecture Diagrams

Add architecture.png or infra-diagram.png showing:

VPC layout

EC2 instances (public/private)

K8s cluster setup

CI/CD pipeline flow

Monitoring integration


###  Visual Proof

Screenshot of app running via Ingress (curl output or browser)


### Grafana Dashboards



Screenshot of:

Node CPU & Memory

App request rate, latency (if prom-client is set)



### Security Report Summary


# Security Report

## RBAC
- Created dedicated service accounts for app and monitoring
- Defined Roles and RoleBindings with least-privilege principle

## Network Policies
- Restricted pod communication using `networkpolicy.yaml`

## Secrets Management
- Used Kubernetes Secrets to store DB credentials
- Optionally, sealed secrets or external secret manager

## Image Vulnerability Scanning
- Integrated `trivy` in CI/CD to scan Docker images
- Blocked pipeline on critical vulnerabilities

## IAM and Access
- Terraform IAM roles limited to S3, EC2, DynamoDB
- Terraform backend encrypted and locked via DynamoDB





