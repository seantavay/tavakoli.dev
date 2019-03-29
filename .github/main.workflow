workflow "New workflow" {
  on = "push"
  resolves = ["Deploy to Azure"]
}

action "Deploy to Azure" {
  uses = "./.github/actions/azure-deploy"
  secrets = ["AzureSecret"]
  env = {
    SERVICE_PRINCIPAL="Tavakoli",
    TENANT_ID="8487d561-b1c6-4299-959b-ac3c192a5a7c",
    APPID="1187442b-49f4-4265-9e8b-2087c3476ae8"  
  }
}
