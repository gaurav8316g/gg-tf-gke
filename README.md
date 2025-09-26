# -------------------------------------------------------------
# IMPORTANT: Set Your GCP Project Name
# -------------------------------------------------------------
# Before running 'terraform apply', update the project name in all configuration files:
#   <GCP_PROJECTNAME>
#
# Example: environments/dev/terraform.tfvars
#   gcp_project = "<GCP_PROJECTNAME>"
# Replace <GCP_PROJECTNAME> with your actual GCP project ID everywhere it appears in the configs.
# Initialize gcloud CLI
./google-cloud-sdk/bin/gcloud init

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

# Configure GCP Credentials (ADC: Application Default Credentials)
# IMPORTANT: MANDATORY FOR TERRAFORM COMMANDS TO WORK WITH GCP FROM OUR LOCAL TERMINAL
gcloud auth application-default login

# -------------------------------------------------------------
# MANDATORY: Enable Required Google Cloud APIs before Terraform
# -------------------------------------------------------------
# -------------------------------------------------------------
# MANDATORY: Enable Required Google Cloud APIs before Terraform
# -------------------------------------------------------------
# 1. Enable Compute Engine API:
#    https://console.developers.google.com/apis/api/compute.googleapis.com/overview?project=<YOUR_PROJECT_ID>
# 2. Enable Kubernetes Engine API:
#    https://console.developers.google.com/apis/api/container.googleapis.com/overview?project=<YOUR_PROJECT_ID>
# Replace <YOUR_PROJECT_ID> with your actual GCP project ID.
# Both APIs must be enabled before running 'terraform apply'.

# -------------------------------------------------------------
# MANDATORY: Create Cloud Storage Bucket for Terraform Backend
# -------------------------------------------------------------
# Before running any Terraform commands, create the required GCS bucket for remote state storage:
#
#   gsutil mb -p <YOUR_PROJECT_ID> -l <YOUR_REGION> gs://gg-terraform-2025
#
# Replace <YOUR_PROJECT_ID> and <YOUR_REGION> with your values.
# The bucket name must match the value in your backend config (see environments/dev/c1-versions.tf):
#   bucket = "gg-terraform-2025"


## Important Note about gke-gcloud-auth-plugin: 
1. Kubernetes clients require an authentication plugin, gke- gcloud-auth-plugin, which uses the Client-go Credential Plugins framework to provide authentication tokens to communicate with GKE clusters

# Verify if gke-gcloud-auth-plugin installed
gke-gcloud-auth-plugin --version

# Install gke-gcloud-auth-plugin
gcloud components install gke-gcloud-auth-plugin

# Verify if gke-gcloud-auth-plugin installed
gke-gcloud-auth-plugin --version

# List gcloud components
gcloud components list

## SAMPLE OUTPUT
Status: Not Installed
Name: kubectl
ID: kubectl
Size: < 1 MiB

# Install kubectl client
gcloud components install kubectl

# Verify kubectl version
kubectl version --output=yaml



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



# Delete Kubernetes  Resources
cd dev
terraform apply -destroy -auto-approve
Remove-Item -Recurse -Force .terraform*