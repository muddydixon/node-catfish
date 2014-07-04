"use strict"

deferred        = require "deferred"
os              = require "os"

Catfish         = require "../catfish"
#
# Catfish.Notification
#
module.exports = class Catfish.Notification
  constructor: (@config)->
    throw new Error("name required") unless @config.name
    @name = @config.name
    @type = @config.type or "mail"
    @hostname = os.hostname()
  notify: (name, err)->
    deferred(null)
  @create: (config)->
    try
      require "./#{config.type.toLowerCase()}_notification"
      new Catfish["#{Catfish.capitalize(config.type)}Notification"](config)
    catch err
      throw new Catfish.Notification.UnknownNotificationError("\"#{config.type}\" is unknown notification")

class Catfish.Notification.UnknownNotificationError extends Error
  constructor: (@message)->
    super(@message)
