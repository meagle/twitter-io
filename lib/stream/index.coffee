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

  app.use express.cookieSession(secret: "doyouwannaknowmysecret?")
  app.use app.router

  app.set "views", __dirname + "/views"
  app.use express.static "#{__dirname}/../../public"

  clients = {}

  io.sockets.on "connection", (client) ->
    console.log "Connected!", client.id

    changeTrack = (_track, userId) ->
      console.log 'Client ID: ', client.id
      twitterSession = clients[userId].twitterSession
      console.log 'twitterSession: ', twitterSession
      twitterSession.stream "statuses/filter",
        track: _track
      , (stream) ->
        stream.on "data", (data) ->
          # console.log data
          client.emit "message", data

        stream.on "destroy", (response) ->
          console.log "Destroying stream..."


    # changeTrack track, client
    client.on "change_track", (payload) ->
      track = payload.track
      userId = payload.userId
      console.log "Using track(s): ", track

      changeTrack track, userId

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

