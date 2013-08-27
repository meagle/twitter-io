express     = require 'express'
stylus      = require 'stylus'
nib         = require 'nib'
mongoose    = require 'mongoose'
User        = require "../models/user"
twitter     = require "ntwitter"
keys        = require "../config/keys"
http        = require 'http'
_           = require 'underscore'

module.exports = (io)->
  app = express()
  compile = (str, path) ->
    stylus(str).set("filename", path).use nib()

  app.use express.cookieSession(secret: "doyouwannaknowmysecret?")

  app.use stylus.middleware(
    src: "#{__dirname}/../../public"
    compile: compile
  )

  app.use app.router

  app.set "views", __dirname + "/views"
  app.use express.static "#{__dirname}/../../public"

  clients = {}

  io.sockets.on "connection", (client) ->
    console.log "Connected!", client.id

    paused = false

    changeTrack = (_track, userId) ->
      twitterSession = _getTwitterSession userId
      twitterSession.stream "statuses/filter",
        track: _track
      , (stream) ->
        stream.on "data", (data) ->
          if data.user and not paused
            client.emit "message", data

        stream.on "destroy", (response) ->
          console.log "Destroying stream..."

    _getTwitterSession = (userId) ->
      clients[userId].twitterSession

    client.on "change_track", (payload) ->
      track = payload.track
      userId = payload.userId
      console.log "Using track(s): ", track

      changeTrack track, userId

    client.on 'pause_stream', ->
      paused = true

    client.on 'resume_stream', ->
      paused = false


  app.get '/', (req, res, next)-> 
    userId = req.session.passport?.user
    if userId
      User.findOne id_str: userId, (err, user)=>
        twitterSession = new twitter _.extend keys, 
          access_token_key    : user.token
          access_token_secret : user.tokenSecret

        clients[userId] = 
          twitterSession : twitterSession
          user           : user

        res.render "index", {user: user, userId : userId}
    else
      res.redirect "/login"

