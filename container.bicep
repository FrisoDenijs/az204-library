param apiName string
param imageTag string
param location string

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: apiName
  location: location
  properties: {
    features: {
      disableLocalAuth: false
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
  }
}

resource containerApp 'Microsoft.App/containerApps@2022-03-01' = {
  name: apiName
  location: location
  properties: {
    configuration: {
      activeRevisionsMode: 'Single'
    }
    managedEnvironmentId: managedEnvironment.id
    template: {
      containers: [
        {
          env: []
          image: '${apiName}:${imageTag}'
          name: 'acctest-cont-230630032906865620'
          probes: []
          resources: {
            cpu: any('0.25')
            memory: '0.5Gi'
          }
          volumeMounts: []
        }
      ]
      scale: {
        maxReplicas: 10
      }
      volumes: []
    }
  }
}

resource managedEnvironment 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: apiName
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: workspace.properties.customerId
        sharedKey: workspace.listKeys().primarySharedKey
      }
    }
    vnetConfiguration: {}
  }
}
