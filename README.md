# Etymbot

A simple Slack bot server that receives a GET request with a query word, scrapes the [Online Etymology Dictionary](http://www.etymonline.com/), and posts the word's etymology back to Slack.

## Installation
- Configure your Slack slash command through the Slack admin UI
- Set the `SM_SLACK_ETYM_TOKEN` environment variable to the value Slack provides
- Install Elixir 1.5.1
- Clone the repo
- `cd` into the app directory and run `mix deps.get`
- Start the server with `mix run --no-halt`
- It's Erlang so it'll probably still be running in 2050
