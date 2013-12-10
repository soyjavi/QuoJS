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
      core        : 'source/quo.coffee'
      ajax        : 'source/quo.ajax.coffee'
      element     : 'source/quo.element.coffee'
      environment : 'source/quo.environment.coffee'
      events      : 'source/quo.events.coffee'
      gestures    : 'source/quo.gestures.coffee'
      output      : 'source/quo.output.coffee'
      query       : 'source/quo.query.coffee'
      style       : 'source/quo.style.coffee'
      spec        : 'spec/*.coffee'

    concat:
      core        : files: '<%=meta.build%>/<%=meta.file%>.coffee': '<%= source.core %>'
      spec        : files: '<%=meta.build%>/<%=meta.file%>.spec.coffee': '<%= source.spec %>'

    coffee:
      core        : files: '<%= meta.build %>/<%= meta.file %>.js': '<%=meta.build%>/<%=meta.file%>.coffee'
      ajax        : files: '<%= meta.build %>/<%= meta.file %>.ajax.js': '<%=source.ajax%>'
      element     : files: '<%= meta.build %>/<%= meta.file %>.element.js': '<%=source.element%>'
      environment : files: '<%= meta.build %>/<%= meta.file %>.environment.js': '<%=source.environment%>'
      events      : files: '<%= meta.build %>/<%= meta.file %>.events.js': '<%=source.events%>'
      gestures    : files: '<%= meta.build %>/<%= meta.file %>.gestures.js': '<%=source.gestures%>'
      output      : files: '<%= meta.build %>/<%= meta.file %>.output.js': '<%=source.output%>'
      query       : files: '<%= meta.build %>/<%= meta.file %>.query.js': '<%=source.query%>'
      style       : files: '<%= meta.build %>/<%= meta.file %>.style.js': '<%=source.style%>'
      spec        : files: '<%= meta.build %>/<%= meta.file %>.spec.js': '<%=meta.build%>/<%=meta.file%>.spec.coffee'

    uglify:
      options: mangle: false, banner: "<%= meta.banner %>"#, report: "gzip"
      core        : files: '<%= meta.bower %>/<%= meta.file %>.js': '<%= meta.build %>/<%= meta.file %>.js'
      ajax        : files: '<%= meta.bower %>/<%= meta.file %>.ajax.js': '<%= meta.build %>/<%= meta.file %>.ajax.js'
      element     : files: '<%= meta.bower %>/<%= meta.file %>.element.js': '<%= meta.build %>/<%= meta.file %>.element.js'
      environment : files: '<%= meta.bower %>/<%= meta.file %>.environment.js': '<%= meta.build %>/<%= meta.file %>.environment.js'
      events      : files: '<%= meta.bower %>/<%= meta.file %>.events.js': '<%= meta.build %>/<%= meta.file %>.events.js'
      gestures    : files: '<%= meta.bower %>/<%= meta.file %>.gestures.js': '<%= meta.build %>/<%= meta.file %>.gestures.js'
      output      : files: '<%= meta.bower %>/<%= meta.file %>.output.js': '<%= meta.build %>/<%= meta.file %>.output.js'
      query       : files: '<%= meta.bower %>/<%= meta.file %>.query.js': '<%= meta.build %>/<%= meta.file %>.query.js'
      style       : files: '<%= meta.bower %>/<%= meta.file %>.style.js': '<%= meta.build %>/<%= meta.file %>.style.js'


    jasmine:
      pivotal:
        src: [
          '<%=meta.bower%>/<%= meta.file %>.js']
        options:
          # vendor: 'spec/components/jquery/jquery.min.js'
          specs: '<%=meta.build%>/<%=meta.file%>.spec.js',
          # outfile: 'spec.html'
          # keepRunner: true

    watch:
      core:
        files: ['<%= source.core %>']
        tasks: ["concat:core", "coffee:core", "uglify:core", "jasmine"]
      ajax:
        files: ['<%= source.ajax %>']
        tasks: ["coffee:ajax", "uglify:ajax"]
      element:
        files: ['<%= source.element %>']
        tasks: ["coffee:element", "uglify:element"]
      environment:
        files: ['<%= source.environment %>']
        tasks: ["coffee:environment", "uglify:environment"]
      events:
        files: ['<%= source.events %>']
        tasks: ["coffee:events", "uglify:events"]
      gestures:
        files: ['<%= source.gestures %>']
        tasks: ["coffee:gestures", "uglify:gestures"]
      output:
        files: ['<%= source.output %>']
        tasks: ["coffee:output", "uglify:output"]
      query:
        files: ['<%= source.query %>']
        tasks: ["coffee:query", "uglify:query"]
      style:
        files: ['<%= source.style %>']
        tasks: ["coffee:style", "uglify:style"]
      spec:
        files: ['<%= source.spec %>']
        tasks: ["concat:spec", "coffee:spec", "jasmine"]



  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-jasmine"
  grunt.loadNpmTasks "grunt-contrib-watch"

  # Default task.
  grunt.registerTask 'default', ["concat", "coffee", "uglify", "jasmine"]
