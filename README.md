# README

## Overview

This repository provides Terraform configurations to set up a Jenkins server hosted on AWS and create an Amazon EKS (Elastic Kubernetes Service) environment with NGINX installed. The goal is to automate the provisioning of the infrastructure needed for continuous integration and deployment.

## Prerequisites

- **Terraform**: Ensure you have Terraform installed on your machine. You can download it from [Terraform's official website](https://www.terraform.io/downloads.html).
instructions.

## Directory Structure

```
.
├── Jenkins_server
│   ├── main.tf
│   ├── data.tf
│   ├── provider.tf
│   ├── jenkins-install.sh
│   └── variables.tf
│     └── ConfFiles
│          ├── deploy.yaml 
│          ├── service.yaml 
│   
├── eks
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── README.md
```

## Jenkins Server Setup

### 1. Navigate to the Jenkins Directory

```bash
cd jenkins
```

### 2. Configure Variables

Edit `variables.tf` to set your desired Jenkins configurations, such as instance type, region, and any other parameters.

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Plan the Deployment

```bash
terraform plan
```

### 5. Apply the Configuration

```bash
terraform apply
```

This will provision a Jenkins server on AWS.





### Create Jenkins Pipeline

### 1. Setup AWS Secrect credentials in Jenkins

    1. Navigate to the appropriate address to access the newly spun up jenkins server
    2. Create a new pipeline
    3. Setup respective credentials for aws (Access Key ID, and Access Key)
        a.Dashboard / Manage Jenkins/ Credentials / System / Global credentials
    4. Use provided jenkinsfile to setup the outline for the pipeline

This will provision an EKS cluster and install Nginx within the cluster.



## Cleanup

To clean up the resources created by Terraform, navigate to the respective directories and run:

```bash
terraform destroy
```