resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'az204librarysa'
  location: 'canadacentral'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
