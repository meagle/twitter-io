module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      compile:
        files: [{
          cwd: '.'
          # expand: true
          src: "index.coffee"
          dest: 'index.js'
          ext: '.js'}
        ,{
          cwd: 'lib/stream/'
          expand: true
          src: "**/*.coffee"
          dest: 'lib/stream'
          ext: '.js'}
        ,{
          cwd: 'lib/login/'
          expand: true
          src: "**/*.coffee"
          dest: 'lib/login'
          ext: '.js'}
        ,{
          cwd: 'lib/config/'
          expand: true
          src: "**/*.coffee"
          dest: 'lib/config'
          ext: '.js'}
        ,{
          cwd: 'public/coffeescript/'
          expand: true
          src: "**/*.coffee"
          dest: 'public/javascript'
          ext: '.js'}
        ,{
          cwd: 'lib/models/'
          expand: true
          src: "**/*.coffee"
          dest: 'lib/models'
          ext: '.js'}
        ]
        options:
          sourceMap: false
          header: true
    watch:
      coffeesrc:
        files: ['**/*.coffee']
        tasks: ['coffee']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-notify'

  grunt.registerTask 'default', ['coffee', 'watch']
