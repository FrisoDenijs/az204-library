# AZ-204 Library
practice app for az204

## Azure

### IP Restrictions
https://docs.azure.cn/en-us/container-apps/ip-restrictions?pivots=azure-portal

### Manual Deployment
### Postgres
### API Gateway
### Auth
#### Librarian users
#### Reader users

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

## Angular