"use strict"

deferred        = require "deferred"
{exec}          = require "child_process"

Watcher         = require "../watcher"
Watcher.Proc    = require "./proc"

#
# Watcher.PsProc
#
module.exports = class Watcher.PsProc extends Watcher.Proc
  constructor: (@config)->
    super(@config)
    throw new Error("ps watcher requires value") unless @config.value
    @value = @config.value

  check: ->
    d = deferred()
    exec("ps aux | grep #{Watcher.bracket(@value)}", (err, stdout, stderr)=>
      return d.reject(new Watcher.PsProc.NoProcError("process not running")) if err
      d.reject null
    )
    d.promise

class Watcher.PsProc.NoProcError extends Error
