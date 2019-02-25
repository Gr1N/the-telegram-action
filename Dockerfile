ARG HTTPIE_VERSION=latest
FROM alpine/httpie:${HTTPIE_VERSION}

LABEL "com.github.actions.name"="The Telegram Action"
LABEL "com.github.actions.description"="Post Telegram messages"
LABEL "com.github.actions.icon"="message-circle"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/Gr1N/the-telegram-action"
LABEL "maintainer"="Nikita Grishko <gr1n@protonmail.com>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
