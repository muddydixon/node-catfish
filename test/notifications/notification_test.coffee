"use strict"

{expect} = require "chai"
os = require "os"

Catfish = require "../../src/catfish"

describe "Catfish.Notification", ->
  describe "constructor", ->
    it "throw error without config.name", ->
      expect(->
        new Catfish.Notification()
      ).throw Error

    it "return instance", ->
      notification = new Catfish.Notification(name: "my notify")
      expect(notification).to.have.property "name", "my notify"
      expect(notification).to.have.property "hostname", os.hostname()

  describe "create notification", ->
    it "throw error when not exist notification", ->
      expect(->
        Catfish.Notification.create(name: "my notify", type: "notExists")
      ).throw Error
      expect(->
        Catfish.Notification.create(name: "my notify", type: "notExists")
      ).throw Catfish.Notification.UnknownNotificationError

    it "return slack notification", ->
      notification = Catfish.Notification.create(
        name: "my notify", type: "slack", domain: "mydomain", token: "mytoken")
      expect(notification).to.be.an.instanceof Catfish.Notification
      expect(notification).to.be.an.instanceof Catfish.SlackNotification
      expect(notification).to.have.property "name", "my notify"
      expect(notification).to.have.property "type", "slack"
      expect(notification).to.have.property "hostname", os.hostname()
