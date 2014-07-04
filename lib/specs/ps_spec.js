"use strict";
var Catfish, deferred, exec,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

deferred = require("deferred");

exec = require("child_process").exec;

Catfish = require("../catfish");

Catfish.Spec = require("./spec");

module.exports = Catfish.PsSpec = (function(_super) {
  __extends(PsSpec, _super);

  function PsSpec(config) {
    this.config = config;
    PsSpec.__super__.constructor.call(this, this.config);
    if (!this.config.value) {
      throw new Error("ps catfish requires value");
    }
    this.value = this.config.value;
  }

  PsSpec.prototype.check = function() {
    var d;
    d = deferred();
    exec("ps aux | grep " + (Catfish.bracket(this.value)), (function(_this) {
      return function(err, stdout, stderr) {
        if (err) {
          return d.reject(new Catfish.PsSpec.NoSpecError("process not running"));
        }
        return d.reject(null);
      };
    })(this));
    return d.promise;
  };

  return PsSpec;

})(Catfish.Spec);

Catfish.PsSpec.NoSpecError = (function(_super) {
  __extends(NoSpecError, _super);

  function NoSpecError() {
    return NoSpecError.__super__.constructor.apply(this, arguments);
  }

  return NoSpecError;

})(Error);
