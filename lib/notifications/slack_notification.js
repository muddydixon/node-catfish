"use strict";
var Catfish, Slack, deferred,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Slack = require("node-slack");

deferred = require("deferred");

Catfish = require("../catfish");

Catfish.Notification = require("../notifications");

module.exports = Catfish.SlackNotification = (function(_super) {
  __extends(SlackNotification, _super);

  function SlackNotification(config) {
    this.config = config;
    SlackNotification.__super__.constructor.call(this, this.config);
    if (!this.config.domain) {
      throw new Error("domain is required");
    }
    if (!this.config.token) {
      throw new Error("token is required");
    }
    this.slack = new Slack(this.config.domain, this.config.token);
  }

  SlackNotification.prototype.notify = function(name, err) {
    var d;
    d = deferred();
    this.slack.send({
      proxy: this.config.proxy || process.env.http_proxy,
      text: "[" + this.hostname + "] " + name + ": " + err.message,
      channel: this.config.channel,
      username: this.config.username
    }, function(err) {
      if (err) {
        return d.reject(err);
      }
      return d.resolve(null);
    });
    return d.promise;
  };

  return SlackNotification;

})(Catfish.Notification);
