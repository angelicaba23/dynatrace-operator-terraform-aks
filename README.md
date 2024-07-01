# DEPLOY AKS

### Initialize Terraform
`terraform init -upgrade`

### Create a Terraform execution plan
`terraform plan -out main.tfplan`

### Apply a Terraform execution plan
`terraform apply main.tfplan`

source: [Quickstart: Deploy an Azure Kubernetes Service (AKS) cluster using Terraform](https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-terraform?pivots=development-environment-azure-cli)

---

# DEPLOY DYNATRACE

### Go to the folder
`cd dynatrace`

### Initialize Terraform
`terraform init -upgrade`

### Create a Terraform execution plan
Create a file `varaibles.tfvars` and define the dollowing variables:
```
dynatrace-operator-version = "1.2.0" # Available versions: https://gallery.ecr.aws/dynatrace/dynatrace-operator
dynatrace-deployment-mode  = "applicationMonitoring" #Use one of the following: "applicationMonitoring", "classicFullStack", "cloudNativeFullStack", "hostMonitoring"
dynatrace-api-url          = "https://ENVIRONMENTID.live.dynatrace.com/api" #REQUIRED For instructions, see https://www.dynatrace.com/support/help/reference/dynatrace-concepts/environment-id/.
dynatrace-apiToken         = "" #REQUIRED For instructions, see https://docs.dynatrace.com/docs/shortlink/installation-k8s-tokens-permissions.
dynatrace-dataIngestToken  = "" #REQUIRED For instructions, see https://docs.dynatrace.com/docs/shortlink/installation-k8s-tokens-permissions.
cluster-name               = "demo-eks" #REQUIRED
```
`terraform plan -out main.tfplan -var-file="varaibles.tfvars"`


### Apply a Terraform execution plan
`terraform apply main.tfplan`

---

# Clean up resources

`terraform plan -destroy -out main.destroy.tfplan`

`terraform apply main.destroy.tfplan`