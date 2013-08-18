express         = require("express")
mongoose        = require("mongoose")
stylus          = require("stylus")
nib             = require("nib")
http            = require("http")

app = express()

app.use express.logger("\u001b[90m:method\u001b[0m \u001b[36m:url\u001b[0m \u001b[90m:response-time ms\u001b[0m")
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.bodyParser()
app.use express.cookieSession(secret: "doyouwannaknowmysecret?")

app.use express.errorHandler
  dumpException: true
  showStack: true

app.set("view engine", "jade")

mongoose.connect('mongodb://localhost/twitterio');

server = http.createServer(app)
socket = require("socket.io").listen(server)

login           = require("./lib/login")()
twitterio       = require("./lib/stream")(socket)

app.use '/login', login
app.use '/twitterio', twitterio

app.get '/', (req, res, next)->
  res.redirect '/login'

port = process.env.PORT or 3000
server.listen port
console.log "\u001b[36mtwitter-io\u001b[90m v%s\u001b[0m running as \u001b[1m%s\u001b[0m on http://%s:%d", app.set("version"), app.set("env"), app.set("host"), app.get("port")
