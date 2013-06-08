module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-jscoverage'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.initConfig

    simplemocha:
      options:
        globals: ['should']
        timeout: 3000
        ignoreLeaks: false
        ui: 'bdd'
        reporter: 'html-cov'
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

    uglify:
      compress_target:
        files: [
            expand: true,
            cwd: 'js/',
            src: ['**/*.js'],
            dest: 'compress/',
            ext: '.min.js'
        ]
    jscoverage:
        options:
            inputDirectory:'js'
            outputDirectory:'js-cov'
    watch:
      files: ['src/**/*.coffee','test/**/*.coffee']
      tasks: ['simplemocha','coffee','uglify']

  grunt.registerTask "default", ["simplemocha"]
