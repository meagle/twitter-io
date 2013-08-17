express     = require("express")
stylus      = require("stylus")
nib         = require("nib")
mongoose    = require("mongoose")
twitter     = require "ntwitter"
keys        = require("../config/keys")()
http        = require("http")

module.exports = (socket)->
  app = express()

  app.use express.cookieSession(secret: "doyouwannaknowmysecret?")
  app.use app.router

  app.set("views", __dirname + "/views")

  app.use(express.static(__dirname + "/../public"))

  #TODO: merge in the user's access token and secret 
  #      with the consumer keys
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
    console.log 'USER: ', req.session.passport?.user
    res.render "index", {}

