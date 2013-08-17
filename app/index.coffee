express     = require 'express'
stylus      = require 'stylus'
nib         = require 'nib'
mongoose    = require 'mongoose'
User        = require "../models/user"
twitter     = require "ntwitter"
keys        = require "../config/keys"
http        = require 'http'
_           = require 'underscore'

module.exports = (socket)->
  app = express()

  app.use express.cookieSession(secret: "doyouwannaknowmysecret?")
  app.use app.router

  app.set("views", __dirname + "/views")
  app.use(express.static(__dirname + "/../public"))

  track = "wimbledon"

  changeTrack = (_track, client) ->
    @twit.stream "statuses/filter",
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
    userId = req.session.passport?.user
    if userId
      User.findOne id_str: userId, (err, user)=>
        @twit = new twitter _.extend keys, 
          access_token_key    : user.token
          access_token_secret : user.tokenSecret
        res.render "index", user
    else
      res.redirect "/login"

