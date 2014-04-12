path = require 'path'

rootPath = path.resolve(__dirname,'../../..')

module.exports =
  development:
    db: 'mongodb://localhost/yawapp'
    rootPath: rootPath
    port: process.env.PORT || 3030

  production:
    rootPath: rootPath
    db: '' # TODO: set mongolab database for production
#    db: 'mongodb://jeames:multivision@ds053178.mongolab.com:53178/multivision'
    port: process.env.PORT || 80
