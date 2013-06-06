module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib'
  grunt.loadNpmTasks 'grunt-simple-mocha'

  grunt.initConfig
    watch:
      coffee:
        files: "src/**/*.coffee",
        tasks: ["coffee"]

      coffee_with_test:
        files: ["src/**/*.coffee", 'test/**/*_test.coffee'],
        tasks: ["coffee:compile", 'simplemocha']

    coffee:
      compile:
        files:
          'dist/all.js': [
            "src/**/*.coffee"
          ]

    simplemocha:
      options:
        globals: ['should']
        timeout: 3000
        ignoreLeaks: false
        ui: 'bdd'
        reporter: 'spec'
        compilers: 'coffee:coffee-script'
      all:
        src: 'test/**/*.coffee'

  grunt.registerTask "run", ["coffee","watch:coffee"]
  grunt.registerTask "run_with_test", ["coffee", "watch:coffee_with_test"]
