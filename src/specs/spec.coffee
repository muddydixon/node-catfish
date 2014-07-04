"use strict"

Catfish         = require "../catfish"
#
# Catfish.Spec
#
module.exports = class Catfish.Spec
  constructor: (@config)->
    throw new Error("name required") unless @config.name
    @name = @config.name
    @type = @config.type or "ps"
  check: ->
  @create: (config)->
    try
      new Catfish["#{Catfish.capitalize(config.type)}Spec"](config)
    catch err
      throw err