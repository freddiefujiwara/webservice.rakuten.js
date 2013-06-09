module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-jscoverage'
  grunt.loadNpmTasks 'grunt-exec'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-jshint'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    simplemocha:
      options:
        globals: ['should','$']
        timeout: 3000
        ignoreLeaks: false
        ui: 'bdd'
        reporter: 'tap'
        compilers: 'coffee:coffee-script'
      all:
        src: 'test/**/*.coffee'

    checkcoverage:
      options:
        globals: ['should','$']
        timeout: 3000
        ignoreLeaks: false
        ui: 'bdd'
        reporter: 'json-cov'
        compilers: 'coffee:coffee-script'
      all:
        src: 'test/**/*.coffee'

    exec:
      makecoveragejson:
        command: './node_modules/.bin/grunt --no-color checkcoverage | grep -v checkcoverage:all | grep -v "Done, without errors" > <%= pkg.name %>.coverage.json 2>&1'
        stdout: false
        stderror: false

    coffee:
      compile:
        options:
          join:true
        files: [
            expand: true,
            cwd: 'src',
            src: '**/*.coffee'
            dest: 'js/',
            ext: '.js'
        ]

    concat:
      options:
        separator:';'
      dist:
        src:['js/**/*.js']
        dest:'dist/<%= pkg.name %>.js'

    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
      dist:
        files:'dist/<%= pkg.name %>.min.js': ['<%= concat.dist.dest %>']

    jshint:
        files:['js/**/*.js']
        options:
          jshintrc:'.jshintrc'

    jscoverage:
        options:
            inputDirectory:'js'
            outputDirectory:'js-cov'
    watch:
      files: ['src/**/*.coffee','test/**/*.coffee']
      tasks: ['simplemocha','coffee','uglify']

  grunt.registerTask "default", ["simplemocha","coffee","jshint","concat","uglify"]

  grunt.registerMultiTask 'checkcoverage', 'Run tests with mocha and take coverages', () ->
    Mocha = require 'mocha'
    mocha_instance = new Mocha @options()
    @filesSrc.forEach(mocha_instance.addFile.bind(mocha_instance))
    done = @async()
    mocha_instance.run (errCount) ->
      done 0 == errCount
