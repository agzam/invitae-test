express = require 'express'
path = require 'path'

module.exports = (app)->

    rootDir = path.resolve __dirname,'../../..'

    app.use express.static rootDir+'/bin/public'

    app.get '/', (req, res)-> res.render('index')

    app.get "/partials/*", (req, res)-> res.render("#{rootDir}/src/client/#{req.params}")

    app.get "/assets/*", (req, res)-> res.sendfile("#{rootDir}/src/client/assets/#{req.params}")
    app.get "/lib/*", (req, res)-> res.sendfile("#{rootDir}/src/lib/vendor/#{req.params}")

