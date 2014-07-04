"use strict"
#
# Catfish
#
Path = require "path"
Fs   = require "fs"

module.exports = class Catfish
  @logger:
    debug: console.log
    info: console.log
    warn: console.log
    error: console.log
  @capitalize: (str)->    "#{str[0].toUpperCase()}#{str[1...].toLowerCase()}"
  @bracket: (str)->       "[#{str[0]}]#{str[1...]}"

require "./agent"
require "./specs"
require "./notifications"
