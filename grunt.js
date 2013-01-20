module.exports = function(grunt) {

  grunt.initConfig({
    pkg: '<json:package/component.json>',

    meta: {
        file: "quo",
        banner: '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("m/d/yyyy") %>\n' +
                '   <%= pkg.homepage %>\n' +
                '   Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>' +
                ' - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */'
    },

    resources: {
        coffee: ['src/**/*.coffee', 'spec/**/*.coffee'],
        js: ['build/**/quo.js',
            'build/**/quo.core.js',
            'build/**/quo.environment.js',
            'build/**/quo.query.js',
            'build/**/quo.style.js',
            'build/**/quo.element.js',
            'build/**/quo.output.js',
            'build/**/quo.ajax.js',
            'build/**/quo.events.js',
            'build/**/quo.gestures.js']
    },

    coffee: {
      app: {
        src: ['<config:resources.coffee>'],
        dest: 'build',
        options: {
            bare: true,
            preserve_dirs: true
        }
      }
    },

    concat: {
      js: {
        src: ['<banner>', '<config:resources.js>'],
        dest: 'package/<%=meta.file%>.debug.js'
      }
    },

    min: {
      js: {
        src: ['<banner>', 'package/<%=meta.file%>.debug.js'],
        dest: 'package/<%=meta.file%>.js'
      }
    },

    watch: {
      files: ['<config:resources.coffee>'],
      tasks: 'coffee concat min'
    },


    uglify: {}
  });

  grunt.loadNpmTasks('grunt-coffee');

  // Default task.
  grunt.registerTask('default', 'coffee concat min');

};
