module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-jscoverage'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-concat'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    simplemocha:
      options:
        globals: ['should']
        timeout: 3000
        ignoreLeaks: false
        ui: 'bdd'
        reporter: 'tap'
        compilers: 'coffee:coffee-script'
      all:
        src: 'test/**/*.coffee'

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

    jscoverage:
        options:
            inputDirectory:'js'
            outputDirectory:'js-cov'
    watch:
      files: ['src/**/*.coffee','test/**/*.coffee']
      tasks: ['simplemocha','coffee','uglify']

  grunt.registerTask "default", ["simplemocha","coffee","uglify"]
