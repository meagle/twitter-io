express         = require("express")
mongoose        = require("mongoose")
stylus          = require("stylus")
nib             = require("nib")
# models          = require("./models")
# routes          = require("./routes")
# environments    = require("./environments")
# errors          = require("./errors")
# hooks           = require("./hooks")
http            = require("http")

module.exports = ->
  app = express()

  app.use express.logger("\u001b[90m:method\u001b[0m \u001b[36m:url\u001b[0m \u001b[90m:response-time ms\u001b[0m")
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.errorHandler
    dumpException: true
    showStack: true

  app.set("view engine", "jade")
  # app.set("views", __dirname + "/views")
  app.use stylus.middleware
    debug: true
    src: __dirname + "/../public"

  mongoose.connect('mongodb://localhost/twitterio');

  server = http.createServer(app)
  socket = require("socket.io").listen(server)
  
  login           = require("../login")()
  twitterio       = require("../app")(socket)

  # Load Mongoose Models
  # models(app)
  
  #  Load Expressjs config
  # config app
  app.use '/login', login
  app.use '/twitterio', twitterio

  app.get '/', (req, res, next)->
    res.redirect '/login'

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
