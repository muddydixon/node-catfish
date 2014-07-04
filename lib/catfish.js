"use strict";
var Catfish, Fs, Path;

Path = require("path");

Fs = require("fs");

module.exports = Catfish = (function() {
  function Catfish() {}

  Catfish.logger = {
    debug: console.log,
    info: console.log,
    warn: console.log,
    error: console.log
  };

  Catfish.capitalize = function(str) {
    return "" + (str[0].toUpperCase()) + (str.slice(1).toLowerCase());
  };

  Catfish.bracket = function(str) {
    return "[" + str[0] + "]" + str.slice(1);
  };

  return Catfish;

})();

require("./agent");

require("./specs");

require("./notifications");
