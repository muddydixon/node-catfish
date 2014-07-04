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
    if typeof Catfish["#{Catfish.capitalize(config.type)}Notification"] is "function"
      new Catfish["#{Catfish.capitalize(config.type)}Notification"](config)
    else
      throw new Catfish.Notification.UnknownNotification("\"#{config.type}\" is unknown notification")

class Catfish.Notification.UnknownNotification extends Error
  constructor: (@message)->
    super(@message)
