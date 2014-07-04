"use strict";
var Catfish, Fs, Path,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Path = require("path");

Fs = require("fs");

Catfish = require("../catfish");

module.exports = Catfish.Spec = (function(_super) {
  __extends(Spec, _super);

  function Spec(config) {
    this.config = config;
    if (!this.config.name) {
      throw new Error("name required");
    }
    this.name = this.config.name;
    this.type = this.config.type || "ps";
  }

  Spec.prototype.check = function() {};

  Spec.create = function(config) {
    var err;
    try {
      require("./" + (config.type.toLowerCase()) + "_spec");
      return new Catfish["" + (Catfish.capitalize(config.type)) + "Spec"](config);
    } catch (_error) {
      err = _error;
      throw new Catfish.Spec.UnknownSpecError("\"" + config.type + "\" is unknown notification");
    }
  };

  return Spec;

})(Catfish);

Catfish.Spec.UnknownSpecError = (function(_super) {
  __extends(UnknownSpecError, _super);

  function UnknownSpecError(message) {
    this.message = message;
    UnknownSpecError.__super__.constructor.call(this, this.message);
  }

  return UnknownSpecError;

})(Error);
