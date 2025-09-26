
# Terraform GCP GKE Deployment Guide

---

## 1. Set Your GCP Project Name

Before running `terraform apply`, update the project name in all configuration files:

*Example:*
```
environments/dev/terraform.tfvars
gcp_project = "<GCP_PROJECTNAME>"
```
Replace `<GCP_PROJECTNAME>` with your actual GCP project ID everywhere it appears in the configs.

---

## 2. Initialize gcloud CLI

```sh
./google-cloud-sdk/bin/gcloud init
```

---

## 3. gcloud Useful Commands

```sh
# List accounts whose credentials are stored on the local system:
gcloud auth list

# List the properties in your active gcloud CLI configuration
gcloud config list

# View information about your gcloud CLI installation and the active configuration
gcloud info

# gcloud config Configurations Commands (For Reference)
gcloud config list
gcloud config configurations list
gcloud config configurations activate
gcloud config configurations create
gcloud config configurations delete
gcloud config configurations describe
gcloud config configurations rename
```

---

## 4. Configure GCP Credentials (ADC: Application Default Credentials)

**MANDATORY FOR TERRAFORM COMMANDS TO WORK WITH GCP FROM LOCAL TERMINAL**

```sh
gcloud auth application-default login
```

---

## 5. Enable Required Google Cloud APIs (MANDATORY)

Enable the following APIs before running `terraform apply`:

1. [Compute Engine API](https://console.developers.google.com/apis/api/compute.googleapis.com/overview?project=<YOUR_PROJECT_ID>)
2. [Kubernetes Engine API](https://console.developers.google.com/apis/api/container.googleapis.com/overview?project=<YOUR_PROJECT_ID>)

Replace `<YOUR_PROJECT_ID>` with your actual GCP project ID.

---

## 6. Create Cloud Storage Bucket for Terraform Backend (MANDATORY)

Before running any Terraform commands, create the required GCS bucket for remote state storage:

```sh
gsutil mb -p <YOUR_PROJECT_ID> -l <YOUR_REGION> gs://gg-terraform-2025
```

Replace `<YOUR_PROJECT_ID>` and `<YOUR_REGION>` with your values.
The bucket name must match the value in your backend config (see `environments/dev/c1-versions.tf`):

```hcl
bucket = "gg-terraform-2025"
```

---

## 7. gke-gcloud-auth-plugin (Kubernetes Authentication)

Kubernetes clients require an authentication plugin, `gke-gcloud-auth-plugin`, which uses the Client-go Credential Plugins framework to provide authentication tokens to communicate with GKE clusters.

### Verify if gke-gcloud-auth-plugin is installed
```sh
gke-gcloud-auth-plugin --version
```

### Install gke-gcloud-auth-plugin
```sh
gcloud components install gke-gcloud-auth-plugin
```

### List gcloud components
```sh
gcloud components list
```

---

## 8. Install kubectl client (if needed)

If `kubectl` is not installed, you may see output like:

```
Status: Not Installed
Name: kubectl
ID: kubectl
Size: < 1 MiB
```

Install and verify:

```sh
gcloud components install kubectl
kubectl version --output=yaml
```

---

## 9. Terraform Workflow

```sh
# Change Directory
cd dev

# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve
```

---

## 10. Delete Kubernetes Resources

```sh
cd dev
terraform apply -destroy -auto-approve
Remove-Item -Recurse -Force .terraform*
```