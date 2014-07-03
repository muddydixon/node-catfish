"use strict"

Watcher         = require "../watcher"
#
# Watcher.Proc
#
module.exports = class Watcher.Proc
  constructor: (@config)->
    throw new Error("name required") unless @config.name
    @name = @config.name
    @type = @config.type or "ps"
  check: ->
  @create: (config)->
    try
      new Watcher["#{Watcher.capitalize(config.type)}Proc"](config)
    catch err
      throw err