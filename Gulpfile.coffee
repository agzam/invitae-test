gulp = require "gulp"
gutil = require "gulp-util"
coffee = require "gulp-coffee"
nodemon = require "gulp-nodemon"
clean = require "gulp-clean"
browserify = require "gulp-browserify"
rename = require "gulp-rename"
uglify = require "gulp-uglify"
ngmin = require 'gulp-ngmin'
runSequence = require 'run-sequence'

gulp.task "compile:server", ->
   gulp.src(["src/server/**/*.coffee"])
#    .on("data",(d)-> console.log "compiling is #{d.path}")
    .pipe(coffee { bare: true } ).on("error",gutil.log)
    .pipe(gulp.dest "./bin/server")


gulp.task "compile:client",->
    clTask = gulp.src("src/client/app.coffee", { read:false })
       .pipe(
           browserify
               transform :['coffeeify']
               extensions: ['.coffee']
       ).pipe(rename 'app.js')

    gulp.src(['src/client/assets/**/*.*']).pipe(gulp.dest 'bin/public/assets')

    if process.env.NODE_ENV is 'production'
        console.log "running on production, will be minifiying javascript"
        clTask =  clTask
        .pipe(ngmin())
        .pipe(uglify({mangle: false}))

    clTask.pipe(gulp.dest 'bin/public/client')


gulp.task "compile:tests", ->
  gulp.src(["src/tests/**/*.coffee",'src/maintenance/**/*.coffee'])
  .pipe(coffee { bare: true } ).on("error",gutil.log)
  .pipe(gulp.dest "./bin/tests")


gulp.task "clean",->
    gulp.src('bin', { read:false })
        .pipe(clean { force:true })


gulp.task "nodemon",->
   ndm = nodemon
        script: 'bin/server/server.js',
        watch: ['src']
        ext: 'coffee jade styl'

   ndm
   .on('change', ['compile:server','compile:client'])
   .on 'restart', -> console.log('restarting server')


gulp.task 'dev:run',->  runSequence 'clean', 'compile:server', 'compile:client', 'nodemon'

gulp.task 'build',-> runSequence 'clean','compile:server','compile:client'

gulp.task 'build:all', -> runSequence 'clean','compile:server','compile:client', 'compile:tests'

gulp.task "default",['build']
