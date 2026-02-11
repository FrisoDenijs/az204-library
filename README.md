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
- https://learn.microsoft.com/en-us/azure/container-apps/quickstart-code-to-cloud?tabs=bash%2Ccsharp
- https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-rest-api

#### Postgres
I created an `appsettings.Production.json` and used the ADO.NET connection string as found in Azure.

Then I used the following command:

`dotnet ef database update -- --environment Production`

See: https://learn.microsoft.com/en-us/ef/core/cli/dotnet#aspnet-core-environment
See: https://learn.microsoft.com/en-us/azure/cosmos-db/postgresql/howto-connect?tabs=pgadmin

### API Gateway
### Auth
#### Librarian users
#### Reader users

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
