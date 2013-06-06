module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-simple-mocha'
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
        reporter: 'spec'
        compilers: 'coffee:coffee-script'
      all:
        src: 'test/**/*.coffee'

    coffee:
      compile:
        options:
          sourceMap: true
        files: [
            expand: true,
            cwd: 'src',
            src: '**/*.coffee'
            dest: 'js/',
            ext: '.js'
        ]

    uglify:
      compress_target:
        options:
          sourceMap: (fileName) ->
            fileName.replace /\.js$/, '.js.map'
        files: [
            expand: true,
            cwd: 'js/',
            src: ['**/*.js'],
            dest: 'compress/',
            ext: '.min.js'
        ]

    watch:
      files: ['src/**/*.coffee','test/**/*.coffee']
      tasks: ['simplemocha','coffee','uglify']

  grunt.registerTask "default", ["simplemocha"]
