'use strict';

var gulp = require('gulp')
  , purs = require('gulp-purescript')
  , Promise = require('bluebird')
  , del = Promise.promisifyAll(require('del'))
  , _ = require('lodash')
  , mocha = require('gulp-mocha')
;

var src = [ 'src/**/*.purs' ]
  , deps = [ 'bower_components/purescript-*/src/**/*.purs' ]
  , tests = [ 'tests/Tests.purs' ]
  , output = [ 'output' ]
;

gulp.task('clean', function() {
    return Promise.all(del(output));
});

gulp.task('make:tests', function() {
    return gulp
        .src(_.flatten([ src, deps, tests ], false))
        .pipe(purs.psc({
             main: 'Tests'
           , output: 'tests.js'
         }))
        .pipe(gulp.dest('tmp'))
    ;
});

gulp.task('test', [ 'make:tests' ], function() {
    return gulp
        .src('tmp/tests.js')
        .pipe(mocha())
    ;
});
