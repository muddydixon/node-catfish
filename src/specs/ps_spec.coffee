"use strict"

deferred        = require "deferred"
{exec}          = require "child_process"

Catfish         = require "../catfish"
Catfish.Spec    = require "../specs"

#
# Catfish.PsSpec
#
module.exports = class Catfish.PsSpec extends Catfish.Spec
  constructor: (@config)->
    super(@config)
    throw new Error("ps catfish requires value") unless @config.value
    @value = @config.value

  check: ->
    d = deferred()
    exec("ps aux | grep #{Catfish.bracket(@value)}", (err, stdout, stderr)=>
      return d.reject(new Catfish.PsSpec.NoSpecError("process not running")) if err
      d.reject null
    )
    d.promise

class Catfish.PsSpec.NoSpecError extends Error
