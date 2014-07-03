#!/usr/bin/env coffee
"use strict"

cluster         = require "cluster"
{exec}          = require "child_process"
config          = require "config"
Fs              = require "fs"
Path            = require "path"

Watcher         = require "../src/watcher"

procDir = Path.join __dirname, "..", "src/procs/"
notificationDir = Path.join __dirname, "..", "src/notifications/"

for file in Fs.readdirSync(procDir).filter((f)-> f.match(/^[^\_]+_proc/))
  [proc, ext] = file.split(".")
  require Path.join procDir, proc
for file in Fs.readdirSync(notificationDir).filter((f)-> f.match(/^[^\_]+_notification/))
  [proc, ext] = file.split(".")
  require Path.join notificationDir, proc

# ------------------------------------------------------------
#
# main
#
if cluster.isMaster
  process.title   = "process-monitoring"

  w = cluster.fork()
  cluster.on "exit", (worker)->
    console.log "worker (#{worker.process.pid}) exit"
    worker.stop?()
    try
      w = cluster.fork()
    catch err
      console.log "create new worker failed"
      process.exit -1
  w.on "message", (err)->
    console.log err
    process.exit -1

else
  process.title   = "process-monitoring-worker"
  watcher = new Watcher(interval: config.interval)

  for conf in config?.procs or []
    try
      proc = Watcher.Proc.create(conf)
    catch err
      process.send err.message
    watcher.addProc(proc)
    console.log "add new watched proc #{conf.name} as #{conf.type}"

  for conf in config?.notifications or []
    try
      notification = Watcher.Notification.create(conf)
    catch err
      process.send err.message
    watcher.addNotification(notification)
    console.log "add new notification #{conf.name} as #{conf.type}"

  watcher.start()

process.on "uncaughtException", (err)->
  console.log err.stack