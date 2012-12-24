module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: '<json:package/component.json>',

    meta: {
        file: "quo",
        name: 'QuoJS - ',
        banner: '/*! <%= meta.name %> - <%= grunt.template.today("yyyy/m/d") %> */'
    },

    resources: {
        coffee: ['src/**/*.coffee', 'spec/**/*.coffee'],
        js: ['build/**/quo.js',
            'build/**/monocle.model.js',
            'build/**/monocle.controller.js',
            'build/**/monocle.view.js',
            'build/**/monocle.templayed.js',
            'build/**/monocle.route.js']
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
        dest: 'package/<%=meta.file%>.js'
      }
    },


    min: {
      js: {
        src: ['<banner>', 'package/<%=meta.file%>.js'],
        dest: 'package/<%=meta.file%>.min.js'
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
