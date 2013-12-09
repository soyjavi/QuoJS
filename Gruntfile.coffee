module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    meta:
      build   : 'build',
      bower   : 'components/quojs',

      file: 'quo'
      banner: '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("yyyy/m/d") %>\n' +
              '   <%= pkg.homepage %>\n' +
              '   Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>' +
              ' - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */\n'

    source:
      core: [
        'src/quo.coffee'
        'src/quo.*.coffee'
      ]
      gestures: []
      ajax: []


    concat:
      core    : files: '<%=meta.build%>/<%=pkg.name%>.debug.coffee'   : '<%= source.core %>'

    coffee:
      core: files: '<%= meta.bower %>/<%= meta.file %>.debug.js': '<%=meta.build%>/<%=pkg.name%>.debug.coffee'

    uglify:
      options: mangle: false, banner: "<%= meta.banner %>"#, report: "gzip"
      core: files: '<%= meta.bower %>/<%= meta.file %>.js': '<%= meta.bower %>/<%= meta.file %>.debug.js'

    watch:
      app:
        files: ['<%= source.core %>']
        tasks: ["concat:core", "coffee:core"]

  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-watch"

  # Default task.
  grunt.registerTask 'default', ["concat", "coffee", "uglify"]

