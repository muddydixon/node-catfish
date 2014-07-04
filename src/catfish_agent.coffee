"use strict"
#
# Catfish Agent
#
Catfish = require "./catfish"

module.exports = class Catfish.Agent extends Catfish
  @cnt: 0
  constructor: (config = {})->
    @id         = Catfish.cnt++
    @interval   = config.interval or 5000
    @specs      = {}
    @notifications = {}

  start: ->
    @timer = setInterval @check, @interval

  stop: ->
    clearInterval @timer

  check: =>
    for name, spec of @specs
      do (name, spec)=>
        # console.log "check #{name}(#{spec.type})"
        spec.check()
        .catch((err)=>
          @notify(spec, err)
          null
        )

  notify: (spec, err)->
    for notificationName, notification of @notifications
      # console.log "#{name}, #{notificationName}, #{err.message}"
      notification.notify(spec.name, err)

  addSpec: (spec)->
    @specs[spec.name] = spec

  addNotification: (notification)->
    @notifications[notification.name] = notification
