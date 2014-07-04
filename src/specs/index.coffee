"use strict"

Path = require "path"
Fs   = require "fs"
Catfish         = require "../catfish"
#
# Catfish.Spec
#
module.exports = class Catfish.Spec extends Catfish
  constructor: (@config)->
    throw new Error("name required") unless @config.name
    @name = @config.name
    @type = @config.type or "ps"
  check: ->
  @create: (config)->
    try
      require "./#{config.type.toLowerCase()}_spec"
      new Catfish["#{Catfish.capitalize(config.type)}Spec"](config)
    catch err
      throw new Catfish.Spec.UnknownSpecError("\"#{config.type}\" is unknown notification")


class Catfish.Spec.UnknownSpecError extends Error
  constructor: (@message)->
    super(@message)
