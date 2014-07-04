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
    var err;
    try {
      require("./" + (config.type.toLowerCase()) + "_notification");
      return new Catfish["" + (Catfish.capitalize(config.type)) + "Notification"](config);
    } catch (_error) {
      err = _error;
      throw new Catfish.Notification.UnknownNotificationError("\"" + config.type + "\" is unknown notification");
    }
  };

  return Notification;

})();

Catfish.Notification.UnknownNotificationError = (function(_super) {
  __extends(UnknownNotificationError, _super);

  function UnknownNotificationError(message) {
    this.message = message;
    UnknownNotificationError.__super__.constructor.call(this, this.message);
  }

  return UnknownNotificationError;

})(Error);
