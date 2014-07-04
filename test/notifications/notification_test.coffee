"use strict"

{expect} = require "chai"
os = require "os"

Notification = require "../../src/notifications/notification"
SlackNotification = require "../../src/notifications/slack_notification"

describe "Catfish.Notification", ->
  describe "constructor", ->
    it "throw error without config.name", ->
      expect(->
        new Notification()
      ).throw Error

    it "return instance", ->
      notification = new Notification(name: "my notify")
      expect(notification).to.have.property "name", "my notify"
      expect(notification).to.have.property "hostname", os.hostname()

  describe "create notification", ->
    it "throw error when not exist notification", ->
      expect(->
        Notification.create(name: "my notify", type: "notExists")
      ).throw Error
      expect(->
        Notification.create(name: "my notify", type: "notExists")
      ).throw Notification.UnknownNotification

    it "return slack notification", ->
      notification = Notification.create(
        name: "my notify", type: "slack", domain: "mydomain", token: "mytoken")
      expect(notification).to.be.an.instanceof Notification
      expect(notification).to.be.an.instanceof SlackNotification
      expect(notification).to.have.property "name", "my notify"
      expect(notification).to.have.property "type", "slack"
      expect(notification).to.have.property "hostname", os.hostname()
