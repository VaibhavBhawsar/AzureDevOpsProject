# AzureDevOpsProject

## Overview
This project demonstrates a **DevOps pipeline** for deploying a FastAPI application using:
- **FastAPI** (Backend API)
- **Docker** (Containerization)
- **Kubernetes (AKS)** (Orchestration)
- **Terraform** (Infrastructure as Code)
- **Jenkins** (CI/CD)
- **Azure VM** (Hosting)

---

## Project Structure
```
AzureDevOpsProject/
├── backend/                # FastAPI backend
│   ├── main.py             # FastAPI app
│   ├── Dockerfile          # Dockerfile for containerization
│   ├── requirements.txt    # Python dependencies
│   ├── app/                # API Code
│   │   ├── __init__.py
│   │   ├── routes.py       # API Routes
│   │   ├── models.py       # Data Models
│   │   ├── database.py     # Database Config (Optional)
│   └── tests/              # Unit Tests
│       ├── test_main.py
│
├── manifests/              # Kubernetes YAML Files
│   ├── deployment.yaml
│   ├── service.yaml
│
├── terraform/              # Terraform Configs
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
├── jenkins/                # CI/CD Pipeline Configs
│   ├── Jenkinsfile
│
└── README.md               # Documentation
```

---

## 1️⃣ Setup FastAPI Backend
### Install Dependencies
```sh
sudo apt update && sudo apt install -y python3 python3-pip
pip install fastapi uvicorn
```
### Create `backend/main.py`
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from FastAPI running in Docker on Azure!"}
```
### Create `backend/requirements.txt`
```
fastapi
uvicorn
```

---

## 2️⃣ Containerize with Docker
### Install Docker
```sh
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
```
### Create `backend/Dockerfile`
```dockerfile
FROM python:3.9
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```
### Build & Run Docker Container
```sh
cd backend
docker build -t fastapi-app .
docker run -d -p 8000:8000 fastapi-app
```

---

## 3️⃣ Deploy to Kubernetes (AKS)
### Install Azure CLI & Kubernetes CLI
```sh
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az login
az aks install-cli
```
### Create AKS Cluster
```sh
az group create --name DevOpsGroup --location eastus
az aks create --resource-group DevOpsGroup --name MyAKSCluster --node-count 1 --generate-ssh-keys
az aks get-credentials --resource-group DevOpsGroup --name MyAKSCluster
```
### Apply Kubernetes Manifests
```sh
kubectl apply -f manifests/
kubectl get services
```

---

## 4️⃣ Automate with Terraform
### Install Terraform
```sh
sudo apt install -y terraform
```
### Create `terraform/main.tf`
```hcl
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "devops" {
  name     = "DevOpsGroup"
  location = "East US"
}
```
### Deploy Infrastructure
```sh
cd terraform
terraform init
terraform apply -auto-approve
```

---

## 5️⃣ Setup CI/CD with Jenkins
### Install Jenkins
```sh
sudo apt update
sudo apt install openjdk-11-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
```
### Configure `jenkins/Jenkinsfile`
```groovy
pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/VaibhavBhawsar/AzureDevOpsProject.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'cd backend && docker build -t fastapi-app .'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f manifests/deployment.yaml'
                sh 'kubectl apply -f manifests/service.yaml'
            }
        }
    }
}
```
### Run Jenkins Pipeline
1. **Login to Jenkins:** `http://your-vm-ip:8080`
2. **Create a new pipeline**
3. **Set GitHub repo URL & add Jenkinsfile**
4. **Run the pipeline**

---

## 6️⃣ Deploy on Azure VM
### Login to Azure VM & Clone Repo
```sh
ssh azureuser@your-vm-ip
git clone https://github.com/VaibhavBhawsar/AzureDevOpsProject.git
cd AzureDevOpsProject
```
### Run Terraform & Kubernetes
```sh
terraform apply -auto-approve
kubectl apply -f manifests/
```

---

## ✅ Final Deployment
🚀 **FastAPI running in Kubernetes (AKS)**
🐳 **Containerized with Docker**
⚙️ **Automated with Terraform**
🔁 **CI/CD with Jenkins**
🔗 **Fully deployed on Azure!** 🎯

