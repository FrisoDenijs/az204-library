param location string
param appServiceAppName string
param apiName string
param imageTag string

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var appServicePlanName = 'az204-library-plan'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

resource libraryApi 'Microsoft.ContainerInstance/containerGroupProfiles@2026-07-01' = {
  name: apiName
  location: location
  properties: {
    containers: [
      {
        name: apiName
        properties: {
          image: '${apiName}:${imageTag}'
        }
      }
    ]
  }
}

output appServiceAppHostName string = appServiceApp.properties.defaultHostName
