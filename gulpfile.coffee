"use strict"

gulp    = require 'gulp'
coffee  = require 'gulp-coffee'
concat  = require 'gulp-concat'
header  = require 'gulp-header'
jasmine = require 'gulp-jasmine'
uglify  = require 'gulp-uglify'
karma   = require('karma').server
gutil   = require 'gulp-util'
pkg     = require './package.json'


path =
  bower   : './bower'
  temp    : './build'
  coffee  : ['./source/*.coffee'
             './spec/*.coffee']
  modules : ['./source/quo.coffee'
             './source/quo.ajax.coffee'
             './source/quo.css.coffee'
             './source/quo.element.coffee'
             './source/quo.environment.coffee'
             './source/quo.events.coffee'
             './source/quo.output.coffee'
             './source/quo.query.coffee']
  gestures: ['./source/quo.gestures.coffee'
             './source/quo.gestures.*.coffee']
  spec    : ['./spec/*.coffee']

banner = [
  "/**"
  " * <%= pkg.name %> - <%= pkg.description %>"
  " * @version v<%= pkg.version %>"
  " * @link    <%= pkg.homepage %>"
  " * @author  <%= pkg.author.name %> (<%= pkg.author.site %>)"
  " * @license <%= pkg.license %>"
  " */"
  ""
].join("\n")


gulp.task 'modules', ->
  gulp.src path.modules
    .pipe coffee().on 'error', gutil.log
    .pipe gulp.dest path.temp
    .pipe uglify mangle: true
    .pipe header banner, pkg: pkg
    .pipe gulp.dest path.bower


gulp.task 'gestures', ->
  gulp.src path.gestures
    .pipe concat 'quo.gestures.coffee'
    .pipe coffee().on 'error', gutil.log
    .pipe gulp.dest path.temp
    .pipe uglify mangle: true
    .pipe header banner, pkg: pkg
    .pipe gulp.dest path.bower


gulp.task 'standalone', ->
  gulp.src path.modules.concat path.gestures
    .pipe concat 'quo.standalone.coffee'
    .pipe coffee().on 'error', gutil.log
    .pipe gulp.dest path.temp
    .pipe uglify mangle: true
    .pipe header banner, pkg: pkg
    .pipe gulp.dest path.bower


gulp.task 'spec', ->
  gulp.src path.spec
    .pipe concat 'spec.coffee'
    .pipe coffee().on 'error', gutil.log
    .pipe gulp.dest path.temp

gulp.task 'karma', ['modules', 'spec'], (done) ->
  karma.start
    configFile: __dirname + '/karma.js',
    files     : [ './build/quo.standalone.js',
                  './build/spec.js']
    singleRun : false
  , done


gulp.task 'init', ['modules', 'gestures', 'standalone', 'spec', 'karma']


gulp.task 'default', ->
  gulp.watch path.coffee, ['karma']
  gulp.watch path.modules, ['modules', 'standalone']
  gulp.watch path.gestures, ['gestures', 'standalone']
  gulp.watch path.spec, ['spec']
