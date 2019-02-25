workflow "Build and Publish" {
  on = "push"
  resolves = "Notify"
}

action "Shell Lint" {
  uses = "actions/bin/shellcheck@master"
  args = "entrypoint.sh"
}

action "Docker Lint" {
  uses = "docker://replicated/dockerfilelint"
  args = ["Dockerfile"]
}

action "Build" {
  needs = ["Shell Lint", "Docker Lint"]
  uses = "actions/docker/cli@master"
  args = "build -t the-telegram-action ."
}

action "Docker Tag" {
  needs = ["Build"]
  uses = "actions/docker/tag@master"
  args = "the-telegram-action gr1n/the-telegram-action --no-latest"
}

action "Publish Filter" {
  needs = ["Build"]
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Docker Login" {
  needs = ["Publish Filter"]
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Publish" {
  needs = ["Docker Tag", "Docker Login"]
  uses = "actions/docker/cli@master"
  args = "push gr1n/the-telegram-action"
}

action "Notify" {
  needs = "Docker Publish"
  uses = "Gr1N/the-telegram-action@master"
  env = {
    TELEGRAM_MESSAGE = "`the-telegram-action` build succeeded"
  }
  secrets = [
    "TELEGRAM_BOT_TOKEN",
    "TELEGRAM_CHAT_ID"
  ]
}
