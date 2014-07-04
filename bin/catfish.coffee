`#!/usr/bin/env node
`
"use strict"

{exec}          = require "child_process"
config          = require "config"
cluster         = require "cluster"
Fs              = require "fs"
_               = require "lodash"

config          = _.merge(
  config,
  Fs.existsSync("/etc/catfish.json") and require("/etc/catfish.json") or {}
)
# TODO: Logger

Catfish         = require "../lib/catfish"

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
