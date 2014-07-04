"use strict";
var Catfish,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Catfish = require("./catfish");

module.exports = Catfish.Agent = (function(_super) {
  __extends(Agent, _super);

  Agent.cnt = 0;

  function Agent(config) {
    if (config == null) {
      config = {};
    }
    this.check = __bind(this.check, this);
    this.id = Catfish.cnt++;
    this.interval = config.interval || 5000;
    this.specs = {};
    this.notifications = {};
  }

  Agent.prototype.start = function() {
    return this.timer = setInterval(this.check, this.interval);
  };

  Agent.prototype.stop = function() {
    return clearInterval(this.timer);
  };

  Agent.prototype.check = function() {
    var name, spec, _ref, _results;
    _ref = this.specs;
    _results = [];
    for (name in _ref) {
      spec = _ref[name];
      _results.push((function(_this) {
        return function(name, spec) {
          return spec.check()["catch"](function(err) {
            _this.notify(spec, err);
            return null;
          });
        };
      })(this)(name, spec));
    }
    return _results;
  };

  Agent.prototype.notify = function(spec, err) {
    var notification, notificationName, _ref, _results;
    _ref = this.notifications;
    _results = [];
    for (notificationName in _ref) {
      notification = _ref[notificationName];
      _results.push(notification.notify(spec.name, err));
    }
    return _results;
  };

  Agent.prototype.addSpec = function(spec) {
    return this.specs[spec.name] = spec;
  };

  Agent.prototype.addNotification = function(notification) {
    return this.notifications[notification.name] = notification;
  };

  return Agent;

})(Catfish);
