# AZ-204 Library
practice app for az204

## Azure

### Local CLI
#### Install 
 `winget install --exact --id Microsoft.AzureCLI`

See https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest&pivots=winget

#### Sign in 
```
az login --use-device-code
```

See https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli-interactively?view=azure-cli-latest#sign-in-with-a-browser

### Terraform
#### Setup
```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
az role assignment create --assignee <APPID_VALUE> --role "User Access Administrator" --scope /subscriptions/<SUBSCRIPTION_ID>

$Env:ARM_CLIENT_ID = "<APPID_VALUE>"
$Env:ARM_CLIENT_SECRET = "<PASSWORD_VALUE>"
$Env:ARM_SUBSCRIPTION_ID = "<SUBSCRIPTION_ID>"
$Env:ARM_TENANT_ID = "<TENANT_VALUE>"

$env:TF_LOG="DEBUG"

terraform init
```

See:
- https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build
- https://medium.com/@vivazmo/azure-container-apps-with-terraform-part-1-ae20649e0dff
- https://medium.com/@abhimanyubajaj98/a-devops-guide-to-deploying-azure-container-registry-and-container-group-using-terraform-and-bash-341203aa80be
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group
- https://stackoverflow.com/a/77044815

#### Run
```
$RESOURCE_GROUP="az204-library-rg"
$LOCATION="canadacentral"
$ACR_NAME="az204lib"
$API_NAME="az204-library-api"
$API_TAG="1.0.0"

az group create --name $RESOURCE_GROUP --location $LOCATION
az acr create -n $ACR_NAME -g $RESOURCE_GROUP --sku Basic --location $LOCATION
az acr build --registry $ACR_NAME --image $API_NAME":"$API_TAG ./library

cd ./terraform
terraform plan -var resource_group_name=$RESOURCE_GROUP -var app_image_name=$API_NAME -var app_image_tag=$API_TAG
terraform apply -var resource_group_name=$RESOURCE_GROUP -var app_image_name=$API_NAME -var app_image_tag=$API_TAG

terraform destroy -var resource_group_name=$RESOURCE_GROUP -var app_image_name=$API_NAME -var app_image_tag=$API_TAG
```

### Bicep
#### Install
```
az bicep install && az bicep upgrade
```

#### Run
```
$RESOURCE_GROUP="az204-library-rg"
$LOCATION="canadacentral"
$ACR_NAME="az204lib"
$API_NAME="az204-library-api-containerapp"
$TAG="1.0.0"

az group create --name $RESOURCE_GROUP --location $LOCATION
az acr create -n $ACR_NAME -g $RESOURCE_GROUP --sku Basic --location $LOCATION
az acr build --registry $ACR_NAME --image $API_NAME":"$TAG ./library
az deployment group create --name main --template-file main.bicep -g $RESOURCE_GROUP --parameters environmentType=nonprod imageTag=$TAG apiName=$API_NAME
```

See:
- https://learn.microsoft.com/en-us/training/modules/build-first-bicep-file/4-exercise-define-resources-bicep-file?pivots=cli
- https://learn.microsoft.com/en-us/training/modules/build-first-bicep-file/6-exercise-add-parameters-variables-bicep-file?pivots=cli
- https://learn.microsoft.com/en-us/azure/templates/microsoft.app/containerapps?pivots=deployment-language-bicep


### IP Restrictions
https://docs.azure.cn/en-us/container-apps/ip-restrictions?pivots=azure-portal

### Manual Deployment
#### Setup
```
az login --use-device-code
az upgrade
az extension add --name containerapp --upgrade --allow-preview true
az provider register --namespace Microsoft.App
az provider register --namespace Microsoft.OperationalInsights
```

#### .NET app
```
az login --use-device-code

$RESOURCE_GROUP="az204-library-rg"
$LOCATION="canadacentral"
$ENVIRONMENT="production"
$API_NAME="az204-library-api-containerapp"

az group create --name $RESOURCE_GROUP --location $LOCATION

az containerapp up --name $API_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --environment $ENVIRONMENT --source .

```
- https://learn.microsoft.com/en-us/azure/container-apps/quickstart-code-to-cloud?tabs=bash%2Ccsharp
- https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-rest-api

#### Postgres
I created an `appsettings.Production.json` and used the ADO.NET connection string as found in Azure.

Then I used the following command:

`dotnet ef database update -- --environment Production`

- See: https://learn.microsoft.com/en-us/ef/core/cli/dotnet#aspnet-core-environment
- See: https://learn.microsoft.com/en-us/azure/cosmos-db/postgresql/howto-connect?tabs=pgadmin

#### Angular

```
az login --use-device-code

$RESOURCE_GROUP="az204-library-rg"
$LOCATION="canadacentral"
$ENVIRONMENT="production"
$UI_NAME="az204-library-ui-containerapp"

az group create --name $RESOURCE_GROUP --location $LOCATION

az containerapp up --name $UI_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --environment $ENVIRONMENT --source .
```
- https://azureossd.github.io/2024/07/30/Deploying-Angular-SSR-to-App-Service-Windows/

See deployment at `http://<yoursitename>.scm.azurewebsites.net`
- https://stackoverflow.com/a/26385007/1984657

### API Gateway
### Auth
- https://learn.microsoft.com/en-us/entra/external-id/customers/concept-planning-your-solution
- https://learn.microsoft.com/en-us/entra/external-id/self-service-sign-up-overview
#### Librarian users
#### Reader users
- https://learn.microsoft.com/en-us/entra/external-id/customers/how-to-user-flow-sign-up-sign-in-customers
- https://learn.microsoft.com/en-us/entra/external-id/self-service-sign-up-user-flow

### Blob storage
https://microsoftlearning.github.io/mslearn-azure-developer/instructions/azure-storage/01-blob-storage-resources-dotnet.html

### Cosmos DB
https://microsoftlearning.github.io/mslearn-azure-developer/instructions/azure-cosmos-db/01-comosdb-create-resources-sdk.html

## .NET

### EF Core
To add a migration and update the database, run the following from VS console:
```
# install and/or update tools
Install-Package Microsoft.EntityFrameworkCore.Tools
Update-Package Microsoft.EntityFrameworkCore.Tools

# verify installation
Get-Help about_EntityFrameworkCore

# migrate and update db
Add-Migration <MigrationName>
Update-Database
```

For tools see https://learn.microsoft.com/en-us/ef/core/cli/

For migrations see https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/?tabs=vs

### Open API
Default link: `localhost:<port>/openapi/v1.json`

See https://learn.microsoft.com/en-us/aspnet/core/fundamentals/openapi/aspnetcore-openapi?view=aspnetcore-10.0&tabs=visual-studio%2Cvisual-studio-code#customize-the-openapi-document-name

## Angular
### Docker
Build and run with the following commands:
```
docker build . -t library-ui
docker run -p 4000:4000 library-ui
```