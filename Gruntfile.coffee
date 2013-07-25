module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      compile:
        files: [{
          cwd: 'app/'
          expand: true
          src: "**/*.coffee"
          dest: 'app'
          ext: '.js'}
        ,{
          cwd: 'config/'
          expand: true
          src: "**/*.coffee"
          dest: 'config'
          ext: '.js'}
        ,{
          cwd: 'public/coffeescript/'
          expand: true
          src: "**/*.coffee"
          dest: 'public/javascript'
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
