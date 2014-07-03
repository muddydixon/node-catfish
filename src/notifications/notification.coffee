"use strict"

deferred        = require "deferred"
Watcher         = require "../watcher"
#
# Watcher.Notification
#
module.exports = class Watcher.Notification
  constructor: (@config)->
    throw new Error("name required") unless @config.name
    @name = @config.name
  notify: (name, err)->
    deferred(null)
  @create: (config)->
    try
      new Watcher["#{Watcher.capitalize(config.type)}Notification"](config)
    catch err
      throw err
