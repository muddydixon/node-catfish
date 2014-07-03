"use strict"

deferred        = require "deferred"
os              = require "os"
Watcher         = require "../watcher"
#
# Watcher.Notification
#
module.exports = class Watcher.Notification
  constructor: (@config)->
    throw new Error("name required") unless @config.name
    @name = @config.name
    @hostname = os.hostname()
  notify: (name, err)->
    deferred(null)
  @create: (config)->
    try
      new Watcher["#{Watcher.capitalize(config.type)}Notification"](config)
    catch err
      throw err
