param location string = resourceGroup().location
param basename string = 'az204lib'
param storageAccountName string = '${basename}${uniqueString(resourceGroup().id)}'
param appServiceAppName string = '${basename}${uniqueString(resourceGroup().id)}'
param apiName string
param imageTag string

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

module appService './appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServiceAppName: appServiceAppName
    environmentType: environmentType
    apiName: apiName
    imageTag: imageTag
  }
}

output appServiceAppHostName string = appService.outputs.appServiceAppHostName
