workflow "New workflow" {
  on = "push"
  resolves = ["GitHub Action for Azure"]
}

action "GitHub Action for Azure" {
  uses = "docker://alpine/git:latest"
  runs = "entrypoint.sh"
}
