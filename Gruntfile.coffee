"use strict"

module.exports = (grunt)->
  grunt.initConfig
    clean:
      all: [ "lib" ]

    coffee:
      options:
        bare: true
      all:
        expand: true
        cwd: "src"
        src: [ "**/*.coffee" ]
        dest: "lib"
        ext: ".js"
      bin:
        files:
          "bin/catfish": "bin/catfish.coffee"
    simplemocha:
      options:
        ui: "bdd"
        reporter: "spec"
        recursive: true
      all:
        src: [ "test/**/*_test.coffee" ]

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-simple-mocha"

  grunt.registerTask "test", [ "simplemocha" ]
  grunt.registerTask "default", [ "clean", "coffee" ]
