"use strict";
var Catfish, deferred,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

deferred = require("deferred");

Catfish = require("../catfish");

Catfish.Notification = require("../notifications");

module.exports = Catfish.MailNotification = (function(_super) {
  __extends(MailNotification, _super);

  function MailNotification() {
    return MailNotification.__super__.constructor.apply(this, arguments);
  }

  return MailNotification;

})(Catfish.Notification);
