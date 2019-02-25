#!/bin/sh

set -e

if [ -z "$TELEGRAM_BOT_TOKEN" ]
then
  echo "Set the TELEGRAM_BOT_TOKEN secret."
  exit 1
fi

if [ -z "$TELEGRAM_CHAT_ID" ]
then
  echo "Set the TELEGRAM_CHAT_ID secret."
  exit 1
fi

if [ -z "$TELEGRAM_MESSAGE" ]
then
  echo "Set the TELEGRAM_MESSAGE variable."
  exit 1
fi

_URL=https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage
_CHAT_ID=${TELEGRAM_CHAT_ID}
_MESSAGE=${TELEGRAM_MESSAGE}

if [ -z "$TELEGRAM_PARSE_MODE" ]
then
  _PARSE_MODE="Markdown"
else
  _PARSE_MODE="${TELEGRAM_PARSE_MODE}"
fi

http --headers --ignore-stdin "${_URL}" chat_id="${_CHAT_ID}" text="${_MESSAGE}" parse_mode="${_PARSE_MODE}"
