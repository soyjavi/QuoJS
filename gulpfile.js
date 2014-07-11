"use strict"

// -- DEPENDENCIES -------------------------------------------------------------
var gulp    = require('gulp');
var coffee  = require('gulp-coffee');
var concat  = require('gulp-concat');
var header  = require('gulp-header');
var jasmine = require('gulp-jasmine');
var uglify  = require('gulp-uglify');
var pkg     = require('./package.json');


// -- FILES --------------------------------------------------------------------
var path = {
  // Exports
  bower   : './bower',
  temp    : './build',
  // Sources
  modules : ['source/quo.coffee',
             'source/quo.ajax.coffee',
             'source/quo.css.coffee',
             'source/quo.element.coffee',
             'source/quo.environment.coffee',
             'source/quo.events.coffee',
             'source/quo.output.coffee',
             'source/quo.query.coffee'],
  gestures: ['source/quo.gestures.coffee',
             'source/quo.gestures.*.coffee'],
  // Spec
  spec    : ['spec/*.coffee'] };

var banner = ['/**',
  ' * <%= pkg.name %> - <%= pkg.description %>',
  ' * @version v<%= pkg.version %>',
  ' * @link    <%= pkg.homepage %>',
  ' * @author  <%= pkg.author.name %> (<%= pkg.author.site %>)',
  ' * @license <%= pkg.license %>',
  ' */',
  ''].join('\n');

// -- TASKS --------------------------------------------------------------------
gulp.task('modules', function() {
  gulp.src(path.modules)
    .pipe(coffee())
    .pipe(gulp.dest(path.temp))
    .pipe(uglify({mangle: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower))
});

gulp.task('gestures', function() {
  gulp.src(path.gestures)
    .pipe(concat('quo.gestures.coffee'))
    .pipe(coffee())
    .pipe(gulp.dest(path.temp))
    .pipe(uglify({mangle: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower))
});

gulp.task('spec', function() {
  gulp.src(path.spec)
    .pipe(concat('spec.coffee'))
    .pipe(coffee())
    .pipe(gulp.dest(path.temp))

  var spec = [
    path.temp + '/spec.js',
    path.temp + '/quo.js',
    path.temp + '/quo.*.js'];

  // gulp.src(spec).pipe(jasmine())
});

gulp.task('init', function() {
  gulp.run(['modules', 'gestures', 'spec']);
});

gulp.task('default', function() {
  gulp.watch(path.modules, ['source', 'spec']);
  gulp.watch(path.gestures, ['gestures', 'spec']);
  gulp.watch(path.spec, ['spec']);
});
