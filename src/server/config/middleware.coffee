express = require "express"
stylus = require "stylus"
path = require "path"

module.exports = (app) ->

    app.configure ->
        rootDir = path.resolve __dirname,'../../..'
        app.set 'view engine', 'jade'
        app.set 'views', rootDir+'/src/views'

        app.use stylus.middleware
            src: rootDir+"/src/styles"
            dest: rootDir+"/bin/public/styles/"
            compile: (str)->
                stylus(str)
                .set('compress', process.env.NODE_ENV is 'production')

        app.use express.bodyParser()

