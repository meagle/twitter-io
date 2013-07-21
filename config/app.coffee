express         = require("express")
# mongoose        = require("mongoose")
# stylus          = require("stylus")
# nib             = require("nib")
# models          = require("./models")
# routes          = require("./routes")
# environments    = require("./environments")
# errors          = require("./errors")
# hooks           = require("./hooks")
http            = require("http")

module.exports = ->
  app = express()
  server = http.createServer(app)
  socket = require("socket.io").listen(server)
  
  twitterio       = require("../app")(socket)

  # Load Mongoose Models
  # models(app)
  
  #  Load Expressjs config
  # config app
  app.use '/twitterio', twitterio

  #  Load Environmental Settings
  # environments app
  
  #  Load routes config
  # routes app, socket
  
  #  Load error routes + pages
  # errors app
  
  #  Load hooks
  # hooks app
  
  port = process.env.PORT or 3000
  server.listen port
  console.log "\u001b[36mtwitter-io\u001b[90m v%s\u001b[0m running as \u001b[1m%s\u001b[0m on http://%s:%d", app.set("version"), app.set("env"), app.set("host"), app.get("port")
  # app
