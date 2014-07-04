"use strict"

{expect} = require "chai"
os = require "os"
sinon = require "sinon"
deferred = require "deferred"
Slack = require("node-slack")

Catfish = require "../../src/catfish"
Catfish.SlackNotification = require "../../src/notifications/slack_notification"

describe "Catfish.SlackNotification", ->
  describe "constructor", ->
    it "throw error without name", ->
      expect(->
        new Catfish.SlackNotification()
      ).throw Error

    it "throw error without domain", ->
      expect(->
        new Catfish.SlackNotification(name: "my slack")
      ).throw "domain is required"

    it "throw error without token", ->
      expect(->
        new Catfish.SlackNotification(name: "my slack", domain: "mydomain")
      ).throw "token is required"

    it "return instance", ->
      notification = new Catfish.SlackNotification(
        name: "my slack", type: "slack", domain: "mydomain", token: "mytoken")
      expect(notification).to.have.property "name", "my slack"
      expect(notification).to.have.property "type", "slack"

  describe "send message", ->
    notification = new Catfish.SlackNotification(
      name: "my slack", type: "slack", domain: "mydomain", token: "mytoken")
    send = null
    before (done)->
      send = sinon.stub(Slack.prototype, "send")
      done()
    after (done)->
      send.restore()
      done()

    it "send success", (done)->
      send.onCall(send.callCount).callsArgWith(1, null)
      notification.notify("hoge", new Error("not running"))
      .then((res)->
        expect(res).to.be.eql null
        done()
      )
      .catch(done)
