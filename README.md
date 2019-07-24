# the-telegram-action

> Project archived, please use https://github.com/appleboy/telegram-action as a better replacement.

This action wraps the Telegram [postMessage](https://core.telegram.org/bots/api#sendmessage) for posting messages to the target chat or username of the target channel (in the format `@channelusername`).

## Use

### Arguments

Doesn't take any arguments.

### Environment Variables

* `TELEGRAM_MESSAGE`: text of the message to be sent;
* `TELEGRAM_PARSE_MODE`: use `Markdown` or `HTML`, if you want Telegram apps to show [bold, italic, fixed-width text or inline URLs](https://core.telegram.org/bots/api#formatting-options) in your bot's message. Default: `Markdown`.

### Secrets

* `TELEGRAM_BOT_TOKEN`: follow [official documentation](https://core.telegram.org/bots#3-how-do-i-create-a-bot) to know how to create your own bot and token;
* `TELEGRAM_CHAT_ID`: unique identifier for the target chat or username of the target channel (in the format `@channelusername`).

### Example workflow

    workflow "Example Workflow" {
      on = "push"
      resolves = "Notify"
    }

    action "Notify" {
      uses = "docker://gr1n/the-telegram-action:master"
      env = {
        TELEGRAM_MESSAGE = "`my-project` build succeeded"
      }
      secrets = [
        "TELEGRAM_BOT_TOKEN",
        "TELEGRAM_CHAT_ID"
      ]
    }
