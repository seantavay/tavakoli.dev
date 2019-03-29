workflow "New workflow" {
  on = "push"
  resolves = ["Azure Login", "Deploy to Web App"]
}

 action "Azure Login" {
  uses = "Azure/github-actions/login@master"
  env = {
    AZURE_SUBSCRIPTION = "Visual Studio Enterprise"
  }
  secrets = ["AZURE_SERVICE_APP_ID", "AZURE_SERVICE_PASSWORD", "AZURE_SERVICE_TENANT"]
}

action "Deploy to Web App" {
  uses = "Azure/github-actions/webapp@master"
  needs = ["Azure Login"]
  env = {
    AZURE_APP_NAME = "Tavakoli"
    AZURE_APP_PACKAGE_LOCATION = "./"
  }
}


action "Deploy to Azure" {
  uses = "./.github/actions/azure-deploy"
  secrets = ["AzureSecret"]
  env = {
    SERVICES_PRINCIPAL = "Tavakoli",
    TENANT_ID="8487d561-b1c6-4299-959b-ac3c192a5a7c",
    APPID = "1187442b-49f4-4265-9e8b-2087c3476ae8"
  }
}
