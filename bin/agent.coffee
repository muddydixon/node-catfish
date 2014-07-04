#!/usr/bin/env coffee
"use strict"

{exec}          = require "child_process"
config          = require "config"
Fs              = require "fs"
Path            = require "path"
cluster         = require "cluster"

libDir = "src"
Catfish         = require "../#{libDir}/catfish"
require "../#{libDir}/catfish_agent"
require "../#{libDir}/specs/spec"
require "../#{libDir}/notifications/notification"

specDir = Path.join __dirname, "..", "src/specs/"
notificationDir = Path.join __dirname, "..", "src/notifications/"

for file in Fs.readdirSync(specDir).filter((f)-> f.match(/^[^\_]+_spec/))
  [spec, ext] = file.split(".")
  require Path.join specDir, spec

for file in Fs.readdirSync(notificationDir).filter((f)-> f.match(/^[^\_]+_notification/))
  [notification, ext] = file.split(".")
  require Path.join notificationDir, notification

# ------------------------------------------------------------
#
# main
#
if cluster.isMaster
  process.title   = "catfish"

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
  process.title   = "catfish-worker"
  agent = new Catfish.Agent(interval: config.interval)

  for conf in config?.specs or []
    try
      spec = Catfish.Spec.create(conf)
    catch err
      console.log err.stack
      process.send err.message
    agent.addSpec(spec)
    console.log "add new watched spec #{conf.name} as #{conf.type}"

  for conf in config?.notifications or []
    try
      notification = Catfish.Notification.create(conf)
    catch err
      process.send err.message
    agent.addNotification(notification)
    console.log "add new notification #{conf.name} as #{conf.type}"

  agent.start()

process.on "uncaughtException", (err)->
  console.log err.stack