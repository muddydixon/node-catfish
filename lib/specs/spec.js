"use strict";
var Catfish;

Catfish = require("../catfish");

module.exports = Catfish.Spec = (function() {
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
      return new Catfish["" + (Catfish.capitalize(config.type)) + "Spec"](config);
    } catch (_error) {
      err = _error;
      throw err;
    }
  };

  return Spec;

})();
