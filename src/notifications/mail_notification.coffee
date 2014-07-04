"use strict"

deferred        = require "deferred"

Catfish         = require "../catfish"
Catfish.Notification         = require "./notification"

#
# Catfish.MailNotification
#
module.exports = class Catfish.MailNotification extends Catfish.Notification
