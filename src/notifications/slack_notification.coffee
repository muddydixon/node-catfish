"use strict"

Slack           = require "node-slack"
deferred        = require "deferred"

Watcher         = require "../watcher"
Watcher.Notification         = require "./notification"

#
# Watcher.SlackNotification
#
module.exports = class Watcher.SlackNotification extends Watcher.Notification
  constructor: (@config)->
    super(@config)
    @slack = new Slack(@config.domain, @config.token)
  notify: (name, err)->
    d = deferred()
    console.log {
      proxy:    @config.proxy or process.env.http_proxy
      text:     "#{name}: #{err.message}"
      channel:  @config.channel
      username: @config.username
    }, JSON.parse(JSON.stringify @config)
    @slack.send({
      proxy:    @config.proxy or process.env.http_proxy
      text:     "#{name}: #{err.message}"
      channel:  @config.channel
      username: @config.username
    }, (err)->
      return d.reject err if err
      d.resolve null
    )
    d.promise
