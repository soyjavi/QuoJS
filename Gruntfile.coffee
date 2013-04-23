module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package/component.json"

    meta:
      file: 'quo'
      banner: '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("yyyy/m/d") %>\n' +
              '   <%= pkg.homepage %>\n' +
              '   Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>' +
              ' - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */\n'

    resources:
      app: [
        'src/quo.coffee'
        'src/quo.*.coffee'
      ]

    coffee:
      app: files: 'package/<%= meta.file %>.debug.js': ['<%= resources.app %>']

    uglify:
      options: compress: false, banner: "<%= meta.banner %>"
      app: files: 'package/<%= meta.file %>.js': 'package/<%= meta.file %>.debug.js'

    watch:
      app:
        files: ['<%= resources.app %>']
        tasks: ["coffee:app"]

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-watch"

  # Default task.
  grunt.registerTask 'default', ["coffee", "uglify"]

