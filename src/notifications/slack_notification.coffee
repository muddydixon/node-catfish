"use strict"

Slack           = require "node-slack"
deferred        = require "deferred"

Catfish         = require "../catfish"
Catfish.Notification         = require "./notification"

#
# Catfish.SlackNotification
#
module.exports = class Catfish.SlackNotification extends Catfish.Notification
  constructor: (@config)->
    super(@config)
    throw new Error("domain is required") unless @config.domain
    throw new Error("token is required") unless @config.token
    @slack = new Slack(@config.domain, @config.token)
  notify: (name, err)->
    d = deferred()
    @slack.send({
      proxy:    @config.proxy or process.env.http_proxy
      text:     "[#{@hostname}] #{name}: #{err.message}"
      channel:  @config.channel
      username: @config.username
    }, (err)->
      return d.reject err if err
      d.resolve null
    )
    d.promise
