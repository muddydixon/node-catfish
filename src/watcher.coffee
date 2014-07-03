"use strict"
#
# Watcher
#
module.exports = class Watcher
  @cnt: 0
  constructor: (config = {})->
    @id         = Watcher.cnt++
    @interval   = config.interval or 5000
    @procs      = {}
    @notifications = {}

  start: ->
    @timer = setInterval @check, @interval

  stop: ->
    clearInterval @timer

  check: =>
    for name, proc of @procs
      do (name, proc)=>
        console.log "check #{name}(#{proc.type})"
        proc.check()
        .catch((err)=>
          @notify(name, err)
          null
        )

  notify: (name, err)->
    for notificationName, notification of @notifications
      console.log "#{name}, #{notificationName}, #{err.message}"
      notification.notify(name, err)

  addProc: (proc)->
    @procs[proc.name] = proc

  addNotification: (notification)->
    @notifications[notification.name] = notification

  @capitalize: (str)->    "#{str[0].toUpperCase()}#{str[1...].toLowerCase()}"
  @bracket: (str)->       "[#{str[0]}]#{str[1...]}"
