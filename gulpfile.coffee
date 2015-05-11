"use strict"

# -- DEPENDENCIES --------------------------------------------------------------
gulp    = require 'gulp'
coffee  = require 'gulp-coffee'
concat  = require 'gulp-concat'
header  = require 'gulp-header'
connect = require "gulp-connect"
uglify  = require 'gulp-uglify'
stylus  = require 'gulp-stylus'
gutil   = require 'gulp-util'
pkg     = require './package.json'
# -- FILES ---------------------------------------------------------------------
path =
  assets  :   './assets'
  coffee  : [ './source/*.coffee']
  stylus  : [ './bower_components/flexo/source/normalize.styl'
              './bower_components/flexo/source/flexo.styl'
              './bower_components/flexo/source/flexo.button.styl'
              './bower_components/flexo/source/flexo.flex.styl'
              './bower_components/flexo/source/flexo.typography.styl'
              './source/style/constants.styl'
              './source/style/site.styl'
              './source/style/site.*.styl']
# -- BANNER --------------------------------------------------------------------
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

# -- TASKS ---------------------------------------------------------------------
gulp.task "server", ->
  connect.server
    port      : 8000
    livereload: true

gulp.task "coffee", ->
  gulp.src path.coffee
    .pipe concat "site.coffee"
    .pipe coffee().on "error", gutil.log
    .pipe uglify mangle: true
    .pipe header banner, pkg: pkg
    .pipe gulp.dest "#{path.assets}/js/"
    .pipe connect.reload()

gulp.task "stylus", ->
  gulp.src path.stylus
    .pipe concat "#{pkg.name}.styl"
    .pipe stylus
      compress: true
      errors  : true
    .pipe header banner, pkg: pkg
    .pipe gulp.dest "#{path.assets}/css/"
    .pipe connect.reload()

gulp.task 'init', ['coffee', 'stylus']

gulp.task 'default', ->
  gulp.watch path.coffee, ['coffee']
  gulp.watch path.stylus, ['stylus']
  gulp.run ["server"]
