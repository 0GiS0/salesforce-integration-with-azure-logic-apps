# 0. Variables
STORAGE_ACCOUNT_NAME="AZURE_STORAGE_NAME"
STORAGE_ACCOUNT_ACCESS_KEY="AZURE_STORAGE_ACCESS_KEY"

# 1. Create Azure Logic Apps Connections

cd terraform/1.api-connections

terraform init \
    -backend-config="storage_account_name=${STORAGE_ACCOUNT_NAME}" \
    -backend-config="container_name=salesforce-integration" \
    -backend-config="key=api-connections.tfstate" \
    -backend-config="access_key=${STORAGE_ACCOUNT_ACCESS_KEY}"

terraform validate
terraform plan -var="azuread_domain=YOUR_DOMAIN.onmicrosoft.com" -out api-connections.tfplan
terraform apply api-connections.tfplan

# 2. Create Azure Logic App workflows

cd terraform/2.workflows

terraform init \
    -backend-config="storage_account_name=${STORAGE_ACCOUNT_NAME}" \
    -backend-config="container_name=salesforce-integration" \
    -backend-config="key=workflow.tfstate" \
    -backend-config="access_key=${STORAGE_ACCOUNT_ACCESS_KEY}"

terraform validate
terraform plan -var="remote_states_access_key=${STORAGE_ACCOUNT_ACCESS_KEY}" -out workflow.tfplan
terraform apply workflow.tfplan


