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
  needs = ["Master Push", "Azure Login"]
  env = {
    AZURE_APP_NAME = "Tavakoli"
    AZURE_APP_PACKAGE_LOCATION = "./"
  }
}

workflow "Staging Env" {
  on = "pull_request"
  resolves = ["Deploy to Web App Test"]
}

action "Deploy to Web App Test" {
  uses = "./.github/actions/azure-deploy"
  needs = ["Azure Login"]
  env = {
    AZURE_APP_NAME = "TavakoliT"
    AZURE_APP_PACKAGE_LOCATION = "./"
  }
}

action "Master Push" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}
