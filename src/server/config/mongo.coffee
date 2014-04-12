mongoose = require "mongoose"
config = require "./config"

module.exports = (config)->
    console.log "Will be using db at: #{config.db}"
    mongoose.connect(config.db)
    db = mongoose.connection
    db.on('error', console.error.bind(console, 'connecting to database failed...'))
    db.once 'open', -> console.log('db opened')


