express     = require("express")
stylus      = require("stylus")
nib         = require("nib")
mongoose    = require("mongoose")
twitter     = require "ntwitter"
keys        = require("../config/keys")()
http        = require("http")

module.exports = (socket)->
  app = express()

  compile = (str, path) ->
    # stylus(str).set("filename", path).include nib.path
    stylus(str).set("filename", path).use(nib())

  app.use express.logger("\u001b[90m:method\u001b[0m \u001b[36m:url\u001b[0m \u001b[90m:response-time ms\u001b[0m")
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.errorHandler
    dumpException: true
    showStack: true

  app.use express.cookieSession(secret: "doyouwannaknowmysecret?")
  app.use app.router

  app.set("view engine", "jade")
  app.set("views", __dirname + "/views")
  app.use stylus.middleware
    debug: true
    src: __dirname + "/../public"
    # compile: compile

  app.use(express.static(__dirname + "/../public"))

  twit = new twitter keys
  track = "wimbledon"

  changeTrack = (_track, client) ->
    twit.stream "statuses/filter",
      track: _track
    , (stream) ->
      stream.on "data", (data) ->
        client.emit "message", data

      stream.on "destroy", (response) ->
        console.log "Destroying stream..."

  socket.on "connection", (client) ->
    console.log "Connected!"
    changeTrack track, client
    client.on "change_track", (_track) ->
      track = _track.track
      console.log "Using track(s): ", track
      changeTrack track, client

  app.get '/', (req, res, next)-> 
  	res.render "index", {}

