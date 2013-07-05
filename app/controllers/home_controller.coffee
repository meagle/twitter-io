twitter = require "ntwitter"
keys    = require("../../config/keys")()

controller = {}

module.exports = (_app, _socket) ->
  twit = new twitter keys
  track = "wimbledon"
  app = _app
  socket = _socket

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

  # db  = app.set('db')
  controller

controller.load = (template, req, res, next) ->
  return next(new Error("missing template"))  unless template
  res.render template, {}

controller.index = (req, res, next) ->
  res.render "home/index", {}
