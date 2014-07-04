"use strict"
#
# Catfish
#
module.exports = class Catfish
  @logger:
    debug: console.log
    info: console.log
    warn: console.log
    error: console.log
  @capitalize: (str)->    "#{str[0].toUpperCase()}#{str[1...].toLowerCase()}"
  @bracket: (str)->       "[#{str[0]}]#{str[1...]}"
