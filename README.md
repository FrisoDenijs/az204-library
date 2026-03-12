# AZ-204 Library
practice app for az204

## Azure

### Local CLI
Sign in with `az login --use-device-code`.

See https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli-interactively?view=azure-cli-latest#sign-in-with-a-browser

### IP Restrictions
https://docs.azure.cn/en-us/container-apps/ip-restrictions?pivots=azure-portal

### Manual Deployment
#### .NET app
```
az login --use-device-code
az upgrade
az extension add --name containerapp --upgrade --allow-preview true
az provider register --namespace Microsoft.App
az provider register --namespace Microsoft.OperationalInsights


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
$APP_PLAN="az204-library-plan"
$ANGULAR_APP="az204-library-ui-webapp"

az appservice plan create -g $RESOURCE_GROUP -n $APP_PLAN --sku F1
az webapp create -g $RESOURCE_GROUP -p $APP_PLAN -n $ANGULAR_APP

npm run prep:pub
az webapp deploy -g $RESOURCE_GROUP -n $ANGULAR_APP --src-path C:\projects\az204-library\library-ui\library-ui.zip --type zip --async true
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
