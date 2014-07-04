"use strict";
var Catfish, deferred, os,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

deferred = require("deferred");

os = require("os");

Catfish = require("../catfish");

module.exports = Catfish.Notification = (function() {
  function Notification(config) {
    this.config = config;
    if (!this.config.name) {
      throw new Error("name required");
    }
    this.name = this.config.name;
    this.type = this.config.type || "mail";
    this.hostname = os.hostname();
  }

  Notification.prototype.notify = function(name, err) {
    return deferred(null);
  };

  Notification.create = function(config) {
    if (typeof Catfish["" + (Catfish.capitalize(config.type)) + "Notification"] === "function") {
      return new Catfish["" + (Catfish.capitalize(config.type)) + "Notification"](config);
    } else {
      throw new Catfish.Notification.UnknownNotification("\"" + config.type + "\" is unknown notification");
    }
  };

  return Notification;

})();

Catfish.Notification.UnknownNotification = (function(_super) {
  __extends(UnknownNotification, _super);

  function UnknownNotification(message) {
    this.message = message;
    UnknownNotification.__super__.constructor.call(this, this.message);
  }

  return UnknownNotification;

})(Error);
