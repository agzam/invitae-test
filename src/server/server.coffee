express = require "express"

app = express()

env = process.env.NODE_ENV = process.env.NODE_ENV or 'development'
config = require('./config/config')[env]
require("./config/middleware")(app)
require("./config/routes")(app)
#require('./config/mongo')(config)
app.listen config.port
console.log "listening on port #{config.port}"
