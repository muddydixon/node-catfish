"use strict"

deferred        = require "deferred"

Watcher         = require "../watcher"
Watcher.Notification         = require "./notification"

#
# Watcher.MailNotification
#
module.exports = class Watcher.MailNotification extends Watcher.Notification
